local function makeassetlist(bankname, buildname)
    
    if buildname == bankname then
        return { Asset("ANIM", "data/anim/"..buildname..".zip") }
    else
        return {
            Asset("ANIM", "data/anim/"..buildname..".zip"),
            Asset("ANIM", "data/anim/"..bankname..".zip"),
        }
    end
end


local prefabs =
{
    "rocks",
    "nitre",
    "flint",
    "goldnugget",
}    

local function makefn(bankname, buildname)
    return function (Sim)
        local inst = CreateEntity()
        local trans = inst.entity:AddTransform()
        local anim = inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        
        MakeObstaclePhysics(inst, 1.)

        anim:SetBank(bankname)
        anim:SetBuild(buildname)
        anim:PlayAnimation("full")
        
	    local minimap = inst.entity:AddMiniMapEntity()
	    minimap:SetIcon( "rock.png" )
	
        inst:AddComponent("lootdropper") 
        inst.components.lootdropper:SetLoot({"rocks", "rocks", "rocks", "flint"})
        inst.components.lootdropper:AddChanceLoot("goldnugget", 0.4)
        inst.components.lootdropper:AddChanceLoot("nitre", 0.2)
        inst.components.lootdropper:AddChanceLoot("flint", 0.6)
        inst.components.lootdropper:AddChanceLoot("rocks", 0.4)
        
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.MINE)
        inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
        
        inst.components.workable:SetOnWorkCallback(
            function(inst, worker, workleft)
                local pt = Point(inst.Transform:GetWorldPosition())
                if workleft <= 0 then
					inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
                    inst.components.lootdropper:DropLoot(pt)
                    inst:Remove()
                else
                    
                    
                    if workleft < TUNING.ROCKS_MINE*(1/3) then
                        inst.AnimState:PlayAnimation("low")
                    elseif workleft < TUNING.ROCKS_MINE*(2/3) then
                        inst.AnimState:PlayAnimation("med")
                    else
                        inst.AnimState:PlayAnimation("full")
                    end
                end
            end)         

        inst:AddComponent("inspectable")
        inst.components.inspectable.nameoverride = "ROCK"
		MakeSnowCovered(inst, .01)        
        return inst
    end
end    


local function rock(name, bankname, buildname)
    return Prefab("forest/objects/rocks/"..name, makefn(bankname, buildname), makeassetlist(bankname, buildname), prefabs)
end
    
return  rock("rock1", "rock", "rock"), rock("rock2", "rock2", "rock2")
