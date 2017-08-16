local assets=
{
	Asset("ANIM", "anim/rook.zip"),
	Asset("ANIM", "anim/rook_build.zip"),
	Asset("ANIM", "anim/rook_nightmare.zip"),
	Asset("SOUND", "sound/chess.fsb"),
}

local prefabs =
{
	"gears",
}

local loot = 
{
	"gears",
	"gears",
}

local SLEEP_DIST_FROMHOME = 1
local SLEEP_DIST_FROMTHREAT = 20
local MAX_CHASEAWAY_DIST = 40
local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 40

local function ShouldSleep(inst)
    local homePos = inst.components.knownlocations:GetLocation("home")
    local myPos = Vector3(inst.Transform:GetWorldPosition() )
    if not (homePos and distsq(homePos, myPos) <= SLEEP_DIST_FROMHOME*SLEEP_DIST_FROMHOME)
       or (inst.components.combat and inst.components.combat.target)
       or (inst.components.burnable and inst.components.burnable:IsBurning() )
       or (inst.components.freezable and inst.components.freezable:IsFrozen() ) then
        return false
    end
    local nearestEnt = GetClosestInstWithTag("character", inst, SLEEP_DIST_FROMTHREAT)
    return nearestEnt == nil
end

local function ShouldWake(inst)
    local homePos = inst.components.knownlocations:GetLocation("home")
    local myPos = Vector3(inst.Transform:GetWorldPosition() )
    if (homePos and distsq(homePos, myPos) > SLEEP_DIST_FROMHOME*SLEEP_DIST_FROMHOME)
       or (inst.components.combat and inst.components.combat.target)
       or (inst.components.burnable and inst.components.burnable:IsBurning() )
       or (inst.components.freezable and inst.components.freezable:IsFrozen() ) then
        return true
    end
    local nearestEnt = GetClosestInstWithTag("character", inst, SLEEP_DIST_FROMTHREAT)
    return nearestEnt
end

local function Retarget(inst)
    local homePos = inst.components.knownlocations:GetLocation("home")
    local myPos = Vector3(inst.Transform:GetWorldPosition() )
    if (homePos and distsq(homePos, myPos) > 40*40) then
        return
    end
    
    local newtarget = FindEntity(inst, TUNING.ROOK_TARGET_DIST, function(guy)
            return (guy:HasTag("character") or guy:HasTag("monster"))
                   and not (inst.components.follower and inst.components.follower.leader == guy)
                   and not guy:HasTag("chess")
                   and inst.components.combat:CanTarget(guy)
    end)
    return newtarget
end

local function KeepTarget(inst, target)

    if inst.sg and inst.sg:HasStateTag("running") then
        return true
    end

    local homePos = inst.components.knownlocations:GetLocation("home")
    local myPos = Vector3(inst.Transform:GetWorldPosition() )
    return (homePos and distsq(homePos, myPos) < 40*40)
end

local function OnAttacked(inst, data)
    local attacker = data and data.attacker
    if attacker and attacker:HasTag("chess") then return end
    inst.components.combat:SetTarget(attacker)
    inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, function(dude) return dude:HasTag("chess") end, MAX_TARGET_SHARES)
end

local function HitShake()
        --       :Shake(shakeType, duration, speed, scale)
        -- TheCamera:Shake("SIDE", 0.2, 0.05, .1)
        TheCamera:Shake("SIDE", 0.5, 0.05, 0.1)
end

local function oncollide(inst, other)
    local v1 = Vector3(inst.Physics:GetVelocity())

    --if inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("hit") then
    --    return
    --end

    if other == GetPlayer() then
        return
    end
    if v1:LengthSq() < 42 then return end

    -- dprint("speed: ", math.sqrt(v1:LengthSq()))
    HitShake()

    inst:DoTaskInTime(2*FRAMES, function()   
    	if  (other and other:HasTag("smashable")) then
    		--other.Physics:SetCollides(false)
            other.components.health:Kill()
        elseif other and other.components.health and other.components.health:GetPercent() >= 0 then
            dprint("----------------HIT!:",other, other.components.health and other.components.health:GetPercent())
    	    SpawnPrefab("collapse_small").Transform:SetPosition(other:GetPosition():Get())
            inst.SoundEmitter:PlaySound("dontstarve/creatures/rook/explo") 
            -- inst.sg:GoToState("hit")
            inst.components.combat:DoAttack(other)
            dprint("_____After HIT")
        elseif other and other.components.workable and other.components.workable.workleft >= 0 then
            print("Doing work to: ", other)
    	    SpawnPrefab("collapse_small").Transform:SetPosition(other:GetPosition():Get())
            other.components.workable:WorkedBy(inst,1)
        end
    end)
end

local function MakeRook(nightmare)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 3, 1.25 )
    inst.Transform:SetFourFaced()
    inst.Transform:SetScale(0.66, 0.66, 0.66)
    MakeCharacterPhysics(inst, 50, 1.5)
    inst.Physics:SetCollisionCallback(oncollide)

    anim:SetBank("rook")
    if nightmare then
        inst.kind = "_nightmare"
        inst.soundpath   = "dontstarve/creatures/rook_nightmare/"
        inst.effortsound = "dontstarve/creatures/rook_nightmare/rattle"
		    --TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound(inst.soundpath .. "steam") end ),
        anim:SetBuild("rook_nightmare") -- name of flash file
    else
        inst.kind = ""
        inst.soundpath   = "dontstarve/creatures/rook/"
        inst.effortsound = "dontstarve/creatures/rook/steam"
        anim:SetBuild("rook_build")
    end
    
    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.ROOK_WALK_SPEED
    inst.components.locomotor.runspeed =  TUNING.ROOK_RUN_SPEED
    
    inst:SetStateGraph("SGrook")

    inst:AddTag("monster")
    inst:AddTag("chess")
    inst:AddTag("rook")

    local brain = require "brains/rookbrain"
    inst:SetBrain(brain)
    
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetWakeTest(ShouldWake)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetResistance(3)

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "spring"
    inst.components.combat:SetAttackPeriod(2)
    inst.components.combat:SetRetargetFunction(3, Retarget)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.ROOK_HEALTH)
    inst.components.combat:SetDefaultDamage(TUNING.ROOK_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.ROOK_ATTACK_PERIOD)
    --inst.components.combat.playerdamagepercent = 2

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)
    
    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")
    
    inst:DoTaskInTime(2*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()) ) end)

    MakeMediumBurnableCharacter(inst, "spring")
    MakeMediumFreezableCharacter(inst, "spring")
    
    inst:ListenForEvent("attacked", OnAttacked)

    --inst:AddComponent("debugger")

    return inst
end

local function MakeFriend()
    local inst = MakeRook(true)

    inst:AddComponent("follower")
    --reset brain
    local brain = require "brains/rookbrain"
    inst:SetBrain(brain)

    return inst
end

return Prefab("chessboard/rook", function() return MakeRook(false) end , assets, prefabs),
       Prefab("cave/monsters/rook_nightmare", function() return MakeRook(true) end , assets, prefabs),
       Prefab("cave/monsters/rook_nightmare_friend", function() return MakeFriend() end, assets, prefabs)

