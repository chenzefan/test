local function makeassetlist(name)
    return {
        Asset("ANIM", "anim/"..name..".zip")
    }
end

local function makefn(name)
    local fn = function()
    	local inst = CreateEntity()
    	inst.entity:AddTransform()
    	inst.entity:AddAnimState()
        
        MakeObstaclePhysics(inst, 2.75)
        
        inst.AnimState:SetBank(name)
        inst.AnimState:SetBuild(name)
        inst.AnimState:PlayAnimation("idle", true)
        
        return inst
    end

    return fn
end

local function pillar(name)
    return Prefab( "cave/objects/"..name, makefn(name), makeassetlist(name)) 
end

return pillar("pillar_ruins"), pillar("pillar_algae")
