require "constants"

local assets =
{
	--Asset("SOUND", "data/sound/forest.fsb"),
	Asset("SOUND", "data/sound/forest_stream.fsb"),
	Asset("SOUND", "data/sound/music.fsb"),
}

local function fn(Sim)
	
	local inst = CreateEntity()
	local sound = inst.entity:AddSoundEmitter()
	inst.persists = false
	
	inst:AddComponent("ambientsoundmixer")
	
	inst:AddTag("AMBIENT_SOUND")
	SetDebugEntity(inst) --kind of cheese...
	
    return inst
end


return Prefab( "forest/forest_ambiance", fn, assets)
