local MakePlayerCharacter = require "prefabs/player_common"

local function DoCharacter(name)
	return MakePlayerCharacter(name, "data/fonts/opensans50.zip", {}, 
	{
		Asset("ANIM", "data/anim/"..name..".zip"),
		Asset("SOUND", "data/sound/"..name..".fsb")
	}
	, function() end)
end


return DoCharacter("wilton"),
	   DoCharacter("woodie")
	    
	
