--[[
	The starting shell to the nightmare cycle for the ruins.
	At the moment the code is near identical to the clock for the day/night cycle above ground.\
	Era times or segment numbers could change based on how insane the player is
]]

local NightmareClock = Class(function(self, inst)
	self.inst = inst
	self.task = nil
	--[[
		Calm = Day
		Warn = Dusk
		Nightmare = Night
	]]
	self.calmsegs = 7
	self.warnsegs = 1
	self.nightmaresegs = 6
	self.totalsegs = 14
	self.segtime = 15

	self.calmColour = Point(1,1,1)
	self.warnColour = Point(0.5,0.5,0.5)
	self.nightmareColour = Point(0.1,0.1,0.1)

	self.currentColour = self.calmColour

	self.lerpToColour = self.calmColour
	self.lerpFromColour = self.calmColour

    self.lerptimeleft = 0
    self.totallerptime = 0
    self.override_timeLeftInEra = nil

    self.inst:StartUpdatingComponent(self)

	self.previous_phase = "nightmare"

	self:StartCalm()
end)

function NightmareClock:GetDebugString()
    return string.format("%s: %2.2f ", self.phase, self:GetTimeLeftInEra())
end

function NightmareClock:GetTimeLeftInEra()
	return self.timeLeftInEra
end

function NightmareClock:GetTimeInEra()
    return self.totalEraTime - self.timeLeftInEra 
end

function NightmareClock:GetNormEraTime()
    local ret = self.totalEraTime > 0 and (1 - self.timeLeftInEra / self.totalEraTime) or 1
    return ret
end

function NightmareClock:SetNormEraTime(percent)
	if self.phase == "calm" then
		self.totalEraTime = self:GetDayTime()
	elseif self.phase == "warn" then
		self.totalEraTime = self:GetDuskTime()
	else
		self.totalEraTime = self:GetNightTime()
	end
	
	self.timeLeftInEra = (1-percent)*self.totalEraTime
end

function NightmareClock:GetNormTime()
    
    local ret = 0
    if self.phase == "day" then
		return (self.calmsegs / self.totalsegs)*self:GetNormEraTime()
    elseif self.phase == "dusk" then
		return (self.calmsegs / self.totalsegs) + (self.warnsegs / self.totalsegs)*self:GetNormEraTime()
    else
		return (self.calmsegs / self.totalsegs) + (self.warnsegs / self.totalsegs) + (self.nightmaresegs / self.totalsegs)*self:GetNormEraTime()
    end    
end

function NightmareClock:SetSegs(calm, warn, nightmare)
	assert(calm + warn + nightmare == self.totalsegs, "invalid number of time segs in NightmareClock:SetSegs")
	
	local norm_time = self:GetNormEraTime()
	
	self.calmsegs = calm
	self.warnsegs = warn
	self.nightmaresegs = nightmare
	
	if self.phase == "calm" then
		self.totalEraTime = self.calmsegs*self.segtime
	elseif self.phase == "warn" then
		self.totalEraTime = self.warnsegs*self.segtime
	else
		self.totalEraTime = self.nightmaresegs*self.segtime
	end
	
	self:SetNormEraTime(norm_time)
	self.inst:PushEvent("nightmaresegschanged")
end

function NightmareClock:OnSave()
	return {
	phase = self.phase,
	normeratime = self:GetNormEraTime()
	}
end

function NightmareClock:OnLoad()
	if data.phase == "nightmare" then
		self:StartNightmare(true)
	elseif data.phase == "warn" then
		self:StartWarn(true)
	else
		self:StartCalm(true)
	end

	local normeratime = data.normeratime or 0
	self:SetNormEraTime(normeratime)

end

function NightmareClock:GetCalmTime()
	return self.calmsegs*self.segtime
end

function NightmareClock:GetNightmareTime()
	return self.nightmaresegs*self.segtime
end

function NightmareClock:GetWarnTime()
	return self.warnsegs*self.segtime
end

function NightmareClock:IsCalm()
	return self.phase == "calm"
end

function NightmareClock:IsNightmare()
	return self.phase == "nightmare"
end

function NightmareClock:IsWarn()
	return self.phase == "warn"
end

function NightmareClock:GetPhase()
	return self.phase
end

function NightmareClock:GetNextPhase()
	if self:IsCalm() then
		return "warn"
	elseif self:IsWarn() then
		return "nightmare"
	else
		return "calm"
	end
end

function NightmareClock:GetPrevPhase()
	if self:IsCalm() then
		return "nightmare"
	elseif self:IsWarn() then
		return "calm"
	else
		return "warn"
	end
end

function NightmareClock:StartCalm(instant)
	self.phase = "calm"
	self.timeLeftInEra = self:GetCalmTime()
	self.totalEraTime = self.timeLeftInEra
	self.inst:PushEvent(self.phase.."start")

    if self.phase ~= self.previous_phase then
        self.previous_phase = self.phase   
    	self:LerpAmbientColour(self.currentColour, self.calmColour, instant and 0 or 4)
	end
end

function NightmareClock:StartWarn(instant)
	self.phase = "warn"
	self.timeLeftInEra = self:GetWarnTime()
	self.totalEraTime = self.timeLeftInEra
	self.inst:PushEvent(self.phase.."start")

    if self.phase ~= self.previous_phase then
        self.previous_phase = self.phase   
    	self:LerpAmbientColour(self.currentColour, self.warnColour, instant and 0 or 4)
	end
end

function NightmareClock:StartNightmare(instant)
	self.phase = "nightmare"
	self.timeLeftInEra = self:GetNightmareTime()
	self.totalEraTime = self.timeLeftInEra
	self.inst:PushEvent(self.phase.."start")

    if self.phase ~= self.previous_phase then
        self.previous_phase = self.phase   
    	self:LerpAmbientColour(self.currentColour, self.nightmareColour, instant and 0 or 4)
	end

end

function NightmareClock:NextPhase()
	if self:IsCalm() then
		self:StartWarn()
	elseif self:IsWarn() then
		self:StartNightmare()
	else
		self:StartCalm()
	end
end

function NightmareClock:OnUpdate(dt)
	self.timeLeftInEra = self.timeLeftInEra - dt

	if self.override_timeLeftInEra ~= nil then
		self.timeLeftInEra = self.override_timeLeftInEra
	end
	if self.timeLeftInEra <= 0 then
		local time_left_over = -self.timeLeftInEra
		self:NextPhase()

		if time_left_over > 0 then
			self:OnUpdate(time_left_over)
			return
		end
	end

    -- if self.lerptimeleft > 0 then
    --     local percent = 1 - (self.lerptimeleft / self.totallerptime)
    --     local r = percent*self.lerpToColour.x + (1 - percent)*self.lerpFromColour.x
    --     local g = percent*self.lerpToColour.y + (1 - percent)*self.lerpFromColour.y
    --     local b = percent*self.lerpToColour.z + (1 - percent)*self.lerpFromColour.z
    --     self.currentColour = Point(r,g,b)
    --     self.lerptimeleft = self.lerptimeleft - dt
    -- end

	self.inst:PushEvent("nightmareclocktick", {phase = self.phase, normalizedtime = self:GetNormTime()})

end


function NightmareClock:LerpAmbientColour(src, dest, time)
	self.lerptimeleft = time
	self.totallerptime = time

    if time == 0 then
		self.currentColour = dest
    else
		self.lerpFromColour = src
		self.lerpToColour = dest
	end

    if not self.currentColour then
		self.currentColour = src
    end
	--This will probably clash with the clock
    --TheSim:SetAmbientColour( self.currentColour.x, self.currentColour.y, self.currentColour.z )
end

function NightmareClock:LerpFactor()
	if self.totallerptime == 0 then
		return 1
	else
		return math.min( 1.0, 1.0 - self.lerptimeleft / self.totallerptime )
	end
end

function NightmareClock:LongUpdate(dt)
	self:OnUpdate(dt)

	self.lerptimeleft = 0
	if self:IsCalm() then
		self.currentColour = self.calmColour
	elseif self:IsWarn() then
		self.currentColour = self.warnColour
	else
		self.currentColour = self.nightmareColour
	end

	--This will probably clash with the clock
	--TheSim:SetAmbientColour( self.currentColour.x, self.currentColour.y, self.currentColour.z )

end

return NightmareClock