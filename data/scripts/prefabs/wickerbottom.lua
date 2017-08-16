
local MakePlayerCharacter = require "prefabs/player_common"


local assets = 
{
    Asset("ANIM", "data/anim/wickerbottom.zip"),
	Asset("SOUND", "data/sound/wickerbottom.fsb")    
}


local fn = function(inst)
	inst.components.builder.bonus_tech_level = 1
end


return MakePlayerCharacter("wickerbottom", "data/fonts/opensans50.zip", nil, assets, fn)
