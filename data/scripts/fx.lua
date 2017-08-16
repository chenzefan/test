local FX =
{
    {
	    name = "sanity_raise", 
	    bank = "blocker_sanity_fx", 
	    build = "blocker_sanity_fx", 
	    anim = "raise",
	    sound = nil,
	    sounddelay = nil,
	    tint = nil,
	    tintalpha = nil,
    },

    {
	    name = "sanity_lower", 
	    bank = "blocker_sanity_fx", 
	    build = "blocker_sanity_fx", 
	    anim = "lower",
	    sound = nil,
	    sounddelay = nil,
	    tint = nil,
	    tintalpha = nil,
    },

    {
	    name = "die_fx", 
	    bank = "die_fx", 
	    build = "die", 
	    anim = "small",
	    sound = "dontstarve/common/deathpoof",
	    sounddelay = nil,
	    tint = Vector3(90/255, 66/255, 41/255),
	    tintalpha = nil,
    },

    {
	    name = "sparks_fx", 
	    bank = "sparks", 
	    build = "sparks", 
	    anim = {"sparks_1", "sparks_2", "sparks_3"},
	    sound = nil,
	    sounddelay = nil,
	    tint = nil,
	    tintalpha = nil,
    },

    {
	    name = "explode_small", 
	    bank = "explode", 
	    build = "explode", 
	    anim = "small",
	    sound = nil,
	    sounddelay = nil,
	    tint = nil,
	    tintalpha = nil,
    },

    {
	    name = "lightning_rod_fx", 
	    bank = "lightning_rod_fx", 
	    build = "lightning_rod_fx", 
	    anim = "idle",
	    sound = nil,
	    sounddelay = nil,
	    tint = nil,
	    tintalpha = nil,
    },


    {
	    name = "splash", 
	    bank = "splash", 
	    build = "splash", 
	    anim = "splash",
	    sound = nil,
	    sounddelay = nil,
	    tint = nil,
	    tintalpha = nil,
    },

    {
	    name = "small_puff", 
	    bank = "small_puff", 
	    build = "smoke_puff_small", 
	    anim = "puff",
	    sound = "dontstarve/common/deathpoof",
	    sounddelay = nil,
	    tint = nil,
	    tintalpha = nil,
    },

    {
	    name = "splash_ocean", 
	    bank = "splash", 
	    build = "splash_ocean", 
	    anim = "idle",
	    sound = nil,
	    sounddelay = nil,
	    tint = nil,
	    tintalpha = nil,
    },

    {
	    name = "maxwell_smoke", 
	    bank = "max_fx", 
	    build = "max_fx", 
	    anim = "anim",
	    sound = nil,
	    sounddelay = nil,
	    tint = nil,
	    tintalpha = nil,
    },
    {
	    name = "pine_needles", 
	    bank = "pine_needles", 
	    build = "pine_needles", 
	    anim = {"chop", "fall"},
	    sound = nil,
	    sounddelay = nil,
	    tint = nil,
	    tintalpha = nil,
    },

    {
	    name = "dr_warm_loop_1", 
	    bank = "diviningrod_fx", 
	    build = "diviningrod_fx", 
	    anim = "warm_loop",
	    sound = nil,
	    sounddelay = nil,
	    tint = Vector3(105/255, 160/255, 255/255),
	    tintalpha = nil,
    },

    {
	    name = "dr_warm_loop_2", 
	    bank = "diviningrod_fx", 
	    build = "diviningrod_fx", 
	    anim = "warm_loop",
	    sound = nil,
	    sounddelay = nil,
	    tint = Vector3(105/255, 182/255, 239/255),
	    tintalpha = nil,
    },

    {
	    name = "dr_warmer_loop", 
	    bank = "diviningrod_fx", 
	    build = "diviningrod_fx", 
	    anim = "warmer_loop",
	    sound = nil,
	    sounddelay = nil,
	    tint = Vector3(255/255, 163/255, 26/255),
	    tintalpha = nil,
    },

    {
	    name = "dr_hot_loop", 
	    bank = "diviningrod_fx", 
	    build = "diviningrod_fx", 
	    anim = "hot_loop",
	    sound = nil,
	    sounddelay = nil,
	    tint = Vector3(181/255, 32/255, 32/255),
	    tintalpha = nil,
    },

}

return FX