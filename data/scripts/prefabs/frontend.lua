require "fonthelper"

local FONTS = {
	{ filename = "data/fonts/stint-ucr50.zip", alias = "stint-ucr" },
	{ filename = "data/fonts/stint-ucr20.zip", alias = "stint-small" },
	{ filename = "data/fonts/opensans50.zip", alias = "opensans" },
	{ filename = "data/fonts/belisaplumilla50.zip", alias = "bp50" },
	{ filename = "data/fonts/belisaplumilla100.zip", alias = "bp100" },	
}

local assets =
{
    Asset("SOUND", "data/sound/sfx.fsb"),
    Asset("IMAGE", "data/images/map.tex"),
    Asset("IMAGE", "data/images/square.tex"),
    Asset("IMAGE", "data/images/bg_red.tex"),
    Asset("IMAGE", "data/images/panel_shield.tex"),
    Asset("IMAGE", "data/images/biobox.tex"),
    Asset("IMAGE", "data/images/button.tex"),
    Asset("IMAGE", "data/images/button_over.tex"),
    Asset("IMAGE", "data/images/button_disabled.tex"),
    Asset("IMAGE", "data/images/inventory_bg.tex"),
    
    Asset("IMAGE", "data/images/button_small.tex"),
    Asset("IMAGE", "data/images/button_small_over.tex"),
    Asset("IMAGE", "data/images/button_small_disabled.tex"),
    
    Asset("IMAGE", "data/images/exit.tex"),
    Asset("IMAGE", "data/images/exit_over.tex"),
    Asset("IMAGE", "data/images/demo.tex"),
    
    Asset("IMAGE", "data/images/special_button.tex"),
    Asset("IMAGE", "data/images/special_button_over.tex"),
    
    Asset("IMAGE", "data/images/spin_arrow.tex"),
    Asset("IMAGE", "data/images/spin_arrow_over.tex"),
    Asset("IMAGE", "data/images/spin_arrow_disabled.tex"),
    Asset("IMAGE", "data/images/spinner.tex"),
    Asset("IMAGE", "data/images/panel.tex"),
    Asset("IMAGE", "data/bigportraits/wendy.tex"),
    Asset("IMAGE", "data/bigportraits/willow.tex"),
    Asset("IMAGE", "data/bigportraits/locked.tex"),
    Asset("IMAGE", "data/bigportraits/wes.tex"),
    Asset("IMAGE", "data/bigportraits/wilson.tex"),
    Asset("IMAGE", "data/bigportraits/wolfgang.tex"),
    Asset("IMAGE", "data/bigportraits/wickerbottom.tex"),
    Asset("IMAGE", "data/bigportraits/wx78.tex"),
    
    Asset("IMAGE", "data/portraits/wallace.tex"),   
    Asset("IMAGE", "data/portraits/waverly.tex"),   
    Asset("IMAGE", "data/portraits/webber.tex"),   
    Asset("IMAGE", "data/portraits/wendy.tex"),   
    Asset("IMAGE", "data/portraits/wes.tex"),   
    Asset("IMAGE", "data/portraits/wickerbottom.tex"),   
    Asset("IMAGE", "data/portraits/wilbur.tex"),   
    Asset("IMAGE", "data/portraits/willow.tex"),   
    Asset("IMAGE", "data/portraits/wilson.tex"),   
    Asset("IMAGE", "data/portraits/wilton.tex"),   
    Asset("IMAGE", "data/portraits/winnie.tex"),   
    Asset("IMAGE", "data/portraits/woodie.tex"),   
    Asset("IMAGE", "data/portraits/wortox.tex"),   
    Asset("IMAGE", "data/portraits/wolfgang.tex"),     
    Asset("IMAGE", "data/portraits/wx78.tex"),     
    Asset("IMAGE", "data/portraits/locked.tex"),     
    
    
    Asset("IMAGE", "data/images/small_dialog.tex"),
    Asset("ANIM", "data/anim/arrow_button.zip"),
    Asset("ANIM", "data/anim/portrait_frame.zip"),
    Asset("ANIM", "data/anim/scroll_arrow.zip"),
    Asset("ANIM", "data/anim/generating_world.zip"),
    Asset("ANIM", "data/anim/creepy_hands.zip"),
    Asset("ANIM", "data/anim/button.zip"),
    Asset("ANIM", "data/anim/button_small.zip"),
    Asset("ANIM", "data/anim/build_status.zip"),
    Asset("ANIM", "data/anim/panel_saveslots.zip"),
    Asset("ANIM", "data/anim/savetile.zip"),
    
	Asset("IMAGE", "data/images/map_button.tex"),
	Asset("IMAGE", "data/images/pause.tex"),
    
    Asset("IMAGE", "data/images/portrait_bg.tex"),    
    Asset("IMAGE", "data/images/clock_hand.tex"),    
    Asset("IMAGE", "data/images/clock_NIGHT.tex"),    
    Asset("IMAGE", "data/images/clock_wedge.tex"),    
    Asset("IMAGE", "data/images/clock_rim.tex"),    
    Asset("IMAGE", "data/images/researchpoints.tex"),    
    Asset("ANIM", "data/anim/clock_transitions.zip"),
    Asset("ANIM", "data/anim/moon_phases_clock.zip"),
    Asset("ANIM", "data/anim/moon_phases.zip"),
    Asset("ANIM", "data/anim/crafting_submenu.zip"),
    
    Asset("ANIM", "data/anim/ui_chest_3x3.zip"),
    Asset("ANIM", "data/anim/ui_backpack_2x4.zip"),
    Asset("ANIM", "data/anim/ui_piggyback_2x6.zip"),
    Asset("ANIM", "data/anim/ui_krampusbag_2x8.zip"),
	Asset("ANIM", "data/anim/ui_cookpot_1x4.zip"), 
	Asset("ANIM", "data/anim/ui_krampusbag_2x5.zip"),
    Asset("ANIM", "data/anim/health.zip"),
    Asset("ANIM", "data/anim/sanity.zip"),
    Asset("ANIM", "data/anim/sanity_arrow.zip"),
    Asset("ANIM", "data/anim/effigy_topper.zip"),
    Asset("ANIM", "data/anim/hunger.zip"),
    Asset("ANIM", "data/anim/hunger_health_pulse.zip"),
    Asset("ANIM", "data/anim/spoiled_meter.zip"),
    
    Asset("ANIM", "data/anim/saving.zip"),
    Asset("ANIM", "data/anim/vig.zip"),
    Asset("ANIM", "data/anim/blood_over.zip"),
    Asset("ANIM", "data/anim/fire_over.zip"),
    Asset("ANIM", "data/anim/ice_over.zip"),
    Asset("IMAGE", "data/images/square.tex"),    

    Asset("IMAGE", "data/images/inv_end.tex"),    
    Asset("IMAGE", "data/images/inv_divide.tex"),    
    Asset("IMAGE", "data/images/inv_sep.tex"),    
    Asset("IMAGE", "data/images/inv_slotbg.tex"),    
    Asset("IMAGE", "data/images/equip_slot.tex"),    
    Asset("IMAGE", "data/images/equip_slot_body.tex"),    
    Asset("IMAGE", "data/images/equip_slot_head.tex"),    

    Asset("IMAGE", "data/images/resource_needed.tex"),   

    Asset("IMAGE", "data/images/craft_end_normal.tex"),   
    Asset("IMAGE", "data/images/craft_end_normal_mouseover.tex"),   
    Asset("IMAGE", "data/images/craft_slot.tex"),   
    Asset("IMAGE", "data/images/craft_slot_locked.tex"),   
    Asset("IMAGE", "data/images/craft_slot_locked_highlight.tex"),   
    Asset("IMAGE", "data/images/craft_slot_locked_nextlevel.tex"),   
    Asset("IMAGE", "data/images/craft_slotbg.tex"),   
    Asset("IMAGE", "data/images/craft_sep.tex"),   

    Asset("IMAGE", "data/images/inv_slot.tex"),    
    Asset("IMAGE", "data/images/inv_slot_spoiled.tex"),    
    Asset("IMAGE", "data/images/cursor01.tex"),
    
    Asset("IMAGE", "data/images/tab_normal.tex"),
    Asset("IMAGE", "data/images/tab_selected.tex"),
    Asset("IMAGE", "data/images/tab_highlight.tex"),
    Asset("IMAGE", "data/images/tab_researchable.tex"),
    Asset("IMAGE", "data/images/craft_bg.tex"),

    Asset("IMAGE", "data/images/tab_arcane.tex"),
    Asset("IMAGE", "data/images/tab_build.tex"),
    Asset("IMAGE", "data/images/tab_dress.tex"),
    Asset("IMAGE", "data/images/tab_farm.tex"),
    Asset("IMAGE", "data/images/tab_science.tex"),
    Asset("IMAGE", "data/images/tab_fight.tex"),
    Asset("IMAGE", "data/images/tab_light.tex"),
    Asset("IMAGE", "data/images/tab_refine.tex"),
    Asset("IMAGE", "data/images/tab_tool.tex"),
    Asset("IMAGE", "data/images/tab_trap.tex"),
    
    Asset("IMAGE", "data/images/tracer.tex"),
    
    Asset("IMAGE", "data/images/inv_open_normal.tex"),   
    Asset("IMAGE", "data/images/inv_open_mouseover.tex"),   

    Asset("ANIM", "data/anim/clouds_ol.zip"),   
    
    Asset("ANIM", "data/anim/progressbar.zip"),   
    Asset("IMAGE", "data/images/death_BG.tex"),   

    Asset("IMAGE", "data/images/button.tex"),   
    Asset("IMAGE", "data/images/button_over.tex"),   
    Asset("IMAGE", "data/images/button_disabled.tex"),   

    Asset("IMAGE", "data/images/textbox_long.tex"),
    Asset("IMAGE", "data/images/textbox_long_over.tex"),
    Asset("IMAGE", "data/images/textbox_short.tex"),
    Asset("IMAGE", "data/images/textbox_short_over.tex"),
    Asset("IMAGE", "data/images/arrow_left.tex"),
    Asset("IMAGE", "data/images/arrow_right.tex"),
    Asset("IMAGE", "data/images/arrow_right_disabled.tex"),
    Asset("IMAGE", "data/images/arrow_right_over.tex"),
}

prefabs = {
	"minimap",
}

AddFontAssets( assets, FONTS )

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddSoundEmitter()
    inst:AddTag("frontend")
    return inst
end

return Prefab( "UI/interface/frontend", fn, assets, prefabs)
