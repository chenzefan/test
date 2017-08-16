
local MakePlayerCharacter = require "prefabs/player_common"


local assets = 
{
    Asset("ANIM", "data/anim/wolfgang.zip"),
	Asset("SOUND", "data/sound/wolfgang.fsb")    
}


local fn = function(inst)
	inst.components.health:SetMaxHealth(TUNING.WILSON_HEALTH * 1.5 )
	inst.components.hunger:SetMax(TUNING.WILSON_HUNGER * 1.5 )
	inst.components.combat.damagemultiplier = 1.5
end


return MakePlayerCharacter("wolfgang", nil, assets, fn)
