local DefaultOnStrike = function(inst)
    if inst.components.health and not inst.components.health:IsDead() then
        local protected = false
        if GetPlayer().components.inventory:IsInsulated() then
            protected = true
        end

        if not protected then
            local mult = 1 + (TUNING.ELECTRIC_WET_DAMAGE_MULT * inst.components.moisture:GetMoisturePercent())
            local damage = -TUNING.LIGHTNING_DAMAGE * mult
            local healthpct = inst.components.health.currenthealth / inst.components.health.maxhealth
            damage = damage * healthpct
            if damage >= inst.components.health.currenthealth - 5 then
                damage = inst.components.health.currenthealth - 5
            end

            inst.components.health:DoDelta(damage, false, "lightning")
            inst.sg:GoToState("electrocute")
        else
            inst:PushEvent("lightningdamageavoided")
        end
    end
end

local PlayerLightningTarget = Class(function(self, inst)
    self.inst = inst
    self.hitchance = 0.3
    self.onstrikefn = DefaultOnStrike
end)

function PlayerLightningTarget:SetHitChance(chance)
	self.hitchance = chance
end

function PlayerLightningTarget:GetHitChance()
	return self.hitchance
end

function PlayerLightningTarget:SetOnStrikeFn(fn)
	self.onstrikefn = fn
end

function PlayerLightningTarget:DoStrike()
	if self.onstrikefn then
    	self.onstrikefn(self.inst)
	end
end

return PlayerLightningTarget