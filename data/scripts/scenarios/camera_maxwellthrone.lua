local distToStart = 48
local distToStart_SQ = distToStart * distToStart
local distToFinish = 35
local distToFinish_SQ = distToFinish * distToFinish
local distToLerpOver = distToStart_SQ - distToFinish_SQ
local percentFromPlayer = 1

local function Lerp(a,b,t)
	return a + (b - a) * t
end

local function Update(inst)
	local distToTarget = inst:GetDistanceSqToInst(inst.objToTrack)
	if distToTarget < distToStart_SQ then
		TheCamera:SetControllable(false)
		percentFromPlayer = (distToTarget - distToFinish_SQ)/distToLerpOver
		if percentFromPlayer >= 0 and percentFromPlayer <= 1 then
			local camAngle = Lerp(0, inst.prevCamAngle, percentFromPlayer)
			local camDist = Lerp(20, inst.prevCamDist, percentFromPlayer)
			if percentFromPlayer < 0 then
				camDist = 20
				camAngle = 0
			end
			TheCamera:SetDistance(camDist)
			TheCamera:SetHeadingTarget(camAngle)
			TheCamera:Apply()
		end
	else
		TheCamera:SetControllable(true)
		inst.prevCamAngle = TheCamera:GetHeadingTarget()
		inst.prevCamDist = TheCamera:GetDistance()
	end
end

local function OnLoad(inst, scenariorunner)
	inst.objToTrack = GetPlayer()
	inst.updatetask = inst:DoPeriodicTask(0.05, Update)
	inst.prevCamDist = 30
	inst.prevCamAngle = 45
end

return 
{
	OnLoad = OnLoad,
}