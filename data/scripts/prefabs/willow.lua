
local MakePlayerCharacter = require "prefabs/player_common"


local assets = 
{
    Asset("ANIM", "data/anim/willow.zip"),
	Asset("SOUND", "data/sound/willow.fsb")    
}

local prefabs = 
{
    "willowfire",
}

local fn = function(inst)
	inst:AddComponent("firebug")
	inst.components.firebug.prefab = "willowfire"
	
	
	inst.components.health.fire_damage_scale = 0
end


return MakePlayerCharacter("willow", prefabs, assets, fn) 
