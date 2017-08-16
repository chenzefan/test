require("stategraphs/commonstates")

local events=
{
    CommonHandlers.OnLocomote(false, true),
    EventHandler("startaura", function(inst, data) inst.sg:GoToState("angry") end),
    EventHandler("stopaura", function(inst, data) inst.sg:GoToState("idle") end),
    EventHandler("attacked", function(inst) if inst.components.health:GetPercent() > 0 then inst.sg:GoToState("hit") end end),
	EventHandler("death", function(inst) inst.sg:GoToState("dissipate") end),
}

local states=
{
    State
    {
        name = "idle",
        tags = {"idle", "canrotate", "canslide"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle", true)
        end,
    },
    
    State
    {
        name = "appear",
        onenter = function(inst)
            inst.AnimState:PlayAnimation("appear")
        end,
        
        events=
        {
            EventHandler("animover", function(inst, data) inst.components.aura:Enable(true) inst.sg:GoToState("idle") end)
        },
        
    },    
    
    State
    {
        name = "angry",
        tags = {"idle", "canrotate", "canslide"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("angry", true)
            --if inst.Light then
				inst.Light:SetColour(255/255, 32/255, 32/255)
				--inst.Light:SetIntensity(3)
			--end
        end,
        
        onexit = function(inst)
            --if inst.Light then
				inst.Light:SetColour(180/255, 195/255, 225/255)
				--inst.Light:SetIntensity(2)
			--end
        end,
    },
    
    State{
        name = "hit",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()            
        end,
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

    State
    {
        name = "dissipate",
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("dissipate")
        end,
        
        events=
        {
            EventHandler("animover", function(inst, data) inst:Remove() end)
        },
    },
   
}


CommonStates.AddSimpleWalkStates(states, "idle")
--CommonStates.AddSimpleRunStates(states, "idle")
    
return StateGraph("ghost", states, events, "appear")

