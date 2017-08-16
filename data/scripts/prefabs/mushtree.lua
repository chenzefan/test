local assets = 
{
	Asset("ANIM", "data/anim/mushroom_tree_tall.zip"),
}

local prefabs =
{
	"log",
	"blue_cap",
	"ash",
}



local function tree_burnt(inst)
	inst.persists = false
	inst.AnimState:PlayAnimation("chop_burnt_tall")
	inst.SoundEmitter:PlaySound("dontstarve/forest/treeCrumble")          
	inst:ListenForEvent("animover", function() inst.components.lootdropper:SpawnLootPrefab("ash") inst:Remove() end)
end

local function stump_burnt(inst)
	inst.components.lootdropper:SpawnLootPrefab("ash") 
	inst:Remove() 	
end

local function dig_up_stump(inst)
	inst.components.lootdropper:SpawnLootPrefab("log")
	inst:Remove()
end

local function makestump(inst)
    inst:RemoveComponent("burnable")
    inst:RemoveComponent("propagator")
    inst:RemoveComponent("workable")
	RemovePhysicsColliders(inst) 
	inst:AddTag("stump")
	MakeSmallPropagator(inst)
	MakeSmallBurnable(inst)
	inst.components.burnable:SetOnBurntFn(stump_burnt)	
    
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetOnFinishCallback(dig_up_stump)
	inst.components.workable:SetWorkLeft(1)
	inst.AnimState:PlayAnimation("stump_tall")
	inst.AnimState:ClearBloomEffectHandle()

	inst.Light:Enable(false)	
end

local function workcallback(inst, worker, workleft)
	local pt = Point(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_mushroom")          
	if workleft <= 0 then
		inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")
		makestump(inst)
	    
		
		
		if math.random() > .5 then
			inst.AnimState:PlayAnimation("fallleft_tall")
		else
			inst.AnimState:PlayAnimation("fallright_tall")
		end

		inst.components.lootdropper:DropLoot(pt)
		inst.AnimState:PushAnimation("stump_tall")

	else			
		inst.AnimState:PlayAnimation("chop_tall")
		inst.AnimState:PushAnimation("sway1_loop_tall", true)
	end
end

local loot = {"log", "log", "blue_cap"}



local function onsave(inst, data)
    if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end
    
    if inst:HasTag("stump") then
        data.stump = true
    end
end
        
local function onload(inst, data)
    if data then

        if data.burnt then
            if data.stump then
            	stump_burnt(inst)
            else
            	tree_burnt(inst)
            end
        elseif data.stump then
        	
        	makestump(inst)
        end
    end
end        

local function tallfn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	
	MakeLargePropagator(inst)
	MakeLargeBurnable(inst)
    inst.components.burnable:SetFXLevel(5)
    inst.components.burnable:SetOnBurntFn(tree_burnt)

    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("mushroom_tree.png")
	MakeObstaclePhysics(inst, 1)

	anim:SetBuild("mushroom_tree_tall")
	anim:SetBank("mushroom_tree")
	anim:PlayAnimation("sway1_loop_tall", true)
	inst.AnimState:SetTime(math.random()*2)    
	

	inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetLoot(loot)
	inst:AddComponent("inspectable")
	inst:AddComponent("workable")

	inst.components.workable:SetWorkAction(ACTIONS.CHOP)
	inst.components.workable:SetWorkLeft(TUNING.MUSHTREE_CHOPS_TALL)

	inst.components.workable:SetOnWorkCallback(workcallback)
	--inst.AnimState:SetBloomEffectHandle( "data/shaders/anim.ksh" )

    local light = inst.entity:AddLight()
	light:SetFalloff(0.5)
	light:SetIntensity(.8)
	light:SetRadius(1.5)
	light:SetColour(237/255, 237/255, 209/255)
     light:Enable(true)


	inst.OnSave = onsave
	inst.OnLoad = onload
	return inst
end


return Prefab("cave/objects/mushtree_tall", tallfn, assets, prefabs)
