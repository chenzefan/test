local Screen = require "widgets/screen"
local AnimButton = require "widgets/animbutton"
local Spinner = require "widgets/spinner"
local ImageButton = require "widgets/imagebutton"
local Text = require "widgets/text"
local Image = require "widgets/image"
local NumericSpinner = require "widgets/numericspinner"
local Toggle = require "widgets/toggle"
local Widget = require "widgets/widget"
local UIAnim = require "widgets/uianim"
require "screens/popupdialog"


local text_font = DEFAULTFONT--NUMBERFONT

local display_rows = 5

local DISABLE = 0
local ENABLE = 1

    
local left_col =-RESOLUTION_X*.26
local mid_col = RESOLUTION_X*.15
local right_col = RESOLUTION_X*.41

ModsScreen = Class(Screen, function(self, cb)
    Widget._ctor(self, "ModsScreen")
	self.cb = cb

	-- save current mod index before user configuration
	KnownModIndex:CacheSaveData()
	-- get the latest mod info
	KnownModIndex:UpdateModInfo()

	self.modnames = KnownModIndex:GetModNames()
	local function alphasort(moda, modb)
		if not moda then return false end
		if not modb then return true end
		print("comparing "..moda.." and "..modb)
		return string.lower(KnownModIndex:GetModFancyName(moda)) < string.lower(KnownModIndex:GetModFancyName(modb))
	end
	table.sort(self.modnames, alphasort)

	self.infoprefabs = {}
	self:LoadModInfoPrefabs(self.infoprefabs)

    self.bg = self:AddChild(Image("images/ui.xml", "bg_plain.tex"))
    self.bg:SetTint(BGCOLOURS.RED[1],BGCOLOURS.RED[2],BGCOLOURS.RED[3], 1)

    self.bg:SetVRegPoint(ANCHOR_MIDDLE)
    self.bg:SetHRegPoint(ANCHOR_MIDDLE)
    self.bg:SetVAnchor(ANCHOR_MIDDLE)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
    self.bg:SetScaleMode(SCALEMODE_FILLSCREEN)
    
    self.root = self:AddChild(Widget("root"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)

    --menu buttons
    
	self.applybutton = self.root:AddChild(ImageButton())
    self.applybutton:SetPosition(right_col, 60, 0)
    self.applybutton:SetText(STRINGS.UI.MODSSCREEN.APPLY)
    self.applybutton.text:SetColour(0,0,0,1)
    self.applybutton:SetOnClick( function() self:Apply() end )
    self.applybutton:SetFont(BUTTONFONT)
    self.applybutton:SetTextSize(40)    
    
	self.morebutton = self.root:AddChild(ImageButton())
    self.morebutton:SetPosition(right_col, -50, 0)
    self.morebutton:SetText(STRINGS.UI.MODSSCREEN.MOREMODS)
    self.morebutton.text:SetColour(0,0,0,1)
    self.morebutton:SetOnClick( function() self:MoreMods() end )
    self.morebutton:SetFont(BUTTONFONT)
    self.morebutton:SetTextSize(40)
    
	self.cancelbutton = self.root:AddChild(ImageButton())
    self.cancelbutton:SetPosition(right_col, -120, 0)
    self.cancelbutton:SetText(STRINGS.UI.MODSSCREEN.CANCEL)
    self.cancelbutton.text:SetColour(0,0,0,1)
    self.cancelbutton:SetOnClick( function() self:Cancel() end )
    self.cancelbutton:SetFont(BUTTONFONT)
    self.cancelbutton:SetTextSize(40)

	-- mod details panel
	self:CreateDetailPanel()

	self.option_offset = 0
    self.optionspanel = self.root:AddChild(Widget("optionspanel"))
    self.optionspanel:SetPosition(left_col,0,0)
    self.optionspanelbg = self.optionspanel:AddChild(Image("images/fepanels.xml", "panel_mod1.tex"))

	self.leftbutton = self.optionspanel:AddChild(AnimButton("scroll_arrow"))
    self.leftbutton:SetPosition(0, 290, 0)
	--self.leftbutton:SetScale(-1,1,1)
	self.leftbutton:SetRotation(-90)
    self.leftbutton:SetOnClick( function() self:Scroll(-display_rows) end)
	
	self.rightbutton = self.optionspanel:AddChild(AnimButton("scroll_arrow"))
    self.rightbutton:SetPosition(0, -300, 0)
	self.rightbutton:SetRotation(90)
    self.rightbutton:SetOnClick( function() self:Scroll(display_rows) end)	

	self.optionwidgets = {}
	self:Scroll(0) -- resets the scroll arrows and populates the list

	if #self.modnames > 0 then
		self:ShowModDetails(1)
	end

	self:StartWorkshopUpdate()
end)

function ModsScreen:CreateDetailPanel()
	if self.detailpanel then
		self.detailpanel:Kill()
	end

    self.detailpanel = self.root:AddChild(Widget("detailpanel"))
    self.detailpanel:SetPosition(mid_col,0,0)
    self.detailpanelbg = self.detailpanel:AddChild(Image("images/fepanels.xml", "panel_mod2.tex"))
    self.detailpanelbg:SetScale(1,1, 1)

	if #self.modnames > 0 then
		self.detailimage = self.detailpanel:AddChild(Image("images/ui.xml", "portrait_bg.tex"))
		self.detailimage:SetScale(0.8,0.8,0.8) -- REMOVE THIS!! Just for testing with placeholder images
		self.detailimage:SetPosition(-130,157,0)

		self.detailtitle = self.detailpanel:AddChild(Text(TITLEFONT, 40))
		self.detailtitle:SetHAlign(ANCHOR_LEFT)
		self.detailtitle:SetPosition(70, 170, 0)
		self.detailtitle:SetRegionSize( 270, 70 )

		--self.detailversion = self.detailpanel:addchild(text(titlefont, 20))
		--self.detailversion:setvalign(anchor_top)
		--self.detailversion:sethalign(anchor_left)
		--self.detailversion:setposition(200, 100, 0)
		--self.detailversion:setregionsize( 180, 70 )

		self.detailauthor = self.detailpanel:AddChild(Text(TITLEFONT, 30))
		self.detailauthor:SetColour(1.0,1.0,1.0,1)
		--self.detailauthor:SetColour(0.9,0.8,0.6,1) -- link colour
		self.detailauthor:SetHAlign(ANCHOR_LEFT)
		self.detailauthor:SetPosition(70, 125, 0)
		self.detailauthor:SetRegionSize( 270, 70 )
		self.detailauthor:EnableWordWrap(true)

		self.detaildesc = self.detailpanel:AddChild(Text(BODYTEXTFONT, 25))
		self.detaildesc:SetPosition(6, 18, 0)
		self.detaildesc:SetRegionSize( 352, 165 )
		self.detaildesc:EnableWordWrap(true)

		self.detailwarning = self.detailpanel:AddChild(Text(BODYTEXTFONT, 25))
		self.detailwarning:SetColour(0.9,0,0,1)
		self.detailwarning:SetPosition(112, -157, 0)
		self.detailwarning:SetRegionSize( 140, 107 )
		self.detailwarning:EnableWordWrap(true)
		
		self.modlinkbutton = self.detailpanel:AddChild(ImageButton("images/ui.xml", "blank.tex","blank.tex","blank.tex","blank.tex" ))
		self.modlinkbutton:SetPosition(5, -89, 0)
		self.modlinkbutton:SetText(STRINGS.UI.MODSSCREEN.MODLINK)
		self.modlinkbutton:SetFont(BUTTONFONT)
		self.modlinkbutton:SetTextSize(30)
		self.modlinkbutton:SetTextColour(0.9,0.8,0.6,1)
		self.modlinkbutton:SetTextFocusColour(1,1,1,1)
		self.modlinkbutton:SetOnClick( function() self:ModLinkCurrent() end )
		
		local enableoptions = {{text="Disabled", data=DISABLE},{text="Enabled",data=ENABLE}}
		self.enablespinner = self.detailpanel:AddChild(Spinner(enableoptions, 200, 60))
		self.enablespinner:SetTextColour(0,0,0,1)
		self.enablespinner:SetPosition(-100, -150, 0)
		self.enablespinner.OnChanged = function( _, data )
			self:EnableCurrent(data)
		end

	else
		self.detaildesc = self.detailpanel:AddChild(Text(BODYTEXTFONT, 25))
		self.detaildesc:SetPosition(6, 18, 0)
		self.detaildesc:SetRegionSize( 352, 165 )
		self.detaildesc:EnableWordWrap(true)
		self.detaildesc:SetString(STRINGS.UI.MODSSCREEN.NO_MODS)

		self.modlinkbutton = self.detailpanel:AddChild(ImageButton("images/ui.xml", "blank.tex","blank.tex","blank.tex","blank.tex" ))
		self.modlinkbutton:SetPosition(5, -89, 0)
		self.modlinkbutton:SetFont(BUTTONFONT)
		self.modlinkbutton:SetTextSize(30)
		self.modlinkbutton:SetTextColour(0.9,0.8,0.6,1)
		self.modlinkbutton:SetTextFocusColour(1,1,1,1)
		self.modlinkbutton:SetText(STRINGS.UI.MODSSCREEN.NO_MODS_LINK)
		self.modlinkbutton:SetOnClick( function() self:MoreMods() end )
		
	end

	-- Workshop blinker

	self.workshopupdatenote = self.detailpanel:AddChild(Text(TITLEFONT, 40))
	self.workshopupdatenote:SetHAlign(ANCHOR_MIDDLE)
	self.workshopupdatenote:SetPosition(0, -270, 0)
	self.workshopupdatenote:SetString("Updating Steam Workshop mods...")
	self.workshopupdatenote:Hide()

end

-- Not currently used, for testing only.
local function OnUpdateWorkshopModsComplete(success, msg)
	print("OnUpdateWorkshopModsComplete", success, msg)

	local status = TheSim:GetWorkshopUpdateStatus()
	for k,v in pairs(status) do
		print("-", k, v)
	end

	local modInfo = TheSim:GetWorkshopMods()
	for i,v in ipairs(modInfo) do
		print("   ", i)
		for k,v in pairs(v) do
			print("   ", k, v)
		end
	end
end


function ModsScreen:StartWorkshopUpdate()
	if TheSim:UpdateWorkshopMods( function() self:WorkshopUpdateComplete() end ) then
		self.updatetask = scheduler:ExecutePeriodic(0, self.ShowWorkshopStatus, nil, 0, self )
		self.workshopupdatenote:Show()
	end
end

function ModsScreen:WorkshopUpdateComplete(status, message) --bool, string
	self.updatetask:Cancel()
	self.updatetask = nil
	self.workshopupdatenote:SetString("Workshop Mods Updated!")

	KnownModIndex:UpdateModInfo()
	self.modnames = KnownModIndex:GetModNames()

	self:ReloadModInfoPrefabs()

	self:CreateDetailPanel()
	self:Scroll(0)
end

function ModsScreen:ShowWorkshopStatus()
end

function ModsScreen:OnControl(control, down)
	if ModsScreen._base.OnControl(self, control, down) then return true end
	
	if not down and control == CONTROL_CANCEL then TheFrontEnd:PopScreen() return true end
end

function ModsScreen:RefreshOptions()

	for k,v in pairs(self.optionwidgets) do
		v:Kill()
	end
	self.optionwidgets = {}
	
	
	local page_total = math.min(#self.modnames - self.option_offset, display_rows)
	for k = 1, page_total do
	
		local idx = self.option_offset+k

		local modname = self.modnames[idx]
		local modinfo = KnownModIndex:GetModInfo(modname)
		
		local opt = self.optionspanel:AddChild(Widget("option"))
		
		opt.bg = opt:AddChild(UIAnim())
		opt.bg:GetAnimState():SetBuild("savetile")
		opt.bg:GetAnimState():SetBank("savetile")
		opt.bg:GetAnimState():PlayAnimation("anim")

		opt.image = opt:AddChild(Image("images/ui.xml", "portrait_bg.tex"))
		local imscale = .6
		opt.image:SetScale(imscale,imscale,imscale)
		opt.image:SetPosition(-115,0,0)
		if modinfo and modinfo.icon and modinfo.icon_atlas then
			opt.image:SetTexture("../mods/"..modname.."/"..modinfo.icon_atlas, modinfo.icon)
		end

		opt.name = opt:AddChild(Text(TITLEFONT, 35))
		opt.name:SetVAlign(ANCHOR_MIDDLE)
		opt.name:SetHAlign(ANCHOR_LEFT)
		opt.name:SetPosition(52, 8, 0)
		opt.name:SetRegionSize( 240, 50 )
		opt.name:SetString(modname)
		if modinfo and modinfo.name then
			opt.name:SetString(modinfo.name)
		end

		opt.status = opt:AddChild(Text(BODYTEXTFONT, 20))
		opt.status:SetVAlign(ANCHOR_MIDDLE)
		opt.status:SetHAlign(ANCHOR_LEFT)
		opt.status:SetPosition(53, -22, 0)
		opt.status:SetRegionSize( 240, 50 )
		opt.status:SetString(modname)
		local modStatus = self:GetBestModStatus(modname)
		if modStatus == "WORKING_NORMALLY" then
			opt.status:SetString(STRINGS.UI.MODSSCREEN.STATUS.WORKING_NORMALLY)
		elseif modStatus == "WILL_ENABLE" then
			opt.status:SetString(STRINGS.UI.MODSSCREEN.STATUS.WILL_ENABLE)
		elseif modStatus == "WILL_DISABLE" then
			opt.status:SetColour(.7,.7,.7,1)
			opt.status:SetString(STRINGS.UI.MODSSCREEN.STATUS.WILL_DISABLE)
		elseif modStatus == "DISABLED_ERROR" then
			opt.status:SetColour(0.9,0.3,0.3,1)
			opt.status:SetString(STRINGS.UI.MODSSCREEN.STATUS.DISABLED_ERROR)
		elseif modStatus == "DISABLED_OLD" then
			opt.status:SetColour(0.9,0.3,0.3,1)
			opt.status:SetString(STRINGS.UI.MODSSCREEN.STATUS.DISABLED_OLD)
		elseif modStatus == "DISABLED_MANUAL" then
			opt.status:SetColour(.7,.7,.7,1)
			opt.status:SetString(STRINGS.UI.MODSSCREEN.STATUS.DISABLED_MANUAL)
		end

		if KnownModIndex:IsModEnabled(modname) then
			opt.image:SetTint(1,1,1,1)
			opt.name:SetColour(1,1,1,1)
		else
			opt.image:SetTint(1.0,0.5,0.5,1)
			opt.name:SetColour(.7,.7,.7,1)
		end
		
		local spacing = 105
		
		
		opt.OnGainFocus =
			function()
				TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_mouseover")
				opt:SetScale(1.1,1.1,1)
				opt.bg:GetAnimState():PlayAnimation("over")
			end

		opt.OnLoseFocus =
			function()
				opt:SetScale(1,1,1)
				opt.bg:GetAnimState():PlayAnimation("anim")
			end
			
		opt.OnControl =function(_, control, down) 
				if Widget.OnControl(opt, control, down) then return true end
				if control == CONTROL_ACCEPT and not down then self:ShowModDetails(idx) return true end 
			end

		opt:SetPosition(0, (display_rows-1)*spacing*.5 - (k-1)*spacing - 00, 0)
		
		table.insert(self.optionwidgets, opt)
	end
end


function ModsScreen:Scroll(dir)
	if (dir > 0 and (self.option_offset + display_rows) < #self.modnames) or
		(dir < 0 and self.option_offset + dir >= 0) then
	
		self.option_offset = self.option_offset + dir
	end
	
	self:RefreshOptions()

	if self.option_offset > 0 then
		self.leftbutton:Show()
	else
		self.leftbutton:Hide()
	end
	
	if self.option_offset + display_rows < #self.modnames then
		self.rightbutton:Show()
	else
		self.rightbutton:Hide()
	end
end

function ModsScreen:GetBestModStatus(modname)
	local modinfo = KnownModIndex:GetModInfo(modname)
	if KnownModIndex:IsModEnabled(modname) then
		if KnownModIndex:WasModEnabled(modname) then
			return "WORKING_NORMALLY"
		else
			return "WILL_ENABLE"
		end
	else
		if KnownModIndex:WasModEnabled(modname) then
			return "WILL_DISABLE"
		else
			if KnownModIndex:GetModInfo(modname).failed or KnownModIndex:IsModKnownBad(modname) then
				return "DISABLED_ERROR"
			elseif KnownModIndex:GetModInfo(modname).old then
				return "DISABLED_OLD"
			else
				return "DISABLED_MANUAL"
			end
		end
	end
end

function ModsScreen:ShowModDetails(idx)
	self.currentmod = idx

	local modname = self.modnames[idx]
	local modinfo = KnownModIndex:GetModInfo(modname)

	if modinfo.icon and modinfo.icon_atlas then
		self.detailimage:SetTexture("../mods/"..modname.."/"..modinfo.icon_atlas, modinfo.icon)
	else
		self.detailimage:SetTexture("images/ui.xml", "portrait_bg.tex")
	end
	if modinfo.name then
		self.detailtitle:SetString(modinfo.name)
	else
		self.detailtitle:SetString(modname)
	end
	if modinfo.version then
		--self.detailversion:setstring( string.format(strings.ui.modsscreen.version, modinfo.version))
	else
		--self.detailversion:setstring( string.format(strings.ui.modsscreen.version, 0))
	end
	if modinfo.author then
		self.detailauthor:SetString( string.format(STRINGS.UI.MODSSCREEN.AUTHORBY, modinfo.author))
	else
		self.detailauthor:SetString( string.format(STRINGS.UI.MODSSCREEN.AUTHORBY, "unknown"))
	end
	if modinfo.description then
		self.detaildesc:SetString(modinfo.description)
	else
		self.detaildesc:SetString("")
	end

	if modinfo.forumthread then
		self.modlinkbutton:SetText(STRINGS.UI.MODSSCREEN.MODLINK)
	else
		self.modlinkbutton:SetText(STRINGS.UI.MODSSCREEN.MODLINKGENERIC)
	end

	self.detailwarning:SetColour(1,1,1,1)
	local modStatus = self:GetBestModStatus(modname)
	if modStatus == "WORKING_NORMALLY" then
		self.enablespinner:SetSelected(ENABLE)
		self.detailwarning:SetString(STRINGS.UI.MODSSCREEN.WORKING_NORMALLY)
	elseif modStatus == "WILL_ENABLE" then
		self.enablespinner:SetSelected(ENABLE)
		self.detailwarning:SetString(STRINGS.UI.MODSSCREEN.WILL_ENABLE)
	elseif modStatus == "WILL_DISABLE" then
		self.enablespinner:SetSelected(DISABLE)
		self.detailwarning:SetString(STRINGS.UI.MODSSCREEN.WILL_DISABLE)
	elseif modStatus == "DISABLED_ERROR" then
		self.enablespinner:SetSelected(DISABLE)
		self.detailwarning:SetColour(0.9,0.3,0.3,1)
		self.detailwarning:SetString(STRINGS.UI.MODSSCREEN.DISABLED_ERROR)
	elseif modStatus == "DISABLED_OLD" then
		self.enablespinner:SetSelected(DISABLE)
		self.detailwarning:SetColour(0.9,0.3,0.3,1)
		self.detailwarning:SetString(STRINGS.UI.MODSSCREEN.DISABLED_OLD)
	elseif modStatus == "DISABLED_MANUAL" then
		self.enablespinner:SetSelected(DISABLE)
		self.detailwarning:SetString(STRINGS.UI.MODSSCREEN.DISABLED_MANUAL)
	end
end

function ModsScreen:EnableCurrent(data)
	local modname = self.modnames[self.currentmod]
	if data == DISABLE then
		KnownModIndex:Disable(modname)
	else
		KnownModIndex:Enable(modname)
	end
	self:Scroll(0)
	self:ShowModDetails(self.currentmod)
end

function ModsScreen:ModLinkCurrent()
	local modname = self.modnames[self.currentmod]
	local thread = KnownModIndex:GetModInfo(modname).forumthread
	
	local url = ""
	if thread then
		url = "http://forums.kleientertainment.com/index.php?%s"
		url = string.format(url, KnownModIndex:GetModInfo(modname).forumthread)
	else
		url = "http://forums.kleientertainment.com/index.php?/forum/26-dont-starve-mods-and-tools/"
	end
	VisitURL(url)
end

function ModsScreen:MoreMods()
	VisitURL("http://forums.kleientertainment.com/downloads.php")
end

function ModsScreen:Cancel()
	KnownModIndex:RestoreCachedSaveData()
	self:UnloadModInfoPrefabs(self.infoprefabs)
	self.cb(false)
end

function ModsScreen:Apply()
	KnownModIndex:Save()
	self:UnloadModInfoPrefabs(self.infoprefabs)
	self.cb(true)
end

function ModsScreen:LoadModInfoPrefabs(prefabtable)
	for i,modname in ipairs(KnownModIndex:GetModNames()) do
		local info = KnownModIndex:GetModInfo(modname)
		if info.icon_atlas and info.icon then
			local modinfoassets = {
				Asset("ATLAS", "../mods/"..modname.."/"..info.icon_atlas),
				Asset("IMAGE", "../mods/"..modname.."/"..info.icon),
			}
			local prefab = Prefab("modbaseprefabs/MODSCREEN_"..modname, nil, modinfoassets, nil)
			RegisterPrefabs( prefab )
			table.insert(prefabtable, prefab.name)
		end
	end

	print("Loading Mod Info Prefabs")
	TheSim:ForceLoadPrefabs( prefabtable )
end

function ModsScreen:UnloadModInfoPrefabs(prefabtable)
	print("Unloading Mod Info Prefabs")
	TheSim:ForceUnloadPrefabs( prefabtable )
	for k,v in pairs(prefabtable) do
		prefabtable[k] = nil
	end
end

function ModsScreen:ReloadModInfoPrefabs()
	print("Reloading Mod Info Prefabs")
	-- load before unload -- this prevents the refcounts of prefabs from going 1,
	-- 0, 1 (which triggers a resource unload and crashes). Instead we load first,
	-- so the refcount goes 1, 2, 1 for existing prefabs so everything stays the
	-- same.
	local oldprefabs = self.infoprefabs
	local newprefabs = {}
	self:LoadModInfoPrefabs(newprefabs)
	self:UnloadModInfoPrefabs(oldprefabs)
	self.infoprefabs = newprefabs
end
