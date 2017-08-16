require "fonthelper"

local assets =
{
	Asset("ANIM", "data/anim/manrabbit_basic.zip"),
	Asset("ANIM", "data/anim/manrabbit_actions.zip"),
	Asset("ANIM", "data/anim/manrabbit_attacks.zip"),
	Asset("ANIM", "data/anim/manrabbit_build.zip"),
	
	Asset("ANIM", "data/anim/manrabbit_beard_build.zip"),
	Asset("ANIM", "data/anim/manrabbit_beard_basic.zip"),
	Asset("ANIM", "data/anim/manrabbit_beard_actions.zip"),
	Asset("SOUND", "data/sound/pig.fsb"),
}

local prefabs =
{
    "meat",
    "monstermeat",
    "manrabbit_tail",
}


local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 30

local function ontalk(inst, script)
	inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/idle_med")
	--inst.SoundEmitter:PlaySound("dontstarve/pig/grunt")
end

local function CalcSanityAura(inst, observer)

	if inst.components.follower and inst.components.follower.leader == observer then
		return TUNING.SANITYAURA_SMALL
	end
	
	return 0
end


local function ShouldAcceptItem(inst, item)
    if item.components.equippable and item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
        return true
    end
    if item.components.edible then
        
        if (item.prefab == "carrot" or item.prefab == "carrot_cooked")
           and inst.components.follower.leader
           and inst.components.follower:GetLoyaltyPercent() > 0.9 then
            return false
        end
        
        return true
    end
end

local function OnGetItemFromPlayer(inst, giver, item)
    
    --I eat food
    if item.components.edible then
        if (item.prefab == "carrot" or item.prefab == "carrot_cooked") then
            if inst.components.combat.target and inst.components.combat.target == giver then
                inst.components.combat:SetTarget(nil)
            elseif giver.components.leader then
				inst.SoundEmitter:PlaySound("dontstarve/common/makeFriend")
				giver.components.leader:AddFollower(inst)
                inst.components.follower:AddLoyaltyTime(TUNING.RABBIT_CARROT_LOYALTY)
            end
        end

        if inst.components.sleeper:IsAsleep() then
            inst.components.sleeper:WakeUp()
        end
    end

    
    --I wear hats
    if item.components.equippable and item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
        local current = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if current then
            inst.components.inventory:DropItem(current)
        end
        
        inst.components.inventory:Equip(item)
        inst.AnimState:Show("hat")
    end
end

local function OnRefuseItem(inst, item)
    inst.sg:GoToState("refuse")
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end


local function OnAttacked(inst, data)
    --print(inst, "OnAttacked")
    local attacker = data.attacker
    inst.components.combat:SetTarget(attacker)
    inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, function(dude) return dude.prefab == inst.prefab end, MAX_TARGET_SHARES)
end

local function OnNewTarget(inst, data)
    inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST, function(dude) return dude.prefab == inst.prefab end, MAX_TARGET_SHARES)
end

local function NormalRetargetFn(inst)
    
    return FindEntity(inst, TUNING.PIG_TARGET_DIST,
        function(guy)
            
            if guy.components.health and not guy.components.health:IsDead() and inst.components.combat:CanTarget(guy) then
                if guy:HasTag("monster") then return guy end
                if guy:HasTag("player") and guy.components.inventory and guy:GetDistanceSqToInst(inst) < TUNING.BUNNYMAN_SEE_MEAT_DIST*TUNING.BUNNYMAN_SEE_MEAT_DIST and guy.components.inventory:FindItem(function(item) return item.components.edible and item.components.edible.foodtype == "MEAT" end ) then return guy end
            end
        end)
end

local function NormalKeepTargetFn(inst, target)
    
    return inst.components.combat:CanTarget(target)
end


local function giveupstring(combatcmp, target)
    return STRINGS.RABBIT_GIVEUP[math.random(#STRINGS.RABBIT_GIVEUP)]
end


local function battlecry(combatcmp, target)
    
    if target and target.components.inventory then
    

        local item = target.components.inventory:FindItem(function(item) return item.components.edible and item.components.edible.foodtype == "MEAT" end )    
        if item then
            return STRINGS.RABBIT_MEAT_BATTLECRY[math.random(#STRINGS.RABBIT_MEAT_BATTLECRY)]
        end
    end
    return STRINGS.RABBIT_BATTLECRY[math.random(#STRINGS.RABBIT_BATTLECRY)]
end


local function SetNormalRabbit(inst)
    local brain = require "brains/bunnymanbrain"
    inst:SetBrain(brain)
    inst:SetStateGraph("SGbunnyman")
    
    inst.components.sleeper:SetResistance(2)

    inst.components.combat:SetDefaultDamage(TUNING.BUNNYMAN_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.BUNNYMAN_ATTACK_PERIOD)
    inst.components.combat:SetKeepTargetFunction(NormalKeepTargetFn)
    inst.components.locomotor.runspeed = TUNING.BUNNYMAN_RUN_SPEED
    inst.components.locomotor.walkspeed = TUNING.BUNNYMAN_WALK_SPEED
    
    inst.components.sleeper.nocturnal = true
    
    inst.components.lootdropper:SetLoot({"carrot","carrot"})
    inst.components.lootdropper:AddRandomLoot("meat",3)
    inst.components.lootdropper:AddRandomLoot("manrabbit_tail",1)
    inst.components.lootdropper.numrandomloot = 1

    inst.components.health:SetMaxHealth(TUNING.BUNNYMAN_HEALTH)
    inst.components.combat:SetRetargetFunction(3, NormalRetargetFn)
    inst.components.combat:SetTarget(nil)
    
    inst.components.trader:Enable()
    inst.Label:Enable(true)
    inst.components.talker:StopIgnoringAll()
end

local function common()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.5, .75 )
    inst.Transform:SetFourFaced()
    local s = 1.25
    inst.Transform:SetScale(s,s,s)

    inst.entity:AddLightWatcher()

    MakeCharacterPhysics(inst, 50, .5)
    
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED --5
    inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED --3

    inst:AddTag("character")
    inst:AddTag("pig")
    inst:AddTag("scarytoprey")
    anim:SetBank("manrabbit")
    anim:PlayAnimation("idle_loop")
    anim:Hide("hat")

    ------------------------------------------
    inst:AddComponent("eater")
    inst.components.eater:SetVegetarian()

    ------------------------------------------
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "manrabbit_torso"
    inst.components.combat.panic_thresh = TUNING.BUNNYMAN_PANIC_THRESH

    inst.components.combat.GetBattleCryString = battlecry
    inst.components.combat.GetGiveUpString = giveupstring


    MakeMediumBurnableCharacter(inst, "manrabbit_torso")

    inst:AddComponent("named")
    inst.components.named.possiblenames = STRINGS.BUNNYMANNAMES
    inst.components.named:PickNewName()
    
    ------------------------------------------
    inst:AddComponent("follower")
    inst.components.follower.maxfollowtime = TUNING.PIG_LOYALTY_MAXTIME
    ------------------------------------------
    inst:AddComponent("health")
    inst.components.health:StartRegen(TUNING.BUNNYMAN_HEALTH_REGEN_AMOUNT, TUNING.BUNNYMAN_HEALTH_REGEN_PERIOD)

    ------------------------------------------

    inst:AddComponent("inventory")
    
    ------------------------------------------

    inst:AddComponent("lootdropper")

    ------------------------------------------

    inst:AddComponent("knownlocations")
    inst:AddComponent("talker")
    inst.components.talker.ontalk = ontalk
    
    inst.entity:AddLabel()
    inst.Label:SetFontSize(24)
    inst.Label:SetFont(TALKINGFONT)
    inst.Label:SetPos(0,3.8,0)

    ------------------------------------------

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    
    ------------------------------------------

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura


    ------------------------------------------

    inst:AddComponent("sleeper")
    
    ------------------------------------------
    MakeMediumFreezableCharacter(inst, "pig_torso")
    
    ------------------------------------------


    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        if inst.components.follower.leader ~= nil then
            return "FOLLOWER"
        end
    end
    ------------------------------------------
    
    inst:ListenForEvent("attacked", OnAttacked)    
    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    return inst
end

local function normal()
    local inst = common()
    inst.AnimState:SetBuild("manrabbit_build")
    SetNormalRabbit(inst)
    return inst
end


return Prefab( "common/characters/bunnyman", normal, assets, prefabs)