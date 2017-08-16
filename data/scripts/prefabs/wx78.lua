
local MakePlayerCharacter = require "prefabs/player_common"


local assets = 
{
    Asset("ANIM", "data/anim/wx78.zip"),
	Asset("SOUND", "data/sound/wx78.fsb")    
}


local fn = function(inst)
	inst.components.eater.ignoresspoilage = true
end


return MakePlayerCharacter("wx78", nil, assets, fn)
