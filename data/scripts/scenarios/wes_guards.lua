local function Unlock(inst, scenariorunner)
	inst:Unlock(inst)
	scenariorunner:ClearScenario()	
end



local function OnLoad(inst, scenariorunner)
--Anything that needs to happen every time the game loads.


end

return 
{
	OnLoad = OnLoad
}