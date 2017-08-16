local assets=
{
	Asset("ANIM", "data/anim/silk.zip"),
    Asset("IMAGE", "data/inventoryimages/silk.tex"),
}



local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    
    
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("silk")
    inst.AnimState:SetBuild("silk")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    
    
    return inst
end

return Prefab( "common/inventory/silk", fn, assets) 
