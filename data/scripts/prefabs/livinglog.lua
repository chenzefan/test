local assets=
{
	Asset("ANIM", "data/anim/livinglog.zip"),
    Asset("IMAGE", "data/inventoryimages/livinglog.tex"),
}

local function FuelTaken(inst, taker)
    if taker and taker.SoundEmitter then
        taker.SoundEmitter:PlaySound("dontstarve/creatures/leif/livinglog_burn")
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()    
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("livinglog")
    inst.AnimState:SetBuild("livinglog")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
    
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL
    inst.components.fuel:SetOnTakenFn(FuelTaken)
    
    
	MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)

    ---------------------       
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    
	inst:AddComponent("repairer")
	inst.components.repairer.repairmaterial = "wood"
	inst.components.repairer.value = TUNING.REPAIR_LOGS*3

	inst:ListenForEvent("onignite", function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/livinglog_burn") end)
    
    return inst
end

return Prefab( "common/inventory/livinglog", fn, assets)

