require "class"
require "screens/pausescreen"
local easing = require "easing"

local trace = function() end

local START_DRAG_TIME = (1/30)*8

local CameraRight = TheCamera:GetRightVec()
local CameraDown = TheCamera:GetDownVec()

local function UpdateCameraHeadings()
	CameraRight = TheCamera:GetRightVec()
	CameraDown = TheCamera:GetDownVec()
end

local PlayerController = Class(function(self, inst)
    self.inst = inst
    self.enabled = true
    
    self.handler = TheInput:AddGeneralControlHandler(function(control, value) self:OnControl(control, value) end)
    self.inst:StartUpdatingComponent(self)
    self.draggingonground = false
    self.startdragtestpos = nil
    self.startdragtime = nil
end)

function PlayerController:OnControl(control, down)

	if not self.enabled then return end
	if not IsHUDPaused() then

		if control == CONTROL_PRIMARY then
			self:OnLeftClick(down)
			return 
		elseif control == CONTROL_SECONDARY then
			self:OnRightClick(down)
			return 
		end
		
		if down then
			if control == CONTROL_INSPECT then
				self:DoInspectButton()
			elseif control == CONTROL_ACTION then
				if TheInput:IsControlPressed(CONTROL_FORCE_ATTACK) then
					self:DoAttackButton()	
				else
					self:DoActionButton()
				end
			elseif control == CONTROL_ATTACK then
				self:DoAttackButton()
			end
		end
	end

end


function PlayerController:RotLeft()
	local rotamount = 90-- GetWorld():IsCave() and 22.5 or 45
	if TheCamera:CanControl() then  
		
		if IsHUDPaused() then
			if GetPlayer().HUD:IsMapShowing() then
				TheCamera:SetHeadingTarget(TheCamera:GetHeadingTarget() + rotamount) 
				TheCamera:Snap()
			end
		else
			TheCamera:SetHeadingTarget(TheCamera:GetHeadingTarget() + rotamount) 
			UpdateCameraHeadings() 
		end
	end
end

function PlayerController:RotRight()
	local rotamount = 90--GetWorld():IsCave() and 22.5 or 45
	if TheCamera:CanControl() then  
		
		if IsHUDPaused() then
			if GetPlayer().HUD:IsMapShowing() then
				TheCamera:SetHeadingTarget(TheCamera:GetHeadingTarget() - rotamount) 
				TheCamera:Snap()
			end
		else
			TheCamera:SetHeadingTarget(TheCamera:GetHeadingTarget() - rotamount) 
			UpdateCameraHeadings() 
		end
	end
end

function PlayerController:OnRemoveEntity()
    self.handler:Remove()
end

function PlayerController:GetHoverTextOverride()
	if self.placer_recipe then
		return STRINGS.UI.HUD.BUILD.. " " .. ( STRINGS.NAMES[string.upper(self.placer_recipe.name)] or STRINGS.UI.HUD.HERE )
	end
end

function PlayerController:CancelPlacement()
	if self.placer then
		self.placer:Remove()
		self.placer = nil
	end
	self.placer_recipe = nil
end


function PlayerController:StartBuildPlacementMode(recipe, testfn)
	self.placer_recipe = recipe
	if self.placer then
		self.placer:Remove()
		self.placer = nil
	end
	self.placer = SpawnPrefab(recipe.placer)
	self.placer.components.placer:SetBuilder(self.inst)
	self.placer.components.placer.testfn = testfn
end


function PlayerController:Enable(val)
    self.enabled = val
end


function PlayerController:GetAttackTarget(force_attack)

	local x,y,z = self.inst.Transform:GetWorldPosition()
	
	local rad = self.inst.components.combat:GetAttackRange()
	--To deal with entity collision boxes we need to pad the radius.
	local nearby_ents = TheSim:FindEntities(x,y,z, rad + 5)
	local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	local has_weapon = tool and tool.components.weapon 
	
	local playerRad = self.inst.Physics:GetRadius()
	
	for k,guy in ipairs(nearby_ents) do
		if guy ~= self.inst and
		   guy:IsValid() and 
		   not guy:IsInLimbo() and
		   not (guy.sg and guy.sg:HasStateTag("invisible")) and
		   guy.components.health and not guy.components.health:IsDead() and 
		   guy.components.combat and guy.components.combat:CanBeAttacked(self.inst) and
		   not (guy.components.follower and guy.components.follower.leader == self.inst) and
		   --Now we ensure the target is in range.
		   distsq(guy:GetPosition(), self.inst:GetPosition()) <= math.pow(rad + playerRad + guy.Physics:GetRadius() + 0.1 , 2) then
				if (guy:HasTag("monster") and has_weapon) or
					guy.components.combat.target == self.inst or
					force_attack then
						return guy
				end
						
		end
	end

end

--

function PlayerController:DoAttackButton()
	
	local attack_target = self:GetAttackTarget(true) 			
	local action = BufferedAction(self.inst, attack_target, ACTIONS.FORCEATTACK)
	self.inst.components.locomotor:PushAction(action, true)

end


function PlayerController:GetActionButtonAction()
	if self.actionbuttonoverride then
		return self.actionbuttonoverride(self.inst)
	end

	if self.enabled and not (self.inst.sg:HasStateTag("working") or self.inst.sg:HasStateTag("doing")) then

		local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)

		--bug catching (has to go before combat)
		if tool and tool.components.tool and tool.components.tool:CanDoAction(ACTIONS.NET) then
			local target = FindEntity(self.inst, 5, 
				function(guy) 
					return  guy.components.health and not guy.components.health:IsDead() and 
							guy.components.workable and
							guy.components.workable.action == ACTIONS.NET
				end)
			if target then
			    return BufferedAction(self.inst, target, ACTIONS.NET, tool)
			end
		end
			
		
		--catching
		local rad = 8
		local projectile = FindEntity(self.inst, rad, function(guy)
		    return guy.components.projectile
		           and guy.components.projectile:IsThrown()
		           and self.inst.components.catcher
		           and self.inst.components.catcher:CanCatch()
		end)
		if projectile then
			return BufferedAction(self.inst, projectile, ACTIONS.CATCH)
		end
		
		rad = self.directwalking and 3 or 10
		--pickup
		local pickup = FindEntity(self.inst, rad, function(guy) return (guy.components.inventoryitem and guy.components.inventoryitem.canbepickedup) or
																		(tool and tool.components.tool and guy.components.workable and tool.components.tool:CanDoAction(guy.components.workable.action)) or
																		(guy.components.pickable and guy.components.pickable:CanBePicked() and guy.components.pickable.caninteractwith) or
																		(guy.components.crop and guy.components.crop:IsReadyForHarvest()) or
																		(guy.components.harvestable and guy.components.harvestable:CanBeHarvested()) or
																		(guy.components.trap and guy.components.trap.issprung) or
																		(guy.components.stewer and guy.components.stewer.done) or
																		(guy.components.activatable and guy.components.activatable.inactive)
																		 end)

		local has_active_item = self.inst.components.inventory:GetActiveItem() ~= nil
		if pickup and not has_active_item then
			local action = nil
			
			if (tool and tool.components.tool and pickup.components.workable and tool.components.tool:CanDoAction(pickup.components.workable.action)) then
				action = pickup.components.workable.action
			elseif pickup.components.trap and pickup.components.trap.issprung then
				action = ACTIONS.CHECKTRAP
			elseif pickup.components.activatable and pickup.components.activatable.inactive then
				action = ACTIONS.ACTIVATE
			elseif pickup.components.inventoryitem and pickup.components.inventoryitem.canbepickedup then 
				action = ACTIONS.PICKUP 
			elseif pickup.components.pickable and pickup.components.pickable:CanBePicked() then 
				action = ACTIONS.PICK 
			elseif pickup.components.harvestable and pickup.components.harvestable:CanBeHarvested() then
				action = ACTIONS.HARVEST
			end
			
			if action then
			    local ba = BufferedAction(self.inst, pickup, action, tool)
			    ba.distance = self.directwalking and rad or 1
			    return ba
			end
		end
	end	
end


function PlayerController:DoActionButton()

	local ba = self:GetActionButtonAction()
	if ba then
		self.inst.components.locomotor:PushAction(ba, true)
	end
	return true
end

function PlayerController:DoInspectButton()
	local rad = 8
	local ent = FindEntity(self.inst, rad, function(guy)
	    return guy.components.inspectable and
			   guy ~= self.inst
	end)
	if ent then
		self.inst.components.locomotor:PushAction( BufferedAction(self.inst, ent, ACTIONS.LOOKAT))
	end
	return true
end



function PlayerController:OnUpdate(dt)
    if not self.enabled then 
		return 
    end  

	self:DoCameraControl()    

	local active_item = self.inst.components.inventory:GetActiveItem()
	
	
	local action = self.inst.components.playeractionpicker:GetLeftMouseAction()	
	local action_r = self.inst.components.playeractionpicker:GetRightMouseAction()	
	
	local terraform_l =	(action and action.action == ACTIONS.TERRAFORM and action.pos and action.invobject)
	local terraform_r =	(action_r and action_r.action == ACTIONS.TERRAFORM and action_r.pos and action_r.invobject)
	local terraform = terraform_l or terraform_r
	
	if terraform then
		if not self.terraformplacer then
			local act = terraform_l and action or action_r
			self.terraformplacer = SpawnPrefab("gridplacer")
			self.terraformplacer.components.placer:SetBuilder(self.inst)
			self.terraformplacer.components.placer.testfn = function(pt) 
				return act.invobject.components.terraformer:CanTerraformPoint(pt) 
			end 
			
		end
	else
		if self.terraformplacer then
			self.terraformplacer:Remove()
			self.terraformplacer = nil
		end
	end
	
	local show_deploy_placer = active_item and active_item.components.deployable and ((action and action.action == ACTIONS.DEPLOY) or (action_r and action_r.action == ACTIONS.DEPLOY))
	
	if show_deploy_placer then
		local placer_name = active_item.components.deployable.placer or ((active_item.prefab or "") .. "_placer")
		if self.deployplacer and self.deployplacer.prefab ~= placer_name then
			self.deployplacer:Remove()
			self.deployplacer = nil
		end
		
		if not self.deployplacer then
			self.deployplacer = SpawnPrefab(placer_name)
			if self.deployplacer then
				self.deployplacer.components.placer:SetBuilder(self.inst)
				self.deployplacer.components.placer.testfn = function(pt) 
						local action = self.inst.components.playeractionpicker:GetLeftMouseAction()
						local action_r = self.inst.components.playeractionpicker:GetRightMouseAction()
						return (action and action.action == ACTIONS.DEPLOY and action.invobject and action.invobject.components.deployable and action.invobject.components.deployable:CanDeploy(pt)) or
							   (action_r and action_r.action == ACTIONS.DEPLOY and action_r.invobject and action_r.invobject.components.deployable and action_r.invobject.components.deployable:CanDeploy(pt))
						
					end
				self.deployplacer.components.placer:OnUpdate(0)  --so that our position is accurate on the first frame
			end
		end
	else
		if self.deployplacer then
			self.deployplacer:Remove()
			self.deployplacer = nil
		end
	end

    
    if self.startdragtime and not self.draggingonground then
        local now = GetTime()
        if now - self.startdragtime > START_DRAG_TIME then
            self.draggingonground = true
        end
    end

	if self.draggingonground and TheFrontEnd:GetFocusWidget() ~= self.inst.HUD then
		self.draggingonground = false
		self.inst.components.locomotor:Stop()
	end

	if not self.inst.sg:HasStateTag("busy") then
		
		if self.draggingonground and not self:WalkButtonDown() then
			local pt = TheInput:GetWorldPosition()
			local dst = distsq(pt, Vector3(self.inst.Transform:GetWorldPosition()))

			if dst > 1 then
				local angle = self.inst:GetAngleToPoint(pt)
				self.inst:ClearBufferedAction()
				self.inst.components.locomotor:RunInDirection(angle)
			end
			self.directwalking = false
		else
	        self:DoDirectWalking()
		end
    end
    
	if self.inst.sg:HasStateTag("idle") and TheInput:IsControlPressed(CONTROL_ACTION) then
	    self:OnControl(CONTROL_ACTION, true)
	end
    
end

function PlayerController:DoDirectWalking()
	local xwalk = TheInput:GetAnalogControlValue(CONTROL_MOVE_RIGHT) - TheInput:GetAnalogControlValue(CONTROL_MOVE_LEFT)
	local ywalk = TheInput:GetAnalogControlValue(CONTROL_MOVE_UP) - TheInput:GetAnalogControlValue(CONTROL_MOVE_DOWN)
	local deadzone = .3
	local maxthrottle = .9
	if math.abs(xwalk) < deadzone and math.abs(ywalk) < deadzone then xwalk = 0 ywalk = 0 end

    CameraRight = TheCamera:GetRightVec()
	CameraDown = TheCamera:GetDownVec()
    
	if xwalk ~= 0 or ywalk ~= 0 then
		
		--self.inst.components.inventory:DropActiveItem()

		local dir = CameraRight * xwalk - CameraDown * ywalk
		dir = dir:GetNormalized()
		--local pt = Vector3(self.inst.Transform:GetWorldPosition()) + dir
		--self.inst.components.locomotor:GoToPoint(pt, nil, true)
		local ang = -math.atan2(dir.z, dir.x)/DEGREES
		
		self.inst:ClearBufferedAction()
		self.inst.components.locomotor:SetBufferedAction(nil)
		self.inst.components.locomotor:RunInDirection(ang)
		self.directwalking = true
		
		if not self.inst.sg:HasStateTag("attack") then
			self.inst.components.combat:SetTarget(nil)
		end
	else
		if self.directwalking then
			self.inst.components.locomotor:Stop()
			self.directwalking = false
		end
	end
end

function PlayerController:WalkButtonDown()
	return  TheInput:IsControlPressed(CONTROL_MOVE_UP) or TheInput:IsControlPressed(CONTROL_MOVE_DOWN) or TheInput:IsControlPressed(CONTROL_MOVE_LEFT) or TheInput:IsControlPressed(CONTROL_MOVE_RIGHT)
end


function PlayerController:DoCameraControl()
	--camera controls
	local time = GetTime()

	local ROT_REPEAT = .25
	local ZOOM_REPEAT = .1

	if TheCamera:CanControl() then
		
		if not self.lastrottime or time - self.lastrottime > ROT_REPEAT then
			
			if TheInput:IsControlPressed(CONTROL_ROTATE_LEFT) then
				self:RotLeft()
				self.lastrottime = time
			elseif TheInput:IsControlPressed(CONTROL_ROTATE_RIGHT) then
				self:RotRight()
				self.lastrottime = time
			end
		end

		if not self.lastzoomtime or time - self.lastzoomtime > ZOOM_REPEAT then
			if TheInput:IsControlPressed(CONTROL_ZOOM_IN) then
				TheCamera:ZoomIn()
				self.lastzoomtime = time
			elseif TheInput:IsControlPressed(CONTROL_ZOOM_OUT) then
				TheCamera:ZoomOut()
				self.lastzoomtime = time
			end
		end
	end

end


function PlayerController:OnLeftUp()
    
    if not self.enabled then return end    

	if self.draggingonground then
		
		if not self:WalkButtonDown() then
			self.inst.components.locomotor:Stop()
		end
		self.draggingonground = false
	end
	self.startdragtime = nil
end



function PlayerController:DoAction(buffaction)
	Print(VERBOSITY.DEBUG, "PlayerController:DoAction")
    if buffaction then
    
        if self.inst.bufferedaction then
            if self.inst.bufferedaction.action == buffaction.action and self.inst.bufferedaction.target == buffaction.target then
                return;
            end
        end
        
        if buffaction.target and buffaction.target.components.highlight then
            buffaction.target.components.highlight:Flash(.2, .125, .1)
        end
		
		Print(VERBOSITY.DEBUG, "Performing Action: ["..buffaction.action.id.."]")
        if  buffaction.invobject and 
            buffaction.invobject.components.equippable and 
            buffaction.invobject.components.equippable.equipslot == EQUIPSLOTS.HANDS and 
            (buffaction.action ~= ACTIONS.DROP and buffaction.action ~= ACTIONS.STORE) then
            
                if not buffaction.invobject.components.equippable.isequipped then 
                    self.inst.components.inventory:Equip(buffaction.invobject)
                end
                
                if self.inst.components.inventory:GetActiveItem() == buffaction.invobject then
                    self.inst.components.inventory:SetActiveItem(nil)
                end
        end
        
        self.inst.components.locomotor:PushAction(buffaction, true)
    end    

end


function PlayerController:OnLeftClick(down)
    
	if not down then return self:OnLeftUp() end

    self.startdragtime = nil

    if not self.enabled then return end
    
    if TheInput:GetHUDEntityUnderMouse() then 
		self:CancelPlacement()
		return 
    end

	if self.placer_recipe then
		--do the placement
		if self.placer.components.placer.can_build then
			self.inst.components.builder:MakeRecipe(self.placer_recipe, TheInput:GetWorldPosition())
			self:CancelPlacement()
		end
		return
	end
    
    
    self.inst.components.combat.target = nil
    
    if self.inst.inbed then
        self.inst.inbed.components.bed:StopSleeping()
        return
    end
    
    local action = self.inst.components.playeractionpicker:GetLeftMouseAction()
    if action then
	    self:DoAction( action )
	else

		self:DoAction( BufferedAction(self.inst, nil, ACTIONS.WALKTO, nil, TheInput:GetWorldPosition()) ) 		
	    local clicked = TheInput:GetWorldEntityUnderMouse()
	    if not clicked then
	        self.startdragtime = GetTime()
	    end
    end
    
end


function PlayerController:OnRightClick(down)

	if not down then return end

    self.startdragtime = nil

	if self.placer_recipe then 
		self:CancelPlacement()
	end

    if not self.enabled then return end
    
    if TheInput:GetHUDEntityUnderMouse() then return end

    if not self.inst.components.playeractionpicker:GetRightMouseAction() then
        self.inst.components.inventory:ReturnActiveItem()
    end
    
    if self.inst.inbed then
        self.inst.inbed.components.bed:StopSleeping()
        return
    end
    
    local action = self.inst.components.playeractionpicker:GetRightMouseAction()
    if action then
		self:DoAction(action )
	end
		
    
end

function PlayerController:ShakeCamera(inst, shakeType, duration, speed, maxShake, maxDist)
    local distSq = self.inst:GetDistanceSqToInst(inst)
    local t = math.max(0, math.min(1, distSq / (maxDist*maxDist) ) )
    local scale = easing.outQuad(t, maxShake, -maxShake, 1)
    if scale > 0 then
        TheCamera:Shake(shakeType, duration, speed, scale)
    end
end

return PlayerController
