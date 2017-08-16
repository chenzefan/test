local Hunger = Class(function(self, inst)
    self.inst = inst
    self.max = 100
    self.current = self.max

    self.hungerrate = 1
    self.hurtrate = 1
    
    self.burning = true
    
    self.period = 1
    
    self.task = self.inst:DoPeriodicTask(self.period, function() self:DoDec() end)
	self.inst:ListenForEvent("respawn", function(inst) self:OnRespawn() end)
	
end)


function Hunger:OnRespawn()
	
end

function Hunger:OnSave()
    if self.current ~= self.max then
        return {hunger = self.current}
    end
end

function Hunger:OnLoad(data)
    if data.hunger then
        self.current = data.hunger
        self:DoDelta(0)
    end
    
end



function Hunger:GetPercent()
    return self.current / self.max
end

function Hunger:Pause()
    self.burning = false
end

function Hunger:Resume()
    self.burning = true
end

function Hunger:GetDebugString()
    return string.format("%2.2f / %2.2f", self.current, self.max)
end

function Hunger:SetMax(amount)
    self.max = amount
    self.current = amount
end


function Hunger:IsStarving() 
    return self.current <= 0
end

function Hunger:DoDelta(delta, overtime)
    local old = self.current
    self.current = self.current + delta
    if self.current < 0 then 
        self.current = 0
    elseif self.current > self.max then
        self.current = self.max
    end
    
    self.inst:PushEvent("hungerdelta", {oldpercent = old/self.max, newpercent = self.current/self.max, overtime = overtime})

    if old > 0 and self.current <= 0 then
        self.inst:PushEvent("startstarving")
    elseif old <= 0 and self.current > 0 then
        self.inst:PushEvent("stopstarving")
    end
    
end

function Hunger:GetPercent(p)
    return self.current / self.max
end

function Hunger:SetPercent(p)
    local old = self.current
    self.current  = p*self.max
    self.inst:PushEvent("hungerdelta", {oldpercent = old/self.max, newpercent = p})

    if old > 0 and self.current <= 0 then
        self.inst:PushEvent("startstarving")
    elseif old <= 0 and self.current > 0 then
        self.inst:PushEvent("stopstarving")
    end

end

function Hunger:DoDec()
	
    local old = self.current
    
    if self.burning then
        if self.current <= 0 then
            self.inst.components.health:DoDelta(-self.hurtrate*self.period, true, "hunger") --  ich haber hunger
        else
            self:DoDelta(-self.hungerrate*self.period, true)
        end
    end
    
    --self.task = self.inst:DoTaskInTime(self.period, function() self:DoDec() end)
end

function Hunger:SetKillRate(rate)
    self.hurtrate = rate
end

function Hunger:SetRate(rate)
    self.hungerrate = rate
end


return Hunger
