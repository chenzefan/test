local assets=
{
	Asset("ANIM", "data/anim/icestaff.zip"),
	Asset("ANIM", "data/anim/swap_icestaff.zip"),
    
    Asset("IMAGE", "data/inventoryimages/icestaff.tex"),
}

local prefabs = 
{
    "ice_projectile",
}

local function onfinished(inst)
    inst:Remove()
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_icestaff", "swap_icestaff")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end

local function onattack(inst, attacker, target)

    if attacker and attacker.components.sanity then
        attacker.components.sanity:DoDelta(-TUNING.SANITY_SUPERTINY)
    end
    
    if target.components.freezable then
        target.components.freezable:AddColdness(1)
        target.components.freezable:SpawnShatterFX()
    end
    if target.components.sleeper and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end
    if target.components.burnable and target.components.burnable:IsBurning() then
        target.components.burnable:Extinguish()
    end
    if target.components.combat then
        target.components.combat:SuggestTarget(attacker)
        if target.sg and not target.sg:HasStateTag("frozen") and target.sg.sg.states.hit then
            target.sg:GoToState("hit")
        end
    end
end


local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    anim:SetBank("icestaff")
    anim:SetBuild("icestaff")
    anim:PlayAnimation("idle")
    
    inst:AddTag("icestaff")
    
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)
    inst.components.weapon:SetRange(8, 10)
    inst.components.weapon:SetOnAttack(onattack)
    inst.components.weapon:SetProjectile("ice_projectile")
    
    -------
    
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.ICESTAFF_USES)
    inst.components.finiteuses:SetUses(TUNING.ICESTAFF_USES)
    
    inst.components.finiteuses:SetOnFinished( onfinished )

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    
    return inst
end

return Prefab( "common/inventory/icestaff", fn, assets, prefabs)
