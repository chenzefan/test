local assets=
{
	Asset("ANIM", "data/anim/amulet_gem.zip"),
    Asset("IMAGE", "data/inventoryimages/redgem.tex"),
}

local function Sparkle(inst)
    inst.AnimState:PlayAnimation("sparkle")
    inst.AnimState:PushAnimation("idle")
    inst.sparkletask = inst:DoTaskInTime(4 + math.random(), Sparkle)
end

local function StartSparkling(inst)
    inst.sparkletask = inst:DoTaskInTime(1, Sparkle)
end

local function StopSparkling(inst)
    if inst.sparkletask then
        inst.sparkletask:Cancel()
        inst.sparkletask = nil
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    
    inst.AnimState:SetBank("redgem")
    inst.AnimState:SetBuild("amulet_gem")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryPhysics(inst)
    
    inst:AddComponent("edible")
    inst.components.edible.foodtype = "ELEMENTAL"
    inst.components.edible.hungervalue = 3
    inst:AddComponent("tradable")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    
    StartSparkling(inst)
    return inst
end

return Prefab( "common/inventory/redgem", fn, assets) 
