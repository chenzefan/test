ChaseAndRam = Class(BehaviourNode, function(self, inst, max_chase_time, give_up_dist, max_attacks, findnewtargetfn)
    BehaviourNode._ctor(self, "ChaseAndRam")
    self.inst = inst
    self.findnewtargetfn = findnewtargetfn
    self.max_chase_time = max_chase_time
    self.give_up_dist = give_up_dist
    self.max_attacks = max_attacks
    self.numattacks = 0
    
    -- we need to store this function as a key to use to remove itself later
    self.onattackfn = function(inst, data)
        self:OnAttackOther(data.target) 
    end

    self.onattackstartfn =
        function(inst, data)
            local combat = self.inst.components.combat
            
            combat:ValidateTarget()
            
            if combat.target then
                local hp = Point(combat.target.Transform:GetWorldPosition())
                local pt = Point(self.inst.Transform:GetWorldPosition())
                self.ram_angle = self.inst:GetAngleToPoint(hp)
                self.ram_vector = (hp-pt):GetNormalized()
                local goal = pt + (self.ram_vector*4)   -- keep running along old vector
                self.inst.components.locomotor:GoToPoint(goal, nil, true)
                dprint("Getting New Attack Vector",self.ram_angle)
            end
        end

    self.inst:ListenForEvent("onattackother", self.onattackfn)
    self.inst:ListenForEvent("onmissother", self.onattackfn)
    self.inst:ListenForEvent("attackstart", self.onattackstartfn)
end)

function ChaseAndRam:__tostring()
    return string.format("target %s", tostring(self.inst.components.combat.target))
end

function ChaseAndRam:OnStop()
    self.inst:RemoveEventCallback("onattackother", self.onattackfn)
    self.inst:RemoveEventCallback("onmissother", self.onattackfn)
    self.inst:RemoveEventCallback("attackstart", self.onattackstartfn)
end

function ChaseAndRam:OnAttackOther(target)
    --print ("on attack other", target)
    self.numattacks = self.numattacks + 1
    self.startruntime = nil -- reset max chase time timer
end

function ChaseAndRam:Visit()
    
    local combat = self.inst.components.combat
    if self.status == READY then
        
        combat:ValidateTarget()
        
        if not combat.target and self.findnewtargetfn then
            combat.target = self.findnewtargetfn(self.inst)
            local hp = Point(combat.target.Transform:GetWorldPosition())
            local pt = Point(self.inst.Transform:GetWorldPosition())
            local dsq = distsq(hp, pt)
            self.ram_angle = self.inst:GetAngleToPoint(hp)
            self.ram_vector = (hp-pt):GetNormalized()
        end
        
        if combat.target then
            self.inst.components.combat:BattleCry()
            self.startruntime = GetTime()
            self.numattacks = 0
            self.status = RUNNING
        else
            self.status = FAILED
            IOprint("\rRAM: no target")
            self.ram_vector = nil
        end
        
    end

    if self.status == RUNNING then
        
       local is_attacking = self.inst.sg:HasStateTag("attack")
        
        if not combat.target or not combat.target.entity:IsValid() then
            self.status = FAILED
            self.ram_vector = nil
            combat:SetTarget(nil)
            self.inst.components.locomotor:Stop()
            IOprint("\rRAM: no validtarget")
        elseif combat.target.components.health and combat.target.components.health:IsDead() then
            self.status = SUCCESS
            combat:SetTarget(nil)
            self.inst.components.locomotor:Stop()
        else
            local hp = Point(combat.target.Transform:GetWorldPosition())
            local pt = Point(self.inst.Transform:GetWorldPosition())
            local dsq = distsq(hp, pt)
            local angle = self.inst:GetAngleToPoint(hp)

            if not self.ram_vector then
                self.ram_angle = self.inst:GetAngleToPoint(hp)
                self.ram_vector = (hp-pt):GetNormalized()
                dprint("Set Initial Vector",self.ram_angle)
            end


            local r= self.inst.Physics:GetRadius()+ combat.target.Physics:GetRadius() + .1
            local running = self.inst.components.locomotor:WantsToRun()
            local goal = pt + (self.ram_vector*4)   -- keep running along old vector
            IOprint("\rAngle diff:",math.abs(angle-self.ram_angle),":",angle,":",self.ram_angle)
            
            if (running and math.abs(angle-self.ram_angle) <= 135) or (not running and dsq < (self.give_up_dist*self.give_up_dist) ) then
                self.inst.components.locomotor:RunInDirection(self.ram_angle)
                --self.inst.components.locomotor:GoToPoint(goal, nil, true)
            elseif not (self.inst.sg and self.inst.sg:HasStateTag("jumping")) then
                dprint("\n---------------------------- RAM STOP : ",running," ang:",math.abs(angle-self.ram_angle) <= 135, math.sqrt(dsq) , self.give_up_dist )
                self.inst.components.locomotor:Stop()
                self.status = FAILED
                combat:SetTarget(nil)
                self.ram_vector = nil
                self.inst.components.locomotor:Stop()
                if self.inst.sg:HasStateTag("canrotate") then
                    self.inst:FacePoint(hp)
                end                
            end
                
            if combat:TryAttack() then
                -- reset chase timer when attack hits, not on attempts
            else
                if not self.startruntime then
                    self.startruntime = GetTime()
                    self.inst.components.combat:BattleCry()
                end
            end

            
            if self.max_attacks and self.numattacks >= self.max_attacks then
                self.status = SUCCESS
                dprint("\n----------------------------RAM: max attacks exceeded")
                self.inst.components.combat:SetTarget(nil)
                self.inst.components.locomotor:Stop()
                return
            end
            
            if self.give_up_dist then
                if dsq >= self.give_up_dist*self.give_up_dist then
                    self.status = FAILED
                    dprint("\n----------------------------RAM: max dist exceeded")
                    self.ram_vector = nil
                    self.inst.components.combat:GiveUp()
                    self.inst.components.locomotor:Stop()
                    return
                end
            end
            
            if self.max_chase_time and self.startruntime then
                local time_running = GetTime() - self.startruntime
                if time_running > self.max_chase_time then
                    self.status = FAILED
                    dprint("\n----------------------------RAM: max time exceeded")
                    self.ram_vector = nil
                    self.inst.components.combat:GiveUp()
                    self.inst.components.locomotor:Stop()
                    return
                end
            end
            self:Sleep(.125)
            
        end
        
    end
end
