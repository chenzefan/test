local assets=
{
	Asset("ANIM", "data/anim/swap_bedroll.zip"),
    Asset("IMAGE", "data/inventoryimages/bedroll_straw.tex"),
}

local function onsleep(inst, sleeper)
	local br = nil
	if inst.components.stackable then
		br = inst.components.stackable:Get()
	else
		br = inst
	end
	
	if br then
		br.persists = false
		br:Remove()
	end
	
	TheFrontEnd:Fade(false,1)
	inst:DoTaskInTime(1.2, function() 
		TheFrontEnd:Fade(true,1) 
		
		if sleeper.components.hunger then
			sleeper.components.hunger:DoDelta(-TUNING.CALORIES_HUGE)
		end

		if sleeper.components.sanity then
			sleeper.components.sanity:DoDelta(TUNING.SANITY_LARGE)
		end
		
		sleeper.sg:GoToState("wakeup")	
		GetClock():MakeNextDay()
	end)
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    anim:SetBank("swap_bedroll")
    anim:SetBuild("swap_bedroll")
    anim:PlayAnimation("idle")
    
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL
    
	MakeSmallBurnable(inst, TUNING.LONG_BURNABLE)
    MakeSmallPropagator(inst)
    
    inst:AddComponent("sleepingbag")
	inst.components.sleepingbag.onsleep = onsleep
    
    
    
    return inst
end

return Prefab( "common/inventory/bedroll_straw", fn, assets)
