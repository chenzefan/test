require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"

local STOP_RUN_DIST = 10
local SEE_PLAYER_DIST = 5
local SEE_FOOD_DIST = 20
local MAX_WANDER_DIST = 80
local MAX_CHASE_TIME = 10

local PenguinBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function PenguinBrain:OnStart()
    local clock = GetClock()
    
    local root = PriorityNode(
    {
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
        ChaseAndAttack(self.inst, MAX_CHASE_TIME),
        --WhileNode(function() return clock and not clock:IsDay() end, "IsNight",
            --DoAction(self.inst, GoHomeAction, "Go Home", true )),
        RunAway(self.inst, "scarytoprey", SEE_PLAYER_DIST, STOP_RUN_DIST),
        Wander(self.inst, nil, MAX_WANDER_DIST),
    }, .25)
    
    self.bt = BT(self.inst, root)
end

return PenguinBrain