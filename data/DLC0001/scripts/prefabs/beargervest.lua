local assets=
{
	Asset("ANIM", "anim/torso_bearger.zip"),
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "torso_bearger", "swap_body")
    if owner.components.hunger then
        owner.components.hunger.burnrate = TUNING.ARMORBEARGER_SLOW_HUNGER
    end
    inst.components.fueled:StartConsuming()
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    if owner.components.hunger then
        owner.components.hunger.burnrate = 1
    end
    inst.components.fueled:StopConsuming()
end

local function onperish(inst)
    inst:Remove()
end

local function fn()
	local inst = CreateEntity()
    
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("torso_bearger")
    inst.AnimState:SetBuild("torso_bearger")
    inst.AnimState:PlayAnimation("anim")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:ChangeImageName("armorbearger")

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.dapperness = TUNING.DAPPERNESS_SMALL

    inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(TUNING.INSULATION_LARGE)

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "USAGE"
    inst.components.fueled:InitializeFuelLevel(TUNING.BEARGERVEST_PERISHTIME)
    inst.components.fueled:SetDepletedFn(onperish)
    
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    
    return inst
end

return Prefab( "common/inventory/beargervest", fn, assets) 
