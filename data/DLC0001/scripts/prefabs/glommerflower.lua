local assets=
{
    Asset("ANIM", "anim/glommer_flower.zip"),
}

local prefabs =
{
    "glommer",
}

local function OnLoseChild(inst, child)
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
    inst:AddTag("show_spoilage")
    inst.deadchild = true
    inst.components.inventoryitem:ChangeImageName("glommerflower_dead")
    inst.AnimState:PlayAnimation("idle_dead")
    inst:RemoveTag("glommerflower")
    
    if inst.components.inventoryitem:IsHeld() then
        local owner = inst.components.inventoryitem.owner
        inst.components.inventoryitem:RemoveFromOwner(true)
        if owner.components.container then
            owner.components.container:GiveItem(inst)
        elseif owner.components.inventory then
            owner.components.inventory:GiveItem(inst)
        end
    end

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_LARGE_FUEL
    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    inst.components.burnable:MakeDragonflyBait(3)

end

local function IsActive(inst)
    return not inst.deadchild
end

local function OnPreLoad(inst, data)
    if data then
        inst.deadchild = data.deadchild
    end

    if inst.deadchild then
        OnLoseChild(inst)
    end
end

local function OnSave(inst, data)
    data.deadchild = inst.deadchild
end

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("glommer_flower")
    inst.AnimState:SetBuild("glommer_flower")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("glommerflower")
    inst:AddTag("nonpotatable")

    inst:AddComponent("leader")
    inst.components.leader.onremovefollower = OnLoseChild
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:ChangeImageName("glommerflower")

    inst.IsActive = IsActive
    inst.OnPreLoad = OnPreLoad
    inst.OnSave = OnSave

    return inst
end

return Prefab( "common/inventory/glommerflower", fn, assets, prefabs)