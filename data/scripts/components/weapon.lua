
local Weapon = Class(function(self, inst)
    self.inst = inst
    self.damage = 10
    self.attackrange = nil
    self.hitrange = nil
    self.onattack = nil
    self.canattack = nil
    self.projectile = nil
end)

function Weapon:SetDamage(dmg)
    self.damage = dmg
end

function Weapon:SetRange(attack, hit)
    self.attackrange = attack
    self.hitrange = hit or self.attackrange
end

function Weapon:SetOnAttack(fn)
    self.onattack = fn
end

function Weapon:SetCanAttack(fn)
    self.canattack = fn
end

function Weapon:SetProjectile(projectile)
    self.projectile = projectile
end

function Weapon:SetAttackCallback(fn)
    self.onattack = fn
end

function Weapon:OnAttack(attacker, target, projectile)
    if self.onattack then
        self.onattack(self.inst, attacker, target)
    end
    
    if self.inst.components.finiteuses then
	    self.inst.components.finiteuses:Use(self.attackwear or 1)
    end
    	
    if not projectile then
	    --er.... fix this later, jerkface!
	    if target.SoundEmitter then
		    if self.inst:HasTag("blowdart") and self.inst:HasTag("sleepdart") then
			    
		    elseif self.inst:HasTag("blowdart") and self.inst:HasTag("firedart") then
		    elseif target.prefab == "leif" then
			    target.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
		    else
			    target.SoundEmitter:PlaySound("dontstarve/wilson/hit_animal")
		    end
	    end
	end
end

function Weapon:LaunchProjectile(attacker, target)
	if self.projectile then
	    local proj = SpawnPrefab(self.projectile)
	    if proj and proj.components.projectile then
	        proj.Transform:SetPosition(attacker.Transform:GetWorldPosition() )
	        proj.components.projectile:Throw(self.inst, target)
	    end
	end
end

function Weapon:CollectUseActions(doer, target, actions)
    if self.inst.components.inventoryitem and target.components.container and target.components.container.canbeopened then
    	-- put weapons into chester, don't attack him unless forcing attack with key press
        table.insert(actions, ACTIONS.STORE)
    else
	    if doer.components.combat and doer.components.combat:CanTarget(target) 
		   and target.components.combat:CanBeAttacked(doer)
	       and (not self.canattack or self.canattack(self.inst, target) ) then
	       
			local should_light = target.components.burnable and self.inst.components.lighter 
			if not should_light then
				table.insert(actions, ACTIONS.ATTACK)
			end
	    end
    end
end


function Weapon:CollectEquippedActions(doer, target, actions)
    if doer.components.combat 
	   and not target:HasTag("wall")
       and doer.components.combat:CanTarget(target)
	   and target.components.combat:CanBeAttacked(doer)
       and not doer.components.combat:IsAlly(target)
       and (not self.canattack or self.canattack(self.inst, target) ) then
        table.insert(actions, ACTIONS.ATTACK)
    end
end

return Weapon
