require "screen"
require "button"
require "animbutton"
require "image"
require "uianim"
require "os"

SlotDetailsScreen = Class(Screen, function(self, slotnum)
	Screen._ctor(self, "LoadGameScreen")
    self.profile = Profile
    self.saveslot = slotnum

	local mode = SaveGameIndex:GetCurrentMode(slotnum)
	local day = SaveGameIndex:GetSlotDay(slotnum)
	local world = SaveGameIndex:GetSlotWorld(slotnum)
	local character = SaveGameIndex:GetSlotCharacter(slotnum) or "wilson"
	self.character = character

    
	self.root = self:AddChild(Widget("ROOT"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0,-20,0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
	
    self.bg = self.root:AddChild(UIAnim())
    self.bg:GetAnimState():SetBuild("panel_saveslots")
    self.bg:GetAnimState():SetBank("panel_saveslots")
    self.bg:GetAnimState():PlayAnimation("anim")
    
	self.cancelbutton = self.root:AddChild(AnimButton("button"))
	self.cancelbutton:SetScale(.8,.8,.8)
    self.cancelbutton:SetText(STRINGS.UI.SLOTDETAILSSCREEN.CANCEL)
    self.cancelbutton:SetOnClick( function() TheFrontEnd:PopScreen(self) end )
    self.cancelbutton:SetFont(BUTTONFONT)
    self.cancelbutton:SetTextSize(35)
    self.cancelbutton.text:SetVAlign(ANCHOR_MIDDLE)
    self.cancelbutton.text:SetColour(0,0,0,1)
    self.cancelbutton:SetPosition( 0, -235, 0)
    
    self.title = self.root:AddChild(Text(TITLEFONT, 60))
    self.title:SetPosition( 0, 230, 0)
    self.title:SetRegionSize(250,70)
    self.title:SetString(STRINGS.UI.SLOTDETAILSSCREEN.TITLE .. " " .. tostring(slotnum))
    self.title:SetVAlign(ANCHOR_MIDDLE)

    self.text = self.root:AddChild(Text(TITLEFONT, 40))
    self.text:SetPosition( 30, 150, 0)
    self.text:SetRegionSize(200,50)
    self.text:SetHAlign(ANCHOR_LEFT)


	self.playerimage = self.root:AddChild(Widget("playerimage"))
	self.playerimage:SetPosition(-130, 150, 0)
	self.playerimage:SetScale(1.5,1.5,1.5)
	self.portrait_bg = self.playerimage:AddChild(Image("data/images/portrait_bg.tex"))
	self.portrait_bg:SetClickable(false)		
	self.portrait_bg:SetScale(.6,.6,1)
	self.portrait_bg:SetVRegPoint(ANCHOR_MIDDLE)
   	self.portrait_bg:SetHRegPoint(ANCHOR_MIDDLE)
	
	self.portrait = self.playerimage:AddChild(Image())
	self.portrait:SetVRegPoint(ANCHOR_MIDDLE)
   	self.portrait:SetHRegPoint(ANCHOR_MIDDLE)
	self.portrait:SetClickable(false)		
	self.portrait:SetTexture("data/portraits/"..character..".tex")
	self.portrait:SetScale(.5,.5,1)
    

    self:BuildMenu()
   
end)

function SlotDetailsScreen:BuildMenu()


	local mode = SaveGameIndex:GetCurrentMode(self.saveslot)
	local day = SaveGameIndex:GetSlotDay(self.saveslot)
	local world = SaveGameIndex:GetSlotWorld(self.saveslot)
	local character = SaveGameIndex:GetSlotCharacter(self.saveslot) or "wilson"


	if self.menu then
		self.menu:Kill()
	end

	self.menu = self.root:AddChild(Widget("menu"))

    local menuitems = 
    {
		{name = STRINGS.UI.SLOTDETAILSSCREEN.CONTINUE, fn = function() self:Continue() end},
		{name = STRINGS.UI.SLOTDETAILSSCREEN.DELETE, fn = function() self:Delete() end},
	}

	if mode == "adventure" then
		self.text:SetString(string.format("%s %d-%d",STRINGS.UI.LOADGAMESCREEN.ADVENTURE, world, day))
	elseif mode == "survival" then
		self.text:SetString(string.format("%s %d-%d",STRINGS.UI.LOADGAMESCREEN.SURVIVAL, world, day))
	else
		--shouldn't actually happen...
		self.text:SetString(string.format("%s",STRINGS.UI.LOADGAMESCREEN.NEWGAME))
	end 
    
    for k,v in pairs(menuitems) do
    	local button = self.menu:AddChild(AnimButton("button"))
		--button:SetScale(.8,.8,.8)
		button:SetText(v.name)
		button:SetOnClick( v.fn )
		button:SetFont(BUTTONFONT)
		button:SetTextSize(35)
		button.text:SetVAlign(ANCHOR_MIDDLE)
		button.text:SetColour(0,0,0,1)
		button:SetPosition( 0, 100 - k*75, 0)
    end

end

function SlotDetailsScreen:OnKeyUp( key )
	if key == KEY_ESCAPE then
		TheFrontEnd:PopScreen(self)
	end
end


function SlotDetailsScreen:Delete()

	local menu_items = 
	{
		-- ENTER
		{
			text=STRINGS.UI.MAINSCREEN.DELETE, 
			cb = function()
				SaveGameIndex:DeleteSlot(self.saveslot, function() TheFrontEnd:PopScreen(self) end)
			end
		},
		-- ESC
		{text=STRINGS.UI.MAINSCREEN.CANCEL, cb = function() end},
	}

	TheFrontEnd:PushScreen(
		PopupDialogScreen(STRINGS.UI.MAINSCREEN.DELETE.." "..STRINGS.UI.MAINSCREEN.SLOT.." "..self.saveslot, STRINGS.UI.MAINSCREEN.SURE, menu_items ) )

end

function SlotDetailsScreen:Continue()

	self.root:Disable()
	TheFrontEnd:Fade(false, 1, function() 
		TheSim:SetInstanceParameters(json.encode{reset_action="loadslot", save_slot = self.saveslot})
		TheSim:Reset()
	 end)
end
