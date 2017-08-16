local assets=
{
	Asset("ANIM", "anim/cave_exit_rope.zip"),
}


local function GetVerb(inst)
	return STRINGS.ACTIONS.ACTIVATE.CLIMB
end

local function onnear(inst)
	inst.AnimState:PlayAnimation("down")
    inst.AnimState:PushAnimation("idle_loop", true)
    inst.SoundEmitter:PlaySound("dontstarve/cave/rope_down")
end

local function onfar(inst)
    inst.AnimState:PlayAnimation("up")
    inst.SoundEmitter:PlaySound("dontstarve/cave/rope_up")
end



local function OnActivate(inst)
	--do popup confirmation
	--do portal presentation 
	--decrement the depth counter
	--save and do restart
	SetHUDPause(true)
	local level = GetWorld().topology.level_number or 1
	local function startadventure()
		local function onsaved()
		    StartNextInstance({reset_action=RESET_ACTION.LOAD_SLOT, save_slot = SaveGameIndex:GetCurrentSaveSlot()}, true)
		end

		SetHUDPause(false)
		if level == 1 then
			SaveGameIndex:SaveCurrent(function() SaveGameIndex:LeaveCave(onsaved) end)
		else
			-- Ascend
			local level = level - 1
			
			SaveGameIndex:SaveCurrent(function() SaveGameIndex:EnterCave(onsaved,nil, inst.cavenum, level) end)
		end
	end

	local title = STRINGS.UI.EXITCAVE.TITLE
	local body = STRINGS.UI.EXITCAVE.BODY
	if level > 1 then
		title = STRINGS.UI.EXITCAVE.TITLE_LEVEL
		body = STRINGS.UI.EXITCAVE.BODY_LEVEL
	end
	TheFrontEnd:PushScreen(PopupDialogScreen(title, body, 
			{{text=STRINGS.UI.EXITCAVE.YES, cb = startadventure},
			 {text=STRINGS.UI.EXITCAVE.NO, cb = function() SetHUDPause(false) inst.components.activatable.inactive = true TheFrontEnd:PopScreen() end}  }))
end


local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    --MakeObstaclePhysics(inst, 1)
    
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "cave_open2.png" )
    
    anim:SetBank("exitrope")
    anim:SetBuild("cave_exit_rope")

    --anim:PlayAnimation("down")
    --anim:PushAnimation("idle_loop", true)

    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(5,7)
    inst.components.playerprox:SetOnPlayerFar(onfar)
    inst.components.playerprox:SetOnPlayerNear(onnear)

    inst:AddComponent("inspectable")

	inst:AddComponent("activatable")
    inst.components.activatable.OnActivate = OnActivate
    inst.components.activatable.inactive = true
    inst.components.activatable.getverb = GetVerb
	inst.components.activatable.quickaction = true

    return inst
end

return Prefab( "common/cave_exit", fn, assets) 
