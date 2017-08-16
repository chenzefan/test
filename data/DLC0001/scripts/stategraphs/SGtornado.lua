require("stategraphs/commonstates")

local events=
{
    EventHandler("locomote", function(inst)
        local is_moving = inst.sg:HasStateTag("moving")
        local is_idling = inst.sg:HasStateTag("idle")
        
        local should_move = inst.components.locomotor:WantsToMoveForward()
        if is_moving and not should_move then
            inst.sg:GoToState("walk_stop")
        elseif (is_idling and should_move) then
        	if inst.sg:HasStateTag("empty") then
        		inst.sg:GoToState("spawn")
        	else
            	inst.sg:GoToState("walk_start")
            end
        end
    end)
}

local function destroystuff(inst)
    local pt = inst:GetPosition()
    local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 3)
    for k,v in pairs(ents) do
        if v and v.components.workable and v.components.workable.workleft > 0 then
            SpawnPrefab("collapse_small").Transform:SetPosition(v:GetPosition():Get())        
            v.components.workable:Destroy(inst)
        end

        if v and v.components.health and not v.components.health:IsDead() 
        and v ~= inst.WINDSTAFF_CASTER then
        	v.components.combat:GetAttacked(inst, TUNING.TORNADO_DAMAGE)
        	v.components.combat:SuggestTarget(inst.WINDSTAFF_CASTER)
    	end
    end
end

local states=
{

	State
	{
		name = "empty",
		tags = {"idle", "empty"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("empty")
		end,
	},

	State
	{
		name = "idle",
		tags = {"idle"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PushAnimation("tornado_loop", false)
			destroystuff(inst)
		end,

		events = 
		{
			EventHandler("animqueueover", function(inst) 
				inst.sg:GoToState("idle") 
			end)
		},
	},
	
	State
	{
		name = "spawn",
		tags = {"moving", "canrotate"},

		onenter = function(inst)
            inst.components.locomotor:WalkForward()
			inst.AnimState:PlayAnimation("tornado_pre")
		end,

		events = 
		{
			EventHandler("animover", function(inst) 
				inst.sg:GoToState("walk") 
			end)
		},
	},

	State
	{
		name = "despawn",
		tags = {"busy"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("tornado_pst")
		end,

		events = 
		{
			EventHandler("animover", function(inst) 
				inst:Remove()
			end)
		},
	},

	State
	{
		name = "walk_start",
		tags = {"moving", "canrotate"},

		onenter = function(inst)
			inst.sg:GoToState("walk")
		end,
	},

	State
	{
		name = "walk",
		tags = {"moving", "canrotate"},

		onenter = function(inst)
            inst.components.locomotor:WalkForward()
			inst.AnimState:PushAnimation("tornado_loop", false)
			destroystuff(inst)
		end,

		timeline =
		{
			TimeEvent(5*FRAMES, destroystuff),
		},

		events = 
		{
			EventHandler("animqueueover", function(inst) 
				inst.sg:GoToState("walk")
			end)
		},
	},

	State
	{
		name = "walk_stop",
		tags = {"canrotate"},

		onenter = function(inst)
			inst.sg:GoToState("idle")
		end,
	},

}
  
return StateGraph("tornado", states, events, "empty")