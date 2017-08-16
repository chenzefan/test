local Screen = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Text = require "widgets/text"
local Image = require "widgets/image"
local UIAnim = require "widgets/uianim"
local Inv = require "widgets/inventorybar"
local Widget = require "widgets/widget"
local CraftTabs = require "widgets/crafttabs"
local HoverText = require "widgets/hoverer"
local MAX_HUD_SCALE = 1.25


require "screens/consolescreen"

require("widgets/statusdisplays")
require("widgets/inventorybar")
require("widgets/hoverer")
require("widgets/crafting")
require("widgets/mapwidget")
local ContainerWidget = require("widgets/containerwidget")

local easing = require("easing")

local Sim = TheSim
local gettime = GetTime

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


    
    self.saving = self:AddChild(SavingIndicator(self.owner))
    self.saving:SetHAnchor(ANCHOR_MIDDLE)
    self.saving:SetVAnchor(ANCHOR_TOP)
    self.saving:SetPosition(Vector3(200,0,0))
    
    self.inv = self.bottom_root:AddChild(Inv(self.owner))
    
    self.crafttabs = self.left_root:AddChild(CraftTabs(self.owner))
    local scale = .75
    self.crafttabs:SetScale(scale,scale,scale)
    


	self.sidepanel = self.topright_root:AddChild(Widget("sidepanel"))
	self.sidepanel:SetScale(1,1,1)
	self.sidepanel:SetPosition(-80, -60, 0)

    self.status = self.sidepanel:AddChild(Status(self.owner))
    self.status:SetPosition(0,-110,0)
    --self.status:SetScale(.9,.9,.9)
    self.clock = self.sidepanel:AddChild(UIClock(self.owner))
    

    if GetWorld() and GetWorld():IsCave() then
    	self.clock:Hide()
    	self.status:SetPosition(-10,-20,0)
    end
    

	self.containers = {}

    local MAPSCALE = .5
	
	self.maproot = self.bottomright_root:AddChild(Widget("mapstuff"))
	self.maproot:SetPosition(-60,70,0)
	self.minimapBtn = self.maproot:AddChild(ImageButton(HUD_ATLAS, "map_button.tex"))
    self.minimapBtn:SetScale(MAPSCALE,MAPSCALE,MAPSCALE)
	self.minimapBtn:SetOnClick( function() self:ToggleMap() end )
	self.minimapBtn:SetTooltip(STRINGS.UI.HUD.MAP)

	self.pauseBtn = self.maproot:AddChild(ImageButton(HUD_ATLAS, "pause.tex"))
	self.pauseBtn:SetTooltip(STRINGS.UI.HUD.PAUSE)
	self.pauseBtn:SetScale(.33,.33,.33)
	self.pauseBtn:SetPosition( Point( 0,-50,0 ) )
	
    self.pauseBtn:SetOnClick(
		function()
			if not IsHUDPaused() then
				TheFrontEnd:PushScreen(PauseScreen())
			end
		end )
	
        
    if true or not IsGamePurchased() then
		self.demotimer = self.top_root:AddChild(DemoTimer(self.owner))
		self.demotimer:SetPosition(320, -25, 0)
	end
	

	self.alphawarning = self.top_root:AddChild(Text(TITLEFONT, 40))
	self.alphawarning:SetRegionSize(400, 50)
	self.alphawarning:SetPosition(0, -28, 0) 
	self.alphawarning:SetString(STRINGS.UI.HUD.CAVEWARNING)
	self.alphawarning:Hide()
	if GetWorld():IsCave() then
		self.alphawarning:Show()
	end


	self.rotleft = self.maproot:AddChild(ImageButton(HUD_ATLAS, "turnarrow_icon.tex"))
    self.rotleft:SetPosition(-40,-40,0)
    self.rotleft:SetScale(-.7,.7,.7)
    self.rotleft:SetOnClick(function() GetPlayer().components.playercontroller:RotLeft() end)
    self.rotleft:SetTooltip(STRINGS.UI.HUD.ROTLEFT)

	self.rotright = self.maproot:AddChild(ImageButton(HUD_ATLAS, "turnarrow_icon.tex"))
    self.rotright:SetPosition(40,-40,0)
    self.rotright:SetScale(.7,.7,.7)
    self.rotright:SetOnClick(function() GetPlayer().components.playercontroller:RotRight() end)
	self.rotright:SetTooltip(STRINGS.UI.HUD.ROTRIGHT)

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
	
    self.mousefollow = self:AddChild(Widget("follower"))
    self.mousefollow:FollowMouse(true)
    self.mousefollow:SetScaleMode(SCALEMODE_PROPORTIONAL)

    self.hover = self:AddChild(HoverText(self.owner))
    self.hover:SetScaleMode(SCALEMODE_PROPORTIONAL)

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
	
	--testing high res displays
	local w,h = TheSim:GetScreenSize()
	
	local res_scale_x = math.max(1, w / 1920)
	local res_scale_y = math.max(1, h / 1200)
	local res_scale = math.min(res_scale_x, res_scale_y)	
	
	local scale = easing.linear(size, min_scale, max_scale-min_scale, 10) * res_scale
	self.topright_root:SetScale(scale,scale,scale)
	self.bottom_root:SetScale(scale,scale,scale)
	self.top_root:SetScale(scale,scale,scale)
	self.bottomright_root:SetScale(scale,scale,scale)
	self.left_root:SetScale(scale,scale,scale)
	self.containerroot:SetScale(scale,scale,scale)
	self.containerroot_side:SetScale(scale,scale,scale)
	self.hover:SetScale(scale,scale,scale)
	
	self.mousefollow:SetScale(scale,scale,scale)
end


function Controls:Update(dt)

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
    
    
    if not GetWorld():IsCave() then
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
            SetHUDPause(true,"minimap")
			self.minimap:Show()
			self.minimap:Update()
            self.minimapBtn:Show()
            self.pauseBtn:Hide()
            self.hover:Hide()
            self.rotleft:Hide()
            self.rotright:Hide()
            
            if self.inv.hovertile then
				self.inv.hovertile:Hide()
			end
        else
			self.containerroot:Show()
			self.containerroot_side:Show()
            self.owner.SoundEmitter:PlaySound("dontstarve/HUD/map_close")
            SetHUDPause(false)
			self.minimap:Hide()
			self.pauseBtn:Show()
			self.hover:Show()
            if self.inv.hovertile then
				self.inv.hovertile:Show()
			end
            self.rotleft:Show()
            self.rotright:Show()

			
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
    
    self.bloodover = self:AddChild(BloodOver())
    
    self.minimap = SpawnPrefab( "minimap" )
    self.under_root = self:AddChild(Widget("under_root"))
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

	
function PlayerHud:Toggle()
	self.shown = not self.shown
	if self.shown then
		self.root:Show()
	else
		self.root:Hide()
	end
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
		self.controls.inv:Refresh()
		--self.inst.entity:SetParent(self.inst.entity)

		self.inst:ListenForEvent("badaura", function(inst, data) return self.bloodover:Flash() end, self.owner)
		self.inst:ListenForEvent("attacked", function(inst, data) return self.bloodover:Flash() end, self.owner)
		self.inst:ListenForEvent("startstarving", function(inst, data) self.bloodover:TurnOn() end, self.owner)
		self.inst:ListenForEvent("stopstarving", function(inst, data) self.bloodover:TurnOff() end, self.owner)
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

function PlayerHud:IsMapShowing()
    return self.minimap and self.minimap.MiniMap:IsVisible()
end

function PlayerHud:OnUpdate(dt)
    if self.owner then
		if self.controls then
			self.controls:Update(dt)
		end

		if self.bloodover then
			self.bloodover:Update(dt)
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

function PlayerHud:OnControl(control, down)
	if PlayerHud._base.OnControl(self, control, down) then return true end

	if not down and control == CONTROL_PAUSE then
		TheFrontEnd:PushScreen(PauseScreen())
		return true
	end

	if not down and control == CONTROL_MAP then
		if not self.owner:HasTag("beaver") then
			self.controls:ToggleMap()			
			return true
		end
	end
	
	--inventory hotkeys
	if down and control >= CONTROL_INV_1 and control <= CONTROL_INV_10 then
		local num = (control - CONTROL_INV_1) + 1
		local item = self.owner.components.inventory:GetItemInSlot(num)
		self.owner.components.inventory:UseItemFromInvTile(item)
		return true
	end

end

function PlayerHud:OnRawKey( key, down )
	if PlayerHud._base.OnRawKey(self, key, down) then return true end
end

return PlayerHud

