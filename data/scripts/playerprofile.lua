PlayerProfile = Class(function(self)
    self.persistdata = 
    {
		--we should migrate the non-gameplay stuff to a separate file, so that we can save them whenever we want
        volume_ambient = 7,
        volume_sfx = 7,
        volume_music = 7,
        HUDSize = 5,
        xp = 0,
        unlocked_worldgen = {},
        unlocked_characters = {},        
        render_quality = RENDER_QUALITY.DEFAULT,
    }
    
    self:SetupSaveSlots()
    
    self.dirty = true

end)

function PlayerProfile:SetupSaveSlots()
	if self.persistdata.save_slots == nil then
		self.persistdata.save_slots = {}
	end
    
    for i =1, 4 do
    	if self.persistdata.save_slots[i] == nil then
    		self.persistdata.save_slots[i] = {}
	        self.persistdata.save_slots[i].current_world_level = 0 --story mode progress
	        self.persistdata.save_slots[i].next_world_playerdata = nil --for travelling between worlds
	        self.persistdata.save_slots[i].progress = nil --day for display
	        self.persistdata.save_slots[i].type = "free"
	        self.persistdata.save_slots[i].character = "wilson"
    	end
    end
    
    self.dirty = true
end

function PlayerProfile:Reset()
	
    self.persistdata.xp = 0
	self.persistdata.unlocked_worldgen = {}
	self.persistdata.unlocked_characters = {}
	self.dirty = true
	self:Save()
end

function PlayerProfile:UnlockEverything()
	
    self.persistdata.xp = 0
	self.persistdata.unlocked_worldgen = { 
			monsters = {spiders=true, tentacles=true, tallbirds=true,  hounds=true, liefs=true },
			animals = {pigs=true, rabbits=true, beefalo=true, frogs=true, bees=true, perd=true },
			resources = {grass=true, rock=true, sapling=true, reeds=true, trees=true},
			unprepared = {carrot=true, berrybush=true},
			misc = {day=true, season=true, season_start=true, world_size=true, world_complexity=true},
			preset = {
					["A Gentle Start"]=true, 
					["Danger, Wilson Robinson!"]=true, 
					["Swine and Spiders"]=true, 
					["My Kingdom for a Log"]=true, 
					["Battle of the Bulging Belly"]=true, 
					["End Game"]=true, 
				},
		}
		
	require("map/tasks")
	self.persistdata.unlocked_worldgen.tasks = {}
	for i, task in pairs(tasks.sampletasks) do
		self.persistdata.unlocked_worldgen.tasks[task.id] = true
	end

	self.persistdata.unlocked_characters = {}
	local characters = {'willow', 'wendy', 'wolfgang', 'wilton', 'wx78', 'wickerbottom', 'wes'}
	for k,v in pairs(characters) do
		self:UnlockCharacter(v)
	end
	self.dirty = true
	self:Save()
end

function PlayerProfile:SetValue(name, value)
    self.dirty = true
    self.persistdata[name] = value
end

function PlayerProfile:SetSaveSlotValue(idx, name, value)
    self.dirty = true
    self:SetupSaveSlots()
    self.persistdata.save_slots[idx][name] = value
end

function PlayerProfile:GetValue(name)
	return self.persistdata[name]
end

function PlayerProfile:GetSaveSlotValue(idx, name)
    self:SetupSaveSlots()
    
	if self.persistdata.save_slots then
		if self.persistdata.save_slots[idx] then
			return self.persistdata.save_slots[idx][name]
		end
	end
	
	return nil
end

function PlayerProfile:SetVolume(ambient, sfx, music)
    self:SetValue("volume_ambient", ambient) 
    self:SetValue("volume_sfx", sfx) 
    self:SetValue("volume_music", music) 
    self.dirty = true
end

function PlayerProfile:SetBloomEnabled(enabled)
	self:SetValue("bloom", enabled)
	self.dirty = true
end

function PlayerProfile:GetBloomEnabled()
	return self:GetValue("bloom")
end

function PlayerProfile:SetHUDSize(size)
	self:SetValue("HUDSize", size)
	self.dirty = true
end

function PlayerProfile:SetDistortionEnabled(enabled)
	self:SetValue("distortion", enabled)
	self.dirty = true
end

function PlayerProfile:GetDistortionEnabled()
	return self:GetValue("distortion")
end

function PlayerProfile:GetVolume()
    return self.persistdata.volume_ambient, self.persistdata.volume_sfx, self.persistdata.volume_music
end

function PlayerProfile:SetRenderQuality(quality)
	self:SetValue("render_quality", quality)
	self.dirty = true
end

function PlayerProfile:GetRenderQuality()
	return self:GetValue("render_quality")
end

----------------------------

function PlayerProfile:IsCharacterUnlocked(character)
    if character == "wilson" then
		return true
    end
    
    if self.persistdata.unlocked_characters[character] then
        return true
    else
        return false
    end
end

function PlayerProfile:UnlockCharacter(character)
    self.persistdata.unlocked_characters[character] = true
    self.dirty = true
end

function PlayerProfile:GetUnlockedCharacters()
    return self.persistdata.unlocked_characters
end
----------------------------

function PlayerProfile:IsWorldGenUnlocked(area, item)
	if self.persistdata.unlocked_worldgen == nil then
		return false
	end
	
	if self.persistdata.unlocked_worldgen[area] == nil then
		return false
	end
	
    if item == nil or self.persistdata.unlocked_worldgen[area][item] then
        return true
    end
    
    return false
end

function PlayerProfile:UnlockWorldGen(area, item)
	if self.persistdata.unlocked_worldgen == nil then
		self.persistdata.unlocked_worldgen = {}
	end
	
	if self.persistdata.unlocked_worldgen[area] == nil then
		self.persistdata.unlocked_worldgen[area] = {}
	end
	
    self.persistdata.unlocked_worldgen[area][item] = true
    self.dirty = true
end

function PlayerProfile:GetUnlockedWorldGen()
    return self.persistdata.unlocked_worldgen
end


----------------------------


function PlayerProfile:GetSaveName()
    return BRANCH == "release" and "profile" or "profile_"..BRANCH
end

function PlayerProfile:GetHUDSize()
	return self.persistdata.HUDSize or 5
end

function PlayerProfile:GetXP()
    return self.persistdata.xp
end

function PlayerProfile:SetXP(xp)
    self:SetValue("xp", xp)
end

function PlayerProfile:Save(callback)
	Print( VERBOSITY.DEBUG, "SAVING" )
    if self.dirty then
        local str = json.encode(self.persistdata)
        local insz, outsz = TheSim:SetPersistentString(self:GetSaveName(), str, ENCODE_SAVES, callback)
    else
		if callback then
			callback(true)
		end
    end
end

function PlayerProfile:Load(callback)
    TheSim:GetPersistentString(self:GetSaveName(),
        function(str) 
			self:Set( str, callback )
        end, false)    
end

local function GetValueOrDefault( value, default )
	if value ~= nil then
		return value
	else
		return default
	end
end

function PlayerProfile:Set(str, callback)
	if string.len(str) == 0 then
		print ("could not load ".. self:GetSaveName())
		if callback then
			callback(false)
		end
	else
		print ("loaded ".. self:GetSaveName())

		self.persistdata = TrackedAssert("TheSim:GetPersistentString profile",  json.decode, str)

		local amb, sfx, music = self:GetVolume()
		Print(VERBOSITY.DEBUG, "volumes", amb, sfx, music )
		
		TheMixer:SetLevel("set_sfx", sfx / 10)
		TheMixer:SetLevel("set_ambience", amb / 10)
		TheMixer:SetLevel("set_music", music / 10)

		if TheFrontEnd then
			local bloom_enabled = GetValueOrDefault( self.persistdata.bloom, true )
			local distortion_enabled = GetValueOrDefault( self.persistdata.distortion, true )
			
			TheFrontEnd:GetGraphicsOptions():SetBloomEnabled( bloom_enabled )
			TheFrontEnd:GetGraphicsOptions():SetDistortionEnabled( distortion_enabled )
		end

		self.dirty = false
		if callback then
			callback(true)
		end
	end
end

function PlayerProfile:SetDirty(dirty)
	self.dirty = dirty
end
