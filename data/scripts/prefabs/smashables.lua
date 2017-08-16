local function makeassetlist(buildname)
    return {
        Asset("ANIM", "anim/"..buildname..".zip")
    }
end

local function ondeath(inst)
    --play smash sound
    inst.SoundEmitter:PlaySound(inst.smashsound or "dontstarve/common/destroy_pot")
    inst.AnimState:PlayAnimation("broken")
end

local function makefn(name, smashsound)
    local function fn()
        local inst = CreateEntity()
        local trans = inst.entity:AddTransform()
        local anim = inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        
        MakeInventoryPhysics(inst)


        anim:SetBank("relic")
        anim:SetBuild(name)
        anim:PlayAnimation("idle")

        inst:AddComponent("combat")
        inst:AddComponent("health")
        inst.components.health.canmurder = false
        inst:AddComponent("lootdropper")
        inst.components.health:SetMaxHealth(1)

        inst:AddTag("smashable")
        
        inst:ListenForEvent("death", ondeath)

        inst:AddComponent("inspectable")
        inst.components.inspectable.nameoverride = "relic"

        inst:AddComponent("named")
        inst.components.named:SetName(STRINGS.NAMES["RELIC"])

        if smashsound then
            inst.smashsound = smashsound
        end
        return inst
    end
    return fn
end    


local function item(name, sound)
    return Prefab( "cave/objects/smashables/"..name, makefn(name, sound), makeassetlist(name) )
end
    
return item("ruins_plate"),
item("ruins_bowl"),
item("ruins_chair", "dontstarve/wilson/rock_break"),
item("ruins_chipbowl"),
item("ruins_vase"),
item("ruins_table", "dontstarve/wilson/rock_break")

