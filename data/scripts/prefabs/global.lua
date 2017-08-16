local assets =
{
	Asset("PKGREF", "data/sound/dontstarve.fev"),

    Asset("SOUND", "data/sound/sfx.fsb"),
	Asset("SOUND", "data/sound/music.fsb"),
	
    Asset("IMAGE", "data/images/square.tex"),
	Asset("IMAGE", "data/images/circle.tex"),
	Asset("IMAGE", "data/images/shadow.tex"),
    Asset("ANIM", "data/anim/button.zip"),
    Asset("ANIM", "data/anim/button_small.zip"),
    Asset("ANIM", "data/anim/button_long.zip"),


	Asset("SHADER", "data/shaders/anim_bloom.ksh"),
	Asset("SHADER", "data/shaders/wall_bloom.ksh"),
	Asset("SHADER", "data/shaders/road.ksh"),
	Asset("IMAGE", "data/images/square.tex"),
	Asset("IMAGE", "data/images/roadedge.tex"),
	Asset("IMAGE", "data/images/roadcorner.tex"),
	Asset("IMAGE", "data/images/roadendcap.tex"),
	Asset("IMAGE", "data/images/roadnoise.tex"),
	Asset("IMAGE", "data/images/pathnoise.tex"),
	Asset("IMAGE", "data/images/erosion.tex"),
	Asset("IMAGE", "data/images/colour_cubes/identity_colourcube.tex"),

	Asset("SHADER", "data/shaders/anim.ksh"),
	Asset("SHADER", "data/shaders/anim_bloom.ksh"),
	Asset("SHADER", "data/shaders/blurh.ksh"),
	Asset("SHADER", "data/shaders/blurv.ksh"),
	Asset("SHADER", "data/shaders/creep.ksh"),
	Asset("SHADER", "data/shaders/debug_line.ksh"),
	Asset("SHADER", "data/shaders/debug_tri.ksh"),
	Asset("SHADER", "data/shaders/font.ksh"),
	Asset("SHADER", "data/shaders/ground.ksh"),
    Asset("SHADER", "data/shaders/ceiling.ksh"),
    Asset("SHADER", "data/shaders/triplanar.ksh"),
	Asset("SHADER", "data/shaders/lighting.ksh"),
	Asset("SHADER", "data/shaders/minimap.ksh"),
	Asset("SHADER", "data/shaders/minimapfs.ksh"),
	Asset("SHADER", "data/shaders/particle.ksh"),
	Asset("SHADER", "data/shaders/road.ksh"),
	Asset("SHADER", "data/shaders/splat.ksh"),
	Asset("SHADER", "data/shaders/texture.ksh"),
	Asset("SHADER", "data/shaders/ui.ksh"),
	Asset("SHADER", "data/shaders/ui_anim.ksh"),
	Asset("SHADER", "data/shaders/postprocess.ksh"),
	Asset("SHADER", "data/shaders/postprocessbloom.ksh"),
	Asset("SHADER", "data/shaders/postprocessdistort.ksh"),
	Asset("SHADER", "data/shaders/postprocessbloomdistort.ksh"),


    --common UI elements that we will always need

    --background
    Asset("IMAGE", "data/images/bg_plain.tex"),

    --buttons
    Asset("IMAGE", "data/images/button.tex"),
    Asset("IMAGE", "data/images/button_over.tex"),
    Asset("IMAGE", "data/images/button_disabled.tex"),
    Asset("IMAGE", "data/images/button_small.tex"),
    Asset("IMAGE", "data/images/button_small_over.tex"),
    Asset("IMAGE", "data/images/button_small_disabled.tex"),

    --spinners
    Asset("IMAGE", "data/images/spin_arrow.tex"),
    Asset("IMAGE", "data/images/spin_arrow_over.tex"),
    Asset("IMAGE", "data/images/spin_arrow_disabled.tex"),
    Asset("IMAGE", "data/images/spinner.tex"),

    --oft-used panel bgs
    Asset("IMAGE", "data/images/panel.tex"),
    Asset("IMAGE", "data/images/panel_upsell.tex"),
    Asset("IMAGE", "data/images/small_dialog.tex"),
    Asset("IMAGE", "data/images/panel_upsell_small.tex"),

    --text input box
    Asset("IMAGE", "data/images/textbox_long.tex"),
    Asset("IMAGE", "data/images/textbox_long_over.tex"),
    Asset("IMAGE", "data/images/textbox_short.tex"),
    Asset("IMAGE", "data/images/textbox_short_over.tex"),

	--character portraits
    Asset("IMAGE", "data/images/saveslot_portraits/background.tex"),   
    Asset("IMAGE", "data/images/saveslot_portraits/webber.tex"),   
    Asset("IMAGE", "data/images/saveslot_portraits/wendy.tex"),   
    Asset("IMAGE", "data/images/saveslot_portraits/wes.tex"),   
    Asset("IMAGE", "data/images/saveslot_portraits/wickerbottom.tex"),   
    Asset("IMAGE", "data/images/saveslot_portraits/willow.tex"),   
    Asset("IMAGE", "data/images/saveslot_portraits/wilson.tex"),   
    Asset("IMAGE", "data/images/saveslot_portraits/wilton.tex"),   
    Asset("IMAGE", "data/images/saveslot_portraits/winnie.tex"),   
    Asset("IMAGE", "data/images/saveslot_portraits/woodie.tex"),   
    Asset("IMAGE", "data/images/saveslot_portraits/wortox.tex"),   
    Asset("IMAGE", "data/images/saveslot_portraits/wolfgang.tex"),     
    Asset("IMAGE", "data/images/saveslot_portraits/wx78.tex"),     
    Asset("IMAGE", "data/images/saveslot_portraits/waxwell.tex"),     
}


require "fonts"
for i, font in ipairs( FONTS ) do
	table.insert( assets, Asset( "FONT", font.filename ) )
end

local function fn(Sim)
    return nil
end

return Prefab( "common/global", fn, assets ) 

