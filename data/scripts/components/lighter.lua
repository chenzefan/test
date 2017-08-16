local Lighter = Class(function(self, inst)
    self.inst = inst
end)

function Lighter:CollectUseActions(doer, target, actions)
    if target.components.burnable then
        if not target.components.burnable:IsBurning() and target.components.burnable.canlight then
        
			local is_empty = target.components.fueled and target.components.fueled:GetPercent() <= 0
			if not is_empty then
				table.insert(actions, ACTIONS.LIGHT)
			end
        end
    end
end

function Lighter:CollectEquippedActions(doer, target, actions, right)
    if right and target.components.burnable then
        if not target.components.burnable:IsBurning() and target.components.burnable.canlight then
			local is_empty = target.components.fueled and target.components.fueled:GetPercent() <= 0
			if not is_empty then
				table.insert(actions, ACTIONS.LIGHT)
			end
        end
    end
end

return Lighter