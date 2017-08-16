require "class"
require "screens/scripterrorscreen"

local runmodfn = function(fn,mod,modtype)
	return (function(...)
		if fn then
			local status, r = pcall( fn, unpack(arg) )
			if not status then
				print("error calling "..modtype.." in mod "..mod.modname..": \n"..r)
				ModManager:RemoveBadMod(mod.modname,r)
				ModManager:DisplayBadMods()
			end
		end
	end)
end

ModWrangler = Class(function(self)
	self.modnames = {}
	self.mods = {}
	self.failedmods = {}
end)

function ModWrangler:AddMod(modname)
	print("enabling mod "..modname)
	--add the file overwrite to this 
	package.path = "mods\\"..modname.."\\scripts\\?.lua;"..package.path
	table.insert(self.modnames, modname)
end

function ModWrangler:GetModNames()
	return self.modnames
end

function CreateEnvironment(modname)

	local env = 
	{
		TUNING=TUNING,
		CHARACTERLIST = CHARACTERLIST,
		modname = modname,
		prefabpostinits = {},
		componentpostinits = {},
		pairs = pairs,
		ipairs = ipairs,
		print = print,
		math = math,
		table = table,
		type = type,
		string = string,
		tostring = tostring,
		Class = Class,
		GLOBAL = _G,
		MODROOT = "mods\\"..modname.."\\"
	}

	env.env = env

	--install our crazy loader!
	env.modimport = function(modulename)
		print("modimport: "..env.MODROOT..modulename)
        local result = kleiloadlua(env.MODROOT..modulename)
		if type(result) == "string" then
			error("Error in modimport: "..modname.."!\n"..result)
		else
        	setfenv(result, env.env)
            result()
        end
	end

	env.AddPrefabPostInit = function(prefabname, fn)
		env.prefabpostinits[prefabname] = fn
	end

	env.AddComponentPostInit = function(componentname, fn)
		env.componentpostinits[componentname] = fn
	end

	env.AddGamePostInit = function(fn)
		env.gamepostinit = fn
	end

	env.AddSimPostInit = function(fn)
		env.simpostinit = fn
	end

	return env
end

function ModWrangler:LoadMods()

	local RunUntrusted = function(fn,env)
		setfenv(fn, env)
	  	return pcall(fn)
	end

	for i,modname in ipairs(self.modnames) do
		local env = CreateEnvironment(modname)
		local fn = kleiloadlua("mods\\"..modname.."\\modmain.lua")
		if type(fn) == "string" then
			print("Error loading mod: "..modname.."!\n"..fn)
			table.insert( self.failedmods, {name=modname,error=fn} )
		elseif not fn then
			print("Error loading mod: "..modname.."!\nDoes it exist?")
			table.insert( self.failedmods, {name=modname,error="Cannot find mod "..modname} )
		else
			local status, r = RunUntrusted(fn,env)

			if status == false then
				print("Error loading mod: "..modname.."!\n"..r)
				table.insert( self.failedmods, {name=modname,error=r} )
			else
				table.insert( self.mods, env )
			end
		end
	end

end

function ModWrangler:RemoveBadMod(badmodname,error)
	for k,mod in ipairs(self.mods) do
		if mod.modname == badmodname then
			table.remove( self.mods, k )
		end
	end

	table.insert( self.failedmods, {name=badmodname,error=error} )
end

function ModWrangler:DisplayBadMods()
	for k,badmod in ipairs(self.failedmods) do
		TheFrontEnd:PushScreen(
			ScriptErrorScreen(
				STRINGS.UI.MAINSCREEN.MODFAILTITLE, 
				STRINGS.UI.MAINSCREEN.MODFAILDETAIL.." "..badmod.name.."\n"..badmod.error.."\n",
				{
					{text=STRINGS.UI.MAINSCREEN.SCRIPTERRORQUIT, cb = function() TheSim:ForceAbort() end},
					{text=STRINGS.UI.MAINSCREEN.MODFORUMS, nopop=true, cb = function() VisitURL("http://forums.kleientertainment.com/forumdisplay.php?54-Don-t-Starve-Beta-Mods-amp-Tools") end }
				},
				ANCHOR_LEFT,
				STRINGS.UI.MAINSCREEN.MODFAILDETAIL2,
				20
				))
	end
	self.failedmods = {}
end

function ModWrangler:SetPostEnv()

	local modnames = ""
	for k,mod in ipairs(self.mods) do
		mod.TheFrontEnd = TheFrontEnd
		mod.LoadPrefabDefs = TheSim.LoadPrefabDefs
		mod.Text = Text
		mod.TheSim = TheSim
		mod.Point = Point
		mod.TheGlobalInstance = TheGlobalInstance

		runmodfn( mod.gamepostinit, mod, "gamepostinit" )()

		modnames = modnames.."\""..mod.modname.."\" "
	end

	if #self.mods > 0 then
		TheFrontEnd:PushScreen(
			ScriptErrorScreen(
				STRINGS.UI.MAINSCREEN.MODTITLE, 
				STRINGS.UI.MAINSCREEN.MODDETAIL.." "..modnames.."\n"..STRINGS.UI.MAINSCREEN.MODDETAIL2,
				{
					{text=STRINGS.UI.MAINSCREEN.TESTINGYES, cb = function() end},
					{text=STRINGS.UI.MAINSCREEN.MODQUIT, cb = function() TheSim:Quit() end},
					{text=STRINGS.UI.MAINSCREEN.MODFORUMS, nopop=true, cb = function() VisitURL("http://forums.kleientertainment.com/forumdisplay.php?54-Don-t-Starve-Beta-Mods-amp-Tools") end }
				}))
	end

	self:DisplayBadMods()

end

function ModWrangler:SimPostInit(wilson)
	for k,mod in ipairs(self.mods) do
		runmodfn( mod.simpostinit, mod, "gamepostinit" )(wilson)
	end

	self:DisplayBadMods()
end

function ModWrangler:GetPrefabPostInitFns(prefabname) 

	local modfns = {}
	for k,mod in ipairs(self.mods) do
		local modfn = mod.prefabpostinits[prefabname]
		if modfn ~= nil then
			--print("added mod init for "..prefabname)
			table.insert(modfns, runmodfn(modfn, mod, prefabname.." post init"))
		end
	end
	return modfns
end

function ModWrangler:GetComponentPostInitFns(componentname) 

	local modfns = {}
	for k,mod in ipairs(self.mods) do
		local modfn = mod.componentpostinits[componentname]
		if modfn ~= nil then
			table.insert(modfns, runmodfn(modfn, mod, componentname.." post init"))
		end
	end
	return modfns
end

ModManager = ModWrangler()

---------------------------------------------

local filename = "mods/modsettings.lua"
local fn = kleiloadlua( filename )
assert(fn, "could not load modsettings: "..filename)
fn()