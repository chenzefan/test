local easing = require("easing")

local Temperature = Class(function(self, inst)
    self.inst = inst
	self.rate = 0
	self.current = 30
	self.maxtemp = 40
	self.mintemp = -20
	self.hurtrate = TUNING.WILSON_HEALTH / TUNING.FREEZING_KILL_TIME
	self.inherentinsulation = 0
	self:OnUpdate(0)

	self.last_real_delta = 0
	
	self.inst:StartUpdatingComponent(self)
end)

function Temperature:GetCurrent()
	return self.current 
end

function Temperature:OnSave()
	return { current = self.current }
			 
end

function Temperature:OnLoad(data)

	self.current = data.current or self.current
	self:OnUpdate(0)
	
end

function Temperature:GetDebugString()
    return string.format("%2.2fC at %2.2f (delta: %2.2f)", self:GetCurrent(), self.rate, self.last_real_delta)
end

function Temperature:IsFreezing()
	return self.current < 0
end

function Temperature:OnUpdate(dt)

    local last = self.current

	local ambient_delta = GetWorld().components.seasonmanager:GetCurrentTemperature() - self.current

	--figure out our insulation
	local total_insulation = 0

	total_insulation = total_insulation + self.inherentinsulation

	if self.inst.components.inventory then
		for k,v in pairs (self.inst.components.inventory.equipslots) do
			if v.components.heater then
				local heat = v.components.heater:GetEquippedHeat()
				if heat > self.current then
					ambient_delta = ambient_delta + (heat - self.current)
				end
			end
			
			if v.components.insulator then
				total_insulation = total_insulation + v.components.insulator.insulation
			end
		end
		for k,v in pairs(self.inst.components.inventory.itemslots) do
			if v.components.heater then
				local heat = v.components.heater:GetCarriedHeat()
				if heat > self.current then
					ambient_delta = ambient_delta + (heat - self.current)
				end
			end
		end
	end
	
	if self.inst.components.beard then
		total_insulation = total_insulation + self.inst.components.beard:GetInsulation()
	end

	--now figure out the temperature where we are standing
	local x,y,z = self.inst.Transform:GetWorldPosition()
	
	local ZERO_DISTANCE = 10
	local ZERO_DISTSQ = ZERO_DISTANCE*ZERO_DISTANCE

	local ents = TheSim:FindEntities(x,y,z, ZERO_DISTANCE)
    for k,v in pairs(ents) do 
		if v.components.heater and v ~= self.inst and not v:IsInLimbo() then
			local heat = v.components.heater:GetHeat(self.inst)
			local distsq = self.inst:GetDistanceSqToInst(v)

			-- This produces a gentle falloff from 1 to zero.
			local heatfactor = ((-1/ZERO_DISTSQ)*distsq) + 1

			if heat*heatfactor > self.current then
				ambient_delta = ambient_delta + (heat*heatfactor - self.current)
			end
		end
    end	

	local delta = ambient_delta
	self.last_real_delta = delta
	local freeze_time = TUNING.SEG_TIME + total_insulation
	local WARM_DEGREES_PER_SECOND = 1
	local THAW_DEGREES_PER_SECOND = 5
	
	if delta < 0 then
		self.rate = math.max(delta, -30 / freeze_time)
	elseif delta > 0 then
		
		self.rate = math.min(delta, self.current <= 0 and THAW_DEGREES_PER_SECOND or WARM_DEGREES_PER_SECOND)
	else
		self.rate = 0
	end
	
	
    self.current = math.max( math.min( self.current + self.rate*dt, self.maxtemp), self.mintemp)
	self.inst:PushEvent("temperaturedelta", {last = last, new = self.current})
	
	if self.current < 0 and self.inst.components.health then
		self.inst.components.health:DoDelta(-self.hurtrate*dt, true, "cold") 
	end
	
end

return Temperature