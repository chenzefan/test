local Firebug = Class(function(self, inst)
    self.inst = inst

    inst:ListenForEvent("enterdark", 
        function(inst, data) 
            self:Start()
        end)

    inst:ListenForEvent("enterlight", 
        function(inst, data) 
            self:Stop()
        end)    

end)

function Firebug:Start()
    self.inst:StartUpdatingComponent(self) 
    self.nextHitTime = 4+math.random()*1
    self.nextSoundTime = self.nextHitTime* (.4 + math.random()*.4)
end


function Firebug:Stop()
    self.inst:StopUpdatingComponent(self) 
end

function Firebug:OnUpdate(dt)
    if self.inst.components.health:IsDead() then
        self:Stop()
        return
    end
    
    if self.nextHitTime > 0 then
        self.nextHitTime = self.nextHitTime - dt
    else
		self.inst.components.talker:Say(GetString(self.inst.prefab, "ANNOUNCE_LIGHTFIRE"))		
		if self.prefab then
			local fire = SpawnPrefab(self.prefab)
			fire.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
		end
		
        self.nextHitTime = 4+math.random()*1
    end
    
end


return Firebug
