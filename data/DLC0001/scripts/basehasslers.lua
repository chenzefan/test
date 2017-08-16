function GetWanderAwayPoint(pt)
    local theta = math.random() * 2 * PI
    local radius = 40
    
    local ground = GetWorld()
    
    -- Walk the circle trying to find a valid spawn point
    local steps = 12
    for i = 1, 12 do
        local offset = Vector3(radius * math.cos( theta ), 0, -radius * math.sin( theta ))
        local wander_point = pt + offset
        
        if ground.Map and ground.Map:GetTileAtPoint(wander_point.x, wander_point.y, wander_point.z) ~= GROUND.IMPASSABLE
           and ground.Pathfinder:IsClear(pt.x, pt.y, pt.z, wander_point.x, wander_point.y, wander_point.z, {ignorewalls = true} ) then
            return wander_point
        end
        theta = theta - (2 * PI / steps)
    end
end

local function onspawn_deerclops(inst)
    local target = GetClosestInstWithTag("structure", GetPlayer(), 40)
    if target then
        local targetPos = Vector3(target.Transform:GetWorldPosition() )
        inst.components.knownlocations:RememberLocation("targetbase", targetPos)
        local wanderAwayPoint = GetWanderAwayPoint(targetPos)
        if wanderAwayPoint then
            inst.components.knownlocations:RememberLocation("home", wanderAwayPoint)
        end
    else
        inst.components.combat:SetTarget(GetPlayer())
    end
end

local function spawncondition_deerclops()
	local snow_cover = GetSeasonManager() and GetSeasonManager():GetSnowPercent() or 0
	return snow_cover >= 0.2
end

local function validtimefn_deerclops()
    -- prevents the deerclops from spawning if winter is set as starting season
    return GetClock():GetNumCycles() > 10
end

local deerclops = 
{
	prefab = "deerclops",
	activeseason =  SEASONS.WINTER,
	attackduringoffseason = false,
	playerstring = "ANNOUNCE_DEERCLOPS",
	attacksperseason = 1,
	warnsound = "dontstarve/creatures/deerclops/distant",
	warnduration = 60,
	onspawnfn = onspawn_deerclops,
	spawnconditionfn = spawncondition_deerclops,
    validtimefn = validtimefn_deerclops,
}

local bearger = 
{
	prefab = "bearger",
	activeseason =  SEASONS.AUTUMN,
	attackduringoffseason = false,
	playerstring = "ANNOUNCE_DEERCLOPS",
	attacksperseason = 1,
	warnsound = "dontstarve/creatures/deerclops/distant",
	warnduration = 60,
}

local function onspawn_moose(inst)
	inst.components.timer:StartTimer("WantsToLayEgg", (TUNING.TOTAL_DAY_TIME*3) * math.random())
end

local NO_TAGS = {"FX", "NOCLICK","DECOR","INLIMBO"}
local BASE_TAGS = {"structure"}

local function spawnconditionfn_moose()
    local pt = GetPlayer():GetPosition()
    local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 30, BASE_TAGS, NO_TAGS) 
    if #ents >= 3 then
        return pt
    end
end

local function spawnposfn_moose(inst)
    local base_offsets = function()
        local positions = {}
        for i = 1, 100 do
            local s = i/32.0--(num/2) -- 32.0
            local a = math.sqrt(s*512.0)
            local b = math.sqrt(s)
            table.insert(positions, Vector3(math.sin(a)*b, 0, math.cos(a)*b))
        end
        return positions
    end
    local basepos = spawnconditionfn_moose()
    local spots = {}
    if basepos then
        local offsets = base_offsets()
        local ground = GetWorld()
        for k,v in pairs(offsets) do
            local try_pos = basepos + (v * 30)
            if not (ground.Map and ground.Map:GetTileAtPoint(try_pos.x, try_pos.y, try_pos.z) == GROUND.IMPASSABLE or ground.Map:GetTileAtPoint(try_pos.x, try_pos.y, try_pos.z) > GROUND.UNDERGROUND ) and 
            #TheSim:FindEntities(try_pos.x, try_pos.y, try_pos.z, 10) <= 0 and
            ground.Pathfinder:IsClear(basepos.x, basepos.y, basepos.z, try_pos.x, try_pos.y, try_pos.z, {ignorewalls = true}) then
                table.insert(spots, try_pos)
            end 
        end
    end
    if #spots > 0 then
    	return spots[#spots]
    end
end

local function spawntime_moose()
	--Should spawn within ~3 days
	return math.random(2, 4) * TUNING.TOTAL_DAY_TIME
end

local function validtimefn_moose()
    -- prevents the moose from spawning if spring is set as starting season
    return GetClock():GetNumCycles() > 10
end

local goosemoose = 
{
	prefab = "moose",
	activeseason =  SEASONS.SPRING,
	attackduringoffseason = false,
	playerstring = "ANNOUNCE_DEERCLOPS",
	attacksperseason = 1,
	warnsound = "dontstarve/creatures/deerclops/distant",
	warnduration = 60,
	spawntimefn = spawntime_moose,
	onspawnfn = onspawn_moose,
	spawnposfn = spawnposfn_moose,
	spawnconditionfn = spawnconditionfn_moose,
    validtimefn = validtimefn_moose,
}

local dragonfly = 
{
    prefab = "dragonfly",
    activeseason =  SEASONS.SUMMER,
    attackduringoffseason = false,
    playerstring = "ANNOUNCE_DEERCLOPS",
    attacksperseason = 1,
    warnsound = "dontstarve/creatures/deerclops/distant",
    warnduration = 60,  
}

return
{
	DEERCLOPS = deerclops,
	BEARGER = bearger,
	GOOSEMOOSE = goosemoose,
    DRAGONFLY = dragonfly,
}