require("stategraphs/commonstates")

local SHAKE_DIST = 40

local function onattackedfn(inst, data)
    if inst.components.health and not inst.components.health:IsDead()
    and (not inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("frozen")) then
        -- Clear out the inventory if he got interrupted
        local target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
        while target do
            target:Remove()
            target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
        end
       inst.sg:GoToState("hit")
    end
end

local function onattackfn(inst)
    if inst.components.health and not inst.components.health:IsDead()
    and (inst.sg:HasStateTag("hit") or not inst.sg:HasStateTag("busy")) then
        -- Clear out the inventory if he got interrupted
        local target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
        while target do
            target:Remove()
            target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
        end
        if inst.CanGroundPound then
            inst.sg:GoToState("pound")
        else
            if not inst.components.timer:TimerExists("GroundPound") then
                inst.components.timer:StartTimer("GroundPound", 10)
            end
            local tpos = Point(inst.components.combat.target.Transform:GetWorldPosition())
            local pos = Point(inst.Transform:GetWorldPosition())
            if distsq(tpos,pos) <= ((TUNING.BEARGER_MELEE_RANGE*1.3)*(TUNING.BEARGER_MELEE_RANGE*1.3)) then
                inst.sg:GoToState("attack")
            elseif inst.components.combat and inst.components.combat.laststartattacktime 
            and ((GetTime() - inst.components.combat.laststartattacktime) >= TUNING.BEARGER_CHARGE_INTERVAL) then
                inst.sg:GoToState("chargeattack")
            end
        end
    end
end

local function destroystuff(inst)
    local pt = inst:GetPosition()
    local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 5)
    local heading_angle = -(inst.Transform:GetRotation())
    for k,v in pairs(ents) do
        if v and v.components.workable and v.components.workable.workleft > 0 then
            SpawnPrefab("collapse_small_fx").Transform:SetPosition(v:GetPosition():Get())        
            v.components.workable:Destroy(inst)
        end
    end
end

local actionhandlers = 
{
    --ActionHandler(ACTIONS.HAMMER, "attack"),
    ActionHandler(ACTIONS.GOHOME, "taunt"),

    ActionHandler(ACTIONS.STEAL, "steal"),
    ActionHandler(ACTIONS.HAMMER, "steal"),
    ActionHandler(ACTIONS.EAT, "eat_loop"),
    
    ActionHandler(ACTIONS.PICKUP, "action"),
    ActionHandler(ACTIONS.HARVEST, "action"),
    ActionHandler(ACTIONS.PICK, "action"),
}
local events=
{
    CommonHandlers.OnLocomote(false,true),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnDeath(),
    EventHandler("doattack", onattackfn),
    EventHandler("attacked", onattackedfn),
}

local function ShakeIfClose(inst)
    local player = GetClosestInstWithTag("player", inst, SHAKE_DIST)
    if player then
        player.components.playercontroller:ShakeCamera(inst, "FULL", 0.7, 0.02, 3, SHAKE_DIST)
    end
end

local function ShakeIfClose_Footstep(inst)
    local player = GetClosestInstWithTag("player", inst, SHAKE_DIST)
    if player then
        player.components.playercontroller:ShakeCamera(inst, "FULL", 0.35, 0.02, 1.25, SHAKE_DIST)
    end
end

local function DoFootstep(inst)
    if inst:IsStandState("quad") then
        inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/step_soft")
    else
        inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/step_stomp")
        ShakeIfClose_Footstep(inst)
    end
end

local function OnTransOver(inst, fn)
    fn(inst)
    inst:RemoveEventCallback("animover", inst.transoverfn)
end

local function GoToStandState(inst, state, customtrans)
    if inst.IsStandState(inst, state) then
        return true
    end
    inst.sg:GoToState(string.lower(state), {endstate = inst.sg.currentstate.name, customtrans = customtrans})    
end


local states=
{

    State{
        name = "bi",
        tags = {"busy"},
        onenter = function(inst, data)
            inst.Physics:Stop()
            inst.sg.statemem.endstate = data.endstate
            inst.AnimState:PlayAnimation(data.customtrans or "taunt_pre")
        end,

        events =
        {
            EventHandler("animover", function(inst) 
                inst:SetStandState("bi") 
                --inst.components.locomotor:SetShouldRun(true)            
                inst.sg:GoToState(inst.sg.statemem.endstate) 
            end)
        },

        timeline=
        {
            TimeEvent(6*FRAMES, function(inst) PlayFootstep(inst) end),
        },
    },

    State{
        name = "quad",
        tags = {"busy"},
        onenter = function(inst, data)
            inst.Physics:Stop()
            inst.sg.statemem.endstate = data.endstate
            inst.AnimState:PlayAnimation(data.customtrans or "taunt_pst")
        end,

        events =
        {
            EventHandler("animover", function(inst) 
                inst:SetStandState("quad")
                --inst.components.locomotor:SetShouldRun(false)               
                inst.sg:GoToState(inst.sg.statemem.endstate) 
            end)
        },

        timeline=
        {
            TimeEvent(7*FRAMES, function(inst) 
                inst:SetStandState("quad")
                DoFootstep(inst)
            end),
        },
    },

    State{
        name = "idle",
        tags = {"idle"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            if inst.components.combat and inst.components.combat.target then
                if inst:IsStandState("quad") then
                    inst.AnimState:PlayAnimation("idle_loop", true)
                else
                    inst.AnimState:PlayAnimation("standing_idle", true)
                end
            else
                if GoToStandState(inst, "quad") then
                    inst.AnimState:PlayAnimation("idle_loop", true)
                end
            end
        end,

        timeline=
        {
            TimeEvent(14*FRAMES, function(inst) 
                if inst:IsStandState("bi") and math.random() < .3 then
                    -- Make sure he's not too noisy
                    if ((GetTime() - inst.last_growl_time) > TUNING.BEARGER_GROWL_INTERVAL) then
                        inst.last_growl_time = GetTime()
                        inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/idle")
                    end
                end
            end),
            TimeEvent(22*FRAMES, function(inst)
                if inst:IsStandState("quad") and math.random() < .3 then
                    -- Make sure he's not too noisy
                    if ((GetTime() - inst.last_growl_time) > TUNING.BEARGER_GROWL_INTERVAL) then
                        inst.last_growl_time = GetTime()
                        inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/idle")
                    end
                end
            end),
        },
    },

----------------------COMBAT------------------------

    State{
        name = "targetstolen",
        tags = {"busy", "canrotate", "noproxgrowl"},
        
        onenter = function(inst)
            if GoToStandState(inst, "bi") then
                inst.components.locomotor:StopMoving()
                inst.AnimState:PlayAnimation("taunt")
            end
        end,
        
        timeline=
        {
            TimeEvent(8*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/taunt") end),
            TimeEvent(9*FRAMES, function(inst) DoFootstep(inst) end),
            TimeEvent(33*FRAMES, function(inst) DoFootstep(inst) end),
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "hit",
        tags = {"hit", "busy", "noproxgrowl"},
        
        onenter = function(inst, cb)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end

            if inst:IsStandState("quad") then
                inst.AnimState:PlayAnimation("hit")
            else
                inst.AnimState:PlayAnimation("standing_hit")
            end
        end,
        
        events =
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "attack",
        tags = {"attack", "busy", "canrotate", "noproxgrowl"},
        
        onenter = function(inst)
            if GoToStandState(inst, "bi") then
                if inst.components.locomotor then
                    inst.components.locomotor:StopMoving()
                end
                inst.components.combat:StartAttack()
                inst.AnimState:PlayAnimation("atk")
            end
        end,

        timeline=
        {
            TimeEvent(4*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/attack") end),
            --TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/attack") end),
            TimeEvent(28*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/swhoosh") end),
            TimeEvent(35*FRAMES, function(inst) inst.components.combat:DoAttack() inst.WorkEntities(inst) end),
        },
        
        
        events=
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "chargeattack",
        tags = {"busy", "attack", "canrotate", "noproxgrowl"},
        
        onenter = function(inst)
            if GoToStandState(inst, "bi") then
                inst:FacePoint(inst.components.combat.target.Transform:GetWorldPosition())
                inst.components.locomotor:StopMoving()
                inst.AnimState:PlayAnimation("taunt")
                inst.AnimState:PushAnimation("charge_pre", false)
                inst.AnimState:PushAnimation("charge_roar_loop", false)
                inst.AnimState:PushAnimation("charge_roar_loop", false)
                inst.AnimState:PushAnimation("charge_pst", false)
            end
        end,

        onupdate = function(inst)
            if inst.charging then
                inst.components.locomotor:RunForward()
            else
                inst.components.locomotor:StopMoving()
            end
        end,

        onexit = function(inst)
            inst.charging = false
        end,
        
        timeline=
        {
            TimeEvent(8*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/taunt") end),
            TimeEvent(9*FRAMES, function(inst) DoFootstep(inst) end),
            TimeEvent(33*FRAMES, function(inst) 
                inst.charging = true
                inst.sg:AddStateTag("chargeattack") 
                inst.sg:AddStateTag("running") 
                DoFootstep(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/swhoosh")
            end),
            TimeEvent(48*FRAMES, function(inst) 
                DoFootstep(inst) 
                inst.components.combat:DoAttack(nil, nil, nil, nil, .2) 
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/swhoosh")
            end),
            TimeEvent(63*FRAMES, function(inst) 
                DoFootstep(inst) 
                inst.components.combat:DoAttack(nil, nil, nil, nil, .2) 
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/swhoosh")
            end),
            TimeEvent(78*FRAMES, function(inst) 
                DoFootstep(inst) 
                inst.components.combat:DoAttack(nil, nil, nil, nil, .2) 
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/swhoosh")
            end),
            TimeEvent(93*FRAMES, function(inst) 
                DoFootstep(inst) 
                inst.components.combat:DoAttack(nil, nil, nil, nil, .2) 
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/swhoosh")
            end),
            TimeEvent(108*FRAMES, function(inst) inst.charging = false DoFootstep(inst) end),
        },
        
        events=
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "pound",
        tags = {"attack", "busy", "canrotate", "noproxgrowl"},
        
        onenter = function(inst)
            if GoToStandState(inst, "bi") then
                if inst.components.locomotor then
                    inst.components.locomotor:StopMoving()
                end
                inst.AnimState:PlayAnimation("ground_pound")
            end
        end,

        timeline=
        {
            TimeEvent(17*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/swhoosh") end),
            TimeEvent(20*FRAMES, function(inst) 
                ShakeIfClose(inst)
                inst.components.groundpounder:GroundPound()
                inst.CanGroundPound = false
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
            end),
        },        
        
        events=
        {
            EventHandler("animover", function(inst) 
                inst:SetStandState("QUAD")
                inst.sg:GoToState("idle") 
            end),
        },
    },

    State{
        name = "death",  
        tags = {"busy", "noproxgrowl"},
        
        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end

            if GoToStandState(inst, "bi") then
                inst.AnimState:PlayAnimation("death")
                inst.Physics:ClearCollisionMask()
            end
        end,

        timeline=
        {
            TimeEvent(6*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/death") end),
            TimeEvent(50*FRAMES, function(inst)
                ShakeIfClose(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
                inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))            
            end),
        },

    },

-------------------EATING-------------------------

    State{
        name = "action",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            if GoToStandState(inst, "bi") then
                inst.AnimState:PlayAnimation("action")
                inst.AnimState:PushAnimation("eat_loop", false)
            end
        end,

        onexit = function(inst)
            
        end,
        
        timeline=
        {
            TimeEvent(5*FRAMES, function(inst) end),
            TimeEvent(15*FRAMES, function(inst)
                inst:PerformBufferedAction()             
                inst.sg:RemoveStateTag("busy")
                inst.sg:AddStateTag("wantstoeat")
                inst.last_eat_time = GetTime()
                inst.brain:ForceUpdate()
            end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("eat_pst") end)
        }
    },

    State{
        name = "eat_loop",
        tags = {"busy"},
        
        onenter = function(inst)
            if GoToStandState(inst, "bi") then
                inst.Physics:Stop()
                inst.AnimState:PushAnimation("eat_loop", true)
                local timeout = math.random()+.5
                local ba = inst:GetBufferedAction()
                if ba and ba.target and ba.target:HasTag("honeyed") then
                    timeout = timeout*2
                end
                inst.sg:SetTimeout(timeout)
            end
        end,
        
        timeline=
        {
            TimeEvent(5*FRAMES, function(inst) end),
            TimeEvent(16*FRAMES, function(inst) end),
        },
        
        ontimeout = function(inst)
            local ba = inst:GetBufferedAction()
            if (ba and ba.target and ba.target:HasTag("honeyed")) then
                inst.last_food_good = ba.target.components.stackable and ba.target.components.stackable:StackSize() or 1
            else
                inst.last_food_good = 0
            end
            inst:PerformBufferedAction() 
            inst.last_eat_time = GetTime()
            inst.sg:GoToState("eat_pst") 
        end,
        
    },

    State{
        name = "eat_pst",
        tags = {"busy"},
        
        onenter = function(inst)
            if GoToStandState(inst, "bi") then
                inst.Physics:Stop()
                inst.AnimState:PlayAnimation("eat_pst")
            end
        end,
        
        timeline=
        {
        },
        
        events=
        {
            EventHandler("animover", function(inst) 
                inst.num_good_food_eaten = inst.last_food_good and inst.num_good_food_eaten + inst.last_food_good or inst.num_good_food_eaten
                inst.last_food_good = nil
                inst.sg:GoToState("idle") 
            end),
        },
    },

    State{
        name = "steal",
        tags = {"busy"},
        
        onenter = function(inst)
            if GoToStandState(inst, "bi") then
                inst.Physics:Stop()
                inst.AnimState:PlayAnimation("atk", false)
            end
        end,
        
        timeline=
        {
            TimeEvent(4*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/attack") end),
            --TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/attack") end),
            TimeEvent(28*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/swhoosh") end),
            TimeEvent(35*FRAMES, function(inst) inst:PerformBufferedAction() end),
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

---------------------------WALKING---------------

    State{
            name = "walk_start",
            tags = {"moving", "canrotate"},

            onenter = function(inst) 
                if inst.components.combat and inst.components.combat.target then
                    if GoToStandState(inst, "bi") then
                        inst.components.locomotor.walkspeed = TUNING.BEARGER_WALK_SPEED_AGRO
                        inst.AnimState:PlayAnimation("charge_pre")
                    end
                else
                    if GoToStandState(inst, "quad") then
                        inst.components.locomotor.walkspeed = TUNING.BEARGER_WALK_SPEED
                        inst.AnimState:PlayAnimation("walk_pre")
                    end
                end
                --inst.components.locomotor:WalkForward()
            end,

            events =
            {   
                EventHandler("animqueueover", function(inst) inst.sg:GoToState("walk") end ),        
            },
        },
        
    State{
            
            name = "walk",
            tags = {"moving", "canrotate"},
            
            onenter = function(inst) 
                if inst.components.combat and inst.components.combat.target then
                    if GoToStandState(inst, "bi") then
                        inst.AnimState:PlayAnimation("charge_loop")
                    end
                else
                    if GoToStandState(inst, "quad") then
                        inst.AnimState:PlayAnimation("walk_loop")
                    end
                end
                inst.components.locomotor:WalkForward()
            end,

            events=
            {   
                EventHandler("animqueueover", function(inst) inst.sg:GoToState("walk") end ),        
            },

            timeline=
            {
                TimeEvent(0*FRAMES, function(inst) DoFootstep(inst) end),
                TimeEvent(16*FRAMES, function(inst) DoFootstep(inst) end),
            },
        },        
    
    State{
            
            name = "walk_stop",
            tags = {"canrotate"},
            
            onenter = function(inst) 
                inst.components.locomotor:StopMoving()
                DoFootstep(inst)

                local should_softstop = false

                if inst.components.combat and inst.components.combat.target then
                    if GoToStandState(inst, "bi") then
                        if should_softstop then
                            inst.AnimState:PushAnimation("charge_pst")
                        else
                            inst.AnimState:PlayAnimation("charge_pst")
                        end
                    end
                else
                    if GoToStandState(inst, "quad") then
                        if should_softstop then
                            inst.AnimState:PushAnimation("walk_pst")
                        else
                            inst.AnimState:PlayAnimation("walk_pst")
                        end
                    end
                end
            end,

            events=
            {   
                EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),        
            },
        },

    -- State{
    --         name = "run_start",
    --         tags = {"moving", "canrotate", "running"},

    --         onenter = function(inst) 
    --             if GoToStandState(inst, "bi") then
    --                 inst.components.locomotor:RunForward()
    --                 inst.AnimState:PlayAnimation("charge_pre")
    --             end
    --         end,

    --         events =
    --         {   
    --             EventHandler("animqueueover", function(inst) inst.sg:GoToState("run") end ),        
    --         },
    --     },
        
    -- State{
            
    --         name = "run",
    --         tags = {"moving", "canrotate", "running"},
            
    --         onenter = function(inst) 
    --             inst.components.locomotor:RunForward()
    --             local anim = "charge_loop"
    --             if inst.components.combat.target and math.random() > 0.9 then
    --                 anim = "charge_roar_loop"
    --                 inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/taunt")
    --             end
    --             inst.AnimState:PlayAnimation(anim)
    --         end,

    --         timeline=
    --         {
    --             TimeEvent(4*FRAMES, function(inst)
    --                 DoFootstep(inst)
    --             end),
    --             TimeEvent(5*FRAMES, function(inst)
    --                 destroystuff(inst)
    --             end),
    --             TimeEvent(15*FRAMES, function(inst)
    --                 destroystuff(inst)
    --             end),
    --             TimeEvent(17*FRAMES, function(inst)
    --                 DoFootstep(inst)
    --             end),
    --         },   

    --         events=
    --         {   
    --             EventHandler("animqueueover", function(inst) inst.sg:GoToState("run") end ),        
    --         },
    --     },        
    
    -- State{
            
    --         name = "run_stop",
    --         tags = {"canrotate"},
            
    --         onenter = function(inst) 
    --             inst.components.locomotor:StopMoving()
    --             local should_softstop = false
    --             inst.AnimState:PlayAnimation("charge_pst")          
    --         end,

    --         events=
    --         {   
    --             EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),        
    --         },
    --     },

------------------SLEEPING-----------------

        State{
            name = "sleep",
            tags = {"busy", "sleeping", "noproxgrowl"},
            
            onenter = function(inst) 
                inst.components.locomotor:StopMoving()
                if inst:IsStandState("quad") then
                    inst.AnimState:PushAnimation("sleep_pre", false)
                else
                    inst.AnimState:PlayAnimation("standing_sleep_pre")
                    inst.AnimState:PushAnimation("sleep_pre", false)
                end
            end,

            events=
            {   
                EventHandler("animqueueover", function(inst) inst.sg:GoToState("sleeping") end ),        
                EventHandler("onwakeup", function(inst) inst.sg:GoToState("wake") end),
            },

            timeline=
            {
                TimeEvent(25*FRAMES, function(inst)
                    if inst:IsStandState("bi") then
                        inst:SetStandState("quad")
                        DoFootstep(inst)
                    end
                end),
            },
        },
        
        State{
            
            name = "sleeping",
            tags = {"busy", "sleeping", "noproxgrowl"},
            
            onenter = function(inst) 
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/sleep")
                inst.AnimState:PlayAnimation("sleep_loop")
            end,
            
            events=
            {   
                EventHandler("animover", function(inst) inst.sg:GoToState("sleeping") end ),        
                EventHandler("onwakeup", function(inst) inst.sg:GoToState("wake") end),
            },
        },        
    
        State{
            
            name = "wake",
            tags = {"busy", "waking"},
            
            onenter = function(inst) 
                inst.components.locomotor:StopMoving()
                inst.AnimState:PlayAnimation("sleep_pst")
                if inst.components.sleeper and inst.components.sleeper:IsAsleep() then
                    inst.components.sleeper:WakeUp()
                end
                if not inst:IsStandState("quad") then inst:SetStandState("quad") end
            end,

            events=
            {   
                EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),        
            },

            timeline=
            {
                TimeEvent(27*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/hurt") end),
            },
        },      
}

CommonStates.AddFrozenStates(states)

return StateGraph("bearger", states, events, "idle", actionhandlers)

