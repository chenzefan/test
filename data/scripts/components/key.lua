local Key = Class(function(self, inst)
	self.inst = inst
	self.keytype = "door"
	self.onused = nil
end)

function Key:SetOnUsedFn(fn)
	self.onused = fn
end

function Key:OnUsed()
	if self.onused then
		self.onused(self.inst)
	end
end

function Key:CollectUseActions(doer, target, actions)
	if target.components.lock then
		if target.components.lock:IsLocked() then
			table.insert(actions, ACTIONS.UNLOCK)
		end
	end
end

return Key