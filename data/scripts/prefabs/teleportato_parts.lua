local function makeassetlist()
    return {
		Asset("ANIM", "data/anim/teleportato_parts.zip"),
		Asset("IMAGE", "data/inventoryimages/teleportato_ring.tex"),
		Asset("IMAGE", "data/inventoryimages/teleportato_box.tex"),
		Asset("IMAGE", "data/inventoryimages/teleportato_crank.tex"),
		Asset("IMAGE", "data/inventoryimages/teleportato_potato.tex"),
    }
end

local function makefn(name, frame)
    local function fn(Sim)
		local inst = CreateEntity()
		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()

		MakeInventoryPhysics(inst)
		
		anim:SetBank("parts")
		anim:SetBuild("teleportato_parts")
		
		anim:PlayAnimation(frame, false)
		
        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")

		inst:AddComponent("tradable")
        
		inst:AddTag("irreplaceable")
		inst:AddTag("teleportato_part")

       	return inst
	end
    return fn
end

local function TeleportatoPart(name, frame)
    return Prefab( "common/inventory/" .. name, makefn(name, frame), makeassetlist())
end

return 	TeleportatoPart( "teleportato_ring", "ring"),
		TeleportatoPart( "teleportato_box", "lever"),
		TeleportatoPart( "teleportato_crank", "support"), 
		TeleportatoPart( "teleportato_potato", "potato")
