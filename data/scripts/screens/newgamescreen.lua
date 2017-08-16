require "screen"
require "button"
require "animbutton"
require "image"
require "uianim"
require "os"
require "screens/worldgenscreen"
require "screens/sandboxscreen"
require "screens/characterselectscreen"

NewGameScreen = Class(Screen, function(self, slotnum)
	Screen._ctor(self, "LoadGameScreen")
    self.profile = Profile
    self.saveslot = slotnum
    self.character = "wilson"

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
    self.cancelbutton:SetText(STRINGS.UI.NEWGAMESCREEN.CANCEL)
    self.cancelbutton:SetOnClick( function() TheFrontEnd:PopScreen(self) end )
    self.cancelbutton:SetFont(BUTTONFONT)
    self.cancelbutton:SetTextSize(35)
    self.cancelbutton.text:SetVAlign(ANCHOR_MIDDLE)
    self.cancelbutton.text:SetColour(0,0,0,1)
    self.cancelbutton:SetPosition( 0, -235, 0)
    
    self.title = self.root:AddChild(Text(TITLEFONT, 60))
    self.title:SetPosition( 0, 230, 0)
    self.title:SetRegionSize(250,70)
    self.title:SetString(STRINGS.UI.NEWGAMESCREEN.TITLE .. " " .. tostring(slotnum))
    self.title:SetVAlign(ANCHOR_MIDDLE)

	self.playerimage = self.root:AddChild(Widget("playerimage"))
	self.playerimage:SetPosition(0, 130, 0)
	self.playerimage:SetScale(1.6,1.6,1.6)
	self.portrait_bg = self.playerimage:AddChild(Image("data/images/portrait_bg.tex"))
	self.portrait_bg:SetClickable(false)		
	self.portrait_bg:SetScale(.6,.6,1)
	self.portrait_bg:SetVRegPoint(ANCHOR_MIDDLE)
   	self.portrait_bg:SetHRegPoint(ANCHOR_MIDDLE)
	
	self.portrait = self.playerimage:AddChild(Image())
	self.portrait:SetVRegPoint(ANCHOR_MIDDLE)
   	self.portrait:SetHRegPoint(ANCHOR_MIDDLE)
	self.portrait:SetClickable(false)		
	self.portrait:SetTexture("data/portraits/"..self.character..".tex")
	self.portrait:SetScale(.5,.5,1)
    
    
    local menuitems = 
    {
		{name = STRINGS.UI.NEWGAMESCREEN.CHANGECHARACTER, fn = function() self:ChangeCharacter() end},
		{name = STRINGS.UI.NEWGAMESCREEN.CUSTOMIZE, fn = function() self:Customize() end},
		{name = STRINGS.UI.NEWGAMESCREEN.START, fn = function() self:Start() end},
    }
    
    for k,v in pairs(menuitems) do
    	local button = self.root:AddChild(AnimButton("button"))
		--button:SetScale(.8,.8,.8)
		button:SetText(v.name)
		button:SetOnClick( v.fn )
		button:SetFont(BUTTONFONT)
		button:SetTextSize(35)
		button.text:SetVAlign(ANCHOR_MIDDLE)
		button.text:SetColour(0,0,0,1)
		button:SetPosition( 0, 100 - k*75, 0)
    end
    
end)


function NewGameScreen:OnKeyUp( key )
	if key == KEY_ESCAPE then
		TheFrontEnd:PopScreen(self)
	end
end

function NewGameScreen:Customize( )
	
	local function onSet(options)
		TheFrontEnd:PopScreen()
		if options then
			self.customoptions = options
		end
	end
	TheFrontEnd:PushScreen(SandboxScreen(Profile, onSet,self.customoptions))
end

function NewGameScreen:ChangeCharacter(  )
	
	local function onSet(character)
		TheFrontEnd:PopScreen()
		if character then

			self.character = character
			self.portrait:SetTexture("data/portraits/"..self.character..".tex")
		end
	end
	TheFrontEnd:PushScreen(CharacterSelectScreen(Profile, onSet, false, self.character))
end



function NewGameScreen:Start()
	local function onsaved()
	    local params = json.encode{reset_action="loadslot", save_slot = self.saveslot}
	    TheSim:SetInstanceParameters(params)
	    TheSim:Reset()
	end

	self.root:Disable()
	TheFrontEnd:Fade(false, 1, function() SaveGameIndex:StartSurvivalMode(self.saveslot, self.character, self.customoptions, onsaved) end )
end
