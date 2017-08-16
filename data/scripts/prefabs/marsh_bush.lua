local assets =
{
	Asset("ANIM", "data/anim/thorns_marsh.zip"),
}

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    anim:SetBuild("thorns_marsh")
    anim:SetBank("thorns")
    anim:PlayAnimation("idle_loop", true)
    anim:SetTime(math.random()*2)

    local color = 0.5 + math.random() * 0.5
    anim:SetMultColour(color, color, color, 1)

    inst:AddComponent("inspectable")
    return inst
end

return Prefab( "marsh/objects/marsh_bush", fn, assets)
