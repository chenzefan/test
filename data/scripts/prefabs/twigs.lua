local assets =
{
	Asset("ANIM", "data/anim/twigs.zip"),
	Asset("SOUND", "data/sound/common.fsb"),
    Asset("IMAGE", "data/inventoryimages/twigs.tex"),
}

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    
    anim:SetBank("twigs")
    anim:SetBuild("twigs")
    anim:PlayAnimation("idle")
    
    -----------------
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    -----------------
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    ---------------------        
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    
    inst:AddComponent("inspectable")
    ----------------------
    
    inst:AddComponent("inventoryitem")
    
	inst:AddComponent("repairer")
	inst.components.repairer.repairmaterial = "wood"
	inst.components.repairer.value = TUNING.REPAIR_STICK
    
    
    return inst
end

return Prefab( "common/inventory/twigs", fn, assets) 
