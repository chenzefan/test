
local Combat = Class(function(self, inst)
    self.inst = inst
    self.nextbattlecrytime = nil
    self.attackrange = 3
    self.hitrange = 3
    self.areahitrange = nil
    self.areahitdamagepercent = nil
    self.defaultdamage = 0
    self.playerdamagepercent = 1
    self.min_attack_period = 4
    self.onhitfn = nil
    self.onhitotherfn = nil
    self.laststartattacktime = 0
    self.keeptargetfn = nil
    self.keeptargettimeout = 0
    self.hiteffectsymbol = "marker"
    self.canattack = true
end)

function Combat:SetAttackPeriod(period)
    self.min_attack_period = period
end

function Combat:InCooldown()
    if self.laststartattacktime then
        local time_since_doattack = GetTime() - self.laststartattacktime
        
        if time_since_doattack < self.min_attack_period then
            return true
        end
    end
	return false
end

function Combat:SetRange(attack, hit)
    self.attackrange = attack
    self.hitrange = hit or self.attackrange
end

function Combat:SetAreaDamage(range, percent)
    self.areahitrange = range
    if self.areahitrange then
        self.areahitdamagepercent = percent or 1
    else
        self.areahitdamagepercent = nil
    end
end

function Combat:BlankOutAttacks(fortime)
	self.canattack = false
	
	if self.blanktask then
		self.blanktask:Cancel()
	end
	self.blanktask = self.inst:DoTaskInTime(fortime, function() self.canattack = true self.blanktask = nil end)
end


function Combat:ShareTarget(target, range, fn, maxnum)
    --print("Combat:ShareTarget", self.inst, target)

    local x,y,z = self.inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z, range)
    
    local num_helpers = 0
    for k,v in pairs(ents) do
        if v ~= self.inst and v.components.combat and not (v.components.health and v.components.health:IsDead()) and fn(v) then
            --print("    share with", v)
            if v.components.combat:SuggestTarget(target) then
                num_helpers = num_helpers + 1
            end
        end
        
        if num_helpers >= maxnum then
            break
        end
        
    end

end

function Combat:SetDefaultDamage(damage)
    self.defaultdamage = damage
end

function Combat:SetOnHit(fn)
    self.onhitfn = fn
end


function Combat:SuggestTarget(target)
    if not self.target and target ~= nil then
        --print("Combat:SuggestTarget", self.inst, target)
        self:SetTarget(target)
        return true
    end
end

function Combat:SetKeepTargetFunction(fn)
    self.keeptargetfn = fn
end

function Combat:TryRetarget()
    if self.targetfn then
    
        if not (self.inst.components.health and self.inst.components.health:IsDead() )
		   and not (self.inst.components.sleeper and self.inst.components.sleeper:IsInDeepSleep()) then
            local newtarget = self.targetfn(self.inst)
            if newtarget and newtarget ~= self.target and not newtarget:HasTag("notarget") then
				if self.target and self.target:HasTag("structure") and not newtarget:HasTag("structure") then
					self:SetTarget(newtarget)
				else
					self:SuggestTarget(newtarget)
				end
			end
        end
        
        if self.retargetperiod then
        
			if self.retargettask then
				self.retargettask:Cancel()
				self.retargettask = nil
			end
            self.retargettask = self.inst:DoTaskInTime(self.retargetperiod, function() self:TryRetarget() end)
        end
    end
end

function Combat:SetRetargetFunction(period, fn)
    self.targetfn = fn
    self.retargetperiod = period
    
	if self.retargettask then
		self.retargettask:Cancel()
		self.retargettask = nil
	end
    
    
    if period and fn then
        self.retargettask = self.inst:DoTaskInTime(period, function() self:TryRetarget() end)
    end
end

function Combat:OnEntitySleep()
	if self.retargettask then
		self.retargettask:Cancel()
		self.retargettask = nil
	end
end

function Combat:OnEntityWake()
	if self.retargettask then
		self.retargettask:Cancel()
		self.retargettask = nil
	end


	if self.retargetperiod then
		self.retargettask = self.inst:DoTaskInTime(self.retargetperiod, function() self:TryRetarget() end)
	end
end

function Combat:OnUpdate(dt)
    if not self.target then
        self.inst:StopUpdatingComponent(self)
        return
    end
    
    if self.keeptargetfn then
        self.keeptargettimeout = self.keeptargettimeout - dt
        if self.keeptargettimeout < 0 then
            self.keeptargettimeout = 1
            if not self.keeptargetfn(self.inst, self.target) then
                self:SetTarget(nil)
            end
        end
    end
end


function Combat:SetTarget(target)
    local new = target ~= self.target
    if new and (not target or self:IsValidTarget(target) ) then
        self.target = target
        self.inst:PushEvent("newcombattarget", {target=target})
        
        if target and self.keeptargetfn then
            self.inst:StartUpdatingComponent(self)
        else
            self.inst:StopUpdatingComponent(self)
        end
    end
end

function Combat:IsValidTarget(target)
    if not target 
	   or not target.components.combat
	   or not target.entity:IsValid()
       or not target.entity:IsVisible()
       or not target.components.health
       or target == self.inst
       or target.components.health:IsDead()
       or (target:HasTag("shadow") and not self.inst.components.sanity)
       or Vector3(target.Transform:GetWorldPosition()).y > self.attackrange then
        return false
    else
		return true
	end
end

function Combat:ValidateTarget()
    if self.target then
		if self:IsValidTarget(self.target) then
			return true
		else
			self:SetTarget(nil)
		end
    end
end

function Combat:GetDebugString()
    
    local str = string.format("target:%s, damage:%d", tostring(self.target), self.defaultdamage or 0 )
    if self.target then
        local dist = math.sqrt(self.inst:GetDistanceSqToInst(self.target)) or 0
        local atkrange = math.sqrt(self:CalcAttackRangeSq()) or 0
        str = str .. string.format(" dist/range: %2.2f/%2.2f", dist, atkrange)
    end
    if self.targetfn and self.retargetperiod then
        str = str.. " Retarget set"
    end
	str = str..string.format(" can attack:%s", tostring(self:CanAttack(self.target)))
    
    return str
end

function Combat:GiveUp()
    if self.inst.components.talker then
        local str = ""
        if self.target and self.target:HasTag("prey") then
            str = GetString(self.inst.prefab, "COMBAT_QUIT", "prey")
        else
            str = GetString(self.inst.prefab, "COMBAT_QUIT")
        end
        
        self.inst.components.talker:Say(str)
        
    end
    self.inst:PushEvent("giveuptarget", {target = self.target})
    self.target = nil
end

function Combat:GetBattleCryString(target)
    return nil
end

function Combat:BattleCry()

    if not self.nextbattlecrytime or GetTime() > self.nextbattlecrytime then
        if self.inst.components.talker then
            self.nextbattlecrytime = GetTime() + 2+math.random()*3
            local cry = self:GetBattleCryString(self.target)
            if cry then
                self.inst.components.talker:Say{Line(cry, 2)}
            end
        elseif self.inst.sg.sg.states.taunt and not self.inst.sg:HasStateTag("busy") then
            self.inst.sg:GoToState("taunt")
        end
    end
end


function Combat:GetAttacked(attacker, damage, weapon)
    --print ("ATTACKED", self.inst, attacker, damage)

    local blocked = false
    self.lastattacker = attacker
    if self.inst.components.health and damage then
    
        if self.inst.components.inventory then
            damage = self.inst.components.inventory:ApplyDamage(damage, attacker)
        end
    
        if damage > 0 and self.inst.components.health:IsInvincible() == false then
            self.inst.components.health:DoDelta(-damage, nil, attacker and attacker.prefab or "NIL")
            if self.inst.components.health:GetPercent() <= 0 then
				if attacker then
					attacker:PushEvent("killed", {victim = self.inst})
				end
                if attacker and attacker:HasTag( "player" ) then
                    ProfileStatsAdd("kill_"..self.inst.prefab)
                end
                
                if self.onkilledbyother then
					self.onkilledbyother(self.inst, attacker)
                end
            end
        else
            blocked = true
        end
    end
    
    if not blocked then
        self.inst:PushEvent("attacked", {attacker = attacker, damage = damage, weapon = weapon})
    
        if self.onhitfn then
            self.onhitfn(self.inst, attacker, damage)
        end
        
        if attacker then
            attacker:PushEvent("onhitother", {target = self.inst, damage = damage})
            if attacker.components.combat and attacker.components.combat.onhitotherfn then
                attacker.components.combat.onhitotherfn(attacker, self.inst, damage)
            end
        end
    else
        self.inst:PushEvent("blocked", {attacker = attacker})
    end
    
    return not blocked
end

function Combat:StartAttack()
    self.laststartattacktime = GetTime()
end

function Combat:CanTarget(target)
    
    return target and 
		target.entity:IsValid() and
		not target:IsInLimbo() and
		target.components.combat and 
		not (target.sg and target.sg:HasStateTag("invisible")) and
        target.components.health and
        not target.components.health:IsDead()

end

function Combat:CanAttack(target)

	if not target then
		return false
	end

    if not self.canattack then 
		return false 
	end
    
    if self.laststartattacktime then
        local time_since_doattack = GetTime() - self.laststartattacktime
        
        if time_since_doattack < self.min_attack_period then
            return false
        end
    end

	if not self:IsValidTarget(target) then
		return false
	end
    
    if self.inst.sg:HasStateTag("busy") then
		return false
    end

	local tpos = Point(target.Transform:GetWorldPosition())
	local pos = Point(self.inst.Transform:GetWorldPosition())
	if distsq(tpos,pos) <= self:CalcAttackRangeSq(target) then
		return true
	else
		return false
	end
end


function Combat:TryAttack(target)
    
    local target = target or self.target 
    
    local is_attacking = self.inst.sg:HasStateTag("attack")
    if is_attacking then
        return true
    end
    
    if self:CanAttack(target) then
        self.inst:PushEvent("doattack", {target = target})
        return true
    end
    
    return false
end

function Combat:GetWeapon()
    if self.inst.components.inventory then
        local item = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if item and item.components.weapon then
            return item
        end
    end
end


function Combat:CalcDamage(target, weapon, multiplier)

    if target:HasTag("alwaysblock") then
        return 0
    end
	local multiplier = multiplier or self.damagemultiplier or 1
	local bonus = self.damagebonus or 0
    if weapon then
        return weapon.components.weapon.damage*multiplier + bonus
    end
    
    if target and target:HasTag("player") then
		return self.defaultdamage * self.playerdamagepercent * multiplier + bonus
    end
    
    return self.defaultdamage * multiplier + bonus
end

function Combat:GetAttackRange()
    local range = self.attackrange
    local weapon = self:GetWeapon()
    if weapon and weapon.components.weapon.attackrange then
        range = range + weapon.components.weapon.attackrange
    end
    return range
end

function Combat:CalcAttackRangeSq(target)
    target = target or self.target
    local range = self:GetAttackRange() + (target.Physics and target.Physics:GetRadius() or 0)
    return range*range
end

function Combat:CanAttackTarget(targ, weapon)
    if targ and targ:IsValid() and not targ:IsInLimbo() then
        local rangesq = self:CalcAttackRangeSq(targ)
        if targ.components.combat and self.inst:GetDistanceSqToInst(targ) <= rangesq then
            return true
        end
        if weapon and weapon.components.projectile then
            local range = weapon.components.projectile.hitdist + (targ.Physics and targ.Physics:GetRadius() or 0)
            if weapon:GetDistanceSqToInst(targ) < range*range then
                return true
            end
        end
    end
end

function Combat:GetHitRange()
    local range = self.hitrange
    local weapon = self:GetWeapon()
    if weapon and weapon.components.weapon.hitrange then
        range = range + weapon.components.weapon.hitrange
    end
    --print("GetHitRange", self.inst, self.hitrange, range)
    return range
end

function Combat:CalcHitRangeSq(target)
    target = target or self.target
    local range = self:GetHitRange() + (target.Physics and target.Physics:GetRadius() or 0)
    return range*range
end

function Combat:CanHitTarget(targ, weapon)
    --print("CanHitTarget", self.inst)
    if targ and targ:IsValid() and not targ:IsInLimbo() then
        local rangesq = self:CalcHitRangeSq(targ)
        if targ.components.combat and self.inst:GetDistanceSqToInst(targ) <= rangesq then
            return true
        end
        if weapon and weapon.components.projectile then
            local range = weapon.components.projectile.hitdist + (targ.Physics and targ.Physics:GetRadius() or 0)
            if weapon:GetDistanceSqToInst(targ) < range*range then
                return true
            end
        end
    end
end

function Combat:CanAreaHitTarget(targ)
    if self:IsValidTarget(targ) then
        return true
    end
end

function Combat:DoAttack(target_override, weapon, projectile)
    
    local targ = target_override or self.target
    local weapon = weapon or self:GetWeapon()
    
    if self:CanHitTarget(targ, weapon) then
        self.inst:PushEvent("onattackother", {target = targ, weapon = weapon, projectile = projectile})
        if weapon and weapon.components.projectile and not projectile then
            local projectile = self.inst.components.inventory:DropItem(weapon, false)
            if projectile then
                projectile.components.projectile:Throw(self.inst, targ)
            end
        elseif weapon and weapon.components.weapon.projectile and not projectile then
            weapon.components.weapon:LaunchProjectile(self.inst, targ)
        else
            local damage = self:CalcDamage(targ, weapon)
            targ.components.combat:GetAttacked(self.inst, damage, weapon)
            
            if weapon then
                weapon.components.weapon:OnAttack(self.inst, targ, projectile)
            end
            if self.areahitrange then
                self:DoAreaAttack(targ, self.areahitrange, weapon)
            end
            self.lastdoattacktime = GetTime()
        end
    else
        self.inst:PushEvent("onmissother", {target = targ, weapon = weapon})
        if self.areahitrange then
            local epicentre = projectile or self.inst
            self:DoAreaAttack(epicentre, self.areahitrange, weapon)
        end
    end

end

function Combat:DoAreaAttack(target, range, weapon, validfn)
    local hitcount = 0
	local pt = Vector3(target.Transform:GetWorldPosition() )
	local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, range)
	for i,ent in ipairs(ents) do
		if ent.components.combat 
            and ent ~= target 
            and ent ~= self.inst 
            and self:CanAreaHitTarget(ent) 
            and (not validfn or validfn(ent)) then
    		    self.inst:PushEvent("onareaattackother", {target = target, weapon = weapon})
    			ent.components.combat:GetAttacked(self.inst, self:CalcDamage(ent, weapon, self.areahitdamagepercent), weapon)
                hitcount = hitcount + 1
		end
	end
    return hitcount
end

function Combat:IsAlly(guy)
    return  (guy == self.inst) or
            (self.inst.components.leader and self.inst.components.leader:IsFollower(guy)) or
            (guy.components.leader and guy.components.leader:IsFollower(self.inst)) or 
            (self.inst:HasTag("player") and guy:HasTag("companion"))
end

function Combat:CanBeAttacked(attacker)
    local can_be_attacked = true
    if self.canbeattackedfn then
		can_be_attacked = self.canbeattackedfn(self.inst, attacker)
    end
	return can_be_attacked
end

function Combat:CollectSceneActions(doer, actions)
    if doer:CanDoAction(ACTIONS.ATTACK) and not self.inst.components.health:IsDead() then
        
        if self:CanBeAttacked(attacker) then
            table.insert(actions, ACTIONS.ATTACK)
        end
    end
end

function Combat:OnSave()
    if self.target then
        return { target = self.target.GUID }
    end
end

function Combat:LoadPostPass(newents, data)
    if data.target then
        local target = newents[data.target]
        if target then
            self:SetTarget(target.entity)
        end
    end
end

return Combat
