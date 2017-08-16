local Repairable = Class(function(self, inst)
    self.inst = inst
    self.repairmaterial = nil
end)

function Repairable:Repair(doer, repair_item)
	if self.inst.components.health and self.inst.components.health:GetPercent() < 1 then
		if repair_item.components.repairer and self.repairmaterial == repair_item.components.repairer.repairmaterial then
			if self.inst.components.health.DoDelta then
                self.inst.components.health:DoDelta(repair_item.components.repairer.value)
            end
			
			if repair_item.components.stackable then
				repair_item.components.stackable:Get():Remove()
			else
				repair_item:Remove()
			end
			
			if self.onrepaired then
				self.onrepaired(self.inst, doer, repair_item)
			end
			return true
		end
    elseif self.inst.components.workable.workleft and self.inst.components.workable.workleft < self.inst.components.workable.maxwork then
		if repair_item.components.repairer and self.repairmaterial == repair_item.components.repairer.repairmaterial then
	        self.inst.components.workable:SetWorkLeft( self.inst.components.workable.workleft + repair_item.components.repairer.value )
			
			if repair_item.components.stackable then
				repair_item.components.stackable:Get():Remove()
			else
				repair_item:Remove()
			end

			if self.onrepaired then
				self.onrepaired(self.inst, doer, repair_item)
			end
			return true
        end
	end
end

return Repairable
