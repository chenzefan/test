local assets=
{
	Asset("ANIM", "data/anim/amulet_gem.zip"),
    Asset("IMAGE", "data/inventoryimages/redgem.tex"),
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    
    inst.AnimState:SetBank("redgem")
    inst.AnimState:SetBuild("amulet_gem")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryPhysics(inst)
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    return inst
end

return Prefab( "common/inventory/redgem", fn, assets)
