require "prefabutil"
local assets =
{
	Asset("ANIM", "data/anim/pinecone.zip"),
    Asset("IMAGE", "data/inventoryimages/pinecone.tex"),
}

local function ondeploy (inst, pt) 
	local tree = SpawnPrefab("evergreen_short") 
    if tree then 
		tree.Transform:SetPosition(pt.x, pt.y, pt.z) 
        tree:PushEvent("growfromseed")
        inst.components.stackable:Get():Remove()
	end 
	
	--tell any nearby leifs to chill out
	local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, TUNING.LEIF_PINECONE_CHILL_RADIUS, {"leif"})
	
	local played_sound = false
	for k,v in pairs(ents) do
		
		local chill_chance = TUNING.LEIF_PINECONE_CHILL_CHANCE_FAR
		if distsq(pt, Vector3(v.Transform:GetWorldPosition())) < TUNING.LEIF_PINECONE_CHILL_CLOSE_RADIUS*TUNING.LEIF_PINECONE_CHILL_CLOSE_RADIUS then
			chill_chance = TUNING.LEIF_PINECONE_CHILL_CHANCE_CLOSE
		end
	
		if math.random() < chill_chance then
			if v.components.sleeper then
				v.components.sleeper:GoToSleep(1000)
			end
		else
			if not played_sound then
				v.SoundEmitter:PlaySound("dontstarve/creatures/leif/taunt_VO")
				played_sound = true
			end
		end
		
	end
	
end

local function test_ground(inst, pt)
	local tiletype = GetGroundTypeAtPosition(pt)
	local ground_OK = tiletype ~= GROUND.ROCKY and tiletype ~= GROUND.ROAD and tiletype ~= GROUND.IMPASSABLE
	
	if ground_OK then
	    local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, 4) -- or we could include a flag to the search?
	    
	    for k, v in pairs(ents) do
			if v ~= inst and v.entity:IsValid() and v.entity:IsVisible() and not v:HasTag("player") then
	            if v.Physics then
					local min_spacing = 2
					if distsq( Vector3(v.Transform:GetWorldPosition()), pt) < min_spacing*min_spacing then
						return false
					end
	            end
			end
		end
		return true
	end
	return false
end


local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("pinecone")
    inst.AnimState:SetBuild("pinecone")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    
    inst:AddComponent("inventoryitem")
    
    inst:AddComponent("deployable")
    inst.components.deployable.test = test_ground
    inst.components.deployable.ondeploy = ondeploy
    

    return inst
end

return Prefab( "common/inventory/pinecone", fn, assets),
	   MakePlacer( "common/pinecone_placer", "evergreen_short", "evergreen_new", "idle_short" )


