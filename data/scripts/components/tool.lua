
local function PercentChanged(inst, data)
    if inst.components.tool
       and data.percent and data.percent <= 0
       and inst.components.inventoryitem and inst.components.inventoryitem.owner then
        inst.components.inventoryitem.owner:PushEvent("toolbroke", {tool = inst})
    end
end

local Tool = Class(function(self, inst)
    self.inst = inst
    
    self.inst:ListenForEvent("percentusedchange", PercentChanged)
end)


function Tool:SetAction(act)
    self.action = act
end

function Tool:CollectUseActions(doer, target, actions, right)
    if target:IsActionValid(self.action, right) then
        table.insert(actions, self.action)
    end
end

function Tool:CollectEquippedActions(doer, target, actions, right)
    if target:IsActionValid(self.action, right) then
        table.insert(actions, self.action)
    end
end


return Tool
