local assets =
{
	Asset("ANIM", "data/anim/tallbird_egg.zip"),
}

local prefabs =
{
    "smallbird",
    "tallbird",
    "tallbirdegg",
}    

local NEST_TIME = 35*TUNING.SEG_TIME
local TALLBIRD_LAY_DIST = 16

local function StopNesting(inst)
    if inst.nesttask then
        inst.nesttask:Cancel()
        inst.nesttask = nil
    end
end

local function DoNesting(inst)
	if inst.components.childspawner and inst.components.pickable then
		for k,v in pairs(inst.components.childspawner.childrenoutside) do
			if distsq(Vector3(v.Transform:GetWorldPosition()), Vector3(inst.Transform:GetWorldPosition()) ) < TALLBIRD_LAY_DIST*TALLBIRD_LAY_DIST then
			    inst.components.pickable:Regen()
			    break
			end
		end
	end
end

local function StartNesting(inst)
    inst.nesttask = inst:DoPeriodicTask(NEST_TIME, DoNesting)
end

local function onpicked(inst, picker)
	inst.thief = picker
	inst.AnimState:PlayAnimation("nest")
	inst.components.childspawner.noregen = true
	if inst.components.childspawner and picker then
		for k,v in pairs(inst.components.childspawner.childrenoutside) do
			if v.components.combat then
				v.components.combat:SuggestTarget(picker)
			end
		end
	end
end

local function onmakeempty(inst)
	inst.AnimState:PlayAnimation("nest")
	inst.components.childspawner.noregen = true
end

local function onregrow(inst)
	inst.AnimState:PlayAnimation("eggnest")
	inst.components.childspawner.noregen = false
	StopNesting(inst)
	inst.thief = nil
end

local function onvacate(inst)
	if inst.components.pickable then
		inst.components.pickable:Pick(nil)
	end
end

local function onsleep(inst)
    if inst.components.pickable and not inst.components.pickable:CanBePicked() then
        StartNesting(inst)
    end
end

local function onwake(inst)
	StopNesting(inst)
end


local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "tallbirdnest.png" )
   
    anim:SetBuild("tallbird_egg")
    anim:SetBank("egg")
    anim:PlayAnimation("eggnest", false)
    
    inst:AddComponent("pickable")
    --inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
    inst.components.pickable:SetUp("tallbirdegg", nil)
    inst.components.pickable:SetOnPickedFn(onpicked)
    inst.components.pickable:SetOnRegenFn(onregrow)
    inst.components.pickable:SetMakeEmptyFn(onmakeempty)
    
    
    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)
    
    -------------------
	inst:AddComponent("childspawner")
	inst.components.childspawner.childname = "tallbird"
	inst.components.childspawner:SetRegenPeriod(10*TUNING.SEG_TIME)
	inst.components.childspawner:SetSpawnPeriod(0)
	inst.components.childspawner:SetSpawnedFn(onvacate)
	inst.components.childspawner:SetMaxChildren(1)
	inst.components.childspawner:StartSpawning()
    -------------------
   
    inst:AddComponent("inspectable")
	inst:ListenForEvent("entitysleep", onsleep)
	inst:ListenForEvent("entitywake", onwake)
    
   
    return inst
end

return Prefab( "common/objects/tallbirdnest", fn, assets, prefabs)
