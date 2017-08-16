require "screen"
require "button"
require "animbutton"
require "image"
require "uianim"

local MAX_HUD_SCALE = 1.25

require "screens/consolescreen"

require("widgets/statusdisplays")
require("widgets/inventorybar")
require("widgets/hoverer")
require("widgets/crafting")
require("widgets/mapwidget")
require("widgets/containerwidget")

local easing = require("easing")

local Sim = TheSim
local gettime = GetTime

local debugstr = {}
local MAX_CONSOLE_LINES = 15
local consolelog = function(...)

    local str = ""
    for i,v in ipairs({...}) do
        str = str..tostring(v)
    end

    table.insert(debugstr, str)

    while #debugstr > MAX_CONSOLE_LINES do
        table.remove(debugstr,1)
    end
end

addprintlogger(consolelog)

local Controls = Class(Widget, function(self, owner)
    Widget._ctor(self, "Controls")
    self.owner = owner
    
    --overlays
    self.clouds = self:AddChild(UIAnim())
    self.clouds:SetClickable(false)
    self.clouds:SetHAnchor(ANCHOR_MIDDLE)
    self.clouds:SetVAnchor(ANCHOR_MIDDLE)
    self.clouds:GetAnimState():SetBank("clouds_ol")
    self.clouds:GetAnimState():SetBuild("clouds_ol")
    self.clouds:GetAnimState():PlayAnimation("idle", true)
    self.clouds:GetAnimState():SetMultColour(1,1,1,0)
    self.clouds:Hide()

    self.iceover = self:AddChild(IceOver(owner))
    self.iceover:Hide()
    self.fireover = self:AddChild(FireOver(owner))
    self.fireover:Hide()


	self:MakeScalingNodes()

	self.minimap = self:AddChild(MapWidget(self.owner))
	self.minimap:Hide()

	--these are visible above the map
    self.bottomright_root = self:AddChild(Widget(""))
    self.bottomright_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.bottomright_root:SetHAnchor(ANCHOR_RIGHT)
    self.bottomright_root:SetVAnchor(ANCHOR_BOTTOM)
    self.bottomright_root:SetMaxPropUpscale(MAX_HUD_SCALE)
	self.bottomright_root = self.bottomright_root:AddChild(Widget(""))



	------ CONSOLE -----------	
	
	self.consoletext = self.bottom_root:AddChild(Text(BODYTEXTFONT, 20, "CONSOLE TEXT"))
	self.consoletext:SetVAlign(ANCHOR_BOTTOM)
	self.consoletext:SetHAlign(ANCHOR_LEFT)
	self.consoletext:SetRegionSize(850, 700)
	self.consoletext:SetPosition(0,500,0)
	self.consoletext:Hide()
    -----------------


    
    self.saving = self:AddChild(SavingIndicator(self.owner))
    self.saving:SetHAnchor(ANCHOR_MIDDLE)
    self.saving:SetVAnchor(ANCHOR_TOP)
    self.saving:SetPosition(Vector3(200,0,0))
    
    self.inv = self.bottom_root:AddChild(Inv(self.owner))
    
    self.crafttabs = self.left_root:AddChild(CraftTabs(self.owner))
    local scale = .65
    self.crafttabs:SetScale(scale,scale,scale)
    


	self.sidepanel = self.topright_root:AddChild(Widget("sidepanel"))
	self.sidepanel:SetScale(.9,.9,.9)
	self.sidepanel:SetPosition(-80, -60, 0)
    self.status = self.sidepanel:AddChild(Status(self.owner))
    self.status:SetPosition(0,-110,0)
    self.status:SetScale(.9,.9,.9)
    self.clock = self.sidepanel:AddChild(UIClock(self.owner))
    self.hover = self:AddChild(HoverText(self.owner))

	self.containers = {}

    local MAPSCALE = .5
	self.minimapBtn = self.bottomright_root:AddChild(Button())

	local btn = self.minimapBtn
	btn.text:SetFont(UIFONT)
	btn.text:SetSize(50)
    btn:SetScale(MAPSCALE,MAPSCALE,MAPSCALE)
    
	btn:SetOnClick( function() self:ToggleMap() end )
	btn:SetMouseOver( function() btn:SetText(STRINGS.UI.HUD.MAP) btn:ScaleTo(MAPSCALE*1.5,MAPSCALE*1.5,MAPSCALE*1.5) end )
	btn:SetMouseOut( function() btn:SetText() btn:ScaleTo(MAPSCALE,MAPSCALE,MAPSCALE) end )
	btn:SetPosition( Point( -50,50,0 ) )
	btn:SetImage( "data/images/map_button.tex" )
    
    self.pauseBtn = self.bottomright_root:AddChild(Button())
	
    self.pauseBtn:SetOnClick(
		function()
			if not IsHUDPaused() then
				TheFrontEnd:PushScreen(PauseScreen())
			end
		end )
	
	self.pauseBtn:SetMouseOver(
		function()
			self.pauseBtn:ScaleTo( MAPSCALE*1.3, MAPSCALE*1.3, MAPSCALE*1.3 )
		end )
		
	self.pauseBtn:SetMouseOut(
		function()
			self.pauseBtn:ScaleTo( MAPSCALE, MAPSCALE, MAPSCALE )
		end )
		
	self.pauseBtn.text:SetFont(UIFONT)
	self.pauseBtn.text:SetSize(50)
	self.pauseBtn:SetImage( "data/images/pause.tex" )	
	self.pauseBtn:SetScale(MAPSCALE,MAPSCALE,MAPSCALE)
	self.pauseBtn:SetPosition( Point( -117, 35, 0 ) )
        
    if true or not IsGamePurchased() then
		self.demotimer = self.top_root:AddChild(DemoTimer(self.owner))
		self.demotimer:SetPosition(320, -25, 0)
	end
	
	
	self.containerroot = self:AddChild(Widget(""))
    self.containerroot:SetHAnchor(ANCHOR_MIDDLE)
    self.containerroot:SetVAnchor(ANCHOR_MIDDLE)
	self.containerroot:SetScaleMode(SCALEMODE_PROPORTIONAL)
	self.containerroot:SetMaxPropUpscale(MAX_HUD_SCALE)
	self.containerroot = self.containerroot:AddChild(Widget(""))
	
	self.containerroot_side = self:AddChild(Widget(""))
    self.containerroot_side:SetHAnchor(ANCHOR_RIGHT)
    self.containerroot_side:SetVAnchor(ANCHOR_MIDDLE)
	self.containerroot_side:SetScaleMode(SCALEMODE_PROPORTIONAL)
	self.containerroot_side:SetMaxPropUpscale(MAX_HUD_SCALE)
	self.containerroot_side = self.containerroot_side:AddChild(Widget(""))
	
    self:SetHUDSize(Profile:GetHUDSize())
end)


function Controls:MakeScalingNodes()

	--these are auto-scaling root nodes
	self.top_root = self:AddChild(Widget("top"))
    self.top_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.top_root:SetHAnchor(ANCHOR_MIDDLE)
    self.top_root:SetVAnchor(ANCHOR_TOP)
    self.top_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.bottom_root = self:AddChild(Widget("bottom"))
    self.bottom_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.bottom_root:SetHAnchor(ANCHOR_MIDDLE)
    self.bottom_root:SetVAnchor(ANCHOR_BOTTOM)
    self.bottom_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.topright_root = self:AddChild(Widget("side"))
    self.topright_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.topright_root:SetHAnchor(ANCHOR_RIGHT)
    self.topright_root:SetVAnchor(ANCHOR_TOP)
    self.topright_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    
	self.left_root = self:AddChild(Widget("side"))
    self.left_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.left_root:SetHAnchor(ANCHOR_LEFT)
    self.left_root:SetVAnchor(ANCHOR_MIDDLE)
    self.left_root:SetMaxPropUpscale(MAX_HUD_SCALE)    
	
	--these are for introducing user-configurable hud scale
	self.topright_root = self.topright_root:AddChild(Widget(""))
	self.bottom_root = self.bottom_root:AddChild(Widget(""))
	self.top_root = self.top_root:AddChild(Widget(""))
	self.left_root = self.left_root:AddChild(Widget(""))
	--

end

function Controls:SetHUDSize( size )
	local min_scale = .75
	local max_scale = 1.1
	local scale = easing.linear(size, min_scale, max_scale-min_scale, 10)
	self.topright_root:SetScale(scale,scale,scale)
	self.bottom_root:SetScale(scale,scale,scale)
	self.top_root:SetScale(scale,scale,scale)
	self.bottomright_root:SetScale(scale,scale,scale)
	self.left_root:SetScale(scale,scale,scale)
	self.containerroot:SetScale(scale,scale,scale)
	self.containerroot_side:SetScale(scale,scale,scale)
end

function Controls:OnKeyDown( key )
	if self.owner and self.owner.components.playercontroller and self.owner.components.playercontroller.enabled then
		if key >= KEY_0 and key <= KEY_9 then
			local num = 1
			if key == KEY_0 then
				num = 10
			else
				num = key - KEY_1 + 1
			end
			self.inv:UseSlot(num)
		elseif key == KEY_MINUS then
			self.inv:UseSlot(11)
		elseif key == KEY_EQUALS then
			self.inv:UseSlot(12)
	    elseif key == KEY_TAB then
		    self:ToggleMap()
	    elseif key == KEY_TILDE and PLATFORM ~= "NACL" and TheSim:GetSetting("MISC", "ENABLECONSOLE") == "true" then
	    	TheFrontEnd:PushScreen(ConsoleScreen())
	    	self.consoletext:Show()
	    elseif key == KEY_L and TheInput:IsKeyDown(KEY_CTRL) then
	    	if self.consoletext.shown then
		    	self.consoletext:Hide()
		    else
		    	self.consoletext:Show()
		    end
	    end
	end
end

function Controls:Update(dt)
    
    local consolestr = ""
    for i,v in ipairs(debugstr) do
    	consolestr = consolestr..v.."\n"
    end
    consolestr = consolestr.."(Press CTRL+L to close this log)"

   	self.consoletext:SetString(consolestr)

    self.status:Update(dt)
    self.hover:Update(dt)
    self.fireover:Update(dt)
    self.crafttabs:Update(dt)
    self.iceover:Update(dt)
    
    for k,v in pairs(self.containers) do
		if not v:Update(dt) then
			self.containers[k] = nil
			v:Kill()
		end
	end
    
    
    --this is kind of a weird place to do all of this, but the anim *is* a hud asset...
    if TheCamera and TheCamera.distance and not TheCamera.dollyzoom then
        local dist_percent = (TheCamera.distance - TheCamera.mindist) / (TheCamera.maxdist - TheCamera.mindist)
        local cutoff = .6
        if dist_percent > cutoff then
            if not self.clouds_on then
				TheCamera.should_push_down = true
                self.clouds_on = true
                self.clouds:Show()
                self.owner.SoundEmitter:PlaySound("dontstarve/common/clouds", "windsound")
                TheMixer:PushMix("high")
            end
            
            local p = easing.outCubic( dist_percent-cutoff , 0, 1, 1 - cutoff) 
            self.clouds:GetAnimState():SetMultColour(1,1,1, p )
            self.owner.SoundEmitter:SetVolume("windsound",p)
        else
            if self.clouds_on then
				TheCamera.should_push_down = false
                self.clouds_on = false
                self.clouds:Hide()
                self.owner.SoundEmitter:KillSound("windsound")
                TheMixer:PopMix("high")
            end
        end
    end
    
    if self.demotimer then
		if IsGamePurchased() then
			self.demotimer:Kill()
			self.demotimer = nil
		else
			self.demotimer:Update(dt)
		end
	end
end

function Controls:ToggleMap()
    local minimap = self.owner.HUD.minimap
    if minimap then
        minimap.MiniMap:ToggleVisibility()
        if minimap.MiniMap:IsVisible() then
            self.containerroot:Hide()
            self.containerroot_side:Hide()
            self.owner.SoundEmitter:PlaySound("dontstarve/HUD/map_open")
            SetHUDPause(true)
			self.minimap:Show()
			self.minimap:Update()
            self.minimapBtn:Show()
            self.pauseBtn:Hide()
        else
			self.containerroot:Show()
			self.containerroot_side:Show()
            self.owner.SoundEmitter:PlaySound("dontstarve/HUD/map_close")
            SetHUDPause(false)
			self.minimap:Hide()
			self.pauseBtn:Show()
        end
    end
end

PlayerHud = Class(Screen, function(self)
	Screen._ctor(self, "HUD")
    
    self.vig = self:AddChild(UIAnim())
    self.vig:GetAnimState():SetBuild("vig")
    self.vig:GetAnimState():SetBank("vig")
    self.vig:GetAnimState():PlayAnimation("basic", true)
    self.vig:SetHAnchor(ANCHOR_LEFT)
    self.vig:SetVAnchor(ANCHOR_TOP)
    self.vig:SetScaleMode(SCALEMODE_FIXEDPROPORTIONAL)
    self.vig:SetClickable(false)
    
    self.bloodover = BloodOver()
    
    self.minimap = SpawnPrefab( "minimap" )
    self.root = self:AddChild(Widget("root"))
end)

function PlayerHud:OnGainFocus()
	Screen.OnGainFocus(self)
	if self.controls then
		self.controls:SetHUDSize(Profile:GetHUDSize())
	end
end

function PlayerHud:OnDestroy()
	self.minimap:Remove()
	Screen.OnDestroy(self)
end

function PlayerHud:Hide()
	self.shown = false
	self.root:Hide()
end

function PlayerHud:Show()
	self.shown = true
	self.root:Show()
end


function PlayerHud:CloseContainer(container)
    for k,v in pairs(self.controls.containers) do
		if v.container == container then
			v:Close()
		end
    end
end

function PlayerHud:OpenContainer(container, side)

	if container then
		local containerwidget = nil
		if side then
			containerwidget = self.controls.containerroot_side:AddChild(ContainerWidget(self.owner))
		else
			containerwidget = self.controls.containerroot:AddChild(ContainerWidget(self.owner))
		end
		containerwidget:Open(container, self.owner)
	    
		for k,v in pairs(self.controls.containers) do
			if v.container then
				if v.container.prefab == container.prefab then
					v:Close()
				end
			else
				self.controls.containers[k] = nil
			end
		end
	    
		self.controls.containers[container] = containerwidget
	end
	    
end

function PlayerHud:GoSane()
    self.vig:GetAnimState():PlayAnimation("basic", true)
end

function PlayerHud:GoInsane()
    self.vig:GetAnimState():PlayAnimation("insane", true)
end

function PlayerHud:SetMainCharacter(maincharacter)
    if maincharacter then
		maincharacter.HUD = self
		self.owner = maincharacter

		self.controls = self.root:AddChild(Controls(self.owner))
		--self.inst.entity:SetParent(self.inst.entity)

		self.inst:ListenForEvent("badaura", function(inst, data) return self.bloodover:Flash() end, self.owner)
		self.inst:ListenForEvent("attacked", function(inst, data) return self.bloodover:Flash() end, self.owner)
		self.inst:ListenForEvent("startstarving", function(inst, data) self.bloodover:TurnOn() end, self.owner)
		self.inst:ListenForEvent("stopstarving", function(inst, data) self.bloodover:TurnOff() end, self.owner)
		self.inst:ListenForEvent("ontriggersave", function(inst, data) self.controls.saving:OnSave(2) end, self.owner)
		self.inst:ListenForEvent("gosane", function(inst, data) self:GoSane() end, self.owner)
		self.inst:ListenForEvent("goinsane", function(inst, data) self:GoInsane() end, self.owner)
		
		if not self.owner.components.sanity:IsSane() then
			self:GoInsane()
		end
		self.controls.crafttabs:UpdateRecipes()
		
		local bp = maincharacter.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
		if bp and bp.components.container then
			bp.components.container:Close()
			bp.components.container:Open(maincharacter)
		end
	end
end

function PlayerHud:OnUpdate(dt)
    if self.owner then
		if self.controls then
			self.controls:Update(dt)
		end
		
		if Profile and self.vig then
			if RENDER_QUALITY.LOW == Profile:GetRenderQuality() then
				self.vig:Hide()
			else
				self.vig:Show()
			end
		end
	end
end


function PlayerHud:OnKeyUp( key )
	if key == KEY_ESCAPE then
		if not IsHUDPaused() then
			TheFrontEnd:PushScreen(PauseScreen())
		end
	end
end

function PlayerHud:OnKeyDown( key )
	local focused = self:GetActiveFocusWidget()
	if self.controls then
		self.controls:OnKeyDown( key )
	end
end

return PlayerHud

