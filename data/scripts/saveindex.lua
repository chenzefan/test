SaveIndex = Class(function(self)
	self.data =
	{
		slots=
		{
		}
	}
	for k = 1, 4 do

		local filename = "latest_" .. tostring(k)

		if BRANCH ~= "release" then
			filename = filename .. "_" .. BRANCH
		end

		self.data.slots[k] = 
		{
			current_mode = nil,
			modes = {survival= {file = filename}}
		}
	end
	self.current_slot = 1
end)

function SaveIndex:GetSaveGameName(type, slot)
	local name = type.."_" ..tostring(slot)
	if BRANCH ~= "release" then
		name = name .. BRANCH
	end
	return name
end

function SaveIndex:GetSaveIndexName()
	local name = "saveindex" 
	if BRANCH ~= "release" then
		name = name .. "_"..BRANCH
	end
	return name
end

function SaveIndex:Save(callback)
	local data = DataDumper(self.data, nil, false)
    local insz, outsz = TheSim:SetPersistentString(self:GetSaveIndexName(), data, ENCODE_SAVES, callback)
end

function SaveIndex:Load(callback)

    local filename = self:GetSaveIndexName()
    TheSim:GetPersistentString(filename,
        function(str) 
			local success, savedata = RunInSandbox(str)
			if success and string.len(str) > 0 then
				self.data = savedata
				print ("loaded "..filename)
			else
				print ("Could not load "..filename)
			end
			self:VerifyFiles(callback)
        end)    
end


--this also does recovery of pre-existing save files (sort of)
function SaveIndex:VerifyFiles(completion_callback)

	local pending_slots = {}
	for k,v in ipairs(self.data.slots) do
		pending_slots[k] = true
	end
	
	for k,v in ipairs(self.data.slots) do
		local dirty = false
		local files = {}
		if v.current_mode == "empty" then
			v.current_mode = nil
		end
		if v.modes then
			v.modes.empty = nil
			if v.modes.survival then
				table.insert(files, v.modes.survival.file)
			end
			if v.modes.adventure then
				table.insert(files, v.modes.adventure.file)
			end
		end

		CheckFiles(function(status) 

			if v.modes then
				for kk,vv in pairs (v.modes) do
					if vv.file and not status[vv.file] then
						vv.file = nil
					end
				end

			 	if v.current_mode == nil then
			 		if v.modes.survival and v.modes.survival.file then
			 			v.current_mode = "survival"
			 		end
			 	end
			 end

		 	pending_slots[k] = nil

		 	if not next(pending_slots) then
		 		self:Save(completion_callback)
		 	end

		 end, files)
	end
end

function SaveIndex:GetModeData(slot, mode)
	if slot and mode and self.data.slots[slot] then
		if not self.data.slots[slot].modes then
			self.data.slots[slot].modes = {}
		end
		if not self.data.slots[slot].modes[mode] then
			self.data.slots[slot].modes[mode] = {}
		end
		return self.data.slots[slot].modes[mode]
	end

	return {}
end


function SaveIndex:GetSaveData(slot, mode, cb)
	self.current_slot = slot
	
	TheSim:GetPersistentString(self:GetModeData(slot, mode).file, function(str)
		local success, savedata = RunInSandbox(str)
		cb(savedata)
	end)
end

function SaveIndex:GetPlayerData(slot, mode)
	return self:GetModeData(slot, mode).playerdata
end

function SaveIndex:DeleteSlot(slot, cb)
	local function onerased()
		self.data.slots[slot] = { current_mode = nil, modes = {}}
		self:Save(cb)
	end

	local files = {}
	for k,v in pairs(self.data.slots[slot].modes) do
		table.insert(files, v.file)
	end
	EraseFiles(onerased, files)
end


function SaveIndex:EraseCurrent(cb)
	
	local filename = ""
	local function onerased()	
		EraseFiles(cb, {filename})
	end
	
	local current_mode = self.data.slots[self.current_slot].current_mode
	local data = self:GetModeData(self.current_slot, current_mode)
	filename = data.file
	data.file = nil
	data.playedata = nil
	data.day = nil
	data.world = nil
	self:Save(onerased)

end

function SaveIndex:SaveCurrent(onsavedcb)
	
	local ground = GetWorld()
	assert(ground, "missing world?")
	local level_number = ground.topology.level_number or 1
	local day_number = GetClock().numcycles + 1

	local function onsavedgame()
		self:Save(onsavedcb)
	end

	local current_mode = self.data.slots[self.current_slot].current_mode
	local data = self:GetModeData(self.current_slot, current_mode)

	self.data.slots[self.current_slot].character = GetPlayer().prefab
	data.day = day_number
	data.file = self:GetSaveGameName(current_mode, self.current_slot)
	SaveGame(self:GetSaveGameName(current_mode, self.current_slot), onsavedgame)
end

function SaveIndex:SetSlotCharacter(saveslot, character, cb)
	self.data.slots[saveslot].character = character
	self:Save(cb)
end

function SaveIndex:SetCurrentIndex(saveslot)
	self.current_slot = saveslot
end

function SaveIndex:GetCurrentSaveSlot()
	return self.current_slot
end


--called upon relaunch when a new level needs to be loaded
function SaveIndex:OnGenerateNewWorld(saveslot, savedata, cb)
	local playerdata = nil
	self.current_slot = saveslot
	local filename = self:GetSaveGameName(self.data.slots[self.current_slot].current_mode, self.current_slot)
	
	local function onindexsaved()
		cb(playerdata)
	end		

	local function onsavedatasaved()
		self.data.slots[self.current_slot].continue_pending = false
		local current_mode = self.data.slots[self.current_slot].current_mode
		local data = self:GetModeData(self.current_slot, current_mode)
		data.file = filename
		data.day = 1
		
		playerdata = data.playerdata
		data.playerdata = nil

		self:Save(onindexsaved)
	end

	local insz, outsz = TheSim:SetPersistentString(filename, savedata, ENCODE_SAVES, onsavedatasaved)	
end

--call after you have worldgen data to initialize a new survival save slot
function SaveIndex:StartSurvivalMode(saveslot, character, customoptions, onsavedcb)
	self.current_slot = saveslot

--	local data = self:GetModeData(saveslot, "survival")
	self.data.slots[self.current_slot].character = character
	self.data.slots[self.current_slot].current_mode = "survival"

	self.data.slots[self.current_slot].modes = 
	{
		survival = {
			file = self:GetSaveGameName("survival", self.current_slot),
			day = 1,
			world = 1,
			options = customoptions
		},
	}
 	
 	self:Save(onsavedcb)
end

function SaveIndex:OnFailAdventure(cb)
	local filename = self.data.slots[self.current_slot].modes.adventure.file

	local function onsavedindex()
		EraseFiles(cb, {filename})
	end

	self.data.slots[self.current_slot].current_mode = "survival"
	self.data.slots[self.current_slot].modes.adventure = {}
	self:Save(onsavedindex)
end

function SaveIndex:FakeAdventure(cb, slot, start_world)
	self.data.slots[slot].current_mode = "adventure"
	self.data.slots[slot].modes.adventure = {world = start_world}
 	self:Save(cb)
end

function SaveIndex:StartAdventure(cb)

	local function ongamesaved()
		self.data.slots[self.current_slot].current_mode = "adventure"
		self.data.slots[self.current_slot].modes.adventure = {world = 1}
	 	self:Save(cb)
	end

	self:SaveCurrent(ongamesaved)

end

--call when you have finished a survival or adventure level to increment the world number and save off the continue information
function SaveIndex:CompleteLevel(cb)
	local adventuremode = self.data.slots[self.current_slot].current_mode == "adventure"

    local playerdata = {}
    local player = GetPlayer()
    if player then
    	player:OnProgress()
        playerdata = player:GetSaveRecord().data
   	 end   

   	local function onerased()
   		self:Save(cb)
   	end

	self.data.slots[self.current_slot].continue_pending = true

	local current_mode = self.data.slots[self.current_slot].current_mode
	local data = self:GetModeData(self.current_slot, current_mode)

	data.day = 1
	data.world = data.world and (data.world + 1) or 2
 	data.playerdata = playerdata
	local file = data.file 
	data.file = nil
	EraseFiles( onerased, { file } )		
end

function SaveIndex:GetSlotDay(slot)
	slot = slot or self.current_slot
	local current_mode = self.data.slots[slot].current_mode
	local data = self:GetModeData(slot, current_mode)
	return data.day or 1
end

function SaveIndex:GetSlotWorld(slot)
	slot = slot or self.current_slot
	local current_mode = self.data.slots[slot].current_mode
	local data = self:GetModeData(slot, current_mode)
	return data.world or 1
end

function SaveIndex:GetSlotCharacter(slot)
	return self.data.slots[slot or self.current_slot].character
end

function SaveIndex:HasWorld(slot, mode)
	slot = slot or self.current_slot
	local current_mode = self.data.slots[slot].current_mode
	local data = self:GetModeData(slot, current_mode)
	return data.file ~= nil
end

function SaveIndex:GetSlotGenOptions(slot, mode)
	slot = slot or self.current_slot
	local current_mode = self.data.slots[slot].current_mode
	local data = self:GetModeData(slot, current_mode)
	return data.options
end

function SaveIndex:IsContinuePending(slot)
	return self.data.slots[slot or self.current_slot].continue_pending
end

function SaveIndex:GetCurrentMode(slot)
	return self.data.slots[slot or self.current_slot].current_mode
end
