PI = 3.14159
DEGREES = PI/180
FRAMES = 1/30
TILE_SCALE = 4

RESOLUTION_X = 1280
RESOLUTION_Y = 720

FACING_RIGHT = 0
FACING_UP = 1
FACING_LEFT = 2
FACING_DOWN = 3

-- Careful inserting into here. You will have to update game\render\RenderLayer.h
LAYER_BACKGROUND = 1
LAYER_WORLD_BACKGROUND = 2
LAYER_WORLD = 3
LAYER_WORLD_CEILING = 4
LAYER_FRONTEND = 6

ANCHOR_MIDDLE = 0
ANCHOR_LEFT = 1
ANCHOR_RIGHT = 2
ANCHOR_TOP = 1
ANCHOR_BOTTOM = 2

SCALEMODE_NONE = 0
SCALEMODE_FILLSCREEN = 1
SCALEMODE_PROPORTIONAL = 2
SCALEMODE_FIXEDPROPORTIONAL = 3

PHYSICS_TYPE_ANIMATION_CONTROLLED = 0
PHYSICS_TYPE_PHYSICS_CONTROLLED = 1

--push priorities
STATIC_PRIORITY = 10000
        
        
-- Controls: Must match the Control enum in DontStarveInputHandler.h
-- player action controls
CONTROL_PRIMARY = 0
CONTROL_SECONDARY = 1
CONTROL_ATTACK = 2
CONTROL_INSPECT = 3
CONTROL_ACTION = 4
-- view controls
CONTROL_ZOOM_IN = 5
CONTROL_ZOOM_OUT = 6
CONTROL_ROTATE_LEFT = 7
CONTROL_ROTATE_RIGHT = 8
-- player movement controls
CONTROL_MOVE_UP = 9
CONTROL_MOVE_DOWN = 10
CONTROL_MOVE_LEFT = 11
CONTROL_MOVE_RIGHT = 12

KEY_TAB = 9
KEY_KP_PERIOD		= 266
KEY_KP_DIVIDE		= 267
KEY_KP_MULTIPLY		= 268
KEY_KP_MINUS		= 269
KEY_KP_PLUS			= 270
KEY_KP_ENTER		= 271
KEY_KP_EQUALS		= 272
KEY_MINUS = 45
KEY_EQUALS = 61
KEY_SPACE = 32
KEY_ENTER = 13
KEY_ESCAPE = 27
KEY_HOME = 278
KEY_INSERT = 277
KEY_DELETE = 127
KEY_END    = 279
KEY_PAUSE = 19
KEY_PRINT = 316
KEY_CAPSLOCK = 301
KEY_SCROLLOCK = 302
KEY_RSHIFT = 303 -- use KEY_SHIFT instead
KEY_LSHIFT = 304 -- use KEY_SHIFT instead
KEY_RCTRL = 305 -- use KEY_CTRL instead
KEY_LCTRL = 306 -- use KEY_CTRL instead
KEY_RALT = 307 -- use KEY_ALT instead
KEY_LALT = 308 -- use KEY_ALT instead
KEY_ALT = 400
KEY_CTRL = 401
KEY_SHIFT = 402
KEY_BACKSPACE = 8
KEY_PERIOD = 46
KEY_SLASH = 47
KEY_LEFTBRACKET	= 91
KEY_BACKSLASH	= 92
KEY_RIGHTBRACKET= 93
KEY_TILDE = 96
KEY_A = 97
KEY_B = 98
KEY_C = 99
KEY_D = 100
KEY_E = 101
KEY_F = 102
KEY_G = 103
KEY_H = 104
KEY_I = 105
KEY_J = 106
KEY_K = 107
KEY_L = 108
KEY_M = 109
KEY_N = 110
KEY_O = 111
KEY_P = 112
KEY_Q = 113
KEY_R = 114
KEY_S = 115
KEY_T = 116
KEY_U = 117
KEY_V = 118
KEY_W = 119
KEY_X = 120
KEY_Y = 121
KEY_Z = 122
KEY_F1 = 282
KEY_F2 = 283
KEY_F3 = 284
KEY_F4 = 285
KEY_F5 = 286
KEY_F6 = 287
KEY_F7 = 288
KEY_F8 = 289
KEY_F9 = 290
KEY_F10 = 291
KEY_F11 = 292
KEY_F12 = 293

KEY_UP			= 273
KEY_DOWN		= 274
KEY_RIGHT		= 275
KEY_LEFT		= 276
KEY_PAGEUP		= 280
KEY_PAGEDOWN	= 281

KEY_0 = 48
KEY_1 = 49
KEY_2 = 50
KEY_3 = 51
KEY_4 = 52
KEY_5 = 53
KEY_6 = 54
KEY_7 = 55
KEY_8 = 56
KEY_9 = 57

-- DO NOT use these for gameplay!
MOUSEBUTTON_LEFT = 1000
MOUSEBUTTON_RIGHT = 1001
MOUSEBUTTON_MIDDLE = 1002
MOUSEBUTTON_SCROLLUP = 1003
MOUSEBUTTON_SCROLLDOWN = 1004


GESTURE_ZOOM_IN = 900
GESTURE_ZOOM_OUT = 901
GESTURE_ROTATE_LEFT = 902
GESTURE_ROTATE_RIGHT = 903
GESTURE_MAX = 904


CHARACTERLIST =
{
	'wilson', 'willow', 'wolfgang', 'wendy', 'wx78', 'wickerbottom', 'woodie', 'wes', 'waxwell',
}

MODCHARACTERLIST = 
{
	-- this gets populated by mods
}

EQUIPSLOTS=
{
    HANDS = "hands",
    HEAD = "head",
    BODY = "body",
}


ITEMTAG=
{
    FOOD = "food",
    MEAT = "meat",
    WEAPON = "weapon",
    TOOL = "tool",
    TREASURE = "treasure",
    FUEL = "fuel",
    FIRE = "fire",
    STACKABLE = "stackable",
    FX = "FX",
}




-- See map_painter.h
GROUND =
{
	INVALID = -1,
    IMPASSABLE = 1,
    
    ROAD = 2,
    ROCKY = 3,
    DIRT = 4,
	SAVANNA = 5,
	GRASS = 6,
	FOREST = 7,
	MARSH = 8,
	WEB = 9,
	WOODFLOOR = 10,
	CARPET = 11,
	CHECKER = 12,

	-- CAVES
	CAVE = 13,
	FUNGUS = 14,
	SINKHOLE = 15,
    UNDERROCK = 16,
    MUD = 17,
    BRICK = 18,
    BRICK_GLOW = 19,
    TILES = 20,
    TILES_GLOW = 21,
    TRIM = 22,
    TRIM_GLOW = 23,

    -- Noise
	ABYSS_NOISE = 124,
	GROUND_NOISE = 125,
	CAVE_NOISE = 126,
	FUNGUS_NOISE = 127,

	UNDERGROUND = 128,
	
	WALL_ROCKY = 151,
	WALL_DIRT = 152,
	WALL_MARSH = 153,
	WALL_CAVE = 154,
	WALL_FUNGUS = 155,
	WALL_SINKHOLE = 156,
	WALL_MUD = 157,
	WALL_TOP = 158,
	WALL_WOOD = 159,
	WALL_HUNESTONE = 160,
	WALL_HUNESTONE_GLOW = 161,
	WALL_STONEEYE = 162,
	WALL_STONEEYE_GLOW = 163,

--	STILL_WATER_SHALLOW = 130,
--	STILL_WATER_DEEP = 131,
--	MOVING_WATER_SHALLOW = 132,
--	MOVING_WATER_DEEP = 133,
--	SALT_WATER_SHALLOW = 134,
--	SALT_WATER_DEEP = 135,
}

TECH = {
	NONE = { SCIENCE = 0, MAGIC = 0, ANCIENT = 0 },
	SCIENCE_ONE = {SCIENCE = 1},
	SCIENCE_TWO = {SCIENCE = 2},
	SCIENCE_THREE = {SCIENCE = 3},
	-- Magic starts at level 2 so it's not teased from the start.
	MAGIC_TWO = {MAGIC = 2},
	MAGIC_THREE = {MAGIC = 3},
	ANCIENT_TWO = {ANCIENT = 2},
	ANCIENT_THREE = {ANCIENT = 3},
}

-- See cell_data.h
NODE_TYPE =
{
	Default = 0, 
	Blank = 1, 
	Background = 2, 
	Random = 3, 
	Blocker = 4, 
	Room = 5,
}

-- See cell_data.h
NODE_INTERNAL_CONNECTION_TYPE =
{
	EdgeCentroid = 0, 
	EdgeSite = 1, 
	EdgeEdgeDirect = 2, 
	EdgeEdgeLeft = 3, 
	EdgeEdgeRight = 4, 
	EdgeData = 5,
}

CA_SEED_MODE =
{
	SEED_RANDOM = 0,
	SEED_CENTROID = 1,
	SEED_SITE = 2,
	SEED_WALLS = 3
}

-- See maze.h
MAZE_TYPE =
{
	MAZE_DFS_4WAY_META = 0,
	MAZE_DFS_4WAY = 1,
	MAZE_DFS_8WAY = 2,
	MAZE_GROWINGTREE_4WAY = 3,
	MAZE_GROWINGTREE_8WAY = 4,
	MAZE_GROWINGTREE_4WAY_INV = 5,
}

-- NORTH	1
-- EAST		2
-- SOUTH	4
-- WEST		8
--[[
Meta maze def:
5 room types:
4 way,	3 way,	2 way,	1 way,	L shape
	1,		4,		2,		4,		4
	15 tiles needed
--]]

MAZE_CELL_EXITS =
{
	NO_EXITS = 		0, -- Dont place a cell here.
	SINGLE_NORTH = 	1,
	SINGLE_EAST = 	2,
	L_NORTH = 		3,
	SINGLE_SOUTH = 	4,
	TUNNEL_NS = 	5,
	L_EAST = 		6,
	THREE_WAY_N = 	7,
	SINGLE_WEST = 	8,
	L_WEST = 		9,
	TUNNEL_EW =		10,
	THREE_WAY_W = 	11,
	L_SOUTH = 		12,
	THREE_WAY_S = 	13,
	THREE_WAY_E = 	14,
	FOUR_WAY = 		15,
}

MAZE_CELL_EXITS_INV =
{
	"SINGLE_NORTH",
	"SINGLE_EAST",
	"L_NORTH",
	"SINGLE_SOUTH",
	"TUNNEL_NS",
	"L_EAST",
	"THREE_WAY_N",
	"SINGLE_WEST",
	"L_WEST",
	"TUNNEL_EW",
	"THREE_WAY_W",
	"L_SOUTH" ,
	"THREE_WAY_S",
	"THREE_WAY_E",
	"FOUR_WAY",
}

LAYOUT =
{
	STATIC = 0,
	CIRCLE_EDGE = 1,
	CIRCLE_RANDOM = 2,
	GRID = 3,
	RECTANGLE_EDGE = 4,
	CIRCLE_FILLED = 5,
}

LAYOUT_POSITION =
{
	RANDOM = 0,
	CENTER = 1,
}

LAYOUT_ROTATION =
{
	NORTH = 0, 	-- 0 Degrees
	EAST = 1, 	-- 90 Degrees
	SOUTH = 2, 	-- 180 Degrees
	WEST = 3, 	-- 270 Degrees
}

PLACE_MASK = 
{
	NORMAL = 0,
	IGNORE_IMPASSABLE = 1,
	IGNORE_BARREN = 2,
	IGNORE_IMPASSABLE_BARREN = 3,
	IGNORE_RESERVED = 4,
	IGNORE_IMPASSABLE_RESERVED = 5,
	IGNORE_BARREN_RESERVED = 6,
	IGNORE_IMPASSABLE_BARREN_RESERVED = 7,
}

COLLISION =
{
    GROUND = 32, -- See BpWorld.cpp (ground and cave walls)
    LIMITS = 64, -- See BpWorld.cpp (ocean walls)
    WORLD = 96,
    ITEMS = 128,
    OBSTACLES = 256,
    CHARACTERS = 512,
    FLYERS = 1024,
    SANITY = 2048,
}

BLENDMODE =
{
	Disabled = 0,
	AlphaBlended = 1,
	Additive = 2,
	Premultiplied = 3,
	InverseAlpha = 4,
}

ANIM_ORIENTATION =
{
	Default = 0,
	OnGround = 1,
}


RECIPETABS=
{
    TOOLS = {str = STRINGS.TABS.TOOLS, sort=0, icon = "tab_tool.tex"},
    LIGHT = {str = STRINGS.TABS.LIGHT, sort=1, icon = "tab_light.tex"},
    SURVIVAL = {str = STRINGS.TABS.SURVIVAL, sort=2, icon = "tab_trap.tex"},
    FARM = {str = STRINGS.TABS.FARM, sort=3, icon = "tab_farm.tex"},
    SCIENCE = {str = STRINGS.TABS.SCIENCE, sort=4, icon = "tab_science.tex"},
    WAR = {str = STRINGS.TABS.WAR, sort=5, icon = "tab_fight.tex"},
    TOWN = {str = STRINGS.TABS.TOWN, sort=6, icon = "tab_build.tex"},
    REFINE = {str = STRINGS.TABS.REFINE, sort=7, icon = "tab_refine.tex"},
    MAGIC = {str = STRINGS.TABS.MAGIC, sort=8, icon = "tab_arcane.tex"},
    DRESS = {str = STRINGS.TABS.DRESS, sort=9, icon = "tab_dress.tex"},
    GEMOLOGY = {str = STRINGS.TABS.GEMOLOGY, sort = 10, icon = "tab_gemology.tex"},
}


VERBOSITY =
{
	ERROR = 0,
	WARNING = 1,
	INFO = 2,
	DEBUG = 3,
}

RENDERPASS =
{
	Z = 0,
	BLOOM = 1,
	DEFAULT = 2,
}

NUM_TRINKETS = 12

SEASONS =
{
	SUMMER = "summer",
	WINTER = "winter",
	CAVES = "caves",
}

RENDER_QUALITY = 
{
	LOW = 0,
	DEFAULT = 1,
	HIGH = 2,
}

CREATURE_SIZE =
{
	SMALL = 0,
	MEDIUM = 1,
	LARGE = 2,
}

ROAD_PARAMETERS =
{
	NUM_SUBDIVISIONS_PER_SEGMENT = 50,
	MIN_WIDTH = 2,
	MAX_WIDTH = 3,
	MIN_EDGE_WIDTH = 0.5,
	MAX_EDGE_WIDTH = 1,
	WIDTH_JITTER_SCALE=1,
}

BGCOLOURS =
{
	RED = {255/255, 89/255, 46/255},
	PURPLE = {202/255, 48/255, 209/255},
	YELLOW = {255/255, 196/255, 45/255},
}

ROAD_STRIPS = 
{
	CORNERS = 0,
	ENDS = 1,
	EDGES = 2,
	CENTER = 3,
}

WRAP_MODE = 
{
	WRAP = 0,
	CLAMP = 1,
	MIRROR = 2,
	CLAMP_TO_EDGE = 3,
}

RESET_ACTION =
{
	LOAD_FRONTEND = 0,
	LOAD_SLOT = 1,
	DO_DEMO = 2,
}
