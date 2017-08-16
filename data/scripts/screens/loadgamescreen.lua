local Screen = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Menu = require "widgets/menu"
local Text = require "widgets/text"
local Image = require "widgets/image"
local UIAnim = require "widgets/uianim"
local Widget = require "widgets/widget"
require "os"
require "screens/slotdetailsscreen"
require "screens/newgamescreen"
require "fileutil"



LoadGameScreen = Class(Screen, function(self, profile)
	Screen._ctor(self, "LoadGameScreen")
    self.profile = profile
    
    self.black = self:AddChild(Image("images/global.xml", "square.tex"))
    self.black:SetVRegPoint(ANCHOR_MIDDLE)
    self.black:SetHRegPoint(ANCHOR_MIDDLE)
    self.black:SetVAnchor(ANCHOR_MIDDLE)
    self.black:SetHAnchor(ANCHOR_MIDDLE)
    self.black:SetScaleMode(SCALEMODE_FILLSCREEN)
	self.black:SetTint(0,0,0,.75)	
    
	self.root = self:AddChild(Widget("ROOT"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0,0,0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
	
    self.bg = self.root:AddChild(Image("images/fepanels.xml", "panel_saveslots.tex"))
	
	self.button = self.root:AddChild(ImageButton())
    self.button:SetText(STRINGS.UI.LOADGAMESCREEN.CANCEL)
    self.button:SetOnClick( function() TheFrontEnd:PopScreen(self) end )
    self.button:SetFont(BUTTONFONT)
    self.button:SetTextSize(35)
    self.button.text:SetVAlign(ANCHOR_MIDDLE)
    self.button.text:SetColour(0,0,0,1)
    self.button:SetPosition( 0, -250, 0)
    
    self.title = self.root:AddChild(Text(TITLEFONT, 60))
    self.title:SetPosition( 0, 215, 0)
    self.title:SetRegionSize(250,70)
    self.title:SetString(STRINGS.UI.LOADGAMESCREEN.TITLE)
    self.title:SetVAlign(ANCHOR_MIDDLE)
	
    self.menu = self.root:AddChild(Menu(nil, -98, false))
    self.menu:SetPosition( 0, 135, 0)
	
	self.default_focus = self.menu
	--self:RefreshFiles()  
end)

function LoadGameScreen:OnBecomeActive()
	self:RefreshFiles()
	LoadGameScreen._base.OnBecomeActive(self)
	print ("load become active")
end


function LoadGameScreen:OnControl(control, down)
    if Screen.OnControl(self, control, down) then return true end
    if not down and control == CONTROL_CANCEL then
        TheFrontEnd:PopScreen(self)
        return true
    end
end

function LoadGameScreen:RefreshFiles()
	self.menu:Clear()

	for k = 1, 4 do
		local tile = self:MakeSaveTile(k)
		self.menu:AddCustomItem(tile)
	end
	

	self.menu.items[1]:SetFocusChangeDir(MOVE_UP, self.button)
	self.button:SetFocusChangeDir(MOVE_DOWN, self.menu.items[1])

	self.button:SetFocusChangeDir(MOVE_UP, self.menu.items[#self.menu.items])
	self.menu.items[#self.menu.items]:SetFocusChangeDir(MOVE_DOWN, self.button)
	

end

function LoadGameScreen:MakeSaveTile(slotnum)
	
	local widget = Widget("savetile")
	widget.base = widget:AddChild(Widget("base"))
	
	local mode = SaveGameIndex:GetCurrentMode(slotnum)
	local day = SaveGameIndex:GetSlotDay(slotnum)
	local world = SaveGameIndex:GetSlotWorld(slotnum)
	local character = SaveGameIndex:GetSlotCharacter(slotnum)
	
    widget.bg = widget.base:AddChild(UIAnim())
    widget.bg:GetAnimState():SetBuild("savetile")
    widget.bg:GetAnimState():SetBank("savetile")
    widget.bg:GetAnimState():PlayAnimation("anim")
	
	widget.portraitbg = widget.base:AddChild(Image("images/saveslot_portraits.xml", "background.tex"))
	widget.portraitbg:SetScale(.65,.65,1)
	widget.portraitbg:SetPosition(-120 + 40, 2, 0)	
	widget.portraitbg:SetClickable(false)	
	
	widget.portrait = widget.base:AddChild(Image())
	widget.portrait:SetClickable(false)	
	if character and mode then	
		local atlas = (table.contains(MODCHARACTERLIST, character) and "images/saveslot_portraits/"..character..".xml") or "images/saveslot_portraits.xml"
		widget.portrait:SetTexture(atlas, character..".tex")
	else
		widget.portraitbg:Hide()
	end
	widget.portrait:SetScale(.65,.65,1)
	widget.portrait:SetPosition(-120 + 40, 2, 0)	
	
	
    widget.text = widget.base:AddChild(Text(TITLEFONT, 40))
    widget.text:SetPosition(40,0,0)
    widget.text:SetRegionSize(200 ,70)
    
    if not mode then
		widget.text:SetString(STRINGS.UI.LOADGAMESCREEN.NEWGAME)
		widget.text:SetPosition(0,0,0)
	elseif mode == "adventure" then
		widget.text:SetString(string.format("%s %d-%d",STRINGS.UI.LOADGAMESCREEN.ADVENTURE, world, day))
	elseif mode == "survival" then
		widget.text:SetString(string.format("%s %d-%d",STRINGS.UI.LOADGAMESCREEN.SURVIVAL, world, day))
	elseif mode == "cave" then
		local level = SaveGameIndex:GetCurrentCaveLevel(slotnum)
		widget.text:SetString(string.format("%s %d",STRINGS.UI.LOADGAMESCREEN.CAVE, level))
	end
	
    widget.text:SetVAlign(ANCHOR_MIDDLE)
    --widget.text:EnableWordWrap(true)
    
	widget.OnGainFocus = function(self)
		Widget.OnGainFocus(self)
    	TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_mouseover")
		widget:SetScale(1.1,1.1,1)
		widget.bg:GetAnimState():PlayAnimation("over")
	end

    widget.OnLoseFocus = function(self)
    	Widget.OnLoseFocus(self)
    	widget.base:SetPosition(0,0,0)
		widget:SetScale(1,1,1)
		widget.bg:GetAnimState():PlayAnimation("anim")
    end
        
    local screen = self
    widget.OnControl = function(self, control, down)
		if control == CONTROL_ACCEPT then
			if down then 
				widget.base:SetPosition(0,-5,0)
			else
				widget.base:SetPosition(0,0,0) 
				screen:OnClickTile(slotnum)
			end
			return true
		end
	end

	return widget
end

function LoadGameScreen:OnClickTile(slotnum)

	TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")	
	if not SaveGameIndex:GetCurrentMode(slotnum) then
		TheFrontEnd:PushScreen(NewGameScreen(slotnum))
	else
		TheFrontEnd:PushScreen(SlotDetailsScreen(slotnum))
	end
end


