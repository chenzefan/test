local FireDetector = Class(function(self, inst)
	self.inst = inst

	self.range = TUNING.FIRE_DETECTOR_RANGE
	self.detectPeriod = TUNING.FIRE_DETECTOR_PERIOD
	self.YESTAGS = { --in priority order
		{"fire"},
		{"smolder"},
		{"withered"},
		{"witherable"},
		{"wildfirestarter"},
		{"burnable"},
	}
	self.NOTAGS = {"FX", "NOCLICK", "DECOR","INLIMBO", "protected"}

	self.onfindfire = nil

end)

function FireDetector:Activate()
	self.detectTask = self.inst:DoPeriodicTask(self.detectPeriod, function() self:LookForFiresAndFirestarters() end)
end

function FireDetector:Deactivate()
	if self.detectTask then
		self.detectTask:Cancel()
		self.detectTask = nil
	end
end

function FireDetector:SetOnFindFireFn(fn)
	self.onfindfire = fn
end

function FireDetector:OnFindFire(firepos)
	if self.onfindfire then
		self.onfindfire(self.inst, firepos)
	end
end

function FireDetector:LookForFiresAndFirestarters()
	local x,y,z = self.inst:GetPosition():Get()
	local priority = 1
	local ents = {}
	while priority <= #self.YESTAGS and #ents == 0 do
		ents = TheSim:FindEntities(x,y,z, self.range, self.YESTAGS[priority], self.NOTAGS)
		priority = priority + 1
	end

	if #ents > 0 then
		for k,v in pairs(ents) do
			if v and (v.makewitherabletask or (v.components.pickable and v.components.pickable.witherable) or (v.components.crop and v.components.crop.witherable)) then
				if self.inst.protected_plants then
					local found = false
					for i,j in pairs(self.inst.protected_plants) do
						if j == v then
							found = true
							break
						end
					end
					if not found then self:OnFindFire(v:GetPosition()) end
				else
					self:OnFindFire(v:GetPosition())
				end
			end
			if v and v.components.burnable and (v.components.burnable:IsBurning() or v.components.burnable:IsSmoldering()) then
				self:OnFindFire(v:GetPosition())
			end
		end
	end
end

return FireDetector