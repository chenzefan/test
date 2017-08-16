local function makeassetlist()
    return {
		Asset("ANIM", "data/anim/teleportato.zip"),
    }
end

local prefabs = {
	"ash",
}


local function TransitionToNextLevel(inst, wilson)
	wilson.sg:GoToState("teleportato_teleport")

	local days_survived, start_xp, reward_xp, new_xp = CalculatePlayerRewards(wilson)
	scheduler:ExecuteInTime(110*FRAMES, function() 
		inst.AnimState:PlayAnimation("laugh", false)
		inst.AnimState:PushAnimation("active_idle", true)
		inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_maxwelllaugh", "teleportato_laugh")
		
	end)
	
	scheduler:ExecuteInTime(110*FRAMES+3, function() 
		SaveGameIndex:CompleteLevel(function() TheFrontEnd:PushScreen(DeathScreen(days_survived, start_xp, true)) end )
	end)
end

local function GetBodyText()
    if SaveGameIndex:GetCurrentMode(Settings.save_slot) == "adventure" then
        return STRINGS.UI.TELEPORTBODY_ADVENTURE
    end
    return STRINGS.UI.TELEPORTBODY_SURVIVAL
end

local function CheckNextLevelSure(inst, doer)

	TheSim:SetTimeScale(0)
	TheMixer:PushMix("pause")	
	
	TheFrontEnd:PushScreen(
		PopupDialogScreen(STRINGS.UI.TELEPORTTITLE, GetBodyText(), 
			{
				{text=STRINGS.UI.TELEPORTYES, cb = 	function() 
				
											print("Lets Go!")
											TheSim:SetTimeScale(1) 
											TheMixer:PopMix("pause") 
											scheduler:ExecuteInTime(1, function()
												TransitionToNextLevel(inst, doer)
											end)
										end},
				{text=STRINGS.UI.TELEPORTNO, cb = function() 
														print("Think I'll stay here")
														TheSim:SetTimeScale(1) 
														TheMixer:PopMix("pause") 
														inst.components.activatable.inactive = true
													  end}  
			}))
end

local function OnActivate(inst, doer)
	inst.components.activatable.inactive = false
	if not inst.activatedonce then
		inst.activatedonce = true
		inst.AnimState:PlayAnimation("activate", false)
		inst.AnimState:PushAnimation("active_idle", true)
		inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_activate", "teleportato_activate")
		inst.SoundEmitter:KillSound("teleportato_idle")
		inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_activeidle_LP", "teleportato_active_idle")

		inst:DoTaskInTime(40*FRAMES, function()
			inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_activate_mouth", "teleportato_activatemouth")
		end)

        if SaveGameIndex:GetCurrentMode(Settings.save_slot) == "adventure" then
            inst.components.container.canbeopened = true
		    inst:DoTaskInTime(2.0, function()
			    inst.components.container:Open(doer)
		    end)
		else
		    inst:DoTaskInTime(3.0, function() CheckNextLevelSure(inst, doer) end)
		end
	elseif SaveGameIndex:GetCurrentMode(Settings.save_slot) == "survival" then
		CheckNextLevelSure(inst, doer)
	end
end

local function GetStatus(inst)
	local partsCount = 0
	for part,found in pairs(inst.collectedParts) do
		if found == true then
			partsCount = partsCount + 1
		end
	end

	if partsCount == 4 then
		return "ACTIVE"
	elseif partsCount > 0 then
		return "PARTIAL"
	end
end

local function ItemTradeTest(inst, item)
	if item:HasTag("teleportato_part") then
		return true
	end
	return false
end

local function PowerUp(inst)
	inst.AnimState:PlayAnimation("power_on", false)
	inst.AnimState:PushAnimation("idle_on", true)

	inst.components.activatable.inactive = true

	inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_powerup", "teleportato_on")
	inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_idle_LP", "teleportato_idle")
end

local partSymbols = {teleportato_ring = "RING", teleportato_crank = "CRANK", teleportato_box = "BOX", teleportato_potato = "POTATO" }

local function TestForPowerUp(inst)
		local allParts = true
		for part,found in pairs(inst.collectedParts) do
			if found == false then
				inst.AnimState:Hide(partSymbols[part])
				allParts = false
			else
				inst.AnimState:Show(partSymbols[part])
			end
		end
		if allParts == true then
	        inst.components.trader:Disable()
			scheduler:ExecuteInTime(0.5, function()
				PowerUp(inst)
			end)
		end
end

local function ItemGet(inst, giver, item)
	if inst.collectedParts[item.prefab] ~= nil then
		inst.collectedParts[item.prefab] = true
		inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_addpart", "teleportato_addpart")
		TestForPowerUp(inst)
	end
end

local function OnLoad(inst, data)
	if data and data.collectedParts then
		inst.collectedParts = data.collectedParts
		TestForPowerUp(inst)
	end
end

local function OnPlayerFar(inst)
	inst.components.container:Close()
end

local slotpos = {	Vector3(0,64+32+8+4,0), 
					Vector3(0,32+4,0),
					Vector3(0,-(32+4),0), 
					Vector3(0,-(64+32+8+4),0)}

local widgetbuttoninfo = {
	text = "Activate",
	position = Vector3(0, -165, 0),
	fn = function(inst, doer) CheckNextLevelSure(inst, doer) end,
}

local function ItemTest(inst, item, slot)
	return not item:HasTag("nonpotatable")
end

local function OnSave(inst, data)
	data.collectedParts = inst.collectedParts
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

	anim:SetBank("teleporter")
	anim:SetBuild("teleportato")
	
	inst:AddTag("teleportato")
	
	anim:PlayAnimation("idle_off", true)

	MakeObstaclePhysics(inst, 1.1)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetPriority( 5 )
	minimap:SetIcon("teleportato.png")
	minimap:SetPriority( 1 )
	
	inst.entity:AddSoundEmitter()
	
	inst:AddComponent("inspectable")	
	inst.components.inspectable.getstatus = GetStatus
	
	inst:AddComponent("activatable")	
	inst.components.activatable.OnActivate = OnActivate
	inst.components.activatable.inactive = false
	inst.components.activatable.quickaction = true

    inst:AddComponent("container")
    inst.components.container.canbeopened = false
    inst.components.container.itemtestfn = ItemTest
    inst.components.container:SetNumSlots(4)
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widgetanimbank = "ui_cookpot_1x4"
    inst.components.container.widgetanimbuild = "ui_cookpot_1x4"
    inst.components.container.widgetpos = Vector3(0,0,0)
    inst.components.container.widgetbuttoninfo = widgetbuttoninfo

    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(3,5)
    inst.components.playerprox:SetOnPlayerFar(OnPlayerFar)

	inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(ItemTradeTest)
	inst.components.trader.onaccept = ItemGet

	-- The "construction" requires a list of parts to have been added
	inst.collectedParts = {teleportato_ring = false, teleportato_crank = false, teleportato_box = false, teleportato_potato = false }
	for part,symbol in pairs(partSymbols) do
		inst.AnimState:Hide(symbol)
	end

	inst.OnSave = OnSave
	inst.OnLoad = OnLoad
	
	return inst
end

return Prefab( "common/objects/teleportato_base", fn, makeassetlist(), prefabs )

