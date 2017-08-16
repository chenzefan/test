local assets =
{
	Asset("ANIM", "data/anim/ghost.zip"),
	Asset("ANIM", "data/anim/ghost_wendy_build.zip"),
	Asset("SOUND", "data/sound/ghost.fsb"),
}

local prefabs = 
{

}

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
    local light = inst.entity:AddLight()

    MakeGhostPhysics(inst, 1, .5)
    
    light:SetIntensity(.6)
    light:SetRadius(.5)
    light:SetFalloff(.6)
    light:Enable(true)
    light:SetColour(180/255, 195/255, 225/255)
    
    local brain = require "brains/abigailbrain"
    inst:SetBrain(brain)
    
    anim:SetBloomEffectHandle( "data/shaders/anim.ksh" )
    anim:SetBank("ghost")
    anim:SetBuild("ghost_wendy_build")
    anim:PlayAnimation("idle", true)
    --inst.AnimState:SetMultColour(1,1,1,.6)
    
    inst:AddTag("monster")
    inst:AddTag("girl")
    inst:AddTag("ghost")
    inst:AddTag("noauradamage")
    inst:AddTag("notraptrigger")
    inst:AddTag("abigail")

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED
    
    inst:SetStateGraph("SGghost")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.ABIGAIL_HEALTH)

	inst:AddComponent("combat")
    inst.components.combat.defaultdamage = TUNING.ABIGAIL_DAMAGE
    inst.components.combat.playerdamagepercent = TUNING.ABIGAIL_DMG_PLAYER_PERCENT

    inst:AddComponent("aura")
    inst.components.aura.radius = TUNING.GHOST_RADIUS
    inst.components.aura.tickperiod = TUNING.ABIGAIL_DMG_PERIOD
    
    ------------------    
    
    inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_girl_howl_LP", "howl")
    
    inst:AddComponent("follower")
	local player = GetPlayer()
	if player and player.components.leader then
		player.components.leader:AddFollower(inst)
	end
    
	inst:ListenForEvent( "daytime", function(tgi, data) inst.components.health:SetVal(0) end, GetWorld())
    
    
    return inst
end

return Prefab( "common/monsters/abigail", fn, assets, prefabs )
