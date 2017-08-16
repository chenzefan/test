return {


	ACTIONFAIL_GENERIC = "I can't do anything right.",
	ANNOUNCE_ADVENTUREFAIL = "Not all deaths are alike.",
	ANNOUNCE_BOOMERANG = "Ow! That was karma.",
	ANNOUNCE_CHARLIE = "Demon! Show yourself!",
	ANNOUNCE_CHARLIE_ATTACK = "I am attacked!",
	ANNOUNCE_COLD = "I am chilled to the bone.",
	ANNOUNCE_CRAFTING_FAIL = "I lack the necessary materials.",
	ANNOUNCE_DUSK = "The darkness will be here soon. I must prepare.",
	ANNOUNCE_EAT =
	{
		GENERIC = "Yum!",
		PAINFUL = "That was not edible.",
		SPOILED = "That food was nearing the end of its lifetime.",
		STALE = "Was that stale?",
	},
	ANNOUNCE_ENTER_DARK = "The darkness has swallowed me.",
	ANNOUNCE_ENTER_LIGHT = "And there was light!",
	ANNOUNCE_HOUNDS = "The hounds are baying.",
	ANNOUNCE_HUNGRY = "I am full of emptiness.",
	ANNOUNCE_HUNT_BEAST_NEARBY = "I sense the beast's presence nearby.",
	ANNOUNCE_HUNT_LOST_TRAIL = "This trail leads nowhere.",
	ANNOUNCE_INV_FULL = "I can carry no more.",
	ANNOUNCE_PECKED = "You try my patience.",
	ANNOUNCE_TORCH_OUT = "Darkness has returned!",
	ANNOUNCE_WORMHOLE = "I emerge into this world once more.",
	BATTLECRY =
	{
		GENERIC = "Death will find you!",
		PIG = "Let death embrace you!",
		PREY = "Suffer, worm!",
		SPIDER = "I shall send you to the other side!",
		SPIDER_WARRIOR = "I will be your end!",
	},
	COMBAT_QUIT =
	{
		GENERIC = "You shall live. For now.",
	},
	DESCRIBE =
	{

		THULECITE = "Its presence marks the edge of the unknown.",
		ARMORRUINS = "A reprieve from death.",
		RUINS_BAT = "I hold the power of the ancients in my hands.",
		NIGHTMARE_TIMEPIECE = --Keeps track of the nightmare cycle
		{
			CALM = "I know not what lurks in the shadow.",	--calm phase
			WARN = "I can feel the prying eyes.",	--Before nightmare
			WAXING = "They approach.", --Nightmare Phase first 33%
			STEADY = "They're all around me!", --Nightmare 33% - 66%
			WANING = "I think they're leaving.", --Nightmare 66% +
			DAWN = "It's almost over.", --After nightmare
			NOMAGIC = "I am alone.", --Place with no nightmare cycle.
		},
		BISHOP_NIGHTMARE = "Time has won this battle.",
		ROOK_NIGHTMARE = "Time erodes everything.",
		KNIGHT_NIGHTMARE = "Another battle lost to time.",
		MINOTAUR = "He must be lonely. Trapped in such a small cage.",	--Monster in labyrinth
		SPIDER_DROPPER = "The darkness has drained the colour from their fur.",	--White spider that comes from the roof
		NIGHTMARELIGHT = "It pulls power from beneath.",	--Lights that activate during nightmare.
		RELIC = "A vision of the past.",	--Fixed relic
		RUINS_RUBBLE = "A vision of the past. Broken.",	--Broken relic
		MULTITOOL_AXE_PICKAXE = "An item with multiple uses.",	--Works as axe and pickaxe
		GREENGEM = "The flaws are its most beautiful features.",
		ORANGESTAFF = "Each time I use it I die and am reborn.",	--Teleports player.
		YELLOWAMULET = "A brief light in my dark life.",	--Emits light, player walks faster.
		GREENAMULET = "A flash of brilliance!",	--Reduce cost of crafting

		SLURPER = "Ah, to be so simple.",
		SLURPER_PELT = "An empty bag of hunger.",
		ARMORSLURPER = "A clinging, dreary, living suit.",
		ORANGEAMULET = "Temporary release from drudgery.",
		YELLOWSTAFF = "The stick is as twisted as my soul.",
		YELLOWGEM = "It reminds me of my mother.",
		ORANGEGEM = "Such things used to bring me happiness.",
		TELEBASE = 
		{
			VALID = "Energy flows through it.",
			GEMS = "The focus is so lifeless.",
		},
		GEMSOCKET = 
		{
			VALID = "The gem has focused it.",
			GEMS = "It looks so empty.",
		},
		STAFFLIGHT = "I can almost make out a tiny solar system.",
		RESEARCHLAB4 = "This is but a step from madness.",
		
		ABIGAIL_FLOWER = 
		{ 
			GENERIC ="It's pretty.",
			LONG = "It was my sister's flower. She's gone far away.",
			MEDIUM = "I can sense Abigail's presence growing stronger.",
			SOON = "Abigail is almost here!",
			HAUNTED_POCKET = "Abigail is ready to play, but she needs some space.",
			HAUNTED_GROUND = "I need to show Abigail how to play.",

		},

        ANCIENT_ALTAR = "It is full of the echos of the dead.",
        ANCIENT_ALTAR_BROKEN = "I hear the painful echos of the dead.",
        ANCIENT_STATUE = "Not very attractive.",

        LICHEN = "How does it manage to grow like that?",
		CUTLICHEN = "Fleeting, just like life.",
		CAVE_BANANA = "The peels look dangerous.",
		CAVE_BANANA_COOKED = "Warmed banana mush is so much better.",
		CAVE_BANANA_TREE = "Poor plant, locked away from the sun.",
		ROCKY = "What terrible sights they have seen.",


		BLUEAMULET = "A familiar chilling embrace.",
		PURPLEAMULET = "It's oozing.",
		TELESTAFF = "I could escape if it were more powerful.",
		MONKEY = "Living without the burden of intelligence must be nice.",
		MONKEYBARREL = "It's filthy.",

		HOUNDSTOOTH="Pulled out by the root.",
		ARMORSNURTLESHELL="Now I can hide from my problems.",
		BAT="A creature of the night.",
		BATBAT = "An enchanted weapon. How exciting!",
		BATWING="If only I could fly away.",
		BATWING_COOKED="The once held such great potential.",
		BEDROLL_FURRY="I will wrap myself in the fuzzy skins of the fallen.",
		BUNNYMAN="What tormented inner lives they must have.",
		FLOWER_CAVE="It looks fragile.",
		FLOWER_CAVE_DOUBLE="It looks fragile.",
		FLOWER_CAVE_TRIPLE="It looks fragile.",
		GUANO="The inevitable byproduct of life.",
		LANTERN="Light the way darkly.",
		LIGHTBULB="It's slowly burning out.",
		MANRABBIT_TAIL="It contains his fuzzy wuzzy essence.",
		MUSHTREE_TALL  ="Even the trees down here are strange.",
		MUSHTREE_MEDIUM="It looks like a rotting hat.",
		MUSHTREE_SMALL ="Do little gnomes live in these?",
		RABBITHOUSE="It is not as edible as it looks.",
		SLURTLE="It is mindlessly chasing after rocks.",
		SLURTLE_SHELLPIECES="Pieces of broken slurtle dreams.",
		SLURTLEHAT="I doubt it will help me more than it did for the original owner.",
		SLURTLEHOLE="The slurtles pop out when they outgrow it.",
		SLURTLESLIME="It shimmers with slimy anticipation.",
		SNURTLE="That one has a larger shell.",
		SPIDER_HIDER="A cowardly spider.",
		SPIDER_SPITTER="It's chewing on something.",
		SPIDERHOLE="It is infested.",
		STALAGMITE="The earth gives up its bounty.",
		STALAGMITE_FULL="The earth gives up its bounty.",
		STALAGMITE_LOW="The earth gives up its bounty.",
		STALAGMITE_MED="The earth gives up its bounty.",
		STALAGMITE_TALL="The earth reaches up.",
		STALAGMITE_TALL_FULL="The earth reaches up.",
		STALAGMITE_TALL_LOW="The earth reaches up.",
		STALAGMITE_TALL_MED="The earth reaches up.",
		TURF_FUNGUS="Some ground.",
		TURF_MUD="Some ground.",
		TURF_SINKHOLE="Some ground.",
		TURF_UNDERROCK="Some ground.",

		POWCAKE = "I would have to be desperate.",		
		CAVE_ENTRANCE = 
		{
			GENERIC="Someone is trying to keep the underground at bay.",
			OPEN = "A great evil lurks beneath the surface.",
		},
        CAVE_EXIT = "The surface beckons.",
		BOOMERANG = "Death returns to the sender.",
		MAXWELLPHONOGRAPH = "Shall we have a danse macabre?",
		ABIGAIL = "That's my twin sister, Abigail.",
		PIGGUARD = "This little piggie looks mean.",
		ADVENTURE_PORTAL = "What technological terror is this?",
		AMULET = "I wonder who used to own this.",
		ANIMAL_TRACK = "Signs of the beast.",
		ARMORGRASS = "I prolong the inevitable.",
		ARMORMARBLE = "Stops the daggers that stab at mine heart.",
		ARMORWOOD = "I might hold off the inevitable a bit longer with this.",
		ARMOR_SANITY = "A perfectly safe way to go insane.",
		AXE = "An instrument for industry and murder.",
		BABYBEEFALO = "Enjoy your youth. Soon you will learn the terrors of the real world.",
		BANDAGE = "I'll only end up hurt again.",
		BASALT = "Trying to break it would be pointless.",
		BEARDHAIR = "That's just nasty.",
		BEDROLL_STRAW = "Sleep is but a temporary death.",
		BEE =
		{
			GENERIC = "I'd steer clear of that stinger.",
			HELD = "Be still, little one.",
		},
		BEEBOX =
		{
			GENERIC = "They shall labour so I can steal.",
			READY = "Their toils have been fruitful!",
		},
		BEEFALO =
		{
			FOLLOWER = "He follows me unto his doom.",
			GENERIC = "What demented thoughts must lie behind those eyes.",
			NAKED = "His nakedness is now on display.",
			SLEEPING = "What nightmares he must be having.",
		},
		BEEFALOHAT = "I shall cover my head.",
		BEEFALOWOOL = "Somewhere, a beefalo is naked and cold.",
		BEEHIVE = "A wretched hive of scum and pollen.",
		BERRIES = "These berries are tart.",
		BERRYBUSH =
		{
			BARREN = "It is barren.",
			GENERIC = "A snack, perchance?",
			PICKED = "I shall have to wait.",
		},
		BIRDCAGE =
		{
			GENERIC = "Some of us can see our cages.",
			OCCUPIED = "He is happier now.",
			SLEEPING = "Is he dead? No. Just sleeping.",
		},
		BIRDTRAP = "Sticks and silk turned lethal.",
		BIRD_EGG = "So much hope, dashed.",
		BIRD_EGG_COOKED = "No bird will ever come of it.",
		BISHOP = "What does he pray for?",
		BLOWDART_FIRE = "Shall I burn down the world?",
		BLUEGEM = "Blue like... er... a sad bird?",
		BLUEPRINT = "Whoever drew this is probably dead.",
		BLUE_CAP = "A fungus to preserve the monotony.",
		BLUE_CAP_COOKED = "All is malleable.",
		BLUE_MUSHROOM =
		{
			GENERIC = "Musty.",
			INGROUND = "I would hide too, if I could.",
			PICKED = "Harvested.",
		},
		BOARDS = "Even scarier for the trees.",
		BUGNET = "A prison for tiny insects.",
		BUSHHAT = "Oh to disappear.",
		BUTTER = "I wasn't expecting that.",
		BUTTERFLY =
		{
			GENERIC = "Pretty, but short-lived.",
			HELD = "I hold its life in my hands.",
		},
		BUTTERFLYWINGS = "No more can the butterfly soar.",
		CAMPFIRE =
		{
			EMBERS = "Darkness is looming.",
			GENERIC = "I might survive this night!",
			HIGH = "A vision of Hell!",
			LOW = "The gloom encroaches.",
			NORMAL = "It's a fire.",
			OUT = "That is not a good sign.",
		},
		CANE = "I can get nowhere faster.",
		CARROT = "It's a carrot.",
		CAVE_FERN = "A touch of colour in the darkness.",
		CHARCOAL = "It is cold and dead, like my heart.",
        CHESSJUNK1 = "Cold, dead artifical life.",
        CHESSJUNK2 = "Cold, dead artifical life.",
        CHESSJUNK3 = "Cold, dead artifical life.",
		CHESTER = "A fuzzy ball of emptiness.",
		CHESTER_EYEBONE =
		{
			GENERIC = "It's looking into my soul.",
			WAITING = "Not so much sleeping as... waiting.",
		},
		COOKEDMEAT = "The blood has been cooked away.",
		COOKEDMONSTERMEAT = "Cooked evil is still evil.",
		COOKEDSMALLMEAT = "Fire has purified it.",
		CROW =
		{
			GENERIC = "Take thy beak from out my heart!",
			HELD = "He is mine.",
		},
		CUTGRASS = "I like to kill small things.",
		CUTREEDS = "I like to cut things up.",
		CUTSTONE = "The better to mark graves with.",
		DEERCLOPS = "Death incarnate!",
		DEERCLOPS_EYEBALL = "What terrors it must see.",
		DIRTPILE = "Oh look. More dirt.",
		DIVININGROD =
		{
			COLD = "The source is distant.",
			GENERIC = "It is forever seeking its lost half.",
			HOT = "Something wicked is here!",
			WARM = "The wickedness draws closer.",
			WARMER = "It is very close now.",
		},
		EARMUFFHAT = "Their bitter end protects me from the bitter cold.",
		EVERGREEN =
		{
			BURNING = "It's burning brightly.",
			BURNT = "Used up and done for.",
			CHOPPED = "Everything dies.",
			GENERIC = "Nature is so boring.",
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "It's burning brightly.",
			BURNT = "Used up and done for.",
			CHOPPED = "Everything dies.",
			GENERIC = "It's cycle of life is ending.",
		},
		EYEPLANT = "They follow their master's every wish.",
		FARMPLOT =
		{
			GENERIC = "What seeds shall I sow?",
			GROWING = "Leafy tendrils coil out of the muck.",
			NEEDSFERTILIZER = "This earth is cold and dead.",
		},
		FEM_PUPPET = "I wonder what she did.",
		FIREFLIES =
		{
			GENERIC = "A tiny brightness in the dark.",
			HELD = "Tiny lights, stranded from the world outside my pocket.",
		},
		FIREHOUND = "His disposition is firey.",
		FIREPIT =
		{
			EMBERS = "Darkness is looming.",
			GENERIC = "I might survive this night!",
			HIGH = "A vision of Hell!",
			LOW = "The gloom encroaches.",
			NORMAL = "It's a fire.",
			OUT = "That is not a good sign.",
		},
		FLINT = "A tiny blade-like rock.",
		FLOWER = "They are bright and cheery. Yuck.",
		FLOWERHAT = "But I am in mourning...",
		FLOWER_EVIL = "At least they're better than the other flowers.",
		FOLIAGE = "Lead me to the Aarnivalkea.",
		FROG =
		{
			DEAD = "Life is small and short.",
			GENERIC = "He's little and warty.",
			SLEEPING = "He's asleep.",
		},
		GEARS = "The insides of a mechanical demon.",
		GHOST = "He has risen from the grave!",
		GOLDNUGGET = "I will take it with me.",
		GRASS =
		{
			BARREN = "It needs poop.",
			BURNING = "It smells funny.",
			GENERIC = "It's just a tuft of grass.",
			PICKED = "I have killed it.",
		},
		GREEN_CAP = "This mushroom is disappointingly normal.",
		GREEN_CAP_COOKED = "All is malleable.",
		GREEN_MUSHROOM =
		{
			GENERIC = "Dank.",
			INGROUND = "I would hide too, if I could.",
			PICKED = "Harvested.",
		},
		GUNPOWDER = "It is a dark path I tread.",
		HAMBAT = "Death begets death.",
		HAMMER = "Oh that I may crush the world.",
		HEALINGSALVE = "Life brings pain, pain brings life.",
		HEATROCK =
		{
			COLD = "As cold and lifeless as every other rock.",
			GENERIC = "There it sits, just taking up space.",
			HOT = "Those that burn brightest, burn fastest.",
			WARM = "Even now it's warmth is fading...",
		},
		HOMESIGN = "A mark is made, however transient.",
		HONEY = "A sweet, but fleeting treat.",
		HONEYCOMB = "Pieces of beehive, scattered.",
		HOUND = "Stay back, foul minion of evil!",
		HOUNDMOUND = "Home to the foulest creatures.",
		ICEBOX = "It is as cold as my heart.",
		ICEHOUND = "He has a cold, dead heart.",
		INSANITYROCK =
		{
			ACTIVE = "It's calling my name.",
			INACTIVE = "It's cold and black.",
		},
		KILLERBEE =
		{
			GENERIC = "A bee with a cold, dead heart.",
			HELD = "Be still, little one.",
		},
		KNIGHT = "A cold, soulless horse.",
		KOALEFANT_SUMMER = "A beast of solitude.",
		KOALEFANT_WINTER = "It stands against the cruel elements.",
		KRAMPUS = "Hello, foul creature of the underworld.",
		KRAMPUS_SACK = "It smells of goat.",
		LIGHTNING_ROD =
		{
			CHARGED = "Even this power will run out.",
			GENERIC = "Focuses the destruction.",
		},
		LITTLE_WALRUS = "The cycle of violence continues.",
		LIVINGLOG = "It is forever silently screaming.",
		LOG = "If trees could talk, they would scream at the sight of this.",
		LUREPLANT = "It consumes all.",
		LUREPLANTBULB = "Life goes on.",
		MALE_PUPPET = "I wonder what he did.",
		MANDRAKE =
		{
			DEAD = "Alas, poor mandrake!",
			GENERIC = "The mighty mandrake. I should pick it at night.",
			PICKED = "Onward, my vegetable minions!",
		},
		MARBLE = "Smooth and lifeless.",
		MARBLEPILLAR = "Even stone can not withstand the constant pull of decay.",
		MARBLETREE = "There is no beat of life within this cold tree.",
		MARSH_BUSH =
		{
			BURNING = "Even thorns burn.",
			GENERIC = "A bush that always hurts.",
			PICKED = "It hurt me to do that.",
		},
		MARSH_PLANT = "It's a plant.",
		MARSH_TREE =
		{
			BURNING = "It's burning",
			BURNT = "Black like my heart",
			CHOPPED = "Its spikes were no protection.",
			GENERIC = "A tree that knows only pain.",
		},
		MAXWELL = "I feel a strange kinship with him.",
		MAXWELLHEAD = "He sure has a taste for the dramatic.",
		MAXWELLLIGHT = "What a curious light.",
		MAXWELLLOCK = "Looks magical.",
		MAXWELLTHRONE = "Not quite what I expected.",
		MEAT = "It is still bloody.",
		MEATRACK =
		{
			DONE = "The drying is over.",
			DRYING = "It sways in the drying wind.",
			GENERIC = "I can hang meat here.",
		},
		MEAT_DRIED = "Meat turned dry and delicious.",
		MERM = "Horrid swamp thing!",
		MERMHEAD = "No dignity at all.",
		MERMHOUSE = "Time has broken it down.",
		MONSTERMEAT = "Evilness pervades it.",
		MONSTERMEAT_DRIED = "Meat turned dry and weird-tasting.",
		MOSQUITO =
		{
			GENERIC = "Takes life so it may live.",
			HELD = "I can feel its stolen warmth.",
		},
		MOUND =
		{
			DUG = "The earth has vomited up its secrets.",
			GENERIC = "Some day, I will join you.",
		},
		NIGHTLIGHT = "Eerie and yet beautiful.",
		NIGHTMAREFUEL = "With the sleep of dreams comes this stuff.",
		NIGHTSWORD = "Dreams come to a point. A sharp one.",
		NITRE = "Herein lies the folly of man.",
		ONEMANBAND = "I used to take such joy in instruments like these.",
		PANDORASCHEST = "Life is a gamble.",
		PANFLUTE = "Music is the window to my empty soul.",
		PAPYRUS = "For documenting my pain.",
		PENGUIN = "All dressed up, but where to go?",
		PETALS = "I have destroyed something beautiful.",
		PETALS_EVIL = "They are painted with the colours of my soul.",
		PICKAXE = "So that I may penetrate the earth itself.",
		PIGGYBACK = "They are more useful in death.",
		PIGHEAD = "Kill the pig. Spill his blood.",
		PIGHOUSE =
		{
			FULL = "I hope he is enjoying himself.",
			GENERIC = "At least they are comfortable.",
			LIGHTSOUT = "Now I am all alone.",
		},
		PIGKING = "Live it up while you can, Your Majesty.",
		PIGMAN =
		{
			DEAD = "He's better off, now.",
			FOLLOWER = "I still feel alone.",
			GENERIC = "They are so standoffish.",
			GUARD = "How Orwellian.",
			WEREPIG = "A creature of the night!",
		},
		PIGTORCH = "It cuts at the darkness.",
		PINECONE = 
		{
		    GENERIC = "A tiny life, ensconced in brittle death.",
		    PLANTED = "A tree will grow soon.",
		},
		PITCHFORK = "What a devilish tool!",
		PLANTMEAT = "It has a foul smell.",
		PLANTMEAT_COOKED = "It's only slightly more appealing.",
		PLANT_NORMAL =
		{
			GENERIC = "An edible plant.",
			GROWING = "Keep growing. I'll wait.",
			READY = "It is ready for the harvest.",
		},
		POND = "Ophelia? Are you down there?",
		POOP = "Life is blood and this.",
		PURPLEGEM = "Purple like a... purple thing.",
		RABBIT =
		{
			GENERIC = "He's wandering mindlessly, oblivious to his fate.",
			HELD = "He is safely in my embrace.",
		},
		RABBITHOLE = "I'm too big to fall down there.",
		RAINOMETER = "",
		RAZOR = "This is just for shaving.",
		REDGEM = "Red like my heart's blood.",
		RED_CAP = "A mushroom after my own heart.",
		RED_CAP_COOKED = "All is malleable.",
		RED_MUSHROOM =
		{
			GENERIC = "Damp.",
			INGROUND = "I would hide too, if I could.",
			PICKED = "Harvested.",
		},
		REEDS =
		{
			BURNING = "Soon to be ashes.",
			GENERIC = "It's just a bunch of reeds.",
			PICKED = "I have picked them.",
		},
        RELIC = 
        {
            GENERIC = "A leftover of an ancient world.",
            BROKEN = "Broken bits of stone",
        },
        RUINS_RUBBLE = "A pile of broken dreams.",
		RESEARCHLAB = "I will learn unspeakable things.",
		RESEARCHLAB2 = "I will learn unspeakable things.",
		RESEARCHLAB3 = "I have learnt unspeakable things.",
		RESURRECTIONSTATUE = "I'm just putting off the inevitable.",
		RESURRECTIONSTONE = "A futile ward.",
		ROBOT_PUPPET = "I wonder what it did.",
		ROCK_LIGHT =
		{
			GENERIC = "A crusted over lava pit.",
			OUT = "It looks harmless.",
			LOW = "The shadows encroach.",
			NORMAL = "The lava's on fire.",
		},
		ROCK = "Even that is not permanent.",
		ROCKS = "Some small rocks.",
        ROOK = "A Rook? Or is it a Castle?",
		ROPE = "That would be the easy way out of this place.",
		ROTTENEGG = "The way of all things.",
		SANITYROCK =
		{
			ACTIVE = "It's calling to me.",
			INACTIVE = "Even this obelisk has left me.",
		},
		SAPLING =
		{
			BURNING = "Consigned to the flames.",
			GENERIC = "It's trying to grow up.",
			PICKED = "Maybe next time, sapling.",
		},
		SEEDS = "Life, or at least the promise of it.",
		SEWING_KIT = "Another implement for putting off inevitable decay.",
		SHOVEL = "What terrible secrets might I uncover?",
		SILK = "So slippery and fine.",
		SKELETON = "I envy his escape.",
		SKULLCHEST = "It shall contain my memento mori.",
		SMALLBIRD =
		{
			GENERIC = "Hello there, little one.",
			HUNGRY = "Are you empty inside?",
			STARVING = "A black hole from which seeds never return.",
		},
		SMALLMEAT = "It smells like tiny fear.",
		SMALLMEAT_DRIED = "Meat turned dry and delicious.",
		SPEAR = "I have become the destroyer of worlds.",
		SPIDER =
		{
			DEAD = "We will meet again some day.",
			GENERIC = "A creature of the night!",
			SLEEPING = "Evil is sleeping.",
		},
		SPIDERDEN = "A nest of filth and villany.",
		SPIDEREGGSACK = "A tiny package full of death and destruction.",
		SPIDERGLAND = "Even in death, this beast causes pain.",
		SPIDERHAT = "Time to stare into the abyss.",
		SPIDERQUEEN = "She is regal in her horribleness.",
		SPIDER_WARRIOR =
		{
			DEAD = "Alas, brave warrior.",
			GENERIC = "A warrior of the night!",
			SLEEPING = "I must beware.",
		},
		SPOILED_FOOD = "Everything turns to waste, eventually.",
		STATUEHARP = "Maybe these statues will keep me company.",
		STATUEMAXWELL = "He brought me here.",
		STINGER = "Sharp and deadly.",
		STRAWHAT = "I shall cover my head.",
		SUNKBOAT = "A cruel trick!",
		TALLBIRD = "Free from the shackles of the sky.",
		TALLBIRDEGG = "So full of potential.",
		TALLBIRDEGG_COOKED = "All that promise, snatched away. Not bad with bacon.",
		TALLBIRDEGG_CRACKED =
		{
			COLD = "Chilled by the darkness.",
			GENERIC = "A tiny fragile being, struggling towards the light.",
			HOT = "It cannot bear the heat.",
			LONG = "A life sooner begun is a life sooner ended.",
			SHORT = "Soon now.",
		},
		TEENBIRD =
		{
			GENERIC = "Will you leave me too?",
			HUNGRY = "We all try to fill the void.",
			STARVING = "Your true nature is revealed!",
		},
		TELEPORTATO_BASE =
		{
			ACTIVE = "I'm sure the next realm will be even more horrible!",
			GENERIC = "No good can come of this.",
			LOCKED = "It's still locked shut.",
			PARTIAL = "Is it half built, or half destroyed?",
		},
		TELEPORTATO_BOX = "It contains a vital spark.",
		TELEPORTATO_CRANK = "It looks complicated.",
		TELEPORTATO_POTATO = "What a hideous creation!",
		TELEPORTATO_RING = "It has no sharp edges.",
		TENT = "Sleep is but a preview of death.",
		TENTACLE = "Long and thin and dangerous!",
		TENTACLESPOTS = "These are better left unmentioned.",
		TENTACLESPIKE = "Sharp, slimy and dangerous.",
        TENTACLE_PILLAR = "So this is what goes on down below.",
        TENTACLE_PILLAR_ARM = "Babies!",
        TENTACLE_GARDEN = "This one is different.",
		TOPHAT = "I shall cover my head.",
		TORCH = "A tiny bulwark against the night.",
		TRAP = "Simple grass has become deadly.",
		TRAP_TEETH = "A devious surprise from underground.",
		TRAP_TEETH_MAXWELL = "Death when I least expect it.",
		TREASURECHEST = "For which to contain my lucre.",
		TRUNKVEST_SUMMER = "Skin to wear on my skin.",
		TRUNKVEST_WINTER = "It may warm my body, but what of my spirit?",
		TRUNK_COOKED = "It looks even worse now.",
		TRUNK_SUMMER = "I would have preferred the ears.",
		TRUNK_WINTER = "Separated from its only friend.",
		TWIGS = "Plucked from the ground before their prime.",
		UMBRELLA = "The clouds weep.",
		WALL_HAY = "That is the mere suggestion of defense.",
		WALL_HAY_ITEM = "Their defensive value is questionable.",
		WALL_STONE = "What will protect me from what's inside?",
		WALL_STONE_ITEM = "These won't protect from the demons within.",
		WALL_RUINS = "These didn't protect the ancients did they!",
		WALL_RUINS_ITEM = "Are the very stones haunted?",
		WALL_WOOD = "Now I can delay the inevitable.",
		WALL_WOOD_ITEM = "Bundled logs.",
		WALRUS = "An old man, of the sea.",
		WALRUSHAT = "What feverish thoughts transpired beneath this?",
		WALRUS_CAMP =
		{
			EMPTY = "If they are not in there, where are they?",
			GENERIC = "This home is not a happy one, I fear.",
		},
		WALRUS_TUSK = "I shall gnash thee.",
		WASPHIVE = "They hide in their fortress of hate.",
		WINTERHAT = "It helps stave off the encroaching cold.",
		WINTEROMETER = "Why do I feel that it is measuring my mortality?",
		WORMHOLE =
		{
			GENERIC = "Life doesn't always make sense.",
			OPEN = "No matter what it consumes, it is never satisfied.",
		},
	},
	DESCRIBE_GENERIC = "It is unmentionable.",
	DESCRIBE_TOODARK = "The darkness! It is too dark!",
	EAT_FOOD =
	{
		TALLBIRDEGG_CRACKED = "I spared it the torment of living.",
	},
}
