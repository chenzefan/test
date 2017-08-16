require "fonthelper"

local assets =
{
	Asset("ANIM", "data/anim/maxwell_basic.zip"),
	Asset("SOUND", "data/sound/maxwell.fsb"),
}

local FONTS = {
	{ filename = "data/fonts/opensans50.zip", alias = DIALOGFONT },
}

AddFontAssets( assets, FONTS )
 
local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.75, .75 )
    inst.Transform:SetTwoFaced()

    anim:SetBank("maxwell")
    anim:SetBuild("maxwell_basic")
    anim:PlayAnimation("appear")

    inst.entity:AddLabel()
    inst.Label:SetFontSize(25)
    inst.Label:SetFont(DIALOGFONT)
    inst.Label:SetPos(0,5,0)
    --inst.Label:SetColour(255/255, 100/255, 100/255)
    inst.Label:Enable(false)
    
    inst:AddComponent("talker")
    inst:AddComponent("inspectable")

    --inst:ListenForEvent( "ontalk", function(inst, data) inst.AnimState:PlayAnimation("dialog_pre") inst.AnimState:PushAnimation("dial_loop", true) end)
    --inst:ListenForEvent( "donetalking", function(inst, data) inst.AnimState:PlayAnimation("dialog_pst") inst.AnimState:PushAnimation("idle", true) end)
	inst.persists = false
    return inst
end

return Prefab( "common/characters/maxwell", fn, assets)
