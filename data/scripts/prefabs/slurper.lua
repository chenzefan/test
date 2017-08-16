--[[
	The Slurper is a mob that lives in the ruins. 
	He will attach to the head of monsters that can wear hats. 
	While attached as a hat, the slurper will slowly drain hunger.
	Slurper is only aggressive if it is very hungry.

	If a slurper is full it will sleep. 
	If a slurper is hungry it will agressily try to find food.

	Hunger > 90% -> Get off head if you're on one.
	Hunger > 70% -> Sleep.
	Hunger <= 70% -> Wake up and wander the world.
	Hunger < 50% -> Start to signal that you're hungry. (need animation!)
	Hunger < 35% -> Seek out food (attack things)

	Pretty simple right now - will improve later.

	Gain hunger through something other than attacking?
	What does the slurper drop?
	Slurper should give a positive to the thing it is draining hunger from.
		Can't be armour.
]]

local assets = 
{
	Asset("ANIM", "anim/slurper_basic.zip"),
	Asset("ANIM", "anim/hat_slurper.zip"),
	Asset("SOUND", "sound/slurper.fsb"),
}

local prefabs = 
{

}


local freq = 750
local slurp_channels =
{
	"set_music",
	"set_ambience",
	"set_sfx/set_ambience",
	"set_sfx/movement",
	"set_sfx/creature",
	"set_sfx/player",
	"set_sfx/voice",
	"set_sfx/sfx"
}	

local function slurphunger(inst, owner)
    if (owner.components.hunger and owner.components.hunger.current > 0 )then
        owner.components.hunger:DoDelta(-1)        
    elseif (owner.components.health and not owner.components.hunger) then
    	owner.components.health:DoDelta(-5,false,"slurper")
    end

    inst.components.hunger:DoDelta(3)
end

local function OnAttacked(inst, data)
	inst.components.combat:SetTarget(data.attacker)
end

local function CanHatTarget(inst, target)
	return (target and (target:HasTag("player") or target:HasTag("manrabbit") or target:HasTag("pigman"))) and
	inst.components.hunger:GetPercent() < 0.9

end

local function Retarget(inst)
	--Find us a tasty target with a hunger component and the ability to equip hats.
	--Otherwise just find a target that can equip hats.

	--Not hungry, don't find a target.
	if inst.components.hunger and inst.components.hunger:GetPercent() > 0.35 then
		return
	end

	--Too far, don't find a target
    local homePos = inst.components.knownlocations:GetLocation("home")
    local myPos = Vector3(inst.Transform:GetWorldPosition() )
    if (homePos and distsq(homePos, myPos) > 30*30) then
        return
    end	

    local newtarget = FindEntity(inst, 15, function(guy) 
    	return (guy:HasTag("character") or guy:HasTag("monster")) and inst.components.combat:CanTarget(guy)
    end)

    return newtarget
end

local function KeepTarget(inst, target)
    local homePos = inst.components.knownlocations:GetLocation("home")
    local myPos = Vector3(inst.Transform:GetWorldPosition() )
    if (homePos and distsq(homePos, myPos) > 50*50) then
    	--You've chased too far. Go home.
        return false
    end

    -- if target.components.inventory then
    -- 	local helm = target.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    -- 	if helm and helm.prefab == inst.prefab then
    -- 		return false
    -- 	end
    -- end

    return true
end

local function OnEquip(inst, owner)
	--Start feeding!

	if not CanHatTarget(inst, owner) then
		owner.components.inventory:Unequip(EQUIPSLOTS.HEAD)
		return
	end

	inst.Light:Enable(true)
    inst.components.lighttweener:StartTween(nil, 3, 0.8, 0.4, nil, 2)


	inst.SoundEmitter:PlaySound("dontstarve/creatures/slurper/attach")

    owner.AnimState:OverrideSymbol("swap_hat", "hat_slurper", "swap_hat")
    owner.AnimState:Show("HAT")
    owner.AnimState:Show("HAT_HAIR")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Hide("HAIR")
    
    if owner:HasTag("player") then
		owner.AnimState:Hide("HEAD")
		owner.AnimState:Show("HEAD_HAIR")

		for k,v in pairs(slurp_channels) do
			TheMixer:SetLowPassFilter(v, freq, 1)
		end
		inst.SoundEmitter:PlaySound("dontstarve/creatures/slurper/headslurp", "player_slurp_loop")
	else
		inst.SoundEmitter:PlaySound("dontstarve/creatures/slurper/headslurp_creatures", "creature_slurp_loop")
	end

	inst.shouldburp = true
	inst.task = inst:DoPeriodicTask(2, function() slurphunger(inst, owner) end)

end

local function OnUnequip(inst, owner)

	inst.Light:Enable(true)	
    inst.components.lighttweener:StartTween(nil, 1, 0.5, 0.7,nil, 2)

	inst.SoundEmitter:PlaySound("dontstarve/creatures/slurper/dettach")

    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")

	if owner:HasTag("player") then
        owner.AnimState:Show("HEAD")
		owner.AnimState:Hide("HEAD_HAIR")

		for k,v in pairs(slurp_channels) do
			TheMixer:ClearLowPassFilter(v, 1)
		end
		inst.SoundEmitter:KillSound("player_slurp_loop")
	else
		inst.SoundEmitter:KillSound("creature_slurp_loop")
	end
	
	if inst.task then inst.task:Cancel() inst.task = nil end

	local season = GetSeasonManager()
	if season then
		season:SetAppropriateDSP()
	end

end

local function SleepTest(inst)
	return inst.components.hunger:GetPercent() > 0.7
        and not (inst.components.combat and inst.components.combat.target)
        and not (inst.components.burnable and inst.components.burnable:IsBurning() )
        and not (inst.components.freezable and inst.components.freezable:IsFrozen() )
        and not (inst.components.inventoryitem and inst.components.inventoryitem.owner)
end

local function WakeTest(inst)
	return (inst.components.hunger and inst.components.hunger:GetPercent() <= 0.7)
        or (inst.components.combat and inst.components.combat.target)
        or (inst.components.burnable and inst.components.burnable:IsBurning() )
        or (inst.components.freezable and inst.components.freezable:IsFrozen() )
        or (inst.components.inventoryitem and inst.components.inventoryitem.owner)

end

local function HungerChange(inst, data)
	if data.newpercent >= 0.9 and data.oldpercent < 0.9 then
		--You've drained a lot of hunger. Yum. Might aswell get off whoever you're draining from.
		inst.components.combat:SetTarget(nil)

		local owner = inst.components.inventoryitem.owner 
		if owner and owner.components.inventory then
			owner.components.inventory:DropItem(inst)
		end
	end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()	
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 2, 1.25 )
	
	inst.Transform:SetFourFaced()

	MakeCharacterPhysics(inst, 10, 0.5)
    MakeMediumBurnableCharacter(inst)
    MakeMediumFreezableCharacter(inst)

    anim:SetBank("slurper")
	anim:SetBuild("slurper_basic")
	anim:PlayAnimation("idle_loop", true)

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.canbepickedup = false
	inst.components.inventoryitem.cangoincontainer = false
	inst.components.inventoryitem.nobounce = true

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable:SetOnUnequip(OnUnequip)
	inst.components.equippable:SetOnEquip(OnEquip)

    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 1 )
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = false }
    inst.components.locomotor.walkspeed = 9

    inst:AddComponent("combat")
    inst.components.combat:SetAttackPeriod(5)
    inst.components.combat:SetRange(8)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst.components.combat:SetDefaultDamage(30)
    inst.components.combat:SetRetargetFunction(3, Retarget)
    inst:ListenForEvent("attacked", OnAttacked)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(200)
    inst.components.health.canmurder = false
    
    inst:AddComponent("hunger")
    inst.components.hunger:SetMax(200)
    inst.components.hunger:SetRate(100/TUNING.TOTAL_DAY_TIME)
    inst.components.hunger:SetKillRate(0)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"lightbulb", "lightbulb"})
    inst.components.lootdropper:AddChanceLoot("beardhair", 0.1)
	-- inst:AddComponent("eater")
	-- inst.components.eater:SetVegetarian()
	-- inst.components.eater:SetOnEatFn(oneat)

 	local light = inst.entity:AddLight()

    inst:AddComponent("lighttweener")
    inst.components.lighttweener:StartTween(light, 1, 0.5, 0.7, {237/255, 237/255, 209/255}, 0)
    light:Enable(true)

	inst:AddComponent("sleeper")
	inst.components.sleeper:SetSleepTest(SleepTest)
	inst.components.sleeper:SetWakeTest(WakeTest)
	--inst.components.sleeper:SetNocturnal()

	local brain = require "brains/slurperbrain"
	inst:SetBrain(brain)
	inst:SetStateGraph("SGslurper")

    inst:AddComponent("knownlocations")    

	inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_SMALL

    inst.HatTest = CanHatTarget

    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()) ) end)

    inst:ListenForEvent("hungerdelta", HungerChange)

	return inst
end

return Prefab("cave/monsters/slurper", fn, assets, prefabs)
