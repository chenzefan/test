require "prefabutil"

local MAXHITS = 6

local function SpawnScion(inst)
    local spawn = ""
    if inst.style == 1 then
        spawn = (math.random()<.5 and "bishop") or "knight"
    elseif inst.style == 2 then
        spawn = (math.random()<.5 and "rook") or "knight"
    else
        spawn = (math.random()<.5 and "rook") or "bishop"
    end
    SpawnPrefab("maxwell_smoke").Transform:SetPosition(inst.Transform:GetWorldPosition())
    local it = SpawnPrefab(spawn).Transform:SetPosition(inst.Transform:GetWorldPosition())
    if it.components.combat then
        it.components.combat:SetTarget(GetPlayer())
    end
end

local function OnRepaired(inst)
	if inst.components.workable.workleft < MAXHITS then
	    inst.AnimState:PlayAnimation("hit" .. inst.style )
	    inst.AnimState:PushAnimation("idle" .. inst.style )
    else
        inst.SoundEmitter:PlaySound("dontstarve/common/place_structure_metal")
	    SpawnPrefab("explode_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
        SpawnScion(inst)
        inst:Remove()
    end
end

local function SpawnCritter(critter, pos)
	GetPlayer():DoTaskInTime(GetRandomWithVariance(1,0.8), function() 
	                            GetSeasonManager():DoLightningStrike(pos)
                                SpawnPrefab("collapse_small").Transform:SetPosition(pos:Get())
	                            SpawnPrefab(critter).Transform:SetPosition(pos:Get())
                           end)
end

local function OnHammered(inst, worker)
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    if math.random() <= .1 then
        local pt = Vector3(inst.Transform:GetWorldPosition())
        local spawn = ""
        GetSeasonManager():DoLightningStrike(pt)
        SpawnScion(inst)
    else
        inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
	    inst.components.lootdropper:DropLoot()
    end
	inst:Remove()
end

local function OnHit(inst, worker, workLeft)
	inst.AnimState:PlayAnimation("hit" .. inst.style )
	inst.AnimState:PushAnimation("idle" .. inst.style )
    inst.SoundEmitter:PlaySound("dontstarve/common/lightningrod")
    local spawn = SpawnPrefab("sparks_fx")
    spawn.Transform:SetPosition(inst.Transform:GetWorldPosition())
    spawn.Transform:SetScale(2,2,2)
end

local assets = 
    {
        Asset("ANIM", "anim/chessmonster_ruins.zip"),
    }

local prefabs =
{
    "bishop",
    "rook",
    "knight",
    "gears",
	"redgem", 
	"greengem",
	"yellowgem",
	"purplegem",
	"orangegem",
}    


local function BasePile(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()

    anim:SetBank("chessmonster_ruins")
    anim:SetBuild("chessmonster_ruins")

    MakeObstaclePhysics(inst, 1.2)
    
    inst.entity:AddSoundEmitter()

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"trinket_6","trinket_6"}) -- frazzled wires
	inst.components.lootdropper:AddChanceLoot("gears", 0.25)
	inst.components.lootdropper:AddChanceLoot("trinket_1", 0.25) -- marbles
	inst.components.lootdropper:AddChanceLoot("redgem", 0.05)
	inst.components.lootdropper:AddChanceLoot("greengem", 0.05)
	inst.components.lootdropper:AddChanceLoot("yellowgem", 0.05)
	inst.components.lootdropper:AddChanceLoot("purplegem", 0.05)
	inst.components.lootdropper:AddChanceLoot("orangegem", 0.05)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(MAXHITS/2)
    inst.components.workable:SetMaxWork(MAXHITS)
    inst.components.workable:SetOnFinishCallback(OnHammered)
    inst.components.workable:SetOnWorkCallback(OnHit)		

    inst:AddComponent("repairable")
    inst.components.repairable.repairmaterial = "gears"
    inst.components.repairable.onrepaired = OnRepaired
    inst:AddTag("chess")
    inst:AddTag("mech")

    inst:AddComponent("inspectable")

	return inst
end

local function Junk(style)
    return function(Sim)
        local inst = BasePile(Sim)

        inst.style = style
        inst.AnimState:PlayAnimation("idle" .. inst.style)

        return inst
    end
end
        
return  Prefab( "common/objects/chessjunk1", Junk(1), assets,prefabs),
        Prefab( "common/objects/chessjunk2", Junk(2), assets,prefabs),
        Prefab( "common/objects/chessjunk3", Junk(3), assets,prefabs)
