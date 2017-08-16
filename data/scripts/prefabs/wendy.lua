
local MakePlayerCharacter = require "prefabs/player_common"


local assets = 
{
    Asset("ANIM", "data/anim/wendy.zip"),
	Asset("SOUND", "data/sound/wendy.fsb")    
}

local prefabs = 
{
    "abigail",
}

local function GetSpawnPos(inst)
    local pos = Vector3(inst.Transform:GetWorldPosition())

    local start_angle = math.random()*PI*2
    local rad = 3.5

    local offset = FindWalkableOffset(pos, start_angle, rad, 8, false)
    if offset then
        pos = pos + offset
    end

    return pos
end

local function OnDusk(inst, tgi, data) 
    --print("abigail - OnDusk", inst, tgi, data, inst.abigail_countdown)
    if inst.abigail_countdown then
        inst.abigail_countdown = inst.abigail_countdown - 1
    else
        inst.abigail_countdown = math.random(0, 1)
    end
    if inst.abigail_countdown < 1 then
        print ("GHOST!")
        inst:DoTaskInTime(5 + math.random()*5, function() 
            if not inst.components.leader:IsBeingFollowedBy("abigail") then
                local ghost = SpawnPrefab("abigail")
                ghost.Transform:SetPosition(GetSpawnPos(inst):Get())
            else
                print ("On second thought, no ghost; we already have one!")
            end
        end)
        inst.abigail_countdown = math.random(1, 3)
    else
        print ("No ghost; the stars say so!")
    end
end

local function custom_init(inst)
	inst:ListenForEvent( "dusktime", function(...) OnDusk(inst, ...) end, GetWorld())
end


return MakePlayerCharacter("wendy", prefabs, assets, custom_init) 
