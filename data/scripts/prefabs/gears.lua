local assets =
{
	Asset("ANIM", "data/anim/gears.zip"),
    Asset("IMAGE", "data/inventoryimages/gears.tex"),
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()

    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("gears")
    inst.AnimState:SetBuild("gears")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
 
    inst:AddComponent("inspectable")  
    
    inst:AddComponent("inventoryitem")      
    
    return inst
end

return Prefab("common/inventory/gears", fn, assets)