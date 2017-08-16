require "fonthelper"



local function OnSane(inst)
	print ("SANE!")
end

local function OnInsane(inst)
	inst.SoundEmitter:PlaySound("dontstarve/sanity/gonecrazy_stinger")
end

local function MakePlayerCharacter(name, font, customprefabs, customassets, customfn)

    local assets =
    {
        Asset("ANIM", "data/anim/player_basic.zip"),
        Asset("ANIM", "data/anim/player_idles_shiver.zip"),
        Asset("ANIM", "data/anim/player_actions.zip"),
        Asset("ANIM", "data/anim/player_actions_axe.zip"),
        Asset("ANIM", "data/anim/player_actions_pickaxe.zip"),
        Asset("ANIM", "data/anim/player_actions_shovel.zip"),
        Asset("ANIM", "data/anim/player_actions_blowdart.zip"),
        Asset("ANIM", "data/anim/player_actions_eat.zip"),
        Asset("ANIM", "data/anim/player_actions_item.zip"),
        Asset("ANIM", "data/anim/player_actions_uniqueitem.zip"),
        Asset("ANIM", "data/anim/player_actions_bugnet.zip"),
        Asset("ANIM", "data/anim/player_actions_fishing.zip"),
        Asset("ANIM", "data/anim/player_actions_boomerang.zip"),
        Asset("ANIM", "data/anim/player_bush_hat.zip"),
        Asset("ANIM", "data/anim/player_attacks.zip"),
        Asset("ANIM", "data/anim/player_idles.zip"),
        Asset("ANIM", "data/anim/player_rebirth.zip"),
        Asset("ANIM", "data/anim/player_jump.zip"),
        Asset("ANIM", "data/anim/player_amulet_resurrect.zip"),
		Asset("ANIM", "data/anim/player_teleport.zip"),
        Asset("ANIM", "data/anim/wilson_fx.zip"),
        Asset("ANIM", "data/anim/player_one_man_band.zip"),
        

		Asset("ANIM", "data/anim/shadow_hands.zip"),

        Asset("SOUND", "data/sound/sfx.fsb"),
        Asset("SOUND", "data/sound/wilson.fsb"),
    }

    local FONTS = 
    {
        { filename = font or "data/fonts/opensans50.zip", alias = DIALOGFONT },
    }

    AddFontAssets( assets, FONTS )

    local prefabs =
    {
        "beardhair",
        "brokentool",
        "abigail",
        "gridplacer",
        "terrorbeak",
        "crawlinghorror",
        "creepyeyes",
        "shadowskittish",
        "shadowwatcher",
        "shadowhand",
		"frostbreath",
    }
    
    if customprefabs then
        for k,v in ipairs(customprefabs) do
            table.insert(prefabs, v)
        end
    end
    
    if customassets then
        for k,v in ipairs(customassets) do
            table.insert(assets, v)
        end
    end

    local fn = function(Sim)  

        local inst = CreateEntity()
        inst.entity:SetCanSleep(false)
        
        local trans = inst.entity:AddTransform()
        local anim = inst.entity:AddAnimState()
        local sound = inst.entity:AddSoundEmitter()
        local shadow = inst.entity:AddDynamicShadow()
        local minimap = inst.entity:AddMiniMapEntity()

        inst.Transform:SetFourFaced()
        
        inst.persists = false --handled in a special way
        
        MakeCharacterPhysics(inst, 75, .5)

        shadow:SetSize( 1.3, .6 )
        
        minimap:SetIcon( name .. ".png" )
        minimap:SetPriority( 10 )
        
        local lightwatch = inst.entity:AddLightWatcher()
        lightwatch:SetLightThresh(.2)
        lightwatch:SetDarkThresh(.05)
        inst.entity:AddLabel()

        inst.Label:SetFontSize(25)
        inst.Label:SetFont(DIALOGFONT)
        inst.Label:SetPos(0,3,0)
        inst.Label:Enable(false)
        
        inst:AddTag("player")
        inst:AddTag("scarytoprey")
        inst:AddTag("character")

        anim:SetBank("wilson")
        anim:SetBuild(name)
        anim:PlayAnimation("idle")
        
        anim:Hide("ARM_carry")
        anim:Hide("hat")
        anim:Hide("hat_hair")
        anim:OverrideSymbol("fx_wipe", "wilson_fx", "fx_wipe")
        anim:OverrideSymbol("fx_liquid", "wilson_fx", "fx_liquid")
		anim:OverrideSymbol("shadow_hands", "shadow_hands", "shadow_hands")
		
        inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
        inst.components.locomotor:SetSlowMultiplier( 0.6 )
        inst.components.locomotor.pathcaps = { player = true, ignorecreep = true } -- 'player' cap not actually used, just useful for testing
        inst.components.locomotor.fasteronroad = true

        inst:AddComponent("combat")
        inst.components.combat:SetDefaultDamage(TUNING.UNARMED_DAMAGE)

        inst:AddComponent("inventory")
        
        inst:AddComponent("dynamicmusic")
        inst:AddComponent("playercontroller")
        
        inst:AddComponent("sanitymonsterspawner")
        ------
        
        inst:AddComponent("health")
        inst.components.health:SetMaxHealth(TUNING.WILSON_HEALTH)
        inst.components.health.nofadeout = true
        -------
        
        inst:AddComponent("hunger")
        inst.components.hunger:SetMax(TUNING.WILSON_HUNGER)
        inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
        inst.components.hunger:SetKillRate(TUNING.WILSON_HEALTH/TUNING.STARVE_KILL_TIME)

        
        inst:AddComponent("sanity")
        inst.components.sanity:SetMax(TUNING.WILSON_SANITY)
        inst.components.sanity.onSane = OnSane
        inst.components.sanity.onInsane = OnInsane
        
        -------
        
        inst:AddComponent("hounded")
        inst:AddComponent("basehassler")
        inst:AddComponent("kramped")
        inst:AddComponent("hunter")
        inst:AddComponent("talker")
        inst:AddComponent("trader")
        inst:AddComponent("wisecracker")
        inst:AddComponent("distancetracker")
        inst:AddComponent("resurrectable")
        
        inst:AddComponent("temperature")
        
        inst:AddComponent("catcher")
        
        -------

        inst:AddComponent("builder")
        
        --give the default recipes
        for k,v in pairs(Recipes) do
            if v.level == 0 then
				inst.components.builder:AddRecipe(v.name)
			end
        end
        
        inst:AddComponent("eater")
        inst:AddComponent("playeractionpicker")
        inst:AddComponent("leader")
		inst:AddComponent("frostybreather")
        
        inst:AddComponent("grue")
        inst.components.grue:SetSounds("dontstarve/charlie/warn","dontstarve/charlie/attack")

        inst.components.combat:SetAttackPeriod(TUNING.WILSON_ATTACK_PERIOD)
        inst.components.combat:SetRange(2)

        function inst.components.combat:GetBattleCryString(target)
            --print("GetBattleCryString", inst.prefab, target.prefab)
            if target:HasTag("prey") then -- generic for little animals: frog, rabbit
                --print("   prey")
                return GetString(inst.prefab, "BATTLECRY", "PREY") 
            else
                return GetString(inst.prefab, "BATTLECRY", target.prefab)
            end            
        end
        
        local brain = require "brains/wilsonbrain"
        inst:SetBrain(brain)
        
        inst:AddInherentAction(ACTIONS.PICK)
        inst:AddInherentAction(ACTIONS.SLEEPIN)



        inst:SetStateGraph("SGwilson")

        inst:ListenForEvent( "startfiredamage", function(it, data) 
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/burned")
                    inst.SoundEmitter:PlaySound("dontstarve/common/campfire", "burning")
                    inst.SoundEmitter:SetParameter("burning", "intensity", 1)
            end)  

        inst:ListenForEvent( "stopfiredamage", function(it, data) 
                    inst.SoundEmitter:KillSound("burning")
            end)  

        inst:ListenForEvent( "containergotitem", function(it, data) 
				inst.SoundEmitter:PlaySound("dontstarve/HUD/collect_resource")
            end)  
        
        inst:ListenForEvent( "gotnewitem", function(it, data) 
                if data.slot then
                	Print(VERBOSITY.DEBUG, "gotnewitem: ["..data.item.prefab.."]") 
                    inst.SoundEmitter:PlaySound("dontstarve/HUD/collect_resource")
                end
            end)  
        
        inst:ListenForEvent( "equip", function(it, data) 
				Print(VERBOSITY.DEBUG, "equip: ["..data.item.prefab.."]")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item")
            end)  
        
        inst:ListenForEvent( "picksomething", function(it, data) 
                if data.object and data.object.components.pickable and data.object.components.pickable.picksound then
					Print(VERBOSITY.DEBUG, "picksomething: ["..data.object.prefab.."]")    -- BTW why is this one 'object'?           
					inst.SoundEmitter:PlaySound(data.object.components.pickable.picksound)			
                end
            end)  

        inst:ListenForEvent( "dropitem", function(it, data) 
			Print(VERBOSITY.DEBUG, "dropitem: ["..data.item.prefab.."]")              
            inst.SoundEmitter:PlaySound("dontstarve/common/dropGeneric")
            end)  

        inst:ListenForEvent( "builditem", function(it, data) 
			Print(VERBOSITY.DEBUG, "builditem: ["..data.item.prefab.."]")        
            inst.SoundEmitter:PlaySound("dontstarve/HUD/collect_newitem")
            end)  

        inst:ListenForEvent( "buildstructure", function(it, data) 
			Print(VERBOSITY.DEBUG, "buildstructure: ["..data.item.prefab.."]")              
            inst.SoundEmitter:PlaySound("dontstarve/HUD/collect_newitem")
            end)  
            
        --set up the UI root entity
        --HUD:SetMainCharacter(inst)
        
        inst:ListenForEvent("actionfailed", function(it, data)
            inst.components.talker:Say(GetActionFailString(inst.prefab, data.action.action.id, data.reason))
        end)

        if customfn then
            customfn(inst)
        end
        
        return inst
    end
    
    return Prefab( "characters/"..name, fn, assets, prefabs)
end


return MakePlayerCharacter
