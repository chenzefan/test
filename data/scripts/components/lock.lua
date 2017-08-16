local Lock = Class(function(self, inst)
	self.inst = inst
	self.locktype = "door"
	self.onunlocked = nil
	self.islocked = true
end)

function Lock:SetOnUnlockedFn(fn)
	self.onunlocked = fn
end

function Lock:CompatableKey(keytype)
	return keytype == self.locktype
end

function Lock:IsLocked()
	return self.islocked
end

function Lock:UnLock(key)
	if self.islocked then
		self.islocked = false
		if key then key.components.key:OnUsed() end
		if self.onunlocked then
			self.onunlocked(self.inst)
		end
	end
end

return Lock