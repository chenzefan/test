local assets =
{
	Asset("ANIM", "data/anim/nightmare_torch.zip"),
    Asset("IMAGE", "data/inventoryimages/nightlight.tex"),
}

local prefabs =
{
    "campfirefire",
}

local function changelevels(inst, order)
    inst.components.burnable:Ignite()
    for i=1, #order do
        inst.components.burnable:SetFXLevel(order[i])
        Sleep(0.05)
    end
end

local function light(inst)
    if not inst.components.burnable:IsBurning() then
        inst.task = inst:StartThread(function() changelevels(inst, inst.lightorder) end)
    end
end

local function extinguish(inst)
    if inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
end

local function fn()

	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "nightlight.png" )

    anim:SetBank("nightmare_torch")
    anim:SetBuild("nightmare_torch")
    anim:PlayAnimation("idle",false)
  
    inst:AddTag("structure")
    MakeObstaclePhysics(inst, .1)    

    -----------------------
    inst:AddComponent("burnable")
    inst.components.burnable:AddBurnFX("maxwelllight_flame", Vector3(0,0,0), "fire_marker")
    ------------------------    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetOnPlayerNear(light)
    inst.components.playerprox:SetOnPlayerFar(extinguish)

    return inst
end

local function arealight()
    local inst = fn()
    inst.lightorder = {5,6,7,8,7}
    inst.components.playerprox:SetDist(17, 27 )

    inst:AddComponent("named")
    inst.components.named:SetName(STRINGS.NAMES["MAXWELLLIGHT"])
    inst.components.inspectable.nameoverride = "maxwelllight"

    return inst
end

local function spotlight()
    local inst = fn()
    inst.lightorder = {1,2,3,4,3}
    inst.components.playerprox:SetDist(6, 8)

    return inst
end

return Prefab( "common/objects/maxwelllight", spotlight, assets, prefabs),
Prefab("common/objects/maxwelllight_area", arealight, assets, prefabs)