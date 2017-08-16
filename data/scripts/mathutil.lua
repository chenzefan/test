--Returns a sine wave based on game time. Mod will modify the period of the wave and abs is wether or not you want
-- the abs value of the wave
function GetSineVal(mod, abs, inst)	
    local time = (inst and inst:GetTimeAlive() or GetTime()) * (mod or 1)
    local val = math.sin(PI * time)
    if abs then
        return math.abs(val)
    else
        return val
    end
end

--Lerp a number from a to b over t
function Lerp(a,b,t)
    t = 1.0-math.cos(t*PI/2)
    return a + (b - a) * t
end

--Round a number to idp decimal points. Rounds up.
function RoundUp(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end


--Rounds numToRound to the nearest multiple of "mutliple"
function RoundToNearest(numToRound, multiple)
    local half = multiple/2
    return numToRound+half - (numToRound+half) % multiple
end