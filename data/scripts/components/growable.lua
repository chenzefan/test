local Growable = Class(function(self, inst)
    self.inst = inst
    self.stages = nil
    self.stage = 1
    self.loopstages = false
    self.growonly = false
end)

local waiting_for_growth = {}
local function GrowableUpdate(dt)
	local tick = TheSim:GetTick()
	if waiting_for_growth[tick] then
		for k,v in pairs(waiting_for_growth[tick]) do
			if v:IsValid() and v.components.growable then
				v.components.growable:DoGrowth()
			end
		end
		waiting_for_growth[tick] = nil
	end	
end



function Growable:OnRemoveEntity()
	self:StopGrowing()
end

function Growable:GetDebugString()
	if self.targettime then
		return string.format("Growing! stage %d, timeleft %2.2fs", self.stage, self.targettime - GetTime())
	end
	return "Not Growing"
end


function Growable:StartGrowing(time)
    if #self.stages == 0 then
        print "Growable component: Trying to grow without setting the stages table"
        return
    end
    
    if self.stage <= #self.stages then
        self:StopGrowing()
        
        local timeToGrow = 10
        if time then
			timeToGrow = time
        elseif self.stages[self.stage].time then
			timeToGrow = self.stages[self.stage].time(self.inst, self.stage)
		end
		--print ("growing ", time, self.stage, timeToGrow)

        if timeToGrow then
            self.targettime = GetTime() + timeToGrow
            self.targettick = GetTickForTime(self.targettime)
            if not waiting_for_growth[self.targettick] then
				waiting_for_growth[self.targettick] = {[self.inst] = self.inst}
            else
				waiting_for_growth[self.targettick][self.inst] = self.inst
            end
            
        end
    end
end

function Growable:GetNextStage()
    local stage = self.stage + 1
    if stage > #self.stages then
        if self.loopstages then
            stage = 1
        else
            stage = #self.stages
        end
    end
    return stage
end

function Growable:DoGrowth()
    local stage = self:GetNextStage()
    
    if not self.growonly then
        self:SetStage(stage)
    end
    
    if self.stages[stage] and self.stages[stage].growfn then
        self.stages[stage].growfn(self.inst)
    end
    
    if stage < #self.stages or self.loopstages then 
		self:StartGrowing()
    end
end

function Growable:StopGrowing()
    
	self.targettime = nil
	
	if self.targettick and waiting_for_growth[self.targettick] then
		waiting_for_growth[self.targettick][self.inst] = nil
    end
	self.targettick = nil
end

function Growable:SetStage(stage)
    if stage > #self.stages then
        stage = #self.stages
    end
    
    self.stage = stage
    
    if self.stages[stage] and self.stages[stage].fn then
        self.stages[stage].fn(self.inst)
    end
end

function Growable:GetCurrentStageData()
    return self.stages[self.stage]
end

function Growable:OnSave()
    local data = 
    {
        stage = self.stage
    }
    local time = GetTime()
    if self.targettime and self.targettime > time then
        data.time = math.floor(self.targettime - time)
    end
    return data
end   
   
function Growable:OnLoad(data)
    if data then    
        self:SetStage(data.stage)
        if data.time then
            self:StartGrowing(data.time)
        end
    end
end

function Growable:OnRemoveFromEntity()
    self:StopGrowing()
end





RegisterStaticComponentUpdate("growable", GrowableUpdate)

return Growable