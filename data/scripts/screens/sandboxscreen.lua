require "screen"
require "animbutton"
require "spinner"
require "numericspinner"

require "screens/popupdialog"
require "widgets/toggle"

local spinner_images = {
	arrow_normal = "data/images/spin_arrow.tex",
	arrow_over = "data/images/spin_arrow_over.tex",
	arrow_disabled = "data/images/spin_arrow_disabled.tex",
	bgtexture = "data/images/spinner.tex",
}

local toggle_images = {
	on = "data/images/arrow_right.tex",
	off = "data/images/arrow_left.tex",
	optional = "data/images/next_arrow.tex",
	disabled = "data/images/spin_arrow_disabled.tex",
	bgtexture = "data/images/spinner.tex",
}

local text_font = DEFAULTFONT--NUMBERFONT
local spinnerFont = { font = text_font, size = 30 }
local spinnerHeight = 64

local customise = require("map/customise")

SandboxScreen = Class(Screen, function(self, profile, cb, defaults)
    Widget._ctor(self, "SandboxScreen")
    self.profile = profile
	self.cb = cb
	
    self.bg = self:AddChild(Image("data/images/bg_red.tex"))
    self.bg:SetVRegPoint(ANCHOR_MIDDLE)
    self.bg:SetHRegPoint(ANCHOR_MIDDLE)
    self.bg:SetVAnchor(ANCHOR_MIDDLE)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
    self.bg:SetScaleMode(SCALEMODE_FILLSCREEN)
    
    self.root = self:AddChild(Widget("root"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    
    local font = BUTTONFONT
    
	self.chosen = { 
					["tasks"] = {},
					["tweak"] = {},
					["preset"] = {"none"},
			}

	self.groupdetails = deepcopy(customise.GROUP)
	for group_id,group in pairs(self.groupdetails) do
		self.chosen["tweak"][group_id] = {}
		for name,item in pairs(group.items) do
			self.chosen["tweak"][group_id][name] = item.value
		end
	end
	
	require("map/levels")

	self.unlocked_tasks = {}
	local this = self
	
	local function UnlockTasks(level)
		if level.tasks ~= nil and #level.tasks >0 then
			for i, task in ipairs(level.tasks) do
				this.unlocked_tasks[task] = true
				--print ("UNLOCK", task)
			end
		end
		if level.optionaltasks ~= nil and #level.optionaltasks >0 then
			for i, task in ipairs(level.optionaltasks) do
				this.unlocked_tasks[task] = true
				--print ("UNLOCK", task)
			end
		end
	end

		
	
	for i, level in pairs(levels.sandbox_levels) do
		table.insert(customise.preset_descriptions, {text=level.name, data=level.name})
		UnlockTasks(level)
	end
	
	for i, level in pairs(levels.story_levels) do
		if self.profile:IsWorldGenUnlocked("preset", level.name) == true then
			table.insert(customise.preset_descriptions, {text=level.name, data=level.name})
			UnlockTasks(level)
		end
	end
	
	self:ChoosePresetTasks(levels.free_level)

    self.title = self.root:AddChild(Text(font, 75))
    self.title:SetPosition(0,200,0)     
 	self.title:SetString(STRINGS.UI.SANDBOXMENU.TITLE)


    self.t1 = self.root:AddChild(Text(font, 60))
    self.t1:SetPosition(0,70,0)
    self.t1:SetString(STRINGS.UI.SANDBOXMENU.TITLEDETAIL)
    
    self.menu = self.root:AddChild(Widget("menu"))
    self.menu:SetPosition(0, -80, 0)

    local but_w = 250

	self.menubutton = self.menu:AddChild(AnimButton("button"))
	self.menubutton:SetText(STRINGS.UI.SANDBOXMENU.MAINMENU)
	self.menubutton:SetOnClick( function() self:OnMenu() end )
	self.menubutton.text:SetColour(0,0,0,1)
	self.menubutton:SetFont(BUTTONFONT)
	self.menubutton:SetTextSize(40)  
	self.menubutton:SetPosition(-but_w, -140, 0)
	
	self.okbutton = self.menu:AddChild(AnimButton("button"))
	self.okbutton:SetText(STRINGS.UI.SANDBOXMENU.GENERATE)
	self.okbutton:SetOnClick( function() self:OnGenerate() end )
	self.okbutton.text:SetColour(0,0,0,1)
	self.okbutton:SetFont(BUTTONFONT)
	self.okbutton:SetTextSize(40)  
	self.okbutton:SetPosition(but_w, -140, 0)
		    
    self:IntialiseScreen()
    
    --TheFrontEnd:DoFadeIn(2)
end)

function SandboxScreen:IntialiseScreen()
	local menu_spacing = 60
	local bottom_offset = 60
	
	local pos = Vector3(350,200,0)
	local offset = Vector3(0, -menu_spacing, 0)
	for	group_id,v in pairs(customise.GROUP) do
		local button = self.menu:AddChild(AnimButton("button"))
		button:SetText(v.text)
		button:SetOnClick( function() self:OnMenuSelect(group_id) end )
		button.text:SetColour(0,0,0,1)
		button:SetFont(BUTTONFONT)
		button:SetTextSize(40)  
		button:SetPosition(pos)
		--if v.enable == true or self.profile:IsWorldGenUnlocked(group_id, nil) == true then
			button:Enable()
		--else
		--	button:Disable()
		--end
		pos = pos + offset 
	end
	
	local this = self
	
	-- Setup preset spinner LEVELS
	this.chosen["preset"] = {"none"}
	
	for idx=#customise.preset_descriptions, 1, -1  do
		if customise.preset_descriptions[idx].data ~= "none" and self.profile:IsWorldGenUnlocked("preset", customise.preset_descriptions[idx].data) == false  then
			table.remove(customise.preset_descriptions, idx)
		end
	end			 
	
	if #customise.preset_descriptions <= 1 then
		customise.preset_descriptions = {{ text = STRINGS.UI.SANDBOXMENU.NONEAVAILABLE, data = "none" }}
	end
	
	local preset_spinner = Spinner( customise.preset_descriptions, 350, spinnerHeight, spinnerFont, spinner_images )
	
	local function UpdateSpinner()
		for idx=1, #customise.preset_descriptions do
			if customise.preset_descriptions[idx].data == this.chosen["preset"][1] then			
				preset_spinner:SetSelectedIndex( idx )
			end
		end			 
	end
		
	preset_spinner.OnChanged =
			function( self, data )
				this.chosen["preset"] = {data}	
				require("map/levels")
				if data ~= "none" then
					local found = false
					for idx=1, #levels.sandbox_levels do
						if data == levels.sandbox_levels[idx].name then
							this:ChoosePresetTasks(levels.sandbox_levels[idx])	
							this.chosen["level_id"] = idx --this.profile:SetSaveSlotValue(this.save_slot_idx, "current_world_level", idx)
							--this.chosen["current_level"] = idx
							found = true
							break
						end
					end
					if found == false then
						for idx=1, #levels.story_levels do
							if data == levels.story_levels[idx].name then
								this:ChoosePresetTasks(levels.story_levels[idx])
								this.chosen["level_id"] = idx -- this.profile:SetSaveSlotValue(this.save_slot_idx, "current_world_level", idx)
								--this.chosen["current_level"] = idx
								break
							end
						end
					end
				else
					this:ChoosePresetTasks(levels.free_level)
				end
						
				UpdateSpinner()		 
			end
	UpdateSpinner()			

	self.menu:AddChild(preset_spinner)
	preset_spinner:SetPosition(Vector3(-300,200,0))
	
 	local label = self.menu:AddChild( Text( DEFAULTFONT, 30, STRINGS.UI.SANDBOXMENU.USEPRESET) )
	label:SetPosition(Vector3(-370,200,0))
	label:SetHAlign( ANCHOR_RIGHT )


--	self.tasksbutton = self.menu:AddChild(AnimButton("button"))
--	self.tasksbutton:SetText(STRINGS.UI.SANDBOXMENU.MODIFYTASKS)
--	self.tasksbutton:SetOnClick( function() self:OnModifyTasks() end )
--	self.tasksbutton.text:SetColour(0,0,0,1)
--	self.tasksbutton:SetFont(BUTTONFONT)
--	self.tasksbutton:SetTextSize(40)  
--	self.tasksbutton:SetPosition(Vector3(-100,100,0))
	
	--print("#unlocked_tasks", GetTableSize(self.unlocked_tasks))
	--if GetTableSize(self.unlocked_tasks) == 0 and self.profile:IsWorldGenUnlocked("tasks", nil) == false then
	--if self.profile:IsWorldGenUnlocked("tasks", nil) == false then
	--	self.tasksbutton:Disable()
	--end
	
end	

function SandboxScreen:OnMenuSelect(group_id)
	local popup = PopupDialogScreen( self.groupdetails[group_id].text, "", { 
					{ text = STRINGS.UI.MAINSCREEN.OK, cb =
						function()
						end
					}})
					
	self:IntialisePopup(popup, group_id)
	popup.bg:SetScale(1.5,2.3,1)
	local pos = popup.menu:GetPosition()
	popup.menu:SetPosition(pos.x+180, pos.y-100, 0)
	popup.title:SetPosition(180, 70, 0)
	TheFrontEnd:PushScreen( popup )
end

function SandboxScreen:IntialisePopup(popup, group_id)
	local spinners = {}
	local this = self
	
	for name,item in pairs(self.groupdetails[group_id].items) do
		if this.chosen["tweak"][group_id] == nil then
			this.chosen["tweak"][group_id] = {}
		end
		
		local desc = deepcopy(self.groupdetails[group_id].desc)	
		if desc == nil then
			desc = deepcopy(item.desc)
		end
		
		local entry = {image = item.image, value = this.chosen["tweak"][group_id][name] }
		
		this.chosen["tweak"][group_id][name] = this.chosen["tweak"][group_id][name] or "default"
		local function UpdateSpinner()
			for idx=1, #desc do
				if desc[idx].data == this.chosen["tweak"][group_id][name] then			
					entry.spinner:SetSelectedIndex( idx )
				end
			end			 
		end
		
		if item.images ~= nil then
			for idx=1, #desc do
				desc[idx].image = item.images[idx]
			end			 
		end
		
		entry.spinner = Spinner( desc, 150, spinnerHeight, spinnerFont, spinner_images )
		entry.spinner.OnChanged =
				function( self, data )
					this.chosen["tweak"][group_id][name] = data				
					UpdateSpinner()		 
				end
				
		UpdateSpinner()
		
		--if item.enable == true or self.profile:IsWorldGenUnlocked(group_id, name) == true then
			entry.spinner:Enable()
		--else
		--	entry.spinner:Disable()
		--end
		
		table.insert(spinners, entry)
	end
	
	local group = self:AddSpinners(popup.proot, spinners, { -RESOLUTION_X/2 + 300, RESOLUTION_Y/2 - 200, 0 })
	group:SetScale(0.7,0.7,1)
end

function SandboxScreen:AddSpinners(popup, data, user_offset)
	local master_group = popup:AddChild( Widget( "MasterSpinnerGroup" ) )
	
	local offset = { 0, 0, 0 }
	if user_offset then
		offset[1] = offset[1] + user_offset[1]
		offset[2] = offset[2] + user_offset[2]
		offset[3] = offset[3] + user_offset[3]
	end
	master_group:SetPosition( offset[1], offset[2], offset[2] )

	local label_width = 200
	local idx = 1
	for name, entry in pairs( data ) do
		local group = master_group:AddChild( Widget( tostring(entry.text)) )
		group:SetPosition( 0, ( idx - 1 ) * -75 + 25, 0 )
		
		if entry.text ~= nil then
			local label = group:AddChild( Text( DEFAULTFONT, 30, entry.text ) )
			label:SetPosition( 0.5 * label_width, 0, 0 )
			label:SetRegionSize( label_width, 50 )
			label:SetHAlign( ANCHOR_RIGHT )
		end
		
		if entry.image ~= nil then
			local icon = group:AddChild(Image(entry.image))
			icon:SetPosition( 0.5 * label_width, 0, 0 )
			icon:SetScale( 0.7,0.7,1 )
    		icon:SetVRegPoint(ANCHOR_MIDDLE)
   			icon:SetHRegPoint(ANCHOR_LEFT)			
		end
		
		group:AddChild( deepcopy(entry.spinner ))
		entry.spinner:SetPosition( label_width + 32, 0, 0 )
		entry.spinner:Show()
		
		idx = idx +1
	end
	
	return master_group
end

function SandboxScreen:ChoosePresetTasks(level)
	--print("Setting tasks & overrides for", level.name)
--	for i, task in pairs(self.chosen["tasks"]) do
--		print(" --> off", i,task)
--		self.chosen["tasks"][task] = "off"
--	end
	self.chosen["tasks"] = {}
	
	if level.tasks ~= nil and #level.tasks >0 then
		for i, task in ipairs(level.tasks) do
			--print("--> on", task)
			if type(task) == type({}) then
		 		task = task[math.random(#task)]
			end
			self.chosen["tasks"][task] = "on"
		end
	end
	if level.optionaltasks ~= nil and #level.optionaltasks >0 then
		for i, task in ipairs(level.optionaltasks) do
			--print("->> on", task)
			if type(task) == type({}) then
		 		task = task[math.random(#task)]
			end
			
			self.chosen["tasks"][task] = "optional"
		end
	end
	
	for area, items in pairs(self.chosen["tweak"]) do
		for name, override in pairs(items) do
			self.chosen["tweak"][area][name] = nil
		end
	end

	if level.overrides ~= nil and #level.overrides >0 then
		for i, override in ipairs(level.overrides) do
			local name = override[1]
		 	if type(name) == type({}) then
		 		name = name[math.random(#name)]
			end
			if name ~= "lucky_draw"	then		
				local area = customise.GetGroupForItem(name)
				if area ~= nil then
					--print(area,name)
					self.chosen["tweak"][area][name] = override[2]
				else
					print("Cant get group for override",name)
					self.chosen[name] = override[2]
				end
			end
		end
	end
end

function SandboxScreen:OnModifyTasks()
	local popup = PopupDialogScreen( STRINGS.UI.SANDBOXMENU.MODIFYTASKS, "", { 
					{ text = STRINGS.UI.MAINSCREEN.OK, cb =
						function()
							-- Clear out all the defaults
						end
					}})
					
	--require("map/tasks")
	
	local spinners = {}
	local this = self
	--this.chosen["tasks"] = {}
	
	--dumptable(self.unlocked_tasks)
	for name, unlocked in pairs(self.unlocked_tasks) do
			
		--if true then --
		if self.profile:IsWorldGenUnlocked("tasks", name) == true then
			if this.chosen["tasks"][name] == nil then
				this.chosen["tasks"][name] = "off"
			end
			
			local entry = {text= name, value = this.chosen["tasks"][name] }

			--print("TASK:", name, this.chosen["tasks"][name])
			entry.spinner = Toggle( toggle_images )
			entry.spinner.OnChanged =
					function( self, data )
						--print(name,"OnChanged", data)
						this.chosen["tasks"][name] = data				
					end
			entry.spinner:DoToggle(this.chosen["tasks"][name])		
			
			if self.unlocked_tasks[name] == true or self.profile:IsWorldGenUnlocked("tasks", name) == true then
				entry.spinner:Enable()
			else
				entry.spinner:Disable()
			end
			
			spinners[name] = entry
		end
	end
	
	local group = self:AddSpinners(popup.proot, spinners, { 0,0, 0 })	
	group:SetScale(0.6,0.6,1)
	popup.bg:SetScale(1.5,2.3,1)
	local pos = popup.menu:GetPosition()
	popup.menu:SetPosition(pos.x+180, pos.y-100, 0)
	popup.title:SetPosition(180, 70, 0)
	TheFrontEnd:PushScreen( popup )
	
	local column_w = 300
	local row = -80
	
	local pos = Vector3(0,0,0)
	local offset = Vector3(0, 0, 0)
	
	local child_count = 0
	
	local children = {}
	for child, v in pairs(group.children) do
		children[child.name] = child
	end
	
	for name,child in pairs(children) do
		offset.y = offset.y + row
		child:SetPosition(210+offset.x, -200 + offset.y, 0)
		
		child_count = child_count + 1
		if child_count%8 == 0 then
			offset.x = offset.x + column_w
			offset.y = 0
		end
	end
	
end

function SandboxScreen:OnMenu()
	TheFrontEnd:PopScreen()
end

function SandboxScreen:OnGenerate()
--	if self.chosen["tasks"] ~= nil and GetTableSize(self.chosen["tasks"])> 0 then
--		for name,val in pairs(self.chosen["tasks"]) do
--			if val == "off" then
--				self.chosen["tasks"][name] = nil
--			end
--		end
--	end
	
	for area, items in pairs(self.chosen["tweak"]) do
		for k,v in pairs(items) do
			if v == "default" then
				self.chosen["tweak"][area][k] = nil
			end
		end
		if GetTableSize(self.chosen["tweak"][area]) == 0 then
			self.chosen["tweak"][area] = nil
		end		
	end
	if GetTableSize(self.chosen["tweak"]) == 0 then
		self.chosen["tweak"] = nil
	end		
	
	--if self.chosen["preset"][1] == "none" then
		self.chosen["preset"] = nil
	--end
	self.chosen["tasks"] = nil
	--self.profile:SetSaveSlotValue(self.save_slot_idx, "world_gen_choices", self.chosen)
	self.cb(self.chosen)
end


function SandboxScreen:ShowButtons(show)
    if show then
		self.menu:Show()
    else
		self.menu:Hide()
    end
end


