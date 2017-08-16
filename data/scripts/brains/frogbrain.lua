require "behaviours/wander"
require "behaviours/doaction"
require "behaviours/chaseandattack"

local STOP_RUN_DIST = 10
local SEE_PLAYER_DIST = 5
local MAX_WANDER_DIST = 20
local SEE_TARGET_DIST = 6

local MAX_CHASE_DIST = 7
local MAX_CHASE_TIME = 8

local function GoHomeAction(inst)
    if inst.components.homeseeker and 
       inst.components.homeseeker.home and 
       inst.components.homeseeker.home:IsValid() then
        return BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
    end
end

local function ShouldGoHome(inst)
    return not GetClock():IsDay() or GetSeasonManager():IsWinter()
end

local FrogBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function FrogBrain:OnStart()
    local root = PriorityNode(
    {
        ChaseAndAttack(self.inst, MAX_CHASE_TIME),
        WhileNode(function() return ShouldGoHome(self.inst) end, "ShouldGoHome",
            DoAction(self.inst, function() return GoHomeAction(self.inst) end, "go home", true )),
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST)
    }, .25)
    
    self.bt = BT(self.inst, root)
    
end

return FrogBrain