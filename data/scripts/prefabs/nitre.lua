local assets=
{
	Asset("ANIM", "data/anim/nitre.zip"),
    Asset("IMAGE", "data/inventoryimages/nitre.tex"),
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("nitre")
    inst.AnimState:SetBuild("nitre")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    return inst
end

return Prefab( "common/inventory/nitre", fn, assets)