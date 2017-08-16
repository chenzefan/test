assets =
{
    Asset("ANIM", "anim/statue_ruins_small.zip")
}

prefabs = 
{
    "marble",
    "greengem",
    "nightmarefuel",
}

local function onwork(inst, worked, workleft)
    local pt = Point(inst.Transform:GetWorldPosition())
    if workleft <= 0 then
        inst.SoundEmitter:KillSound("hoverloop")
        inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
        inst.components.lootdropper:DropLoot(pt)
        inst:Remove()
    else                
        if workleft < TUNING.MARBLEPILLAR_MINE*(1/3) then
            inst.AnimState:PlayAnimation("hit_low", true)
        elseif workleft < TUNING.MARBLEPILLAR_MINE*(2/3) then
            inst.AnimState:PlayAnimation("hit_med", true)
        else
            inst.AnimState:PlayAnimation("idle_full", true)
        end
    end
end

local function commonfn()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    
    MakeObstaclePhysics(inst, 0.66)

    anim:SetBank("statue_ruins_small")
    anim:SetBuild("statue_ruins_small")
    anim:PlayAnimation("idle_full", true)

    inst:AddComponent("inspectable")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.MARBLEPILLAR_MINE)
    inst.components.workable:SetOnWorkCallback(onwork)
    
    inst:AddComponent("lootdropper")

    inst.SoundEmitter:PlaySound("dontstarve/common/floating_statue_hum", "hoverloop")
    
    return inst
end

local function gem()
    local inst = commonfn()
        --don't hide gem
        --add gem to loot table

    inst.components.lootdropper:SetLoot({"marble","marble", "marble", "greengem"}) --Add other loot?


    return inst
end

local function nogem()
    local inst = commonfn()
        --hide gem
        --no gem in loot table
    inst.AnimState:Hide("gem")
    inst.components.lootdropper:SetLoot({"marble","marble", "marble", "nightmarefuel"}) --Add other loot?


    return inst
end

return Prefab("cave/objects/statueface", gem, assets, prefabs),
Prefab("cave/objects/statueface_nogem", nogem, assets, prefabs)