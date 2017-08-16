
local function DoSpawn(inst)
    local spawner = inst.components.periodicspawner
    if spawner then
        if next(spawner.pendingspawns) ~= nil then
            for k,v in pairs(spawner.pendingspawns) do
                if spawner:TrySpawn(v) then
                    spawner.pendingspawns[k] = nil
                end
            end
        else
            spawner:TrySpawn()
        end
        spawner:Start()
    end
end

local PeriodicSpawner = Class(function(self, inst)
    self.inst = inst
    self.basetime = 40
    self.randtime = 60
    self.prefab = nil
    
    self.range = nil
    self.density = nil
    self.spacing = nil
    
    self.onspawn = nil
    self.spawntest = nil
    
    self.pendingspawns = {}
    self.spawnoffscreen = false
end)

function PeriodicSpawner:SetPrefab(prefab)
    self.prefab = prefab
end

function PeriodicSpawner:SetRandomTimes(basetime, variance)
    self.basetime = basetime
    self.randtime = variance
end

function PeriodicSpawner:SetDensityInRange(range, density)
    self.range = range
    self.density = density
end

function PeriodicSpawner:SetMinimumSpacing(spacing)
    self.spacing = spacing
end

function PeriodicSpawner:SetOnlySpawnOffscreen(offscreen)
    self.spawnoffscreen = offscreen
end

function PeriodicSpawner:SetOnSpawnFn(fn)
    self.onspawn = fn
end

function PeriodicSpawner:SetSpawnTestFn(fn)
    self.spawntest = fn
end

function PeriodicSpawner:AddPendingSpawn(prefab)
    table.insert(self.pendingspawns, prefab)
end


function PeriodicSpawner:TrySpawn(prefab)
    prefab = prefab or self.prefab
    if not self.inst:IsValid() or not prefab then
        return
    end
    
    local canspawn = true
    
    if self.range or self.spacing then
        local pos = Vector3(self.inst.Transform:GetWorldPosition())
        local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, self.range or self.spacing)
        local count = 0
        for k,v in pairs(ents) do
            if v.prefab == prefab then
                if self.spacing and v:GetDistanceSqToInst(self.inst) < self.spacing*self.spacing then
                    canspawn = false
                    break
                end
                count = count + 1
            end
        end
        if self.density and count >= self.density then
            canspawn = false
        end
    end
    
    if self.spawnoffscreen and not self.inst:IsAsleep() then
        canspawn = false
    end
    
    if self.spawntest then
        canspawn = canspawn and self.spawntest(self.inst)
    end

    if canspawn then
        local inst = SpawnPrefab(prefab)
        if self.onspawn then
            self.onspawn(self.inst, inst)
        end
        inst.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
    end
    return canspawn
end

function PeriodicSpawner:Start()
    local t = self.basetime + math.random()*self.randtime
    
    self.task = self.inst:DoTaskInTime(t, DoSpawn)
end


function PeriodicSpawner:Stop()
    if self.task then
        self.task:Cancel()
        self.task = nil
    end
end

return PeriodicSpawner