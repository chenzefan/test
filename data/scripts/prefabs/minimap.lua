local shader_filename = "data/shaders/minimap.ksh"
local fs_shader = "data/shaders/minimapfs.ksh"
local atlas_filename = "data/minimap/minimap_atlas.tex"
local bg_filename = "data/images/map.tex"
local atlas_info_filename = "data/minimap/minimap_data.xml"

local MINIMAP_GROUND_PROPERTIES =
{
	{ GROUND.ROAD,       { name = "map_edge",      noise_texture = "data/levels/textures/mini_cobblestone_noise.tex" } },
	{ GROUND.MARSH,      { name = "map_edge",      noise_texture = "data/levels/textures/mini_marsh_noise.tex" } },
	{ GROUND.ROCKY,      { name = "map_edge",	   noise_texture = "data/levels/textures/mini_rocky_noise.tex" } },
	{ GROUND.SAVANNA,    { name = "map_edge",      noise_texture = "data/levels/textures/mini_grass2_noise.tex" } },
	{ GROUND.GRASS,      { name = "map_edge",      noise_texture = "data/levels/textures/mini_grass_noise.tex" } },
	{ GROUND.FOREST,     { name = "map_edge",      noise_texture = "data/levels/textures/mini_forest_noise.tex" } },
	{ GROUND.DIRT,       { name = "map_edge",      noise_texture = "data/levels/textures/mini_dirt_noise.tex" } },
	{ GROUND.WOODFLOOR,  { name = "map_edge",      noise_texture = "data/levels/textures/mini_woodfloor_noise.tex" } },
	{ GROUND.CARPET,  	 { name = "map_edge",      noise_texture = "data/levels/textures/mini_carpet_noise.tex" } },
	{ GROUND.CHECKER,  	 { name = "map_edge",      noise_texture = "data/levels/textures/mini_checker_noise.tex" } },
}

local assets =
{
	Asset( "FILE", atlas_info_filename ),
	Asset( "IMAGE", atlas_filename ),
	Asset( "IMAGE", bg_filename ),

	Asset( "SHADER", shader_filename ),
	Asset( "SHADER", fs_shader ),
}
    
local function GroundImage( name )
	return "data/levels/tiles/" .. name .. ".tex"
end

local function GroundAtlas( name )
	return "data/levels/tiles/" .. name .. ".xml"
end

local function AddAssets( layers )
	for k, data in pairs( layers ) do
		local tile_type, properties = unpack( data )
		table.insert( assets, Asset( "IMAGE", properties.noise_texture ) )
		table.insert( assets, Asset( "IMAGE", GroundImage( properties.name ) ) )
		table.insert( assets, Asset( "FILE", GroundAtlas( properties.name ) ) )
	end
end

AddAssets( MINIMAP_GROUND_PROPERTIES )

local function fn(Sim)
	local inst = CreateEntity()
	local uitrans = inst.entity:AddUITransform()
	local minimap = inst.entity:AddMiniMap()
    inst:AddTag("minimap")

	minimap:SetEffects( shader_filename, fs_shader )
	minimap:SetAtlasInfo( atlas_info_filename )

	for i, data in pairs( MINIMAP_GROUND_PROPERTIES ) do
		local tile_type, layer_properties = unpack( data )
		local handle =
			MapLayerManager:CreateRenderLayer(
				tile_type,
				GroundAtlas( layer_properties.name ),
				GroundImage( layer_properties.name ),
				layer_properties.noise_texture
			)
		minimap:AddRenderLayer( handle )
	end

	return inst
end

return Prefab( "common/interface/hud/minimap", fn, assets)

