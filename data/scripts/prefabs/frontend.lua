local assets =
{
  --FE

    Asset("ANIM", "data/anim/credits.zip"),
    Asset("IMAGE", "data/images/klei_new_logo.tex"),   
    Asset("IMAGE", "data/images/bg_purple.tex"),
    Asset("IMAGE", "data/images/bg_yellow.tex"),
    Asset("IMAGE", "data/images/panel_shield.tex"),
    Asset("IMAGE", "data/images/biobox.tex"),

    Asset("IMAGE", "data/images/nondefault_customization.tex"),
    Asset("IMAGE", "data/images/presetbox.tex"),
    Asset("IMAGE", "data/images/panel_customization.tex"),
    Asset("IMAGE", "data/images/panel_allblack.tex"),
    Asset("IMAGE", "data/images/panel_saveslots.tex"),
    Asset("IMAGE", "data/images/special_button.tex"),
    Asset("IMAGE", "data/images/special_button_over.tex"),
    
    
    Asset("IMAGE", "data/bigportraits/wendy.tex"),
    Asset("IMAGE", "data/bigportraits/willow.tex"),
    Asset("IMAGE", "data/bigportraits/locked.tex"),
    Asset("IMAGE", "data/bigportraits/wes.tex"),
    Asset("IMAGE", "data/bigportraits/wilson.tex"),
    Asset("IMAGE", "data/bigportraits/wolfgang.tex"),
    Asset("IMAGE", "data/bigportraits/wickerbottom.tex"),
    Asset("IMAGE", "data/bigportraits/wx78.tex"),
    Asset("IMAGE", "data/bigportraits/waxwell.tex"),

    Asset("ANIM", "data/anim/portrait_frame_characters.zip"),
    Asset("ANIM", "data/anim/portrait_frame_silhouettes.zip"),
    Asset("ANIM", "data/anim/portrait_frame.zip"),
    Asset("ANIM", "data/anim/scroll_arrow.zip"),

    Asset("ANIM", "data/anim/generating_world.zip"),
    Asset("ANIM", "data/anim/generating_cave.zip"),
    Asset("ANIM", "data/anim/creepy_hands.zip"),

    Asset("ANIM", "data/anim/build_status.zip"),

    Asset("ANIM", "data/anim/panel_saveslots.zip"),
    Asset("ANIM", "data/anim/savetile.zip"),
    


    Asset("IMAGE", "data/images/arrow_left.tex"),
    Asset("IMAGE", "data/images/arrow_right.tex"),
    Asset("IMAGE", "data/images/arrow_right_disabled.tex"),
    Asset("IMAGE", "data/images/arrow_right_over.tex"),
    Asset("IMAGE", "data/images/next_arrow.tex"),

    Asset("IMAGE", "data/images/customisation/angry_bees.tex"),
    Asset("IMAGE", "data/images/customisation/spiders.tex"),
    Asset("IMAGE", "data/images/customisation/tentacles.tex"),
    Asset("IMAGE", "data/images/customisation/tallbirds.tex"),
    Asset("IMAGE", "data/images/customisation/hounds.tex"),
    Asset("IMAGE", "data/images/customisation/liefs.tex"),
    Asset("IMAGE", "data/images/customisation/deerclops.tex"),
    Asset("IMAGE", "data/images/customisation/mactusk.tex"),
    Asset("IMAGE", "data/images/customisation/pigs.tex"),
    Asset("IMAGE", "data/images/customisation/rabbits.tex"),
    Asset("IMAGE", "data/images/customisation/beefalo.tex"),
    Asset("IMAGE", "data/images/customisation/beefaloheat.tex"),
    Asset("IMAGE", "data/images/customisation/frogs.tex"),
    Asset("IMAGE", "data/images/customisation/bees.tex"),
    Asset("IMAGE", "data/images/customisation/grass.tex"),
    Asset("IMAGE", "data/images/customisation/rock.tex"),
    Asset("IMAGE", "data/images/customisation/sapling.tex"),
    Asset("IMAGE", "data/images/customisation/reeds.tex"),
    Asset("IMAGE", "data/images/customisation/trees.tex"),
    Asset("IMAGE", "data/images/customisation/carrot.tex"),
    Asset("IMAGE", "data/images/customisation/carrot_never.tex"),
    Asset("IMAGE", "data/images/customisation/carrot_rare.tex"),
    Asset("IMAGE", "data/images/customisation/carrot_default.tex"),
    Asset("IMAGE", "data/images/customisation/carrot_often.tex"),
    Asset("IMAGE", "data/images/customisation/carrot_always.tex"),
    Asset("IMAGE", "data/images/customisation/berrybush.tex"),
    Asset("IMAGE", "data/images/customisation/day.tex"),
    Asset("IMAGE", "data/images/customisation/season_start.tex"),
    Asset("IMAGE", "data/images/customisation/season_start_summer.tex"),
    Asset("IMAGE", "data/images/customisation/season_start_winter.tex"),
    Asset("IMAGE", "data/images/customisation/season.tex"),
    Asset("IMAGE", "data/images/customisation/perd.tex"),
    Asset("IMAGE", "data/images/customisation/world_size.tex"),
    Asset("IMAGE", "data/images/customisation/world_size_small.tex"),
    Asset("IMAGE", "data/images/customisation/world_size_medium.tex"),
    Asset("IMAGE", "data/images/customisation/world_size_large.tex"),
    Asset("IMAGE", "data/images/customisation/world_size_huge.tex"),
    Asset("IMAGE", "data/images/customisation/world_complexity.tex"),
    Asset("IMAGE", "data/images/customisation/world_branching.tex"),
    Asset("IMAGE", "data/images/customisation/world_loop.tex"),
    Asset("IMAGE", "data/images/customisation/rain.tex"),
    Asset("IMAGE", "data/images/customisation/lightning.tex"),
    Asset("IMAGE", "data/images/customisation/skeletons.tex"),
    Asset("IMAGE", "data/images/customisation/resurrection.tex"),

}

--we don't actually instantiate this prefab. It's used for controlling asset loading
local function fn(Sim)
    return CreateEntity()
end

return Prefab( "UI/interface/frontend", fn, assets)
