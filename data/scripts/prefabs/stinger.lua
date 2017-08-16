local assets=
{
	Asset("ANIM", "data/anim/stinger.zip"),
    Asset("IMAGE", "data/inventoryimages/stinger.tex"),
}



local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("stinger")
    inst.AnimState:SetBuild("stinger")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    return inst
end

return Prefab( "common/inventory/stinger", fn, assets) 
