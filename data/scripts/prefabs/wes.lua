
local MakePlayerCharacter = require "prefabs/player_common"


local assets = 
{
    --Asset("ANIM", "data/anim/wendy.zip"),
    Asset("ANIM", "data/anim/wes.zip"),
	Asset("ANIM", "data/anim/player_mime.zip"),    
}

local prefabs = {}


local fn = function(inst)
	inst.components.health:SetMaxHealth(TUNING.WILSON_HEALTH * .75 )
	inst.components.hunger:SetMax(TUNING.WILSON_HUNGER * .75 )
	inst.components.combat.damagemultiplier = .75
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE*1.25)
	inst.components.sanity:SetMax(TUNING.WILSON_SANITY*.75)
end


return MakePlayerCharacter("wes", "data/fonts/opensans50.zip", prefabs, assets, fn)
