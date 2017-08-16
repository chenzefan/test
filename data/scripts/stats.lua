STATS_ENABLE = true
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


function BuildContextTable()
	local sendstats = {}

	sendstats.user = TheSim:GetUserID()
	if sendstats.user == nil then
		if BRANCH == "release" then
			sendstats.user = "unknown"
		else
			sendstats.user = "testing"
		end
	end
	if BRANCH ~= "release" then
		sendstats.user = sendstats.user
	end

	sendstats.branch = BRANCH

	sendstats.build = APP_VERSION

	if GetSeasonManager() then
		sendstats.season = GetSeasonManager():GetSeasonString()
	end

	if GetClock() then
		sendstats.day = GetClock().numcycles
	end

	if GetWorld() then
		local level_type = GetWorld().topology.level_type or "UNKNOWN"
		local level_id = GetWorld().level_id or "UNKNOWN"
		sendstats.level = level_type ..":".. level_id
	end

	return sendstats
end


--- GAME Stats and details to be sent to server on game complete ---
ProfileStats = {}

function GetProfileStats(wipe)
	if GetTableSize(ProfileStats) == 0 then
		return json.encode( {} )
	end

	wipe = wipe or false
	local jsonstats = ''
	local sendstats = BuildContextTable()

	sendstats.stats = ProfileStats

	jsonstats = json.encode( sendstats )

	if wipe then
		ProfileStats = {}
    end
    return jsonstats
end


function RecordDeathStats(killed_by, time_of_day, sanity, hunger, will_resurrect)
	if not STATS_ENABLE then
		return
	end

	local sendstats = BuildContextTable()
	sendstats.death = {
		killed_by=killed_by,
		time_of_day=time_of_day,
		sanity=sanity,
		hunger=hunger,
		will_resurrect=will_resurrect,
	}

	local jsonstats = json.encode( sendstats )
	print("Sending death stats...\n")
	print(jsonstats)
	TheSim:SendProfileStats( jsonstats )
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

function ProfileStatsSet(item, value)
	ProfileStats[item] = value
end

function SendAccumulatedProfileStats()
	if not STATS_ENABLE then
		return
	end
	local stats = GetProfileStats(true)
	--print("Sending stats...\n")
	--print(stats)
	TheSim:SendProfileStats( stats )
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
	SendAccumulatedProfileStats()
end

function SubmitStartStats(playercharacter)
	if not STATS_ENABLE then
		return
	end
	
	-- At the moment there are no special start stats.
end

function SubmitExitStats()
	if not STATS_ENABLE then
	    Shutdown()
		return
	end

	-- At the moment there are no special exit stats.
	Shutdown()
end

function SubmitQuitStats()
	if not STATS_ENABLE then
		return
	end

	-- At the moment there are no special quit stats.
end

