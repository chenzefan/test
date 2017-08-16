local snow_texture = "data/levels/textures/snow.tex"

local IDENTITY_COLOURCUBE = "data/images/colour_cubes/identity_colourcube.tex"

local CURRENT_DEST_CC = {
	[0] = IDENTITY_COLOURCUBE,
	[1] = IDENTITY_COLOURCUBE,
}

local INSANITY_CCS =
{
	DAY = "data/images/colour_cubes/insane_day_cc.tex",
	DUSK = "data/images/colour_cubes/insane_dusk_cc.tex",
	NIGHT = "data/images/colour_cubes/insane_night_cc.tex",
}

local SEASON_CCS = {
	[SEASONS.SUMMER] = {	DAY = "data/images/colour_cubes/day05_cc.tex",
							DUSK = "data/images/colour_cubes/dusk03_cc.tex",
							NIGHT = "data/images/colour_cubes/night03_cc.tex",
					   },
	[SEASONS.WINTER] = {	DAY = "data/images/colour_cubes/snow_cc.tex",
							DUSK = "data/images/colour_cubes/snowdusk_cc.tex",
							NIGHT = "data/images/colour_cubes/night04_cc.tex",
						},
}

--local CURRENT_SEASON = SEASONS.SUMMER

local WEB_FOOTSTEP_SOUNDS = {
	[CREATURE_SIZE.SMALL]	=	{ runsound = "dontstarve/movement/run_web_small",		walksound = "dontstarve/movement/walk_web_small" },
	[CREATURE_SIZE.MEDIUM]	=	{ runsound = "dontstarve/movement/run_web",				walksound = "dontstarve/movement/walk_web" },
	[CREATURE_SIZE.LARGE]	=	{ runsound = "dontstarve/movement/run_web_large",		walksound = "dontstarve/movement/walk_web_large" },
}

local WAVE_IMAGE = "data/images/wave.tex"
local TEXTURE_SHADER = "data/shaders/texture.ksh"

local assets =
{
    Asset("ANIM", "data/anim/die.zip"),
    Asset("ANIM", "data/anim/snow.zip"),
    Asset("ANIM", "data/anim/lightning.zip"),
    Asset("ANIM", "data/anim/splash_ocean.zip"),
    Asset("ANIM", "data/anim/frozen.zip"),
    Asset("SOUND", "data/sound/forest_stream.fsb"),
    Asset("SOUND", "data/sound/sanity.fsb"),
    Asset("IMAGE", IDENTITY_COLOURCUBE),
	Asset("IMAGE", snow_texture),
	Asset("IMAGE", WAVE_IMAGE),
    Asset("SHADER", TEXTURE_SHADER),
}

local GROUND_PROPERTIES = {
	{ GROUND.ROAD,		{ name = "cobblestone",		noise_texture = "data/images/square.tex",								runsound="dontstarve/movement/run_dirt",		walksound="dontstarve/movement/walk_dirt",		snowsound="dontstarve/movement/run_ice"	} },
	{ GROUND.MARSH,		{ name = "marsh",			noise_texture = "data/levels/textures/Ground_noise_marsh.tex",			runsound="dontstarve/movement/run_marsh",		walksound="dontstarve/movement/walk_marsh",		snowsound="dontstarve/movement/run_ice"		} },
	{ GROUND.ROCKY,		{ name = "rocky",			noise_texture = "data/levels/textures/noise_rocky.tex",					runsound="dontstarve/movement/run_dirt",		walksound="dontstarve/movement/walk_dirt",		snowsound="dontstarve/movement/run_ice"		} },
	{ GROUND.SAVANNA,	{ name = "yellowgrass",		noise_texture = "data/levels/textures/Ground_noise_grass_detail.tex",	runsound="dontstarve/movement/run_tallgrass",	walksound="dontstarve/movement/walk_tallgrass",	snowsound="dontstarve/movement/run_snow"	} },
	{ GROUND.FOREST,	{ name = "forest",			noise_texture = "data/levels/textures/Ground_noise.tex",				runsound="dontstarve/movement/run_grass",		walksound="dontstarve/movement/walk_grass",		snowsound="dontstarve/movement/run_snow"		} },
	{ GROUND.GRASS,		{ name = "grass",			noise_texture = "data/levels/textures/Ground_noise.tex",				runsound="dontstarve/movement/run_grass",		walksound="dontstarve/movement/walk_grass",		snowsound="dontstarve/movement/run_snow"		} },
	{ GROUND.DIRT,		{ name = "dirt",			noise_texture = "data/levels/textures/Ground_noise_dirt.tex",			runsound="dontstarve/movement/run_dirt",		walksound="dontstarve/movement/walk_dirt",		snowsound="dontstarve/movement/run_snow"		} },
	{ GROUND.WOODFLOOR,	{ name = "blocky",			noise_texture = "data/levels/textures/noise_woodfloor.tex",				runsound="dontstarve/movement/run_wood",		walksound="dontstarve/movement/walk_wood",		snowsound="dontstarve/movement/run_ice"		} },
	{ GROUND.CHECKER,	{ name = "blocky",			noise_texture = "data/levels/textures/noise_checker.tex",				runsound="dontstarve/movement/run_wood",		walksound="dontstarve/movement/walk_wood",		snowsound="dontstarve/movement/run_ice"		} },
	{ GROUND.CARPET,	{ name = "carpet",			noise_texture = "data/levels/textures/noise_carpet.tex",				runsound="dontstarve/movement/run_wood",		walksound="dontstarve/movement/walk_wood",		snowsound="dontstarve/movement/run_ice"		} },
}

local GROUND_CREEP_PROPERTIES = {
	{ 1, { name = "web", noise_texture = "data/levels/textures/web_noise.tex" } },
}

local underground_layers =
{
	{ GROUND.UNDERGROUND, { name = "falloff", noise_texture = "data/images/square.tex" } },
}

local CACHED_GROUND = nil

function GetTileInfo( tile )
	for k, data in ipairs( GROUND_PROPERTIES ) do
		local tile_type, tile_info = unpack( data )
		if tile == tile_type then
			return tile_info
		end
	end
	return nil
end

function PlayFootstep(inst, volume)
	volume = volume or 1
	
    local sound = inst.SoundEmitter
    if sound then
		if CACHED_GROUND == nil then
			CACHED_GROUND = GetWorld()
		end
        local tile, tileinfo = inst:GetCurrentTileType()
        
        if tile and tileinfo then
			local x, y, z = inst.Transform:GetWorldPosition()
			local oncreep = CACHED_GROUND.GroundCreep:OnCreep( x, y, z )
			local onsnow = GetSeasonManager():GetSnowPercent() > 0.15
			
			--this is only for playerd for the time being because isonroad is suuuuuuuper slow.
			local onroad = inst:HasTag("player") and RoadManager ~= nil and RoadManager:IsOnRoad( x, 0, z )
			if onroad then
				tile = GROUND.ROAD
				tileinfo = GetTileInfo( GROUND.ROAD )
			end

			local creature_size = CREATURE_SIZE.MEDIUM
			local size_affix = ""
			if inst:HasTag("smallcreature") then
				creature_size = CREATURE_SIZE.SMALL
				size_affix = "_small"
			elseif inst:HasTag("largecreature") then
				creature_size = CREATURE_SIZE.LARGE
				size_affix = "_large"
			end
			
			if onsnow then
				sound:PlaySound(tileinfo.snowsound .. size_affix, nil, volume)
			else
				if inst.sg:HasStateTag("running") then
					sound:PlaySound(tileinfo.runsound .. size_affix, nil, volume)
				else
					sound:PlaySound(tileinfo.walksound .. size_affix, nil, volume)
				end
			end

			if oncreep then
				sound:PlaySound( WEB_FOOTSTEP_SOUNDS[ creature_size ].runsound, nil, volume)
			end           
        end
    end
end

function PlayCreatureSound(inst, sound, creature)
    local creature = creature or inst.soundgroup or inst.prefab
    inst.SoundEmitter:PlaySound("dontstarve/creatures/" .. creature .. "/" .. sound)
end

local function GroundImage( name )
	return "data/levels/tiles/" .. name .. ".tex"
end

local function GroundAtlas( name )
	return "data/levels/tiles/" .. name .. ".xml"
end

local function AddAssets( layers )
	for i, data in ipairs( layers ) do
		local tile_type, properties = unpack( data )
		table.insert( assets, Asset( "IMAGE", properties.noise_texture ) )
		table.insert( assets, Asset( "IMAGE", GroundImage( properties.name ) ) )
		table.insert( assets, Asset( "FILE", GroundAtlas( properties.name ) ) )
	end

	for season, cc_data in pairs( SEASON_CCS ) do
		for cc_name, tex_filename in pairs( cc_data ) do
			table.insert( assets, Asset( "IMAGE", tex_filename ) )
		end
	end

	for cc_name, tex_filename in pairs( INSANITY_CCS ) do
		table.insert( assets, Asset( "IMAGE", tex_filename ) )
	end
end

AddAssets( GROUND_PROPERTIES )
AddAssets( underground_layers )
AddAssets( GROUND_CREEP_PROPERTIES )

local prefabs =
{
	"evergreen",
    "evergreen_normal",
    "evergreen_short",
    "evergreen_tall",
	"evergreen_sparse",
    "evergreen_sparse_normal",
    "evergreen_sparse_short",
    "evergreen_sparse_tall",
   	"evergreen_burnt",
   	"evergreen_stump",
    "sapling",
    "berrybush",
    "berrybush2",
    "grass",
    "rock1",
    "rock2",
    "tallbirdnest",
    "hound",
    "firehound",
    "icehound",
    "krampus",
    "deerclops",
	"knight",
	"bishop",
	"adventure_portal",
	"resurrectionstone",
    "mound",
    "gravestone",
    "flower",
    "animal_track",
    "dirtpile",

    "beefaloherd",
    "beefalo",
    "koalefant_summer",
    "koalefant_winter",
    
    "pigman",
    "pighouse",
    "pigking",
    "bonfire",
    "mandrake",
    "chester",
    "beehive",
	"wasphive",
    "walrus_camp",
    "pighead",
    "mermhead",
    
    "goldnugget",

    "crow",
    "robin",
	"robin_winter",
    
    "butterfly",
    "rabbithole",
    "flint",
    "carrot_planted",
    "log",
    "spiderden",
    "tentacle",
    "spawnpoint",
	"wormhole",
    
    "phonograph_gears",
    "phonograph_box",
    "phonograph_crank",
    "phonograph_cone",

	"teleportato_base",
	"teleportato_ring",
	"teleportato_box",
	"teleportato_crank",
	"teleportato_potato",
    
	"pond", 
	"marsh_tree", 
	"marsh_bush", 
	"reeds", 
    
    "fireflies",
    "forest_ambiance",
    "turf_road",
    "turf_rocky",
    "turf_marsh",
    "turf_savanna",
    "turf_dirt",
    "turf_forest",
    "turf_grass",
    "skeleton",
	
	"mist",
	"snow",
	"rain",

	"insanityrock",
	"sanityrock",
	"basalt",
	"basalt_pillar",
	"houndmound",
	"houndbone",
	"pigtorch",
	"red_mushroom",
	"green_mushroom",
	"blue_mushroom",
	"mermhouse",
	"marblepillar",
	"marbletree",
	"flower_evil",
	"statueharp",
	"statuemaxwell",
	"blueprint",
	"maxwellthrone",

	"lockedwes",
	"wormhole_limited_1",
}

local function UpdateCCLerp( total_time )
    local tick_time = TheSim:GetTickTime()

    local time_left = total_time
    while time_left > 0 do
        PostProcessor:SetColourCubeLerp( 0, 1.0 - time_left / total_time )
        time_left = time_left - tick_time
		Yield()
    end
end

local function RegisterTimeColourCube( inst, event, start_cc, end_cc, length )
    inst:ListenForEvent( event,
        function(inst, data)
			local CURRENT_SEASON = GetSeasonManager():GetSeason()
			PostProcessor:SetColourCubeData( 0, SEASON_CCS[ CURRENT_SEASON ][ start_cc ], SEASON_CCS[ CURRENT_SEASON ][ end_cc ] )
			PostProcessor:SetColourCubeLerp( 0, 0 )
			CURRENT_DEST_CC[ 0 ] = SEASON_CCS[ CURRENT_SEASON ][ end_cc ]

			PostProcessor:SetColourCubeData( 1, INSANITY_CCS[ start_cc ], INSANITY_CCS[ end_cc ] )
			PostProcessor:SetColourCubeLerp( 1, 0 )
			CURRENT_DEST_CC[ 1 ] = INSANITY_CCS[ end_cc ]

            StartThread( function() UpdateCCLerp( length ) end, inst.GUID )
        end, GetWorld())
end

local function GetCCToActivate()
	local clock = GetClock()
	if clock then
		local CURRENT_SEASON = GetSeasonManager():GetSeason()
	
		local season = SEASON_CCS[ CURRENT_SEASON ]

		if clock:IsDay() then
			return season.DAY
		elseif clock:IsDusk() then
			return season.DUSK
		elseif clock:IsNight() then
			return season.NIGHT
		end
	end
end


local function UpdateAndTransitionCC( index, inst, time )
	local cc = GetCCToActivate()
	local current_cc = CURRENT_DEST_CC[ index ]
	PostProcessor:SetColourCubeData( index, current_cc, cc )
	CURRENT_DEST_CC[ index ] = cc

	StartThread( function()
		local time_left = time
		local tick_time = TheSim:GetTickTime()

		while time_left > 0 do
			local lerp = 1.0 - math.min( 1, math.max( 0, time_left / time ) )
			PostProcessor:SetColourCubeLerp( 0, lerp )
			time_left = time_left - tick_time
			Yield()
		end
	end, inst.GUID )
end

TheMap = nil

local function fn(Sim)

	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local map = inst.entity:AddMap()
	local pathfinder = inst.entity:AddPathfinder()
	local waves = inst.entity:AddWaveComponent()
	local groundcreep = inst.entity:AddGroundCreep()
	
	--groundcreep:SetUpdateInterval( 1 )
	--groundcreep:SetMaxRadius( 24 )

	waves:SetRegionSize( 32, 16 )
	waves:SetRegionNumWaves( 6 )
	waves:SetWaveTexture( WAVE_IMAGE )
	waves:SetWaveEffect( TEXTURE_SHADER )
	waves:SetWaveSize( 2048, 512 )

	TheMap = map

	inst:AddTag( "ground" )
	inst:AddTag( "NOCLICK" )
    inst.entity:SetCanSleep(false)
    inst.persists = false
    
	inst.tileinfo = GROUND_PROPERTIES
	for i, data in ipairs( GROUND_PROPERTIES ) do
		local tile_type, props = unpack( data )
		local layer_name = props.name
		local handle =
			MapLayerManager:CreateRenderLayer(
				tile_type, --embedded map array value
				GroundAtlas( layer_name ),
				GroundImage( layer_name ),
				props.noise_texture
			)

		map:AddRenderLayer( handle )
		-- TODO: When this object is destroyed, these handles really should be freed. At this time, this is not an
		-- issue because the map lifetime matches the game lifetime but if this were to ever change, we would have
		-- to clean up properly or we leak memory
	end

	for i, data in ipairs( GROUND_CREEP_PROPERTIES ) do
		local tile_type, props = unpack( data )
		local handle = MapLayerManager:CreateRenderLayer( tile_type, GroundAtlas( props.name ), GroundImage( props.name ), props.noise_texture )
		groundcreep:AddRenderLayer( handle )
	end

	local underground_layer = underground_layers[1][2]
	local underground_handle = MapLayerManager:CreateRenderLayer( GROUND.UNDERGROUND, GroundAtlas( underground_layer.name ), GroundImage( underground_layer.name ), underground_layer.noise_texture )
	map:SetUndergroundRenderLayer( underground_handle )
	
    map:SetImpassableType( GROUND.IMPASSABLE )
	map:SetOverlayTexture( snow_texture )

	inst:AddComponent("clock")
	inst:AddComponent("seasonmanager")
	inst.entity:AddSoundEmitter()

    inst:SpawnChild("forest_ambiance")
	inst:AddComponent("groundcreep")
    inst:AddComponent("birdspawner")
    inst:AddComponent("butterflyspawner")
    inst.components.butterflyspawner:SetButterfly("butterfly")

	RegisterTimeColourCube( inst, "daytime", "NIGHT", "DAY", 4 )
	RegisterTimeColourCube( inst, "dusktime", "DAY", "DUSK", 6 )
	RegisterTimeColourCube( inst, "nighttime", "DUSK", "NIGHT", 8 )
	
	inst:ListenForEvent( "seasonChange",
		function( inst, data )
			UpdateAndTransitionCC( 0, inst, 10 )
		end, GetWorld())
		

	local cc = SEASON_CCS[ SEASONS.SUMMER ].NIGHT
	local insanity_cc = INSANITY_CCS.NIGHT
	local clock = GetClock()
	if clock then
		if clock:IsDay() then
			cc = SEASON_CCS[ SEASONS.SUMMER ].DAY
			insanity_cc = INSANITY_CCS.DAY
		elseif clock:IsDusk() then
			cc = SEASON_CCS[ SEASONS.SUMMER ].DUSK
			insanity_cc = INSANITY_CCS.DUSK
		end
	end

	CURRENT_DEST_CC[ 0 ] = cc
	CURRENT_DEST_CC[ 1 ] = IDENTITY_COLOURCUBE
	PostProcessor:SetColourCubeData( 0, cc, cc )
	PostProcessor:SetColourCubeLerp( 0, 0 )

	PostProcessor:SetColourCubeData( 1, insanity_cc, insanity_cc )
	PostProcessor:SetColourCubeLerp( 1, 0 )

    return inst
end

return Prefab( "forest/forest", fn, assets, prefabs)

