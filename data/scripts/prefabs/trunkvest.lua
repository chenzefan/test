local assets=
{
	Asset("ANIM", "data/anim/armor_trunkvest_summer.zip"),
    Asset("IMAGE", "data/inventoryimages/trunkvest_summer.tex"),
	Asset("ANIM", "data/anim/armor_trunkvest_winter.zip"),
    Asset("IMAGE", "data/inventoryimages/trunkvest_winter.tex"),
}

local function onequip_summer(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "armor_trunkvest_summer", "swap_body")
end

local function onequip_winter(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "armor_trunkvest_winter", "swap_body")
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
end

local function create_common(inst)
    
    MakeInventoryPhysics(inst)
    
    inst.AnimState:PlayAnimation("anim")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/trunksuit"

    inst:AddComponent("dapperness")
    inst.components.dapperness.dapperness = TUNING.DAPPERNESS_SMALL


    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    
    inst.components.equippable:SetOnUnequip( onunequip )
    
	inst:AddComponent("insulator")
    
    return inst
end

local function create_summer()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("armor_trunkvest_summer")
    inst.AnimState:SetBuild("armor_trunkvest_summer")

    create_common(inst)

    inst.components.equippable:SetOnEquip( onequip_summer )

    inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    
	return inst
end

local function create_winter()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("armor_trunkvest_winter")
    inst.AnimState:SetBuild("armor_trunkvest_winter")

    create_common(inst)

    inst.components.equippable:SetOnEquip( onequip_winter )

    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
    
	return inst
end

return Prefab( "common/inventory/trunkvest_summer", create_summer, assets),
		Prefab( "common/inventory/trunkvest_winter", create_winter, assets)
