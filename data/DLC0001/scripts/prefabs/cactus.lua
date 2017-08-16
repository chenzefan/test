local cactusassets =
{
	Asset("ANIM", "anim/cactus.zip"),
}

local cactusprefabs = 
{
    "cactus_meat",
    "cactusflower",
}

local function ontransplantfn(inst)
	inst.components.pickable:MakeEmpty()
end


local function onpickedfn(inst, picker)
	inst.AnimState:PlayAnimation("picked") 
	inst.AnimState:PushAnimation("empty", false)
	if picker.components.combat then
        picker.components.combat:GetAttacked(inst, TUNING.CACTUS_DAMAGE)
        picker:PushEvent("thorns")
	end
end

local function onregenfn(inst)
	inst.AnimState:PlayAnimation("grow") 
	inst.AnimState:PushAnimation("idle", true)
end

local function makeemptyfn(inst)
	inst.AnimState:PlayAnimation("idle_dead")
end

local function cactusfn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "cactus.png" )

    anim:SetBuild("cactus")
    anim:SetBank("cactus")
    anim:PlayAnimation("idle", true)
    anim:SetTime(math.random()*2)

    MakeObstaclePhysics(inst, .3)
    
    inst:AddTag("thorny")

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/harvest_sticks"
    
    inst.components.pickable:SetUp("cactus_meat", TUNING.CACTUS_REGROW_TIME)
	inst.components.pickable.onregenfn = onregenfn
	inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.makeemptyfn = makeemptyfn
	inst.components.pickable.ontransplantfn = ontransplantfn

    inst:AddComponent("inspectable")
    
    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    return inst
end

local flowerassets = 
{
	Asset("ANIM", "anim/cactus_flower.zip"),
}

local function cactusflowerfn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

    anim:SetBuild("cactusflower")
    anim:SetBank("cactus_flower")
    anim:PlayAnimation("idle")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    
    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)
    return inst
end

return Prefab( "cactus", cactusfn, cactusassets, cactusprefabs),
Prefab("cactus_flower", cactusflowerfn, flowerassets)
