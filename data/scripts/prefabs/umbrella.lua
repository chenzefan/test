local assets=
{
	Asset("ANIM", "data/anim/umbrella.zip"),
	--Asset("ANIM", "data/anim/goldenpitchfork.zip"),
	Asset("ANIM", "data/anim/swap_umbrella.zip"),
	--Asset("ANIM", "data/anim/swap_goldenpitchfork.zip"),
    Asset("IMAGE", "data/inventoryimages/umbrella.tex"),
    --Asset("IMAGE", "data/inventoryimages/goldenpitchfork.tex"),
}
    

local function StartSound(inst)
	local owner = inst.components.inventoryitem.owner
	if owner and owner.SoundEmitter then
		owner.SoundEmitter:PlaySound("dontstarve/rain/rain_on_umbrella", "umbrellarainsound") 
	end
end

local function StopSound(inst)
	local owner = inst.components.inventoryitem.owner
	if owner and owner.SoundEmitter then
		owner.SoundEmitter:KillSound("umbrellarainsound") 
	end
end

local function onfinished(inst)
    inst:Remove()
end
    
local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_umbrella", "swap_umbrella")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
    
    if owner.SoundEmitter then
        if GetSeasonManager():IsRaining() then
            StartSound(inst)
        end
    end
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
    
    if owner.SoundEmitter then
        StopSound(inst)
    end
end
    
    
local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()    
    MakeInventoryPhysics(inst)
    
    anim:SetBank("umbrella")
    anim:SetBuild("umbrella")
    anim:PlayAnimation("idle")
    

    inst:AddComponent("dapperness")
    inst.components.dapperness.mitigates_rain = true
    -------
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.UMBRELLA_USES)
    inst.components.finiteuses:SetUses(TUNING.UMBRELLA_USES)
    inst.components.finiteuses:SetOnFinished( onfinished) 
    --inst.components.finiteuses:SetConsumption(ACTIONS.TERRAFORM, .125)
    -------

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.UMBRELLA_DAMAGE)
    
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    
    inst:ListenForEvent("rainstop", function() StopSound(inst) end, GetWorld()) 
	inst:ListenForEvent("rainstart", function() StartSound(inst) end, GetWorld()) 
    
    
    return inst
end



return Prefab( "common/inventory/umbrella", fn, assets)--,
	   --Prefab( "common/inventory/goldenpitchfork", golden, assets)

