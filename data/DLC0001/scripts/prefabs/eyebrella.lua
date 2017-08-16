local assets=
{
    Asset("ANIM", "anim/eyebrella.zip"),
	Asset("ANIM", "anim/swap_eyebrella.zip"),
}
  
local function UpdateSound(inst)
    local soundShouldPlay = GetSeasonManager():IsRaining() and inst.components.equippable:IsEquipped()
    if soundShouldPlay ~= inst.SoundEmitter:PlayingSound("umbrellarainsound") then
        if soundShouldPlay then
		    inst.SoundEmitter:PlaySound("dontstarve/rain/rain_on_umbrella", "umbrellarainsound") 
        else
		    inst.SoundEmitter:KillSound("umbrellarainsound")
		end
    end
end  

local function onfinished(inst)
    inst:Remove()
end
    
local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_eyebrella", "swap_object")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    UpdateSound(inst)
    
    owner.DynamicShadow:SetSize(2.2, 1.4)

    inst.components.fueled:StartConsuming()
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
    UpdateSound(inst)

    owner.DynamicShadow:SetSize(1.3, 0.6)

    inst.components.fueled:StopConsuming()
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()    
    MakeInventoryPhysics(inst)

    inst:AddTag("nopunch")
    
    inst:AddComponent("waterproofer")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

    inst:AddComponent("insulator")
    inst.components.insulator:SetSummer()

    inst:ListenForEvent("rainstop", function() UpdateSound(inst) end, GetWorld()) 
	inst:ListenForEvent("rainstart", function() UpdateSound(inst) end, GetWorld()) 
        
    inst.AnimState:SetBank("eyebrella")
    inst.AnimState:SetBuild("eyebrella")
    inst.AnimState:PlayAnimation("idle")  

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "USAGE"
    inst.components.fueled:SetDepletedFn(onfinished)

    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_ABSOLUTE)
    inst.components.insulator:SetInsulation(TUNING.INSULATION_LARGE)
    inst.components.fueled:InitializeFuelLevel(TUNING.EYEBRELLA_PERISHTIME)  
    return inst
end

return Prefab( "common/inventory/eyebrella", fn, assets)
