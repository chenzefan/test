local assets = 
{
	Asset("ANIM", "anim/catcoon_build.zip"),
	Asset("ANIM", "anim/catcoon_basic.zip"),
	Asset("ANIM", "anim/catcoon_actions.zip"),
}

local prefabs = 
{
	"mole",
	"rabbit",
	"flint",
	"tumbleweed",
	"cutgrass",
	"twigs",
	"catcoonhat",
}

local neutralGiftPrefabs =
{
	{ --tier 1
		"spoiled_food",
	},
	{ --tier 2
		"twigs",
		"spoiled_food",
	},
	{ --tier 3
		"cutgrass",
		"twigs",
		"wetgoop",
	},
	{ --tier 4
		"flint",
		"cutgrass",
		"twigs",
		"rope",
	},
	{ --tier 5
		"mole",
		"rabbit",
		"flint",
		"tumbleweed",
		"rope",
	},
}

local friendGiftPrefabs =
{
	{ --tier 1
		"spoiled_food",
	},
	{ --tier 2
		"twigs",
		"spoiled_food",
	},
	{ --tier 3
		"cutgrass",
		"twigs",
		"wetgoop",
	},
	{ --tier 4
		"flint",
		"cutgrass",
		"twigs",
		"rope",
	},
	{ --tier 5
		"mole",
		"rabbit",
		"flint",
		"tumbleweed",
		"rope",
	},
}

local function OnAttacked(inst, data)
	if inst.components.combat and not inst.components.combat.target then
		inst.sg:GoToState("hiss")
	end
    if inst.components.combat then inst.components.combat:SetTarget(data.attacker) end
end

local function KeepTargetFn(inst, target)
    return (target
    	and target.components.combat
        and target.components.health
        and not target.components.health:IsDead()
        and not (inst.components.follower and inst.components.follower.leader == target))
end

local function RetargetFn(inst)
    return FindEntity(inst, TUNING.CATCOON_TARGET_DIST,
        function(guy)
            return 	((guy:HasTag("monster") or guy:HasTag("smallcreature")) and 
            		guy.components.health and 
            		not guy.components.health:IsDead() and 
            		inst.components.combat:CanTarget(guy) and 
            		not (inst.components.follower.leader ~= nil and guy:HasTag("abigail")))
            	or 	guy:HasTag("cattoyairborne")
        end)
end

local function SleepTest(inst)
	if inst.components.follower and inst.components.follower.leader then return end
	if inst.components.combat and inst.components.combat.target then return end
	if inst.components.playerprox:IsPlayerClose() then return end
	if not inst.sg:HasStateTag("busy") and (not inst.last_wake_time or GetTime() - inst.last_wake_time >= inst.nap_interval) then
		inst.nap_length = math.random(TUNING.MIN_CATNAP_LENGTH, TUNING.MAX_CATNAP_LENGTH)
		inst.last_sleep_time = GetTime()
		return true
	end
end

local function WakeTest(inst)
	if not inst.last_sleep_time or GetTime() - inst.last_sleep_time >= inst.nap_length then
		inst.nap_interval = math.random(TUNING.MIN_CATNAP_INTERVAL, TUNING.MAX_CATNAP_INTERVAL)
		inst.last_wake_time = GetTime()
		return true
	end
end

local function PickRandomGift(inst, tier)
	return (inst.components.follower and inst.components.follower.leader) and 
		GetRandomItem(friendGiftPrefabs[tier]) or 
		GetRandomItem(neutralGiftPrefabs[tier])
end

local function ShouldAcceptItem(inst, item)
	if item:HasTag("cattoy") or item:HasTag("catfood") or item:HasTag("cattoyairborne") then
		return true
	else
		return false
	end
end

local function OnGetItemFromPlayer(inst, giver, item)
    if inst.components.combat.target and inst.components.combat.target == giver then
        inst.components.combat:SetTarget(nil)
        inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/catcoon/pickup")
    elseif giver.components.leader then
    	inst.SoundEmitter:PlaySound("dontstarve/common/makeFriend")
    	if inst.components.follower and inst.components.follower.leader then -- Just adding loyalty, lower interval.
    		inst.hairball_friend_interval = inst.hairball_friend_interval / 2
    	else -- Just started following. Should hack soon.
    		inst.last_hairball_time = GetTime()
    		inst.hairball_friend_interval = math.random(2,6)
    	end
		giver.components.leader:AddFollower(inst)
        inst.components.follower:AddLoyaltyTime(TUNING.CATCOON_LOYALTY_PER_ITEM)
        inst:FacePoint(giver.Transform:GetWorldPosition())
        inst.sg:GoToState("pawground")
    end
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function OnRefuseItem(inst, item)
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/catcoon/hiss_pre")
	if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize(2,0.75)
	trans:SetFourFaced()

	MakeCharacterPhysics(inst, 1, 0.5)

	anim:SetBank("catcoon")
	anim:SetBuild("catcoon_build")
	anim:PlayAnimation("idle_loop")

	inst:AddTag("smallcreature")
	inst:AddTag("catcoon")

	inst:AddComponent("inspectable")

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(TUNING.CATCOON_LIFE)

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(TUNING.CATCOON_DAMAGE)
	inst.components.combat:SetRange(TUNING.CATCOON_ATTACK_RANGE)
    inst.components.combat:SetAttackPeriod(TUNING.CATCOON_ATTACK_PERIOD)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst.components.combat:SetRetargetFunction(3, RetargetFn)
    inst.components.combat:SetHurtSound("dontstarve_DLC001/creatures/catcoon/hurt")
    inst:ListenForEvent("attacked", OnAttacked)
    inst.components.combat.battlecryinterval = 20

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:AddChanceLoot("catcoonhat", 0.33)
	inst.components.lootdropper:AddChanceLoot("meat", 		1)
	inst.PickRandomGift = PickRandomGift

	inst:AddComponent("follower")
    inst.components.follower.maxfollowtime = TUNING.CATCOON_LOYALTY_MAXTIME

	inst:AddComponent("inventory")

	inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    inst.components.trader.deleteitemonaccept = false
    inst.last_hairball_time = GetTime()
    inst.hairball_friend_interval = math.random(TUNING.MIN_HAIRBALL_FRIEND_INTERVAL, TUNING.MAX_HAIRBALL_FRIEND_INTERVAL)
    inst.hairball_neutral_interval = math.random(TUNING.MIN_HAIRBALL_NEUTRAL_INTERVAL, TUNING.MAX_HAIRBALL_NEUTRAL_INTERVAL)

    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(3,4)
    inst.components.playerprox:SetOnPlayerNear(function(inst)
    	if inst.components.sleeper:IsAsleep() then
    		inst.components.sleeper:WakeUp()
    	end
    end)

	inst:AddComponent("sleeper")
    --inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.last_sleep_time = nil
    inst.last_wake_time = GetTime()
    inst.nap_interval = math.random(TUNING.MIN_CATNAP_INTERVAL, TUNING.MAX_CATNAP_INTERVAL)
    inst.nap_length = math.random(TUNING.MIN_CATNAP_LENGTH, TUNING.MAX_CATNAP_LENGTH)
    inst.components.sleeper:SetWakeTest(WakeTest)
    inst.components.sleeper:SetSleepTest(SleepTest)

	inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = 3

	inst:ListenForEvent("rainstart", function(it)
		inst:DoTaskInTime(math.random(2,6), function(inst) 
			inst.raining = true
		end)
	end, GetWorld())

	MakeSmallBurnableCharacter(inst, "catcoon_torso", Vector3(1,0,1))
	MakeSmallFreezableCharacter(inst)

	local brain = require("brains/catcoonbrain")
	inst:SetBrain(brain)
	inst:SetStateGraph("SGcatcoon")

	inst.PickRandomGift = PickRandomGift

	return inst
end

return Prefab("creatures/catcoon", fn, assets, prefabs)