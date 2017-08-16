require "screen"
require "button"
require "animbutton"
require "image"
require "uianim"

CharacterSelectScreen = Class(Screen, function(self, profile, cb, no_backbutton, default_character)
	Screen._ctor(self, "CharacterSelect")
    self.profile = profile
	self.log = true
    
    self.no_cancel = no_backbutton
    
    self.currentcharacter = nil

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

    self.fixed_root = self.root:AddChild(Widget("root"))
    self.fixed_root:SetPosition(-RESOLUTION_X/2, -RESOLUTION_Y/2, 0)
    
    self.heroportait = self.fixed_root:AddChild(Image())
    self.heroportait:SetVRegPoint(ANCHOR_BOTTOM)
    self.heroportait:SetHRegPoint(ANCHOR_LEFT)
    
    self.biobox = self.fixed_root:AddChild(Image("data/images/biobox.tex"))
    self.biobox:SetPosition(822,RESOLUTION_Y-489,0)
    
    self.charactername = self.fixed_root:AddChild(Text(TITLEFONT, 60))
    self.charactername:SetHAlign(ANCHOR_MIDDLE)
    self.charactername:SetPosition(820, RESOLUTION_Y - 400,0)
	self.charactername:SetRegionSize( 500, 70 )

    self.characterquote = self.fixed_root:AddChild(Text(UIFONT, 30))
    self.characterquote:SetHAlign(ANCHOR_MIDDLE)
    self.characterquote:SetVAlign(ANCHOR_TOP)
    self.characterquote:SetPosition(820, RESOLUTION_Y - 525 + 60,0)
	self.characterquote:SetRegionSize( 500, 60 )
	self.characterquote:EnableWordWrap( true )
	self.characterquote:SetString( "" )

    self.characterdetails = self.fixed_root:AddChild(Text(BODYTEXTFONT, 30))
    self.characterdetails:SetHAlign(ANCHOR_LEFT)
    self.characterdetails:SetVAlign(ANCHOR_TOP)
    self.characterdetails:SetPosition(820, RESOLUTION_Y - 525 - 30,0)
	self.characterdetails:SetRegionSize( 450, 120 )
	self.characterdetails:EnableWordWrap( true )
	self.characterdetails:SetString( "" )

    
	self.startbutton = self.fixed_root:AddChild(AnimButton("arrow_button"))
    self.startbutton.anim:GetAnimState():SetManualBB(0,0,180, 100)
    self.startbutton:SetPosition(1088, RESOLUTION_Y-616, 0)
    self.startbutton:SetText(STRINGS.UI.CHARACTERSELECT.PLAY)
    self.startbutton:SetOnClick(
		function()
		    self.startbutton:Disable()
			TheFrontEnd:GetSound():KillSound("FEMusic")
			if self.cb then
				self.cb(self.currentcharacter)
			end
		end)
    self.startbutton:SetFont(TITLEFONT)
    self.startbutton:SetTextSize(80)    

	if not no_backbutton then
		self.backbutton= self.fixed_root:AddChild(AnimButton("arrow_button"))
		self.backbutton.anim:GetAnimState():SetManualBB(0,0,180, 100)
	    self.backbutton.anim:SetScale(-1,1,1)
	    self.backbutton:SetPosition( 60 ,50 , 0)
	    self.backbutton:SetText(STRINGS.UI.CHARACTERSELECT.BACK)
	    self.backbutton:SetOnClick( function() if self.cb then self.cb(nil) end end)
	    self.backbutton:SetFont(TITLEFONT)
	    self.backbutton:SetTextSize(80)    
	    self.backbutton:SetScale(.5,.5,.5)
    end
    
    self.characters = CHARACTERLIST

    self.portrait_bgs = {}
    self.portraits = {}
    
    for k = 1,3 do
		local ypos = 720-300
		local xbase = 640
		local width = 190
		local xpos = xbase + (k-1) * width
		
		local portraitbg = self.fixed_root:AddChild(UIAnim())
		portraitbg:GetAnimState():SetBuild("portrait_frame")
		portraitbg:GetAnimState():SetBank("portrait_frame")
		portraitbg:GetAnimState():PlayAnimation("idle")
		portraitbg:SetLeftMouseDown(function() self:OnClickPortait(k) end)
		portraitbg:SetLeftMouseDown(function() self:OnClickPortait(k) end)
		
		portraitbg:SetMouseOver(function() if self.portrait_idx ~= k then portraitbg:GetAnimState():PlayAnimation("mouseover") end end)
		portraitbg:SetMouseOut(function() if self.portrait_idx ~= k then portraitbg:GetAnimState():PlayAnimation("idle") end end)
		
		portraitbg:SetPosition(xpos, ypos, 0)
		
		table.insert(self.portrait_bgs, portraitbg)
		
		local portrait = self.fixed_root:AddChild(Image())
		portrait:SetPosition(xpos,ypos-10,0)
		portrait:SetVRegPoint(ANCHOR_BOTTOM)
		portrait:SetClickable(false)
		table.insert(self.portraits, portrait)
    end

	self.rightbutton = self.fixed_root:AddChild(AnimButton("scroll_arrow"))
    self.rightbutton:SetPosition(1129, RESOLUTION_Y-211, 0)
    self.rightbutton:SetOnClick( function() self:Scroll(1) end)

	self.leftbutton = self.fixed_root:AddChild(AnimButton("scroll_arrow"))
    self.leftbutton:SetPosition(516, RESOLUTION_Y-211, 0)
    self.leftbutton:SetScale(-1,1,1)
    self.leftbutton:SetOnClick( function() self:Scroll(-1) end)
    
    self:SetOffset(0)
    self:SelectPortrait(1)
    self.cb = cb
    
    --TheFrontEnd:DoFadeIn(2)
    self:SelectCharacter(default_character)
end)

function CharacterSelectScreen:OnKeyUp( key )
	if key == KEY_ESCAPE and not self.no_cancel then
		if self.cb then self.cb(nil) end
	elseif key == KEY_ENTER then
		if self.currentcharacter then
			self.cb(self.currentcharacter)
		end
	end
end

function CharacterSelectScreen:OnGainFocus()
    self._base.OnGainFocus(self)
    self.startbutton:Enable()
end

function CharacterSelectScreen:OnClickPortait(portrait)
	TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
	local character = self:GetCharacterForPortrait(portrait)
	self:SelectPortrait(portrait)
end

function CharacterSelectScreen:SelectCharacter(character)
	for k,v in ipairs(self.characters) do
		if v == character then
			self:SetOffset(k-1)
			self:SelectPortrait(1)
		end
	end
end

function CharacterSelectScreen:Scroll(scroll)
	if self.portrait_idx then
		self.portrait_idx = self.portrait_idx - scroll
	end
	self:SetOffset( self.offset + scroll )
end

function CharacterSelectScreen:GetCharacterForPortrait(portrait)
	local idx = (portrait-1 + self.offset) % #self.characters + 1 
	return self.characters[idx]
end

function CharacterSelectScreen:SetOffset(offset)
	self.offset = offset
	for k = 1,3 do
		local character = self:GetCharacterForPortrait(k)
		
		self.portrait_bgs[k]:GetAnimState():PlayAnimation(k == self.portrait_idx and "selected" or "idle", true)
		
		self.portraits[k]:SetTexture("data/portraits/"..character..".tex")
		if not self.profile:IsCharacterUnlocked(character) then
			self.portraits[k]:SetTint(0,0,0,1)
		else
			self.portraits[k]:SetTint(1,1,1,1)
		end
	end	
end

function CharacterSelectScreen:SelectPortrait(portrait)
	local character = self:GetCharacterForPortrait(portrait)

	self.portrait_idx = portrait
	for k,v in pairs(self.portrait_bgs) do
		v:GetAnimState():PlayAnimation("idle")
	end

	if self.portrait_bgs[portrait] then
		self.portrait_bgs[portrait]:GetAnimState():PlayAnimation("selected", true)
	end

	if character and self.profile:IsCharacterUnlocked(character) then
		self.heroportait:SetTexture("data/bigportraits/"..character..".tex")
		self.currentcharacter = character
		self.charactername:SetString(STRINGS.CHARACTER_TITLES[character] or "")
		self.characterquote:SetString(STRINGS.CHARACTER_QUOTES[character] or "")
		self.characterdetails:SetString(STRINGS.CHARACTER_DESCRIPTIONS[character] or "")
		self.startbutton:Enable()
	else
		self.heroportait:SetTexture("data/bigportraits/locked.tex")		
		self.charactername:SetString(STRINGS.CHARACTER_NAMES.unknown)
		self.characterquote:SetString("")
		self.characterdetails:SetString("")
		self.startbutton:Disable()
	end
end

