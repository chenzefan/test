local assets=
{
	Asset("ANIM", "data/anim/penguin.zip"),
	Asset("ANIM", "data/anim/penguin_build.zip"),
	--Asset("SOUND", "data/sound/perd.fsb"),
}

local prefabs =
{
    "meat",
}

local loot = 
{
    "meat",
}
 
local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 30, function(dude)
        return dude:HasTag("walrus") and not dude:HasTag("player") and not dude.components.health:IsDead()
    end, 5)
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.5, .75 )
    inst.Transform:SetFourFaced()

    MakeCharacterPhysics(inst, 50, .5)    
     
    anim:SetBank("penguin")
    anim:SetBuild("penguin_build")
    
    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 2
    
    inst:SetStateGraph("SGpenguin")

    inst:AddTag("penguin")
    inst:AddTag("animal")
    inst:AddTag("smallcreature")
    
    inst:AddComponent("homeseeker")
    local brain = require "brains/penguinbrain"
    inst:SetBrain(brain)
    
    inst:AddComponent("sleeper")

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "body"
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.WALRUS_HEALTH)
    inst.components.combat:SetDefaultDamage(TUNING.WALRUS_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.WALRUS_ATTACK_PERIOD)
    
    MakeSmallFreezableCharacter(inst, "body")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)
    
    inst:AddComponent("inventory")
    
    inst:AddComponent("inspectable")
    
    MakeMediumBurnableCharacter(inst, "body")

    inst:ListenForEvent("attacked", OnAttacked)
    
    return inst
end

return Prefab( "forest/animals/penguin", fn, assets, prefabs)
