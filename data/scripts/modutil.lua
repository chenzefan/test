
local function AddModCharacter(name)
	table.insert(MODCHARACTERLIST, name)
end


local function initprint(...)
	local modname = getfenv(3).modname
	print(modname, ...)
end

local function InsertPostInitFunctions(env)


	env.postinitfns = {}
	env.postinitdata = {}

	env.postinitfns.LevelPreInit = {}
	env.AddLevelPreInit = function(levelid, fn)
		initprint("AddLevelPreInit", levelid)
		env.postinitfns.LevelPreInit[levelid] = fn
	end
	env.postinitfns.LevelPreInitAny = nil
	env.AddLevelPreInitAny = function(fn)
		initprint("AddLevelPreInitAny")
		env.postinitfns.LevelPreInitAny = fn
	end
	env.postinitfns.TaskPreInit = {}
	env.AddTaskPreInit = function(taskname, fn)
		initprint("AddTaskPreInit", taskname)
		env.postinitfns.TaskPreInit[taskname] = fn
	end
	env.postinitfns.RoomPreInit = {}
	env.AddRoomPreInit = function(roomname, fn)
		initprint("AddRoomPreInit", roomname)
		env.postinitfns.RoomPreInit[roomname] = fn
	end

	env.AddAction = function(action)
		initprint("AddAction", action.id)
		table.insert(ACTIONS, action)
		STRINGS.ACTIONS[action.id] = action.str
	end

	env.postinitdata.StategraphActionHandler = {}
	env.AddStategraphActionHandler = function(stategraph, handler)
		initprint("AddStategraphActionHandler", stategraph)
		if not env.postinitdata.StategraphActionHandler[stategraph] then
			env.postinitdata.StategraphActionHandler[stategraph] = {}
		end
		table.insert(env.postinitdata.StategraphActionHandler[stategraph], handler)
	end

	env.postinitdata.StategraphState = {}
	env.AddStategraphState = function(stategraph, state)
		initprint("AddStategraphState", stategraph)
		if not env.postinitdata.StategraphState[stategraph] then
			env.postinitdata.StategraphState[stategraph] = {}
		end
		table.insert(env.postinitdata.StategraphState[stategraph], state)
	end

	env.postinitdata.StategraphEvent = {}
	env.AddStategraphEvent = function(stategraph, event)
		initprint("AddStategraphEvent", stategraph)
		if not env.postinitdata.StategraphEvent[stategraph] then
			env.postinitdata.StategraphEvent[stategraph] = {}
		end
		table.insert(env.postinitdata.StategraphEvent[stategraph], event)
	end

	env.postinitfns.StategraphPostInit = {}
	env.AddStategraphPostInit = function(stategraph, fn)
		initprint("AddStategraphPostInit", stategraph)
		env.postinitfns.StategraphPostInit[stategraph] = fn
	end

	env.postinitfns.ComponentPostInit = {}
	env.AddComponentPostInit = function(component, fn)
		initprint("AddComponentPostInit", component)
		env.postinitfns.ComponentPostInit[component] = fn
	end

	env.postinitfns.PrefabPostInit = {}
	env.AddPrefabPostInit = function(prefab, fn)
		initprint("AddPrefabPostInit", prefab)
		env.postinitfns.PrefabPostInit[prefab] = fn
	end

	env.AddGamePostInit = function(fn)
		initprint("AddGamePostInit")
		env.gamepostinit = fn
	end

	env.AddSimPostInit = function(fn)
		initprint("AddSimPostInit")
		env.simpostinit = fn
	end

end

return {
			AddModCharacter = AddModCharacter,
			InsertPostInitFunctions = InsertPostInitFunctions,
		}
