
local assets=
{
    Asset("ANIM", "data/anim/chester_eyebone.zip"),
    Asset("IMAGE", "data/inventoryimages/chester_eyebone.tex"),
}

local SPAWN_DIST = 30

local trace = function() end

local function GetSpawnPoint(pt)

    local theta = math.random() * 2 * PI
    local radius = SPAWN_DIST

	local offset = FindWalkableOffset(pt, theta, radius, 12, true)
	if offset then
		return pt+offset
	end
end

local function SpawnChester(inst)
    trace("chester_eyebone - SpawnChester")

    local pt = Vector3(inst.Transform:GetWorldPosition())
    trace("    near", pt)
        
    local spawn_pt = GetSpawnPoint(pt)
    if spawn_pt then
        trace("    at", spawn_pt)
        local chester = SpawnPrefab("chester")
        if chester then
            chester.Physics:Teleport(spawn_pt:Get())
            chester:FacePoint(pt)
            return chester
        end
    else
        -- this is not fatal, they can try again in a new location by picking up the bone again
        trace("chester_eyebone - SpawnChester: Couldn't find a suitable spawn point for chester")
    end
end


local function StopRespawn(inst)
    trace("chester_eyebone - StopRespawn")
    if inst.respawntask then
        inst.respawntask:Cancel()
        inst.respawntask = nil
        inst.respawntime = nil
    end
end

local function RebindChester(inst, chester)
    trace("chester_eyebone - RebindChester")
     chester = chester or TheSim:FindFirstEntityWithTag("chester")
    if chester then
        trace("   exists")

        inst.AnimState:PlayAnimation("idle_loop", true)
        inst:ListenForEvent("death", function() inst:OnChesterDeath() end, chester)

        if chester.components.follower.leader ~= inst then
            trace("   set to follow")
            chester.components.follower:SetLeader(inst)
        end

    end
end

local function RespawnChester(inst)
    trace("chester_eyebone - RespawnChester")

    StopRespawn(inst)

    local chester = TheSim:FindFirstEntityWithTag("chester")
    if not chester then
        chester = SpawnChester(inst)
    end
    RebindChester(inst, chester)
end

local function StartRespawn(inst, time)
    trace("chester_eyebone - StartRespawn", time)

    StopRespawn(inst)

    local respawntime = time or TUNING.CHESTER_RESPAWN_TIME
    if respawntime then
        trace("    respawn in", respawntime)
        inst.respawntask = inst:DoTaskInTime(respawntime, function() RespawnChester(inst) end)
        inst.respawntime = GetTime() + respawntime
        inst.AnimState:PlayAnimation("dead", true)
    end
end

local function OnChesterDeath(inst)
    trace("chester_eyebone - OnChesterDeath")

    StartRespawn(inst)
end

local function OnPutInInventory(inst)
    trace("chester_eyebone - OnPutInInventory")

    if not inst.loading and not inst.respawntask then
        -- picked up for the first time, spawn chester
        RespawnChester(inst)
    end
end

local function OnSave(inst, data)
    trace("chester_eyebone - OnSave")

    -- Hack #2
    -- Data isn't returned to OnLoad if it's empty, so force there to be a data object during OnLoad 
    -- so I can tell the difference between loading a save vs. initial instantiation (see Hack #1)
    data.from_save = true

    local time = GetTime()
    if inst.respawntime and inst.respawntime > time then
        data.respawntimeremaining = inst.respawntime - time
        trace("   data.respawntimeremaining", data.respawntimeremaining)
    end
end

local function OnLoadPostPass(inst)
    trace("chester_eyebone - OnLoadPostPass")

    if inst.loading then
        inst.loading = nil

        if inst.respawntimeremaining then
            -- pick up the respawn process
            trace("   inst.respawntimeremaining", inst.respawntimeremaining)
            StartRespawn(inst, inst.respawntimeremaining)
            inst.respawntimeremaining = nil
        else
            -- if chester already exists, pick him up
            RebindChester(inst)
        end
    end
end

local function OnLoad(inst, data)
    trace("chester_eyebone - OnLoad")

    -- Hack #1
    -- because OnPutInInventory can be called during load, but can't operate correctly because chester isn't spawned yet
    -- set a flag so that OnPutInInventory knows not to do anything during load.  Reset during OnLoadPostPass
    inst.loading = true

    if data then
        if data.respawntimeremaining then
            inst.respawntimeremaining = data.respawntimeremaining
        end
        -- OnLoadPostPass will be called, we're all good here
    else
        -- Hack #3
        -- because i don't know if i'm being loaded with a missing data (see Hack #2), or instantiated for the first time, make sure that OnLoadPostPass happens
        -- in order to reset inst.loading.  it's ok to call it multiple times if it turns out we ARE loading from file
        inst:DoTaskInTime(.1, function() OnLoadPostPass(inst) end)
    end
end

local function OnDropped(inst)
    trace("chester_eyebone - OnDropped")
end

local function GetStatus(inst)
    trace("smallbird - GetStatus")
    if inst.respawntask then
        return "WAITING"
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    --so I can find the thing while testing
    --local minimap = inst.entity:AddMiniMapEntity()
    --minimap:SetIcon( "treasure.png" )

    inst:AddTag("chester_eyebone")
    inst:AddTag("irreplaceable")
	inst:AddTag("nonpotatable")

    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("eyebone")
    inst.AnimState:SetBuild("chester_eyebone")
    inst.AnimState:PlayAnimation("idle_loop", true)
    
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus

    inst:AddComponent("leader")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)

    inst.OnLoad = OnLoad
    inst.OnSave = OnSave
    inst.OnLoadPostPass = OnLoadPostPass
    inst.OnChesterDeath = OnChesterDeath

    return inst
end

return Prefab( "common/inventory/chester_eyebone", fn, assets)
