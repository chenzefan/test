require("stategraphs/commonstates")

local actionhandlers = {}

local events = 
{
    EventHandler("putoutfire", function(inst, data) 
        if inst.canFire and inst.components.machine:IsOn() and not inst.sg:HasStateTag("busy") then
            inst.sg:GoToState("shoot", {firePos = data.firePos})
        end
    end)
}

local states = 
{

    State{
        name = "turn_on",
        tags = {"idle"},

        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_on")
            inst.AnimState:PlayAnimation("turn_on")
        end,


        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle_on") end),
        }
    },

    State{
        name = "turn_off",
        tags = {"idle"},

        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_off")
            inst.AnimState:PlayAnimation("turn_off")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle_off") end),
        }
    },

    State{
        name = "idle_on",
        tags = {"idle"},

        onenter = function(inst)
            --Start some loop sound
            if not inst.SoundEmitter:PlayingSound("firesuppressor_idle") then
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_idle", "firesuppressor_idle")
            end
            inst.AnimState:PlayAnimation("idle_on_loop")
        end,

        timeline = 
        {
            TimeEvent(16*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_chuff") end)
        },

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle_on") end),
        }
    },

    State{
        name = "idle_off",
        tags = {"idle"},

        onenter = function(inst)
            --Stop some loop sound
            inst.SoundEmitter:KillSound("firesuppressor_idle")
            inst.AnimState:PlayAnimation("idle_off", true)
        end,
    },

    State{  
        name = "shoot",
        tags = {"busy"},

        onenter = function(inst, data)
            inst.AnimState:PlayAnimation("launch_pre")
            inst.AnimState:PushAnimation("launch")
            inst.AnimState:PushAnimation("launch_pst", false)
            inst.sg.statemem.firePos = data.firePos
            inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_spin")
            --Play some sound 
        end,

        timeline = 
        {
            TimeEvent(25*FRAMES, function(inst) 
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_shoot")
                inst:LaunchProjectile(inst.sg.statemem.firePos) end)
        },

        events = 
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle_on") end)
        },
    },

    State{  
        name = "place",
        tags = {"busy"},

        onenter = function(inst, data)
            inst.AnimState:PlayAnimation("place")
            --Play some sound 
        end,

        timeline = {},

        events = 
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle_on") end)
        },
    },

    State{  
        name = "hit",
        tags = {"busy"},

        onenter = function(inst, data)
            if inst.on then 
                inst.AnimState:PlayAnimation("hit_on")
            else
                inst.AnimState:PlayAnimation("hit_off")
            end
            --Play some sound 
        end,

        timeline = {},

        events = 
        {
            EventHandler("animover", function(inst) 
                if inst.on then 
                    inst.sg:GoToState("idle_on")
                else
                    inst.sg:GoToState("idle_off")
                end
            end)
        },
    },
}
    
return StateGraph("firesuppressor", states, events, "idle_off", actionhandlers)