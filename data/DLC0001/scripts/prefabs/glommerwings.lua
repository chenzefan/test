local assets = 
{
	Asset("ANIM", "anim/glommer_wings.zip"),
}

local prefabs = {}

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

	anim:SetBank("glommer_wings")
	anim:SetBuild("glommer_wings")
	anim:PlayAnimation("idle")

	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")

	return inst
end


return Prefab("glommerwings", fn, assets, prefabs)