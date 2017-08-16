local assets =
{
	Asset("ANIM", "data/anim/marble.zip"),
	Asset("IMAGE", "data/inventoryimages/marble.tex"),
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("marble")
	inst.AnimState:SetBuild("marble")
	inst.AnimState:PlayAnimation("anim")

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")

	return inst
end

return Prefab ("common/inventory/marble", fn, assets)