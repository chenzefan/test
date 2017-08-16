local assets = 
{
	Asset("ANIM", "anim/mossling_spin_fx.zip")
}

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()

	inst.AnimState:SetBank("mossling_spin_fx")
	inst.AnimState:SetBuild("mossling_spin_fx")
	inst.AnimState:PlayAnimation("spin_loop")

	inst:AddTag("fx")

	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
	inst.persists = false

	inst:ListenForEvent("animover", function() inst:Remove() end)

	return inst
end

return Prefab("mossling_spin_fx", fn, assets)