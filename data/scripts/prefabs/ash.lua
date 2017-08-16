local assets=
{
	Asset("ANIM", "data/anim/ash.zip"),
    Asset("IMAGE", "data/inventoryimages/ash.tex"),
}


-- NOTE:
-- You have to add a custom DESCRIBE for each item you
-- mark as nonpotatable
local function GetStatus(inst)
	print("Getstatus!")
	if inst.components.named.name ~= nil then
		local mod = "REMAINS_"..inst.components.named.name
		mod = string.gsub(mod, " ", "_")
		print(mod)
		return mod
	end
end


local function BlowAway(inst)
	inst.SoundEmitter:PlaySound("dontstarve/common/dust_blowaway")

	if inst.DynamicShadow then
        inst.DynamicShadow:Enable(false)
    end

	inst.AnimState:PlayAnimation("disappear")

	inst:DoTaskInTime(2.0, function() inst:Remove() end)
end

local function StopBlowAway(inst)
	if inst.blowawaytask then
		inst.blowawaytask:Cancel()
	end
end
		
local function PrepareBlowAway(inst)
	StopBlowAway(inst)
	inst.blowawaytask = inst:DoTaskInTime(25+math.random()*10,
		function()
			BlowAway(inst)
		end)
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ashes")
    inst.AnimState:SetBuild("ash")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    
    ---------------------       
    
    inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = GetStatus
    
    inst:AddComponent("inventoryitem")

	inst:AddComponent("named")
	inst.components.named.nameformat = STRINGS.NAMES.ASH_REMAINS
	inst:ListenForEvent("stacksizechange", function(inst, stackdata)
		if stackdata.stacksize and stackdata.stacksize > 1 then
			inst.components.named:SetName(nil)
		end
	end)
   
	inst:ListenForEvent("ondropped", function()
			PrepareBlowAway(inst)
		end)
	inst:ListenForEvent("onpickup", function()
			StopBlowAway(inst)
		end)
	PrepareBlowAway(inst)

    return inst
end

return Prefab( "common/inventory/ash", fn, assets)

