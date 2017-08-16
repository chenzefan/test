local Follower = Class(function(self, inst)
    self.inst = inst
    self.leader = nil
    self.targettick = nil
    self.targettime = nil
    self.maxfollowtime = nil
    self.canaccepttarget = true
end)

local willStopFollowing = {}
local function FollowerUpdate(dt)
	local tick = TheSim:GetTick()
	if willStopFollowing[tick] then
		for k,v in pairs(willStopFollowing[tick]) do
			if v:IsValid() and v.components.follower then
			    v:PushEvent("loseloyalty", {leader=v.components.follower.leader})
				v.components.follower:SetLeader(nil)
				v.components.follower.targettime = nil
				v.components.follower.targettick = nil
			end
		end
		willStopFollowing[tick] = nil
	end	
end

function Follower:GetDebugString()
    local str = "Following "..tostring(self.leader)
	if self.targettime then
		str = str..string.format(" Stop in %2.2fs, %2.2f%%", self.targettime - GetTime(), 100*self:GetLoyaltyPercent())
	end
	return str
end

function Follower:SetLeader(inst)
    if self.leader and self.leader.components.leader then
        self.leader.components.leader:RemoveFollower(self.inst)
    end
    if inst and inst.components.leader then
        inst.components.leader:AddFollower(self.inst)
    end
    self.leader = inst
end

function Follower:DestroyLoyalty()
    if self.targettick and willStopFollowing[self.targettick] then
	    willStopFollowing[self.targettick][self.inst] = nil
        self.targettick = nil
        self.targettime = nil
    end
end

function Follower:GetLoyaltyPercent()
    if self.targettime and self.maxfollowtime then
        local timeLeft = math.max(0, self.targettime - GetTime())
        return timeLeft / self.maxfollowtime
    end
    return 0
end

function Follower:AddLoyaltyTime(time)
    
    local currentTime = GetTime()
    local timeLeft = self.targettime or 0
    timeLeft = math.max(0, timeLeft - currentTime)
    timeLeft = math.min(self.maxfollowtime or 0, timeLeft + time)
    self:DestroyLoyalty()
    
    self.targettime = currentTime + timeLeft
    self.targettick = GetTickForTime(self.targettime)
    
    if not willStopFollowing[self.targettick] then
		willStopFollowing[self.targettick] = {[self.inst] = self.inst}
    else
		willStopFollowing[self.targettick][self.inst] = self.inst
    end
end

function Follower:IsNearLeader(dist)
    return self.leader and self.inst:IsNear(self.leader, dist)
end

function Follower:OnSave()
    local time = GetTime()
    if self.targettime and self.targettime > time then
        return {time = math.floor(self.targettime - time) }
    end
end

function Follower:OnLoad(data)
    if data.time then
        self:AddLoyaltyTime(data.time)
    end
end

RegisterStaticComponentUpdate("follower", FollowerUpdate)

return Follower
