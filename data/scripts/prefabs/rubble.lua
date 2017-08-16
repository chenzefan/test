local assets =
{
	Asset("ANIM", "anim/ruins_rubble.zip"),
}

local prefabs =
{
    "rocks",
    "marble",
    "nightmarefuel",
    "greengem",
    "orangegem",
    "yellowgem",
}    

local function workcallback(inst, worker, workleft)
	local pt = Point(inst.Transform:GetWorldPosition())
	if workleft <= 0 then
		inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
		inst.components.lootdropper:DropLoot(pt)
		inst:Remove()
	else				
		if workleft < TUNING.ROCKS_MINE*(1/3) then
			inst.AnimState:PlayAnimation("low")
		elseif workleft < TUNING.ROCKS_MINE*(2/3) then
			inst.AnimState:PlayAnimation("med")
		else
			inst.AnimState:PlayAnimation("full")
		end
	end
end

local function common_fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	
	inst.AnimState:SetBank("rubble")
	inst.AnimState:SetBuild("ruins_rubble")

	MakeObstaclePhysics(inst, 1.)
	
	--local minimap = inst.entity:AddMiniMapEntity()
	--minimap:SetIcon( "rock.png" )

	inst:AddComponent("lootdropper") 
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.MINE)

	inst.components.workable:SetOnWorkCallback(workcallback)         

	inst:AddComponent("inspectable")
	MakeSnowCovered(inst, .01)    

	return inst
end

local function rubble_fn(Sim)
	local inst = common_fn()
	inst.AnimState:PlayAnimation("full")
	inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)	

	return inst
end

local function rubble_med_fn(Sim)
	local inst = common_fn()
	inst.AnimState:PlayAnimation("med")
	inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)	
	inst.components.workable:WorkedBy(inst, TUNING.ROCKS_MINE * 0.34)
	return inst
end

local function rubble_low_fn(Sim)
	local inst = common_fn()
	inst.AnimState:PlayAnimation("low")
	inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)	
	inst.components.workable:WorkedBy(inst, TUNING.ROCKS_MINE * 0.67)
	return inst
end


return Prefab("cave/objects/rocks/rubble", rubble_fn, assets, prefabs),
        Prefab("forest/objects/rocks/rubble_med", rubble_med_fn, assets, prefabs),
        Prefab("forest/objects/rocks/rubble_low", rubble_low_fn, assets, prefabs) 
