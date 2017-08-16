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
	SANDBOX_1 =
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
			string = STRINGS.MAXWELL_SANDBOXINTROS.ONE,
			wait = 3,
			anim = nil,
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_SANDBOXINTROS.TWO, 
			wait = 3, 
			anim = nil, 
			sound = nil,
		},
	},

	ADVENTURE_1 =
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
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_1.ONE,
			wait = 3,
			anim = nil,
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_1.TWO, 
			wait = 3, 
			anim = nil, 
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_1.THREE, 
			wait = 3, 
			anim = nil, 
			sound = nil, 
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_1.FOUR, 
			wait = 3,
			anim = nil,
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_1.FIVE, 
			wait = 3,
			anim = nil,
			sound = nil,
		},
	},

	ADVENTURE_2 =
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
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_2.ONE,
			wait = 3,
			anim = nil,
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_2.TWO, 
			wait = 3, 
			anim = nil, 
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_2.THREE, 
			wait = 3, 
			anim = nil, 
			sound = nil, 
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_2.FOUR, 
			wait = 3,
			anim = nil,
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_2.FIVE, 
			wait = 3,
			anim = nil,
			sound = nil,
		},
	},

	ADVENTURE_3 =
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
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_3.ONE,
			wait = 3,
			anim = nil,
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_3.TWO, 
			wait = 3, 
			anim = nil, 
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_3.THREE, 
			wait = 3, 
			anim = nil, 
			sound = nil, 
		},
	},

	ADVENTURE_4 =
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
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_4.ONE,
			wait = 3,
			anim = nil,
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_4.TWO, 
			wait = 3, 
			anim = nil, 
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_4.THREE, 
			wait = 3, 
			anim = nil, 
			sound = nil, 
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_4.FOUR, 
			wait = 3,
			anim = nil,
			sound = nil,
		},
	},

	ADVENTURE_5 =
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
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_5.ONE,
			wait = 2,
			anim = nil,
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_5.TWO, 
			wait = 2, 
			anim = nil, 
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_5.THREE, 
			wait = 2, 
			anim = nil, 
			sound = nil, 
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_5.FOUR, 
			wait = 2.5,
			anim = nil,
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_5.FIVE, 
			wait = 1,
			anim = nil,
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_5.SIX, 
			wait = 1.5,
			anim = nil,
			sound = nil,
		},
	},

	ADVENTURE_6 =
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
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_6.ONE,
			wait = 3,
			anim = nil,
			sound = nil,
		},
		{
			string = STRINGS.MAXWELL_ADVENTUREINTROS.LEVEL_6.TWO, 
			wait = 3, 
			anim = nil, 
			sound = nil,
		},
	},
}

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
    
	--inst.task = inst:StartThread(function()	inst.components.maxwelltalker:DoTalk(inst) end) 

    return inst
end

return Prefab("common/characters/maxwellintro", fn, assets)