Level = Class( function(self, data)
	self.name = data.name
	self.tasks = data.tasks or {}
	self.overrides = data.overrides or {}
	self.substitutes = data.substitutes or {}
	self.override_triggers = data.override_triggers
	self.set_pieces = data.set_pieces or {}
	self.numoptionaltasks = data.numoptionaltasks
	self.maxwell = data.maxwell
	self.optionaltasks = data.optionaltasks or {}
	self.hideminimap = data.hideminimap or false
end)


function Level:GetOverridesForTasks(tasklist)
	-- Update the task with whatever overrrides are going
	local resources = require("map/resource_substitution")
	
	-- WE MAKE ONE SELECTION FOR ALL TASKS or ONE PER TASK
	for name, override in pairs(self.substitutes) do

		local substitute = resources.GetSubstitute(name)
		--print ("GetOverridesForTasks", name, substitute)
		if name ~= substitute then
			for task_idx,val in ipairs(tasklist) do
				local chance = 	math.random()
				if chance < override.perstory then 
					if tasklist[task_idx].substitutes == nil then
						tasklist[task_idx].substitutes = {}
					end
					--print(task_idx, "Overriding", name, "with", substitute, "for:", self.name, chance, override.perstory )
					tasklist[task_idx].substitutes[name] = substitute
				-- else
				-- 	print("NOT overriding ", name, "with", substitute, "for:", self.name, chance, override.perstory)

				end
			end
		end
	end

	return tasklist
end

function Level:GetTasksForLevel(sampletasks)
	--print("Getting tasks for level:", self.name)
	local tasklist = {}
	for i=1,#self.tasks do
		self:EnqueueATask(tasklist, self.tasks[i], sampletasks)
	end

	if self.numoptionaltasks and self.numoptionaltasks > 0 then
		local shuffletasknames = shuffleArray(self.optionaltasks)
		local numtoadd = self.numoptionaltasks
		local i = 1
		while numtoadd > 0 and i <= #self.optionaltasks do
			if type(self.optionaltasks[i]) == "table" then
				for i,taskname in ipairs(self.optionaltasks[i]) do
					self:EnqueueATask(tasklist, taskname, sampletasks)
					numtoadd = numtoadd - 1
				end
			else
				self:EnqueueATask(tasklist, self.optionaltasks[i], sampletasks)
				numtoadd = numtoadd - 1
			end
			i = i + 1
		end
	end

	for name, choicedata in pairs(self.set_pieces) do
		local found = false
		local idx = {}
		for i, task in ipairs(tasklist) do
			idx[task.id] = i
		end

		-- Pick one of the choces and add it to that task
		local choices = choicedata.tasks
		local count = choicedata.count or 1

		assert(choices, "Trying to add set piece '"..name.."' but no choices given.")

		-- Only one layout per task, so we stop when we run out of tasks or 
		while count > 0 and #choices > 0 do
			local idx_choice_offset = math.random(#choices) - 1 -- we'll convert back to 1-index in a moment
			-- To account for the fact that some of the choices might not exist in the level (i.e. option tasks) loop through them.
			for i=1,#choices do
				local idx_choice = ((idx_choice_offset + i)% #choices) + 1 -- convert back to 1-index
				local choice = idx[choices[idx_choice]]
				--print("choice", idx_choice, choice, #choices, choices[idx_choice], tasklist[choice])
				if tasklist[choice] then
					if tasklist[choice].set_pieces == nil then
						tasklist[choice].set_pieces = {}
					end
					table.insert(tasklist[choice].set_pieces, name)
					idx[choices[idx_choice]] = nil
					table.remove(choices, choice)
					break
				end
			end
			count = count-1
		end
	end
	
	self:GetOverridesForTasks(tasklist)
	return tasklist
end

function Level:EnqueueATask(tasklist, taskname, sampletasks)
	local task = self:GetTaskByName(taskname, sampletasks)
	if task then
		--print("\tChoosing task:",task.id)
		table.insert(tasklist, deepcopy(task))
	else
		assert(task, "Could not find a task called "..taskname)
	end
end

function Level:GetTaskByName(taskname, sampletasks)
	for j=1,#sampletasks do
		if string.upper(taskname) == string.upper(sampletasks[j].id) then
			return sampletasks[j]
		end
	end
	return nil
end

local test_level = Level({
	name="TEST_LEVEL",
	maxwell=STRINGS.MAXWELL_TEST,
	overrides={
		{"world_size", "medium"},
	},
	tasks={
		"TEST_TASK",
		"TEST_TASK1",
	},
	numoptionaltasks = 0,
	optionaltasks = {
	}
})

local free_levels ={
		Level({ 
			name=STRINGS.UI.SANDBOXMENU.PRESETLEVELS[1],
			maxwell="SANDBOX_1",
			overrides={
				{"start_setpeice", 	"DefaultStart"},		
				{"start_node",		"Clearing"},
			},
			tasks = {
				"Make a pick",
				"Dig that rock",
				"Great Plains",
				"Squeltch",
				"Beeeees!",
				"Speak to the king",
				"Forest hunters",
			},
			numoptionaltasks = 4,
			optionaltasks = {
				"Befriend the pigs",
				"For a nice walk",
				"Kill the spiders",
				"Killer bees!",
				"Make a Beehat",
				"The hunters",
				"Magic meadow",
				"Frogs and bugs",
			},
		set_pieces = {
			["ResurrectionStone"] = { count=2, tasks={"Make a pick", "Dig that rock", "Great Plains", "Squeltch", "Beeeees!", "Speak to the king", "Forest hunters" } },
			["WormholeGrass"] = { count=8, tasks={"Make a pick", "Dig that rock", "Great Plains", "Squeltch", "Beeeees!", "Speak to the king", "Forest hunters", "Befriend the pigs", "For a nice walk", "Kill the spiders", "Killer bees!", "Make a Beehat", "The hunters", "Magic meadow", "Frogs and bugs"} },
		},
		}),
	Level({
			name=STRINGS.UI.SANDBOXMENU.PRESETLEVELS[2],
			maxwell="SANDBOX_1",
		overrides={
			{"world_size", 		"medium"},
			--{"day", 			"longdusk"}, 
			
			{"start_setpeice", 	"WinterStartEasy"},	
			{"start_node",		"Clearing"},

			{"season", 			"preonlywinter"}, 
			{"season_start", 	"summer"},
			
			{"deerclops", 		"never"},
			{"hounds", 			"never"},
			{"mactusk", 		"always"},
			
			{"carrot", 			"often"},
			{"berrybush", 		"never"},
		},
		tasks = {
				"Make a pick",
				"Dig that rock",
				"Great Plains",
				"Squeltch",
				"Beeeees!",
				"Speak to the king",
				"Forest hunters",
		},
		numoptionaltasks = 4,
		optionaltasks = {
				"Befriend the pigs",
				"For a nice walk",
				"Kill the spiders",
				"Killer bees!",
				"Make a Beehat",
				"The hunters",
				"Magic meadow",
				"Frogs and bugs",
				"WalrusDesolate",
		},
		-- set_pieces = {
		-- 	["MacTuskTown"] = {"Forest hunters", "Dig that rock"},
		-- },
	}),
--[[  		Level({ 
			name=STRINGS.UI.SANDBOXMENU.PRESETLEVELS[2],
			maxwell=STRINGS.MAXWELL_QUEST_SURVIVE[2],
			overrides={
					{"world_size", "medium"},
			},
			tasks = {
				"Make a pick",
				"Speak to the king",
				"Dig that rock",
				"Pigs in the city",
				"Great Plains",
				"Squeltch",
				"Beeeees!",
				"Forest hunters",
			},
			numoptionaltasks = 5,
			optionaltasks = {
				"For a nice walk",
				"Kill the spiders",
				"Killer bees!",
				"Make a Beehat",
				"The hunters",
				"Magic meadow",
				"Frogs and bugs",
			},
		}),
		Level({ 
			name=STRINGS.UI.SANDBOXMENU.PRESETLEVELS[3],
			maxwell=STRINGS.MAXWELL_QUEST_SURVIVE[3],
			overrides={
					{"world_size", "huge"},
			},
			tasks = {
				"Make a pick",
				"The Pigs are back in town",
				"Dig that rock",
				"Pigs in the city",
				"Great Plains",
				"Squeltch",
				"Beeeees!",
				"Forest hunters",
			},
			numoptionaltasks = 6,
			optionaltasks = {
				"For a nice walk",
				"Kill the spiders",
				"Killer bees!",
				"Make a Beehat",
				"The hunters",
				"Magic meadow",
				"Frogs and bugs",
			},
		}),
		Level({ -- Too much water - swamp etc
			name=STRINGS.UI.SANDBOXMENU.PRESETLEVELS[4],
			maxwell=STRINGS.MAXWELL_QUEST_SURVIVE[4],
			overrides={
				{"weather", "alwayswet"}, 
			},
			tasks = {
				"Merms ahoy",
				"Make a pick",
				"Great Plains",
				"Killer bees!",
				"The hunters",
				"Magic meadow",
				"Frogs and bugs",
			},
			numoptionaltasks = 2,
			optionaltasks = {
				"Dig that rock",
				"Befriend the pigs",
				"Great Plains",
			},
		}),
		Level({ -- Dry and hot
			name=STRINGS.UI.SANDBOXMENU.PRESETLEVELS[5],
			maxwell=STRINGS.MAXWELL_QUEST_SURVIVE[5],
			overrides={
				{"day", "onlyday"}, 
				{"season", "onlysummer"}, 
				{{"trees", "grass", "rock", "sapling", "lucky_draw"}, "rare"}, -- lucky_draw == nothing restricted
			},
			tasks = {
				"Make a pick",
				"Dig that rock",
				"Befriend the pigs",
				"Great Plains",
				"Greater Plains",
				"Beeeees!",
				"Forest hunters",
			},
			numoptionaltasks = 2,
			optionaltasks = {
				"Speak to the king",
				"For a nice walk",
				"Kill the spiders",
				"Killer bees!",
				"Make a Beehat",
				"The hunters",
			},
		}),
		Level({ -- Winter focus
			name=STRINGS.UI.SANDBOXMENU.PRESETLEVELS[6],
			maxwell=STRINGS.MAXWELL_QUEST_SURVIVE[6],
			overrides={
				{"season", "onlywinter"}, 
			},
			tasks = {
				"Make a pick",
				"Dig that rock",
				"Befriend the pigs",
				"Great Plains",
				"Greater Plains",
				"Squeltch",
			},
			numoptionaltasks = 2,
			optionaltasks = {
				"Kill the spiders",
				"Killer bees!",
				"Make a Beehat",
				"The hunters",
				"Magic meadow",
				"Frogs and bugs",
			},
		}),
		Level({ -- Island hopping
			name=STRINGS.UI.SANDBOXMENU.PRESETLEVELS[7],
			maxwell=STRINGS.MAXWELL_QUEST_SURVIVE[7],
			overrides={
			},
			tasks = {
				"Make a pick",
				"Dig that rock",
				"Befriend the pigs",
				"Great Plains",
				"Squeltch",
				"Beeeees!",
				"Forest hunters",
			},
			numoptionaltasks = 4,
			optionaltasks = {
				"Speak to the king",
				"For a nice walk",
				"Kill the spiders",
				"Killer bees!",
				"Make a Beehat",
				"The hunters",
				"Magic meadow",
				"Frogs and bugs",
			},
		}),
		Level({ -- Focus on sanity play
			name=STRINGS.UI.SANDBOXMENU.PRESETLEVELS[8],
			maxwell=STRINGS.MAXWELL_QUEST_SURVIVE[8],
			overrides={
			},
			tasks = {
				"Make a pick",
				"Dig that rock",
				"Befriend the pigs",
				"Great Plains",
				"Squeltch",
				"Beeeees!",
				"Forest hunters",
			},
			numoptionaltasks = 4,
			optionaltasks = {
				"Speak to the king",
				"For a nice walk",
				"Kill the spiders",
				"Killer bees!",
				"Make a Beehat",
				"The hunters",
				"Magic meadow",
				"Frogs and bugs",
			},
		}),
		Level({ -- Focus on nighttime play
			name=STRINGS.UI.SANDBOXMENU.PRESETLEVELS[9],
			maxwell=STRINGS.MAXWELL_QUEST_SURVIVE[9],
			overrides={
				{"day", "onlynight"}, 
				{"start_node", "NightmareStart"},
			},
			tasks = {
				"Make a pick",
				"Dig that rock",
				"Befriend the pigs",
				"Great Plains",
				"Squeltch",
				"Beeeees!",
				"Forest hunters",
			},
			numoptionaltasks = 4,
			optionaltasks = {
				"Speak to the king",
				"For a nice walk",
				"Kill the spiders",
				"Killer bees!",
				"Make a Beehat",
				"The hunters",
				--"Mine Forest",
				"Magic meadow",
				"Frogs and bugs",
			},
		}),
--]]	}

local function GetRandomSubstituteList( substitutes, num_choices )	
	local subs = {}
	local list = {}

	for k,v in pairs(substitutes) do 
		list[k] = v.weight
	end

	for i=1,num_choices do
		local choice = weighted_random_choice(list)
		list[choice] = nil
		subs[choice] = substitutes[choice]
	end

	return subs
end

local SUBS_1= {
			["evergreen"] = 		{perstory=0.5, weight=1},
			["evergreen_short"] = 	{perstory=1, weight=1},
			["evergreen_normal"] = 	{perstory=1, weight=1},
			["evergreen_tall"] = 	{perstory=1, weight=1},
			["sapling"] = 			{perstory=0.6, weight=1},
			["beefalo"] = 			{perstory=1, weight=1},
			["rabbithole"] = 		{perstory=1, weight=1},
			["rock1"] = 			{perstory=0.5, weight=1},
			["rock2"] = 			{perstory=0.5, weight=1},
			["grass"] = 			{perstory=0.5, weight=1},
			["spiderden"] =			{perstory=1, weight=1},
		}

local story_levels = {
	--note to self: list, not dict, for now?
	Level({
		name=STRINGS.UI.SANDBOXMENU.ADVENTURELEVELS[1],
		maxwell= "ADVENTURE_1",
		overrides={
			{"world_size", 		"medium"},
			{"day", 			"longdusk"}, 
			{"weather", 		"squall"},		
			{"weather_start", 	"wet"},		
			
			{"start_setpeice", 	"WinterStartEasy"},	
			{"start_node", 		"Forest"},	

			{"season", 			"autumn"}, 
			{"season_start", 	"summer"},
			
			{"deerclops", 		"never"},
			{"hounds", 			"never"},
			{"mactusk", 		"always"},
			
			{"trees", 			"often"},
			{"carrot", 			"often"},
			{"berrybush", 		"never"},
		},
		substitutes = GetRandomSubstituteList(SUBS_1, 1),
		tasks = {
				"Make a pick",
				"Dig that rock",
				"Great Plains",
				"Squeltch",
				"Beeeees!",
				"Speak to the king",
				"Forest hunters",
		},
		numoptionaltasks = 4,
		optionaltasks = {
				"Befriend the pigs",
				"For a nice walk",
				"Kill the spiders",
				"Killer bees!",
				"Make a Beehat",
				"The hunters",
				"Magic meadow",
				"Frogs and bugs",
				"WalrusDesolate",
		},
		-- set_pieces = {
		-- 	["MacTuskTown"] = {"Forest hunters", "Dig that rock"},
		-- },
	}),
	Level({
		name=STRINGS.UI.SANDBOXMENU.ADVENTURELEVELS[2],
		maxwell="ADVENTURE_2",
		overrides={
			{"world_size", 		"medium"},
			{"day", 			"longdusk"}, 
			
			{"start_setpeice", 	"WinterStartMedium"},		
			{"start_node",		"Clearing"},

			{"loop",			"never"},
			{"branching",		"least"},
			
			{"season", 			"onlywinter"},
			{"season_start", 	"winter"},
			{"weather", 		"always"},		
			
			{"deerclops", 		"often"},
			{"hounds", 			"never"},
			{"mactusk", 		"always"},
			
			{"carrot", 			"rare"},
			{"berrybush", 		"rare"},
		},
		substitutes = GetRandomSubstituteList(SUBS_1, 1),
		tasks = {
			"Resource-rich Tier2",
			"Sanity-Blocked Great Plains",
			"Hounded Greater Plains",
			"Insanity-Blocked Necronomicon",
		},
		numoptionaltasks = 2,
		optionaltasks = {
			"WalrusDesolate",
			"Rock-Blocked Kill the spiders",
			"The Deep Forest",
			"Forest hunters",
		},
		set_pieces = {
			["MacTuskTown"] = { tasks={"Resource-rich Tier2", "Insanity-Blocked Necronomicon", "Hounded Greater Plains"} },
		},
	}),
	-- Weather: start with very short winter, then endless summer.
	Level({
		name=STRINGS.UI.SANDBOXMENU.ADVENTURELEVELS[3],
		maxwell="ADVENTURE_3",
		overrides={
			{"world_size", 		"medium"},
			{"day",			 	"longdusk"}, 
			
			{"start_setpeice", 	"PreSummerStart"},
			{"start_node",		"Clearing"},
					
			{"season", 			"preonlysummer"}, 
			{"season_start", 	"winter"},
			{"spiders", 		"often"},

			{"branching",		"default"},
			{"loop",			"never"},
		},
		substitutes = GetRandomSubstituteList(SUBS_1, 1),
	-- Enemies: Lots of hound mounds and maxwell traps everywhere. Frequent hound invasions.
		tasks = {
			"Resource-Rich",
			"Lots-o-Spiders",
			"Lots-o-Tentacles",
			"Lots-o-Tallbirds",
			"Lots-o-Chessmonsters",
		},
		numoptionaltasks = 4,
		optionaltasks = {
			"The hunters",
			"Trapped Forest hunters",
			"Wasps and Frogs and bugs",
			"Tentacle-Blocked The Deep Forest",
			"Hounded Greater Plains",
			"Merms ahoy",
		},
		set_pieces = {
			["SimpleBase"] = { tasks={"Lots-o-Spiders", "Lots-o-Tentacles", "Lots-o-Tallbirds", "Lots-o-Chessmonsters"}},
			--["WesUnlock"] = { tasks={ "The hunters", "Trapped Forest hunters", "Wasps and Frogs and bugs", "Tentacle-Blocked The Deep Forest", "Hounded Greater Plains", "Merms ahoy" }},
		},
	}),
	Level({
		name=STRINGS.UI.SANDBOXMENU.ADVENTURELEVELS[4],
		maxwell="ADVENTURE_4",
		overrides={
			{"world_size", 		"medium"},
			{"day", 			"longday"}, 
			{"season", 			"onlysummer"},
			{"season_start",	"summer"},
			
			{"islands", 		"always"},	
			{"roads", 			"never"},	
				
			{"start_setpeice", 	"BargainStart"},		
			{"start_node",		"Clearing"},
		},
		substitutes = GetRandomSubstituteList(SUBS_1, 1),
		tasks = {
			-- Part 1 - Easy peasy - lots of stuff
			"Land of Plenty",
			
			-- Part 2 - Lets kill them off
			"The other side",	
		},
		override_triggers = {
			["Land of Plenty"] = {	
									{"weather", "never"}, 
									{"day", "longday"},
							 	},
			["The other side"] = {	
									{"weather", "always"}, 
									{"day", "longdusk"},
							 	},
		},
		set_pieces = {
			["MaxPigShrine"] = {tasks={"Land of Plenty"}},
			["MaxMermShrine"] = {tasks={"The other side"}},
		},
	}),
	Level({
		name=STRINGS.UI.SANDBOXMENU.ADVENTURELEVELS[5],
		maxwell="ADVENTURE_5",
		overrides={
			{"branching",		"never"},

			{"season_start", 	"summer"},
			{"weather", 		"always"},
			
			{"roads", 			"never"},
			{"carrot", 			"never"},
			{"berrybush", 		"never"},
			{"spiders", 		"always"},
			
			{"start_setpeice", 	"ThisMeansWarStart"},
			{"start_node",		"Marsh"},
		},
		substitutes = GetRandomSubstituteList(SUBS_1, 1),
		tasks = {
			"Swamp start",
			"Battlefield",
			"Rock-Blocked Kill the spiders",
			"Sanity-Blocked Spider Queendom",
			"Chessworld",
		},
		numoptionaltasks = 4,
		optionaltasks = {
			"Killer Bees!",
			"Tentacle-Blocked The Deep Forest",
			"Tentacle-Blocked Spider Swamp",
			"Trapped Forest hunters",
			"Waspy The hunters",
			"Hounded Magic meadow",
		},
		override_triggers = {
			[5] = {	
				{"season", 		"onlywinter"},
				{"season_start","winter"}, 
				{"weather", 	"always"},
				{"day", 		"onlynight"}, 
			},
		},	
		set_pieces = {
			["RuinedBase"] = {tasks={"Swamp start", "Battlefield", "Rock-Blocked Kill the spiders", "Killer Bees!"}},
		},

	}),
	
 	Level({
		name=STRINGS.UI.SANDBOXMENU.ADVENTURELEVELS[6],
		maxwell="ADVENTURE_6",
		overrides={
			{"day", 			"onlynight"}, 
			{"season", 			"onlysummer"},
			{"weather", 		"never"},
			{"creepyeyes", 		"always"},
		},
		tasks = {
			"MaxHome",
		},
		numoptionaltasks =0,
		hideminimap = true,
		optionaltasks = {
		},
	}),
	
}
levels = { story_levels=story_levels, sandbox_levels=free_levels, free_level=free_levels[1], test_level=test_level }
