local assets=
{
	Asset("ANIM", "data/anim/armor_sweatervest.zip"),
    Asset("IMAGE", "data/inventoryimages/sweatervest.tex"),
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "armor_sweatervest", "swap_body")
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
end

local function fn(Sim)
	local inst = CreateEntity()
    
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("armor_sweatervest")
    inst.AnimState:SetBuild("armor_sweatervest")
    inst.AnimState:PlayAnimation("anim")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")

    inst:AddComponent("dapperness")
    inst.components.dapperness.dapperness = TUNING.DAPPERNESS_MED
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    
	inst:AddComponent("insulator")
    inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    
    
    return inst
end

return Prefab( "common/inventory/sweatervest", fn, assets)
