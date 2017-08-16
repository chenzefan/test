local assets=
{
	Asset("ANIM", "data/anim/livinglog.zip"),
    Asset("IMAGE", "data/inventoryimages/livinglog.tex"),
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("livinglog")
    inst.AnimState:SetBuild("livinglog")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
    
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL
    
    
	MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)

    ---------------------       
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    
	inst:AddComponent("repairer")
	inst.components.repairer.repairmaterial = "wood"
	inst.components.repairer.value = TUNING.REPAIR_LOGS*3


	--inst:ListenForEvent("burnt", function(inst) inst.entity:Retire() end)
    
    return inst
end

return Prefab( "common/inventory/livinglog", fn, assets)
