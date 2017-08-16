require "prefabutil"

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function onhit(inst, worker)
end


local assets = 
{
	Asset("ANIM", "data/anim/winter_meter.zip"),
	Asset("IMAGE", "data/inventoryimages/winterometer.tex"),
}
local function CheckTemp(inst)
	local temp = GetSeasonManager():GetCurrentTemperature()
	local high_temp = 35
	local low_temp = 0
	
	temp = math.min( math.max(low_temp, temp), high_temp)
	local percent = (temp + low_temp) / (high_temp - low_temp)
	inst.AnimState:SetPercent("meter", 1-percent)
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "winterometer.png" )
    
	MakeObstaclePhysics(inst, .4)
    
	anim:SetBank("winter_meter")
	anim:SetBuild("winter_meter")
	anim:SetPercent("meter", 0)

	inst:AddComponent("inspectable")
	
	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)		
	MakeSnowCovered(inst, .01)
	
	inst:DoPeriodicTask(1, CheckTemp, .1)
	--CheckTemp(inst)
	
	return inst
end
return Prefab( "common/objects/winterometer", fn, assets),
	   MakePlacer("common/winterometer_placer", "winter_meter", "winter_meter", "idle" )


