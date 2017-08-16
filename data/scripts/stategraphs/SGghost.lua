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
			inst.Light:SetColour(255/255, 32/255, 32/255)
            if inst:HasTag("girl") then
                inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_girl_attack_LP", "angry")
            else
                inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_attack_LP", "angry")
            end
        end,
        
        onexit = function(inst)
			inst.Light:SetColour(180/255, 195/255, 225/255)
            inst.SoundEmitter:KillSound("angry")
        end,
    },
    
    State{
        name = "hit",
        tags = {"busy"},
        
        onenter = function(inst)
            if inst:HasTag("girl") then
                inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_girl_howl")
            else
                inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_howl")
            end
                
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

