STATS_ENABLE = false
-- NOTE: There is also a call to 'anon/start' in dontstarve/main.cpp which has to be un/commented

--- non-user-facing Tracking stats  ---
TrackingEventsStats = {}
TrackingTimingStats = {}
function IncTrackingStat(stat, subtable)

    local t = TrackingEventsStats
    if subtable then
        t = TrackingEventsStats[subtable]

        if not t then
            t = {}
            TrackingEventsStats[subtable] = t
        end
    end

    t[stat] = 1 + (t[stat] or 0)
end

function SetTimingStat(subtable, stat, value)

    local t = TrackingTimingStats
    if subtable then
        t = TrackingTimingStats[subtable]

        if not t then
            t = {}
            TrackingTimingStats[subtable] = t
        end
    end

    t[stat] = math.floor(value/1000)
end


function SendTrackingStats()
	if GetTableSize(TrackingEventsStats) then
    	local stats = json.encode({events=TrackingEventsStats, timings=TrackingTimingStats})
    	TheSim:LogBulkMetric(stats)
    end
end

--- GAME Stats and details to be sent to server on game complete ---
ProfileStats = {}

function GetProfileStats(wipe)
	wipe = wipe or false
	local jsonstats = ''
	if GetTableSize(ProfileStats) then
    	jsonstats = json.encode({
    						stats = ProfileStats
    						})
    else
    	jsonstats = json.encode({})
    end
	if wipe then
		ProfileStats = {}
    end
    return jsonstats
end

function ProfileStatsSet(item, value)
    ProfileStats[item] = value
end

-- value is optional, 1 if nil
function ProfileStatsAdd(item, value)
    --print ("ProfileStatsAdd", item)
    if value == nil then
        value = 1
    end

    if ProfileStats[item] then
    	ProfileStats[item] = ProfileStats[item] + value
    else
    	ProfileStats[item] = value
    end
end

function ProfileStatsAddItemChunk(item, chunk)
    if ProfileStats[item] == nil then
    	ProfileStats[item] = {}
    end

    if ProfileStats[item][chunk] then
    	ProfileStats[item][chunk] =ProfileStats[item][chunk] +1
    else
    	ProfileStats[item][chunk] = 1
    end
end

function SendAccumulatedProfileStats()
	if not STATS_ENABLE then
		return
	end
	TheSim:SendProfileStats( GetProfileStats(true) )
end

--Periodically upload and refresh the player stats, so we always
--have up-to-date stats even if they close/crash the game.
StatsHeartbeatRemaining = 30
function AccumulatedStatsHeartbeat(dt)
    -- only fire this while in-game
    local player = GetPlayer()
    if player then
        ProfileStatsAdd("time_played", math.floor(dt*1000))
        StatsHeartbeatRemaining = StatsHeartbeatRemaining - dt
        if StatsHeartbeatRemaining < 0 then
            SendAccumulatedProfileStats()
            StatsHeartbeatRemaining = 120
        end
    end
end

function SubmitCompletedLevel()
	if not STATS_ENABLE then
		return
	end
	TheSim:SubmitCompletedLevel(GetProfileStats(true))
end

function SubmitStartStats(playercharacter)
	if not STATS_ENABLE then
		return
	end
	
	local query
	if PLATFORM == "NACL" then
		query = "/inst/get"
	else
		query = "/anon/new"
	end

	if STATS_ENABLE == true then
		TheSim:QueryServer( query, 
				function( result , isSuccessful )
					-- callback ignored on Windows, don't do anything important here
					Print(VERBOSITY.DEBUG, 'DoInitGame TheSim:QueryServer', query, isSuccessful, result)
				end, 
				"POST",
				json.encode({
								name= "Test name",
								size= "small",
								character= playercharacter
							}) 
				)
	end

end

function SubmitExitStats()
	if not STATS_ENABLE then
	    Shutdown()
		return
	end

	local query
	if PLATFORM == "NACL" then
		query = "/inst/exit"
	else
		query = "/anon/exit"
	end
	
	
	Print(VERBOSITY.DEBUG, 'About to send stats and exit!')

	TheSim:QueryServer( query, 
			function( result , isSuccessful )
				Print(VERBOSITY.DEBUG, 'DoInitGame TheSim:QueryServer', query, isSuccessful, result)
				Shutdown() -- doesn't matter if it succeeded or not, we're shutting down!
			end, 
			"POST",
			GetProfileStats(true),
			3 -- timeout in seconds
			)
end

function SubmitQuitStats()
	if not STATS_ENABLE then
		return
	end

	local query
	if PLATFORM == "NACL" then
		return
	else
		query = "/anon/quit"
	end
	
	TheSim:QueryServer( query, 
			function( result , isSuccessful )
				Print(VERBOSITY.DEBUG, 'DoInitGame TheSim:QueryServer', query, isSuccessful, result)
			end, 
			"POST",
			nil,
			3 -- timeout in seconds
			)
end

