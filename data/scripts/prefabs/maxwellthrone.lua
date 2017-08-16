require "fonthelper"

local assets =
{
	Asset("ANIM", "data/anim/maxwelltemp.zip"),
	Asset("SOUND", "data/sound/maxwell.fsb"),
}

local FONTS = {
	{ filename = "data/fonts/opensans50.zip", alias = DIALOGFONT },
}

local SPEECH =
{
    NULL_SPEECH=
    {
        appearanim = "appear",
        idleanim= "idle",
        dialogpreanim = "dialog_pre",
        dialoganim="dial_loop",
        dialogpostanim = "dialog_pst",
        disappearanim = "disappear",
        disableplayer = true,
        skippable = true,
        {
            string = "There is no speech number.", --The string maxwell will say
            wait = 2, --The time this segment will last for
            anim = nil, --If there's a different animation, the animation maxwell will play
            sound = nil, --if there's an extra sound, the sound that will play
        },
        {
            string = nil, 
            wait = 0.5, 
            anim = "smoke", 
            sound = "dontstarve/common/destroy_metal", 
        },
        {
            string = "Go set one.", 
            wait = 2, 
            anim = nil, 
            sound = nil, 
        },
        {
            string = "Goodbye", 
            wait = 1,
            anim = nil,
            sound = "dontstarve/common/destroy_metal",
        },    
    },

    INTRO =
    {
        appearanim = "appear",
        idleanim= "idle",
        dialogpreanim = "dialog_pre",
        dialoganim="dial_loop",
        dialogpostanim = "dialog_pst",
        disappearanim = "disappear",
        disableplayer = true,
        skippable = true,
        {
            string = STRINGS.MAXWELL_ADVENTURETHRONE.LEVEL_6.INTRO.ONE,
            wait = 3,
            anim = nil,
            sound = nil,
        },
        {
            string = STRINGS.MAXWELL_ADVENTURETHRONE.LEVEL_6.INTRO.TWO, 
            wait = 3, 
            anim = nil, 
            sound = nil,
        },
        {
            string = STRINGS.MAXWELL_ADVENTURETHRONE.LEVEL_6.INTRO.THREE, 
            wait = 3, 
            anim = nil, 
            sound = nil, 
        },
        {
            string = STRINGS.MAXWELL_ADVENTURETHRONE.LEVEL_6.INTRO.FOUR, 
            wait = 3,
            anim = nil,
            sound = nil,
        },
        {
            string = STRINGS.MAXWELL_ADVENTURETHRONE.LEVEL_6.INTRO.FIVE, 
            wait = 3,
            anim = nil,
            sound = nil,
        },
        {
            string = STRINGS.MAXWELL_ADVENTURETHRONE.LEVEL_6.INTRO.SIX, 
            wait = 3,
            anim = nil,
            sound = nil,
        },
        {
            string = STRINGS.MAXWELL_ADVENTURETHRONE.LEVEL_6.INTRO.SEVEN, 
            wait = 3,
            anim = nil,
            sound = nil,
        },
    },

    MAXWELL =
    {       
        appearanim = "appear",
        idleanim= "idle",
        dialogpreanim = "dialog_pre",
        dialoganim="dial_loop",
        dialogpostanim = "dialog_pst",
        disappearanim = "disappear",
        disableplayer = true,
        skippable = true,
        {
            string = STRINGS.MAXWELL_ADVENTURETHRONE.LEVEL_6.MAXWELL.ONE,
            wait = 3,
            anim = nil,
            sound = nil,
        },
        {
            string = STRINGS.MAXWELL_ADVENTURETHRONE.LEVEL_6.MAXWELL.TWO, 
            wait = 3, 
            anim = nil, 
            sound = nil,
        },
    },

    PORTAL =
    {       
        appearanim = "appear",
        idleanim= "idle",
        dialogpreanim = "dialog_pre",
        dialoganim="dial_loop",
        dialogpostanim = "dialog_pst",
        disappearanim = "disappear",
        disableplayer = true,
        skippable = true,
        {
            string = STRINGS.MAXWELL_ADVENTURETHRONE.LEVEL_6.PORTAL.ONE,
            wait = 3,
            anim = nil,
            sound = nil,
        },
    },
}

local function activateintrospeech(inst)
        
    inst.task = inst:StartThread(function()   inst.components.maxwelltalker:DoTalk(inst) end)
end

local function activatemaxwellspeech(inst)
end

local function activateportalspeech(inst)
end

AddFontAssets( assets, FONTS )
 
local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.75, .75 )
    inst.Transform:SetTwoFaced()

    anim:SetBank("maxwelltemp")
    anim:SetBuild("maxwelltemp")
   -- anim:PlayAnimation("appear")
    anim:PlayAnimation("idle")

    inst.entity:AddLabel()
    inst.Label:SetFontSize(25)
    inst.Label:SetFont(DIALOGFONT)
    inst.Label:SetPos(0,5,0)
    --inst.Label:SetColour(255/255, 100/255, 100/255)
    inst.Label:Enable(false)

    inst:AddComponent("named")
    inst.components.named:SetName("Maxwell")
    
    inst:AddComponent("talker")
    inst:AddComponent("inspectable")
    inst.components.inspectable.nameoverride = "maxwell"

    inst:AddComponent("maxwelltalker")
    inst.components.maxwelltalker.speeches = SPEECH

    return inst
end

return Prefab( "common/characters/maxwellthrone", fn, assets)
