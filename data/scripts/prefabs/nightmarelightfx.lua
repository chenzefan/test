local assets =
{
	Asset("ANIM", "anim/rock_light_fx.zip"),
}

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

    anim:SetBuild("rock_light_fx")
    anim:SetBank("rock_light_fx")
    anim:PlayAnimation("idle_closed", false)

    inst.persists = false

    --inst.AnimState:SetMultColour(104/255, 40/255, 121/255, 1)

    return inst
end

return Prefab("common/nightmarelightfx", fn, assets)