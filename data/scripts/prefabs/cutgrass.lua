local assets =
{
	Asset("ANIM", "data/anim/cutgrass.zip"),
    Asset("IMAGE", "data/inventoryimages/cutgrass.tex"),
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("cutgrass")
    inst.AnimState:SetBuild("cutgrass")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    
	inst:AddComponent("repairer")
	inst.components.repairer.repairmaterial = "hay"
	inst.components.repairer.value = TUNING.REPAIR_CUTGRASS
    
    inst:AddComponent("inventoryitem")

    return inst
end

return Prefab( "common/inventory/cutgrass", fn, assets) 

