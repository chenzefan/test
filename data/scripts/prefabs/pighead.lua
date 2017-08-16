local assets =
{
	Asset("ANIM", "data/anim/pig_head.zip")
}

local prefabs =
{
	"flies",
	"pigskin",
	"twigs",
}

local function OnFinish(inst)
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst.components.lootdropper:DropLoot()
	inst:Remove()
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()

	inst.AnimState:SetBank("pig_head")
	inst.AnimState:SetBuild("pig_head")
	inst.AnimState:PlayAnimation("idle_asleep")

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"pigskin", "pigskin", "twigs", "twigs"})

	inst:AddComponent("inspectable")

	inst.flies = inst:SpawnChild("flies")

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(3)
	inst.components.workable:SetOnWorkCallback(function(inst) 
		inst.AnimState:PlayAnimation("hit")
		inst.AnimState:PushAnimation("idle_asleep")
		end)
	inst.components.workable.onfinish = OnFinish

	return inst
end

return Prefab("forest/objects/pighead", fn, assets, prefabs)