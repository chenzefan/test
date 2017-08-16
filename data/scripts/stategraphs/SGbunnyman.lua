require("stategraphs/commonstates")

local actionhandlers = 
{
    ActionHandler(ACTIONS.GOHOME, "gohome"),
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.PICKUP, "pickup"),
    ActionHandler(ACTIONS.EQUIP, "pickup"),
    ActionHandler(ACTIONS.ADDFUEL, "pickup"),
}


local events=
{
    CommonHandlers.OnStep(),
    CommonHandlers.OnLocomote(true,true),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnAttack(),
    CommonHandlers.OnAttacked(true),
    CommonHandlers.OnDeath(),
    EventHandler("transformnormal", function(inst) if inst.components.health:GetPercent() > 0 then inst.sg:GoToState("transformNormal") end end),
    
}

local states=
{
    State{
        name= "funnyidle",
        tags = {"idle"},
        
        onenter = function(inst)
			inst.Physics:Stop()
            
            
			if inst.components.health:GetPercent() < TUNING.BUNNYMAN_PANIC_THRESH then
				inst.AnimState:PlayAnimation("idle_angry")
				inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/angry_idle")
            elseif inst.components.follower.leader and inst.components.follower:GetLoyaltyPercent() < 0.05 then
                inst.AnimState:PlayAnimation("hungry")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/hungry")
            elseif inst.components.combat.target then
                inst.AnimState:PlayAnimation("idle_angry")
                inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/angry_idle")
            elseif inst.components.follower.leader and inst.components.follower:GetLoyaltyPercent() > 0.3 then
                inst.AnimState:PlayAnimation("idle_happy")
                inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/happy")
            else
                inst.AnimState:PlayAnimation("idle_creepy")
                inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/idle_med")
            end
        end,
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },        
    },
    
    State {
		name = "frozen",
		tags = {"busy"},
		
        onenter = function(inst)
            inst.AnimState:PlayAnimation("frozen")
            inst.Physics:Stop()
            inst.components.highlight:SetAddColour(Vector3(82/255, 115/255, 124/255))
        end,
    },
    
    State{
        name = "death",
        tags = {"busy"},
        
        onenter = function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/death")
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)            
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))            
        end,
        
    },
    
    State{
		name = "abandon",
		tags = {"busy"},
		
		onenter = function(inst, leader)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("abandon")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/angry_idle")
            inst:FacePoint(Vector3(leader.Transform:GetWorldPosition()))
		end,
		
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },        
    },
    
    State{
        name = "attack",
        tags = {"attack", "busy"},
        
        onenter = function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/attack")        
            inst.components.combat:StartAttack()
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk")
        end,
        
        timeline=
        {
            TimeEvent(13*FRAMES, function(inst) 
				inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/bite")        
				inst.components.combat:DoAttack() inst.sg:RemoveStateTag("attack") 
				inst.sg:RemoveStateTag("busy") 
			end),
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "eat",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.Physics:Stop()            
            inst.AnimState:PlayAnimation("eat")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/eat")            
        end,
        
        timeline=
        {
            TimeEvent(20*FRAMES, function(inst) inst:PerformBufferedAction() end),
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },        
    },
    State{
        name = "hit",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/hurt")
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()            
        end,
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },        
    },    
}

CommonStates.AddWalkStates(states,
{
	walktimeline = {
		TimeEvent(0*FRAMES, PlayFootstep ),
		TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/hop") end),
		TimeEvent(12*FRAMES, PlayFootstep ),
		TimeEvent(12*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/hop") end),
	},
})
CommonStates.AddRunStates(states,
{
	runtimeline = {
		TimeEvent(0*FRAMES, PlayFootstep ),
		TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/hop") end),
		TimeEvent(10*FRAMES, PlayFootstep ),
		TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/hop") end),
	},
})

CommonStates.AddSleepStates(states,
{
	sleeptimeline = 
	{
		TimeEvent(35*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/sleep") end ),
	},
})

CommonStates.AddIdle(states,"funnyidle")
CommonStates.AddSimpleState(states,"refuse", "pig_reject", {"busy"})
CommonStates.AddFrozenStates(states)

CommonStates.AddSimpleActionState(states,"pickup", "pig_pickup", 10*FRAMES, {"busy"})

CommonStates.AddSimpleActionState(states, "gohome", "pig_pickup", 4*FRAMES, {"busy"})

    
return StateGraph("pig", states, events, "idle", actionhandlers)

