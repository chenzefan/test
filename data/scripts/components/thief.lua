local Thief = Class(function(self, inst)
    self.inst = inst
    self.stolenitems = {}
    self.onstolen--[[inst, victim, item]] = nil
end)

function Thief:SetOnStolenFn(fn)
    self.onstolen = fn
end

function Thief:StealItem(victim)
    if victim.components.inventory then
        local item = victim.components.inventory:FindItem(function(item) return not item:HasTag("nosteal") end)
        if item then
            local direction = Vector3(self.inst.Transform:GetWorldPosition()) - Vector3(victim.Transform:GetWorldPosition() )
            victim.components.inventory:DropItem(item, false, direction:GetNormalized() )
            table.insert(self.stolenitems, item)
            if self.onstolen then
                self.onstolen(self.inst, victim, item)
            end
        end
    end
end

return Thief