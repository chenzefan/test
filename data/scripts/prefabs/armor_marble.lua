local assets=
{
	Asset("ANIM", "data/anim/armor_marble.zip"),
    Asset("IMAGE", "data/inventoryimages/armormarble.tex"),
}

local function OnBlocked(owner) 
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end


local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "armor_marble", "swap_body")
    inst:ListenForEvent("blocked", OnBlocked, owner)
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst:RemoveEventCallback("blocked", OnBlocked, owner)
end

local function fn()
	local inst = CreateEntity()
    
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("armor_marble")
    inst.AnimState:SetBuild("armor_marble")
    inst.AnimState:PlayAnimation("anim")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    --TODO: Ask matt about foley sounds for marble armor
    --inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/logarmour"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL
    
    inst:AddComponent("armor")
    inst.components.armor:InitCondition(TUNING.ARMORMARBLE, TUNING.ARMORMARBLE_ABSORPTION)
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.walkspeedmult = TUNING.ARMORMARBLE_SLOW
    
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    
    return inst
end

return Prefab( "common/inventory/armormarble", fn, assets)
