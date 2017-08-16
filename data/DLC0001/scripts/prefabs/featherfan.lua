local assets =
{
	Asset("ANIM", "anim/fan.zip"),
}

local function OnUse(inst, target)
	local coolingAmount = TUNING.FAN_COOLING
	if target.components.temperature then
		if target.components.temperature:GetCurrent() + coolingAmount <= 0 then
			coolingAmount = -target.components.temperature:GetCurrent() + 5
		end
		target.components.temperature:DoDelta(coolingAmount)
	end
end

local function CanUse(inst, target)
	return target.components.temperature and target.components.temperature.current > 0
end

local function OnFinished(inst)
	inst:Remove()
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()

	inst.AnimState:SetBank("fan")
	inst.AnimState:SetBuild("fan")
	inst.AnimState:PlayAnimation("idle")

	inst:AddTag("fan")

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")

    inst:AddComponent("fan")
    inst.components.fan:SetOnUseFn(OnUse)

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(5)
    inst.components.finiteuses:SetUses(5)
    inst.components.finiteuses:SetOnFinished(OnFinished)
    inst.components.finiteuses:SetConsumption(ACTIONS.FAN, 1)

	return inst
end

return Prefab("featherfan", fn, assets)