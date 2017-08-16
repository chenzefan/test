local BlinkStaff = Class(function(self, inst)
    self.inst = inst
    self.onblinkfn = nil
end)


function BlinkStaff:CanBlinkToPoint(pt)
    local ground = GetWorld()
    if ground then
		local tile = ground.Map:GetTileAtPoint(pt.x, pt.y, pt.z)
		return tile ~= GROUND.IMPASSIBLE and tile < GROUND.UNDERGROUND
	end
	return false
end

function BlinkStaff:CollectPointActions(doer, pos, actions, right)
    if right then
		if self:CanBlinkToPoint(pos) then
			table.insert(actions, ACTIONS.BLINK)
		end
	end
end

function BlinkStaff:SpawnEffect(inst)
	local pt = inst:GetPosition()
	local fx = SpawnPrefab("small_puff")
	fx.Transform:SetPosition(pt.x, pt.y, pt.z)

end

function BlinkStaff:Blink(pt, caster)
	if self:CanBlinkToPoint(pt) == false then
		return false
	end

	self:SpawnEffect(caster)
	caster.SoundEmitter:PlaySound("dontstarve/common/staff_blink")
	caster:Hide()
	if caster.components.health then
		caster.components.health:SetInvincible(true)
	end
	caster:DoTaskInTime(0.25, function() 
		if caster.components.health then
			caster.components.health:SetInvincible(false)
		end
		caster.Transform:SetPosition(pt.x, pt.y, pt.z)
		self:SpawnEffect(caster)
		caster:Show()
		caster.SoundEmitter:PlaySound("dontstarve/common/staff_blink")
		end)
	
	--TheCamera:Snap()
	if self.onblinkfn then
		self.onblinkfn(self.inst, pt, caster)
	end

	return true
end

return BlinkStaff
