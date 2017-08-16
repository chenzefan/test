local assets =
{
	Asset("ANIM", "data/anim/gunpowder.zip"),
    Asset("ANIM", "data/anim/explode.zip"),
    Asset("IMAGE", "data/inventoryimages/gunpowder.tex"),
}


local OnIgniteFn = function(inst)
    DefaultBurnFn(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_fuse_LP", "hiss")
end

local OnBurntFn = function(inst)
    
    inst.SoundEmitter:KillSound("hiss")

    local pos = Vector3(inst.Transform:GetWorldPosition())
    
    GetClock():DoLightningLighting()
    inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_explo")
    GetPlayer().components.playercontroller:ShakeCamera(inst, "FULL", 0.7, 0.02, .5, 40)

    local explode = PlayFX(pos,"explode", "explode", "small")
    explode.AnimState:SetBloomEffectHandle( "data/shaders/anim.ksh" )
    explode.AnimState:SetLightOverride(1)

    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, TUNING.GUNPOWDER_RANGE)

    for k,v in pairs(ents) do
        local inpocket = v.components.inventoryitem and v.components.inventoryitem:IsHeld()

        if not inpocket then
            if v.components.workable and not v:HasTag("busy") then --Haaaaaaack!
                v.components.workable:WorkedBy(inst, 10)
            end

            if v.components.burnable and not v.components.fueled then
                v.components.burnable:Ignite()
            end

            if v.components.combat and v ~= inst then
                v.components.combat:GetAttacked(inst, TUNING.GUNPOWDER_DAMAGE*inst.components.stackable.stacksize, nil)
            end

        end
    end


    inst:Remove()
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("gunpowder")
    inst.AnimState:SetBuild("gunpowder")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
	MakeSmallBurnable(inst, 3+math.random()*3)
    inst.components.burnable.onburnt = OnBurntFn
    inst.components.burnable:SetOnIgniteFn(OnIgniteFn)
    MakeSmallPropagator(inst)
    
    inst:AddComponent("inventoryitem")

    return inst
end

return Prefab( "common/inventory/gunpowder", fn, assets)

