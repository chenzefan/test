local assets =
{

 --In-game only

    Asset("IMAGE", "data/images/turnarrow_icon.tex"),
    Asset("IMAGE", "data/images/turnarrow_icon_over.tex"),
    Asset("IMAGE", "data/images/map_button.tex"),
    Asset("IMAGE", "data/images/pause.tex"),
    Asset("IMAGE", "data/images/map.tex"),

    Asset("IMAGE", "data/images/clock_hand.tex"),    
    Asset("IMAGE", "data/images/clock_NIGHT.tex"),    
    Asset("IMAGE", "data/images/clock_wedge.tex"),    
    Asset("IMAGE", "data/images/clock_rim.tex"),    
    Asset("ANIM", "data/anim/clock_transitions.zip"),
    Asset("ANIM", "data/anim/moon_phases_clock.zip"),
    Asset("ANIM", "data/anim/moon_phases.zip"),

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
    Asset("IMAGE", "data/images/ice_over.tex"),
    Asset("ANIM", "data/anim/clouds_ol.zip"),   
    Asset("ANIM", "data/anim/progressbar.zip"),   
    Asset("IMAGE", "data/images/death_BG.tex"),   

    Asset("IMAGE", "data/images/equip_slot.tex"),    
    Asset("IMAGE", "data/images/equip_slot_body.tex"),    
    Asset("IMAGE", "data/images/equip_slot_head.tex"),    
    Asset("IMAGE", "data/images/inv_slot.tex"),    
    Asset("IMAGE", "data/images/inv_slot_spoiled.tex"),    
    Asset("IMAGE", "data/images/inventory_bg.tex"),


    Asset("ANIM", "data/anim/crafting_submenu.zip"),
    Asset("IMAGE", "data/images/resource_needed.tex"),   
    Asset("IMAGE", "data/images/craft_end_normal.tex"),   
    Asset("IMAGE", "data/images/craft_end_normal_mouseover.tex"),   
    Asset("IMAGE", "data/images/craft_end_normal_disabled.tex"),   
    
    Asset("IMAGE", "data/images/craft_slot.tex"),   
    Asset("IMAGE", "data/images/craft_slot_locked.tex"),   
    Asset("IMAGE", "data/images/craft_slot_locked_highlight.tex"),   
    Asset("IMAGE", "data/images/craft_slot_locked_nextlevel.tex"),   
    Asset("IMAGE", "data/images/craft_slotbg.tex"),   
    Asset("IMAGE", "data/images/craft_sep.tex"),   

    
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
}


local prefabs = {
	"minimap",
}

--we don't actually instantiate this prefab. It's used for controlling asset loading
local function fn(Sim)
    return CreateEntity()
end

return Prefab( "UI/interface/hud", fn, assets, prefabs)
