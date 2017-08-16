local assets =
{
    Asset("ANIM", "data/anim/hound_base.zip"),
	Asset("SOUND", "data/sound/hound.fsb"),
}

local prefabs =
{
	"hound",
    "firehound",
    "icehound",
    "houndstooth",
}

local function GetSpecialHoundChance()
	local day = GetClock().numcycles
	local chance = 0
	for k,v in ipairs(TUNING.HOUND_SPECIAL_CHANCE) do
	    if day > v.minday then
	        chance = v.chance
	    elseif day <= v.minday then
	        return chance
	    end
	end
end

local function SpawnGuardHound(inst)
    local prefab = "hound"
    if math.random() < GetSpecialHoundChance() then
        if GetSeasonManager():IsWinter() then
            prefab = "icehound"
        else
	        prefab = "firehound"
	    end
	end
    local defender = inst.components.childspawner:SpawnChild(prefab)
    if defender and attacker and defender.components.combat then
        defender.components.combat:SetTarget(attacker)
        defender.components.combat:BlankOutAttacks(1.5 + math.random()*2)
    end
end

local function SpawnGuards(inst)
    if not inst.components.health:IsDead() and inst.components.childspawner then
        local num_to_release = math.min(3, inst.components.childspawner.childreninside)
        for k = 1,num_to_release do
            SpawnGuardHound(inst)
        end
    end
end

local function OnKilled(inst)
    if inst.components.childspawner then
        inst.components.childspawner:ReleaseAllChildren()
    end
    inst.SoundEmitter:KillSound("loop")
end


local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

    inst.entity:AddSoundEmitter()

    MakeObstaclePhysics(inst, .5)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "hound_mound.png" )

	anim:SetBank("houndbase")
	anim:SetBuild("hound_base")
	anim:PlayAnimation("idle")

    inst:AddTag("structure")
    inst:AddTag("houndmound")

    -------------------
	inst:AddComponent("health")
    inst.components.health:SetMaxHealth(300)
    inst:ListenForEvent("death", OnKilled)

    -------------------
	inst:AddComponent("childspawner")
	inst.components.childspawner.childname = "hound"
	inst.components.childspawner:SetRegenPeriod(TUNING.HOUNDMOUND_REGEN_TIME)
	inst.components.childspawner:SetSpawnPeriod(TUNING.HOUNDMOUND_RELEASE_TIME)

	inst.components.childspawner:SetMaxChildren(TUNING.HOUNDMOUND_HOUNDS)
    inst.components.childspawner:StartSpawning()

    ---------------------
    --inst:AddComponent("lootdropper")

    --inst:AddComponent("combat")
    --inst.components.combat:SetOnHit(SpawnDefenders)
    --inst:ListenForEvent("death", OnKilled)

    ---------------------
    inst:AddComponent("inspectable")
    
	MakeSnowCovered(inst)
    inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/mound_LP", "loop")
	return inst
end

return Prefab( "forest/monsters/houndmound", fn, assets, prefabs )

