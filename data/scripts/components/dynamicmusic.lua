local DynamicMusic = Class(function(self, inst)
    self.inst = inst
    self.inst:StartUpdatingComponent(self)
    
    self.is_busy = false
    self.busy_timeout = 0
    
    self.playing_danger = false
    
    self.inst.SoundEmitter:PlaySound( "dontstarve/music/music_work", "busy")
    self.inst.SoundEmitter:SetParameter( "busy", "intensity", 0 )
    
    self.inst:ListenForEvent( "gotnewitem", function() self:OnContinueBusy() end )  
    self.inst:ListenForEvent( "dropitem", function() self:OnContinueBusy() end )  
    
    self.inst:ListenForEvent( "attacked", function(inst, dat)
        if dat.attacker
           and dat.attacker ~= self.inst
           and not dat.attacker:HasTag("shadow") then
            self:OnStartDanger()
        end
    end )  
    self.inst:ListenForEvent( "doattack", function(inst, dat)
		if dat.target
		   and not dat.target:HasTag("prey")
			and not dat.target:HasTag("bird")
			and not dat.target:HasTag("wall")
			and not dat.target:HasTag("butterfly")
			and not dat.target:HasTag("shadow")
			and not dat.target:HasTag("veggie") then
			self:OnStartDanger()
		end
	end )  
    
  
    self.inst:ListenForEvent( "dusktime", function(it, data) 
            
            if not self.playing_danger then
                self:StopPlayingBusy()
                self.inst.SoundEmitter:PlaySound( "dontstarve/music/music_dusk_stinger")
            end
            
            
        end, GetWorld())      

    self.inst:ListenForEvent( "daytime", function(it, data) 
    
    
            if data.day > 0 and not self.playing_danger then
                self:StopPlayingBusy()
                self.inst.SoundEmitter:PlaySound( "dontstarve/music/music_dawn_stinger")
            end
            
        end, GetWorld())      

    self.inst:ListenForEvent( "nighttime", function(it, data) 
        end, GetWorld())      
    
    
    inst:ListenForEvent( "builditem", function(it, data) self:OnStartBusy() end)  
    inst:ListenForEvent( "buildstructure", function(it, data) self:OnStartBusy() end)  
    inst:ListenForEvent( "working", function(it, data) self:OnStartBusy() end)  
    
    
end)


function DynamicMusic:StopPlayingBusy()
    self.inst.SoundEmitter:SetParameter( "busy", "intensity", 0 )
end

function DynamicMusic:OnStartBusy()
    local day = GetClock():IsDay()

    if day then
        self.busy_timeout = 15
        
        if not self.is_busy then
            self.is_busy = true
            if not self.playing_danger then
                self.inst.SoundEmitter:SetParameter( "busy", "intensity", 1 )
            end
        end
    end
end


function DynamicMusic:OnStartDanger()
    self.danger_timeout = 10
    if not self.playing_danger then
        local epic = GetClosestInstWithTag("epic", self.inst, 30)
        
        self.inst.SoundEmitter:PlaySound(epic and "dontstarve/music/music_epicfight" or "dontstarve/music/music_danger", "danger")
        self:StopPlayingBusy()
        self.playing_danger = true
    end
end

function DynamicMusic:OnContinueBusy()
    if self.is_busy then
        self.busy_timeout = 10
    end
end

function DynamicMusic:OnUpdate(dt)

    if self.danger_timeout and self.danger_timeout > 0 then
        self.danger_timeout = self.danger_timeout - dt
        if self.danger_timeout <= 0 then
            self.inst.SoundEmitter:KillSound("danger")
            self.playing_danger = false
        end
    end

    if self.busy_timeout and self.busy_timeout > 0 then
        self.busy_timeout = self.busy_timeout - dt
        if self.busy_timeout <= 0 then
            self:StopPlayingBusy()
            self.is_busy = false
        end
    end
end



return DynamicMusic

