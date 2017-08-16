

local function MakeFx(name, bank, build, anim, sound, sounddelay, tint, tintalpha)
    local assets = 
    {
        Asset("ANIM", "anim/"..build..".zip")
    }

    local function fn()
    	local inst = CreateEntity()
    	inst.entity:AddTransform()
    	inst.entity:AddAnimState()

        if type(anim) ~= "string" then
            anim = anim[math.random(#anim)]
        end

        if sound then
            inst.entity:AddSoundEmitter()
            
            if sounddelay then
                inst:DoTaskInTime(sounddelay, function() inst.SoundEmitter:PlaySound(sound) end)
            else
                inst.SoundEmitter:PlaySound(sound)
            end
        end
        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation(anim)

        if tint then
            inst.AnimState:SetMultColour(tint.x,tint.y,tint.z,tintalpha or 1)
        end

        inst:AddTag("FX")
        inst.persists = false
        inst:ListenForEvent("animover", function() inst:Remove() end)
        return inst
    end
    return Prefab("common/"..name, fn, assets)
end

local prefs = {}
local fx = require("fx") 

for k,v in pairs(fx) do
    table.insert(prefs, MakeFx(v.name, v.bank, v.build, v.anim, v.sound, v.sounddelay, v.tint, v.tintalpha))
end

return unpack(prefs)
