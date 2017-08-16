local LurePlantSpawner = Class(function(self, inst)
	self.inst = inst
	self.spawntime = TUNING.LUREPLANT_SPAWNTIME
	self.spawntimevariance = TUNING.LUREPLANT_SPAWNTIME_VARIANCE
	self.minoffset = 80
	self.maxoffset = 200
	self.playertrail = {}
	self.trailcap = 32
	self.trailticktime = 40
	self.maxweight = 3
	self:StartNextSpawn()
	self.inst:DoPeriodicTask(self.trailticktime, function() self:LogPlayerLocation() end)
end)

function LurePlantSpawner:LogPlayerLocation()
	if #self.playertrail >= self.trailcap then
		table.remove(self.playertrail, 1)
	end

	local pos = GetPlayer():GetPosition()

	for k,v in pairs(self.playertrail) do
		if distsq(Vector3(pos.x, pos.y, pos.z), Vector3(v.x, v.y, v.z)) < 40*40 then
			--You're close to an old point. Just make that point more likely to be a spawn location.
			v.weight = v.weight + 0.2
			if v.weight > self.maxweight then
				v.weight = self.maxweight
			end
			return
		end
	end
	--This is a new point. Add it to the list!
	table.insert(self.playertrail, {x = pos.x, y = pos.y, z = pos.z, weight = 0.01})
end

function LurePlantSpawner:FindSpawnLocationInTrail()
	if not self.playertrail then
		return nil
	end

	local total_w = 0
	for k,v in pairs(self.playertrail) do
		total_w = total_w + (v.weight or 1)
	end
	
	local rnd = math.random()*total_w
	local num = 1
	for k,v in pairs(self.playertrail) do
		rnd = rnd - (v.weight or 1)
		if rnd <= 0 then
			table.remove(self.playertrail, num)
			return {x = v.x, y = v.y, z = v.z}
		end
		num = num + 1
	end
end

function LurePlantSpawner:ResumeSpawn(time)
	if self.task then
		self.task:Cancel()
		self.task = nil
	end
	self:SetSpawnInfo(time)
	self.task = self.inst:DoTaskInTime(time, function() self:SpawnPlant() end)
end

function LurePlantSpawner:StartNextSpawn()
	self:SetSpawnInfo(self.spawntime)
	self.task = self.inst:DoTaskInTime(self.spawntime + math.random(-self.spawntimevariance, self.spawntimevariance),
	function() self:SpawnPlant() end)
end

function LurePlantSpawner:SetSpawnInfo(time)
	self.spawninfo = {}
	self.spawninfo.time = time
	self.spawninfo.targettime = GetTime() + time
	return time
end

function LurePlantSpawner:SpawnPlant()
	local loc = self:FindSpawnLocationInTrail()
	
	if not loc then
		loc = self:FindSpawnLocation()
	end

	if loc then
		local plant = SpawnPrefab("lureplant")
		plant.Transform:SetPosition(loc.x, loc.y, loc.z)
		plant.sg:GoToState("spawn")
	end
	self:StartNextSpawn()
end

function LurePlantSpawner:FindSpawnLocation()
	local player = GetPlayer()
	local pt = Vector3(player.Transform:GetWorldPosition())
    local theta = math.random() * 2 * PI
    local radius = math.random(self.minoffset, self.maxoffset)
    local steps = 40
    local ground = GetWorld()

    local validpos = {}

    for i = 1, steps do
        local offset = Vector3(radius * math.cos( theta ), 0, -radius * math.sin( theta ))
        local try_pos = pt + offset
       
        if not (ground.Map and ground.Map:GetTileAtPoint(try_pos.x, try_pos.y, try_pos.z) == GROUND.IMPASSABLE or ground.Map:GetTileAtPoint(try_pos.x, try_pos.y, try_pos.z) > GROUND.UNDERGROUND ) and 
		#TheSim:FindEntities(try_pos.x, try_pos.y, try_pos.z, 1) <= 0 then
			table.insert(validpos, {x = try_pos.x, y = try_pos.y, z = try_pos.z})
        end
        theta = theta - (2 * PI / steps)
    end

    if #validpos > 0 then
    	local num = math.random(#validpos)
    	return {x = validpos[num].x, y = validpos[num].y, z = validpos[num].z}
    else
    	return nil
    end
end

function LurePlantSpawner:OnLoad(data)
	if data.targettime then
		self:ResumeSpawn(data.targettime)
	end

	if data.playertrail then self.playertrail = data.playertrail end
end

function LurePlantSpawner:OnSave()
	local data = {}
	if self.spawninfo.targettime then
		data.targettime = self.spawninfo.targettime - GetTime()
	end

	if self.playertrail ~= nil then
		data.playertrail = self.playertrail
	end
	return data
end

function LurePlantSpawner:LongUpdate(dt)
	if self.spawninfo then
		if self.task then
			self.task:Cancel()
			self.task = nil
		end

		local newtime = self.spawninfo.targettime - GetTime() - dt

		if newtime <= 0 then
			--spawn
			self:SpawnPlant()
		else
			self:ResumeSpawn(newtime)
		end
	end
end

return LurePlantSpawner