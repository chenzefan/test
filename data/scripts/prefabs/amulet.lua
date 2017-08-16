local assets=
{
	Asset("ANIM", "data/anim/amulet.zip"),
	Asset("ANIM", "data/anim/torso_amulet.zip"),
    Asset("IMAGE", "data/inventoryimages/amulet.tex"),
}


local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "torso_amulet", "swap_body")
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
end


local function fn(Sim)
	local inst = CreateEntity()
    
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

    
    inst.AnimState:SetBank("amulet")
    inst.AnimState:SetBuild("amulet")
    inst.AnimState:PlayAnimation("anim")
    
    inst:AddComponent("stackable")
    
    inst:AddComponent("inspectable")
	inst.AnimState:SetBloomEffectHandle( "data/shaders/anim.ksh" )    
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    
    
	inst:AddComponent("dapperness")
	inst.components.dapperness.dapperness = TUNING.DAPPERNESS_SMALL
    
    
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.keepondeath = true
    inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/jewlery"
    
    return inst
end

return Prefab( "common/inventory/amulet", fn, assets) 
