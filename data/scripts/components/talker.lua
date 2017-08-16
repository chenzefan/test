Line = Class(function(self, message, duration)
    self.message = message
    self.duration = duration
end)


local Talker = Class(function(self, inst)
    self.inst = inst
    self.task = nil
    self.ignoring = false
    if not inst.Label then
        self.inst.entity:AddLabel()
    end
end)

function Talker:IgnoreAll()
    self.ignoring = true
end

function Talker:StopIgnoringAll()
    self.ignoring = false
end

local function sayfn(inst, script)
    for k,line in ipairs(script) do
        
        if line.message then
            inst.Label:Enable(true)
            inst.Label:SetText(line.message)
            inst:PushEvent("ontalk")
        else
            inst.Label:Enable(false)
        end
        
        Sleep(line.duration)
    
    end
    
    inst.Label:Enable(false)
    inst:PushEvent("donetalking")

end

function Talker:ShutUp()
    if self.task then
        scheduler:KillTask(self.task)
        self.inst.Label:Enable(false)
    end
end


function Talker:Say(script, time)
    if self.inst.components.health and  self.inst.components.health:IsDead() then
        return
    end
    
    if self.inst.components.sleeper and  self.inst.components.sleeper:IsAsleep() then
        return
    end
    
    if self.ignoring then
        return
    end
    
	if self.ontalk then
		self.ontalk(self.inst, script)
	end
    
    local lines = nil
    if type(script) == "string" then
        lines = {Line(script, time or 2.5)}
    else
        lines = script
    end

    self:ShutUp()
    if lines then
        self.task = self.inst:StartThread( function() sayfn(self.inst, lines) end)    
    end
end



return Talker
