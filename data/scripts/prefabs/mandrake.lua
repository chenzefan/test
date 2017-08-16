require "fonthelper"
local brain = require "brains/mandrakebrain"

local assets =
{
	Asset("ANIM", "data/anim/mandrake.zip"),
	Asset("SOUND", "data/sound/mandrake.fsb"),
    Asset("IMAGE", "data/inventoryimages/mandrake.tex"),
    Asset("IMAGE", "data/inventoryimages/cookedmandrake.tex"),
}

local prefabs =
{
    "cookedmandrake",
}


local function MakeFollower(inst)
	inst:AddTag("picked") 
	inst:RemoveComponent("pickable")
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(20)
    inst.components.health.nofadeout = true
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "mandrake_root"
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
	inst:SetBrain(brain)	

    inst:RemoveComponent("burnable")
    inst:RemoveComponent("propagator")
    MakeSmallBurnableCharacter(inst, "mandrake_root")
	
    inst.DynamicShadow:Enable(true)
    inst:AddComponent("follower")
	local player = GetPlayer()
	if player and player.components.leader then
		player.components.leader:AddFollower(inst)
	end
	
end

local function MakeItem(inst)
	inst:AddTag("item") 
	inst:RemoveComponent("pickable")
	inst:RemoveComponent("combat")
	inst:RemoveComponent("follower")
    inst:RemoveComponent("health")
    inst.Physics:SetCollisionGroup(COLLISION.ITEMS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:SetMass(1)
    inst.Physics:SetFriction(.1)
    inst.Physics:SetDamping(0)
    inst.Physics:SetRestitution(.75)
	inst.DynamicShadow:Enable(false)
	if inst.components.inventoryitem then
	    inst.components.inventoryitem.canbepickedup = true
        inst.components.inventoryitem:SetOnPickupFn(function(inst) inst.sg:GoToState("item") end)
        inst.components.inventoryitem:SetOnPutInInventoryFn(function(inst) inst.sg:GoToState("item") end)
        inst.components.inventoryitem:SetOnDroppedFn(function(inst) inst.sg:GoToState("item") end)
    end
    
    inst:RemoveComponent("burnable")
    inst:RemoveComponent("propagator")
	MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

end

local function MakePlanted(inst)
	inst:RemoveTag("picked") 
	
	if not inst.components.pickable then
        inst:AddComponent("pickable")
    end
    inst.Physics:SetCollisionGroup(COLLISION.ITEMS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
	inst.DynamicShadow:Enable(false)
    inst.components.pickable.canbepicked = true
    inst.components.pickable.onpickedfn = function(inst) inst.sg:GoToState("picked") end
	local player = GetPlayer()
	if player and player.components.leader and player.components.leader:IsFollower(inst) then
		player.components.leader:RemoveFollower(inst)
	end
	inst:RemoveComponent("combat")
	inst:RemoveComponent("follower")
    inst:RemoveComponent("health")
    inst:RemoveComponent("burnable")
    inst:RemoveComponent("propagator")
	MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)
end

local function DoAreaEffect(inst, user, range, time, knockout)
    local pos = Vector3(user.Transform:GetWorldPosition())
    local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, range)
    for k,v in pairs(ents) do
	    if v.components.sleeper then
		    v.components.sleeper:AddSleepiness(10, time)
		elseif v:HasTag("player") and knockout then
	        v.sg:GoToState("wakeup")
	        v.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_KNOCKEDOUT") )
	    end
    end
end

local function OnEaten(inst, eater)
	DoAreaEffect(inst, eater, TUNING.MANDRAKE_SLEEP_RANGE, TUNING.MANDRAKE_SLEEP_TIME)
	eater.SoundEmitter:PlaySound("dontstarve/creatures/mandrake/death")
end

local function OnEaten_cooked(inst, eater)
    GetClock():MakeNextDay()
	DoAreaEffect(inst, eater, TUNING.MANDRAKE_SLEEP_RANGE_COOKED, TUNING.MANDRAKE_SLEEP_TIME, true)
	eater.SoundEmitter:PlaySound("dontstarve/creatures/mandrake/death")
end

local function OnCooked(inst, cooker, chef)
    inst.persists = false
    GetClock():NextPhase()
	DoAreaEffect(inst, chef, TUNING.MANDRAKE_SLEEP_RANGE_COOKED, TUNING.MANDRAKE_SLEEP_TIME, true)
	chef.SoundEmitter:PlaySound("dontstarve/creatures/mandrake/death")
end

local function commonfn()
    
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	
    inst:AddTag("mandrake")
    
    anim:SetBank("mandrake")
    anim:SetBuild("mandrake")
    
    ------------------------------------------
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        if inst:HasTag("picked") then
            return "PICKED"
        elseif inst:HasTag("dead") then
            return "DEAD"
        end
    end
    inst:AddComponent("inventoryitem")
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("edible")
    inst.components.edible.foodtype = "VEGGIE"
    return inst
end

local function defaultfn()
	local inst = commonfn()
	
    inst:AddTag("character")
    
    inst.AnimState:PlayAnimation("ground")

	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.75, .5 )
    inst.Transform:SetFourFaced()
	MakeCharacterPhysics(inst, 10, .25)

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 6

    inst:SetStateGraph("SGMandrake")

	inst.components.inventoryitem.canbepickedup = false
    inst.components.stackable:SetOnDeStack(MakeItem)
    
    
    inst.components.edible.healthvalue = TUNING.HEALING_HUGE
    inst.components.edible.hungervalue = TUNING.CALORIES_HUGE
    inst.components.edible:SetOnEatenFn(OnEaten)
    
    inst:AddComponent("cookable")
    inst.components.cookable.product = "cookedmandrake"
    inst.components.cookable:SetOnCookedFn(OnCooked)
    
    ------------------------------------------
    
    inst.OnSave = function(inst, data)
		if inst:HasTag("picked") then
			data.picked = true
		elseif inst:HasTag("item") then
		    data.item = true
		end
    end        
    
    inst.OnLoad = function(inst, data)
        if data then
    		if data.picked then
    			MakeFollower(inst)
    			inst.sg:GoToState("idle")
    		elseif data.item then
    		    MakeItem(inst)
    	        inst.AnimState:PlayAnimation("object")
    		end
        end
    end
   
    MakePlanted(inst)
    
    inst.userfunctions = 
    {
        MakePlanted = MakePlanted,
        MakeItem = MakeItem,
        MakeFollower = MakeFollower,
    }
    
    inst:ListenForEvent( "daytime", function()
        if inst.components.health and not inst.components.health:IsDead() then
            inst.sg:GoToState("plant")
        end
    end, GetWorld())
    
	return inst
end

local function cookedfn()
	local inst = commonfn()
	
    inst.components.edible.healthvalue = TUNING.HEALING_SUPERHUGE
    inst.components.edible.hungervalue = TUNING.CALORIES_SUPERHUGE
    inst.components.edible:SetOnEatenFn(OnEaten_cooked)

    inst:AddTag("cooked")
    inst:AddTag("dead")
    
    inst.AnimState:PlayAnimation("cooked")
	return inst
end

return Prefab( "common/mandrake", defaultfn, assets, prefabs),
		Prefab("common/cookedmandrake", cookedfn, assets)
