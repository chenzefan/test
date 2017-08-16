require("stategraphs/commonstates")

local actionhandlers = 
{
    ActionHandler(ACTIONS.GOHOME, "gohome"),
    ActionHandler(ACTIONS.EAT, "eat"),
}


local events=
{
    CommonHandlers.OnStep(),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnAttack(),
    CommonHandlers.OnAttacked(),
    CommonHandlers.OnDeath(),
    EventHandler("locomote", function(inst)
        local is_moving = inst.sg:HasStateTag("moving")
        local is_idling = inst.sg:HasStateTag("idle")
        
        local should_move = inst.components.locomotor:WantsToMoveForward()
        if is_moving and not should_move then
            inst.sg:GoToState("idle")
        elseif (is_idling and should_move) then
            inst.sg:GoToState("walk")
        end
    end),
    CommonHandlers.OnFreeze(),
}

local states=
{
	State{
        name = "death",
        tags = {"busy"},
        
        onenter = function(inst)
            --inst.SoundEmitter:PlaySound("dontstarve/creatures/perd/death")
            inst.AnimState:PlayAnimation("death")
            inst.components.locomotor:StopMoving()
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))            
        end,
        
    },

    
    State{
        name = "appear",
        tags = {"busy"},
        
        onenter = function(inst)
            --inst.SoundEmitter:PlaySound("dontstarve/creatures/perd/scream")
            inst.Physics:Stop()	
			inst.Physics:ClearCollisionMask()inst.Physics:ClearCollisionMask()
            inst.AnimState:PlayAnimation("slide_pre")
            inst.AnimState:PushAnimation("slide_bounce", false)
            inst.AnimState:PushAnimation("slide_loop", false)
            inst.AnimState:PushAnimation("slide_post", false)
        end,
        
        events =
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
    
	State{
		name = "walk",
		tags = {"moving", "canrotate"},
	    
		onenter = function(inst) 
			inst.components.locomotor:WalkForward()
			inst.AnimState:PlayAnimation("walk")
		end,
		
		timeline = 
		{
		},
		
		events=
		{   
			EventHandler("animover", function(inst) inst.sg:GoToState("walk") end ),        
		},
	},

    State{
        name = "attack",
        tags = {"attack"},
        
        onenter = function(inst)
            --inst.SoundEmitter:PlaySound("dontstarve/creatures/perd/attack")
            inst.components.combat:StartAttack()
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk_pre")
            inst.AnimState:PushAnimation("atk", false)
        end,
        
        timeline =
        {
            TimeEvent(20*FRAMES, function(inst) inst.components.combat:DoAttack() end),
        },
        
        events =
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
    
}

CommonStates.AddSleepStates(states,
{
    --starttimeline = 
    --{
		--TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/perd/sleep") end ),
    --},
    --
	--sleeptimeline = {
        --TimeEvent(40*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/perd/sleep") end),
	--},
})

CommonStates.AddCombatStates(states,
{
    hittimeline = 
    {
    },
    attacktimeline = 
    {
    },
    deathtimeline = 
    {
    },
})

CommonStates.AddIdle(states)
CommonStates.AddSimpleState(states,"hit","hit", {"busy"})
CommonStates.AddSimpleState(states,"taunt","taunt", {"busy"})
CommonStates.AddFrozenStates(states)

    
return StateGraph("penguin", states, events, "idle", actionhandlers)

