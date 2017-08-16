local easing = require("easing")


local IDENTITY_COLOURCUBE = "data/images/colour_cubes/identity_colourcube.tex"

local INSANITY_CCS =
{
	DAY = "data/images/colour_cubes/insane_day_cc.tex",
	DUSK = "data/images/colour_cubes/insane_dusk_cc.tex",
	NIGHT = "data/images/colour_cubes/insane_night_cc.tex",
}

local SEASON_CCS = {
	[SEASONS.SUMMER] = {	DAY = "data/images/colour_cubes/day05_cc.tex",
							DUSK = "data/images/colour_cubes/dusk03_cc.tex",
							NIGHT = "data/images/colour_cubes/night03_cc.tex",
					   },
	[SEASONS.WINTER] = {	DAY = "data/images/colour_cubes/snow_cc.tex",
							DUSK = "data/images/colour_cubes/snowdusk_cc.tex",
							NIGHT = "data/images/colour_cubes/night04_cc.tex",
						},
	[SEASONS.CAVES] = {		DAY = "data/images/colour_cubes/caves_default.tex",
							DUSK = "data/images/colour_cubes/caves_default.tex",
							NIGHT = "data/images/colour_cubes/caves_default.tex",
						},
}


local ColourCubeManager = Class(function(self, inst)


	self.CURRENT_DEST_CC = {
		[0] = IDENTITY_COLOURCUBE,
		[1] = IDENTITY_COLOURCUBE,
	}


	self:RegisterTimeColourCube( inst, "daytime", "NIGHT", "DAY", 4 )
	self:RegisterTimeColourCube( inst, "dusktime", "DAY", "DUSK", 6 )
	self:RegisterTimeColourCube( inst, "nighttime", "DUSK", "NIGHT", 8 )
	
	inst:ListenForEvent( "seasonChange",
		function( inst, data )
			self:UpdateAndTransitionCC( 0, inst, 10 )
		end, GetWorld())
		
	local cc = SEASON_CCS[ SEASONS.SUMMER ].NIGHT
	local insanity_cc = INSANITY_CCS.NIGHT
	local clock = GetClock()
	if clock then
		if clock:IsDay() then
			cc = SEASON_CCS[ SEASONS.SUMMER ].DAY
			insanity_cc = INSANITY_CCS.DAY
		elseif clock:IsDusk() then
			cc = SEASON_CCS[ SEASONS.SUMMER ].DUSK
			insanity_cc = INSANITY_CCS.DUSK
		end
	end

	self.CURRENT_DEST_CC[ 0 ] = cc
	self.CURRENT_DEST_CC[ 1 ] = IDENTITY_COLOURCUBE
	PostProcessor:SetColourCubeData( 0, cc, cc )
	PostProcessor:SetColourCubeLerp( 0, 0 )

	PostProcessor:SetColourCubeData( 1, insanity_cc, insanity_cc )
	PostProcessor:SetColourCubeLerp( 1, 0 )

	self:UpdateAndTransitionCC(0, inst, .1)
end)


function ColourCubeManager:UpdateCCLerp( total_time )
    local tick_time = TheSim:GetTickTime()

    local time_left = total_time
    while time_left > 0 do
        PostProcessor:SetColourCubeLerp( 0, 1.0 - time_left / total_time )
        time_left = time_left - tick_time
		Yield()
    end
end

function ColourCubeManager:RegisterTimeColourCube( inst, event, start_cc, end_cc, length )
    inst:ListenForEvent( event,
        function(inst, data)
			local CURRENT_SEASON = GetSeasonManager():GetSeason()
			PostProcessor:SetColourCubeData( 0, SEASON_CCS[ CURRENT_SEASON ][ start_cc ], SEASON_CCS[ CURRENT_SEASON ][ end_cc ] )
			PostProcessor:SetColourCubeLerp( 0, 0 )
			self.CURRENT_DEST_CC[ 0 ] = SEASON_CCS[ CURRENT_SEASON ][ end_cc ]

			PostProcessor:SetColourCubeData( 1, INSANITY_CCS[ start_cc ], INSANITY_CCS[ end_cc ] )
			PostProcessor:SetColourCubeLerp( 1, 0 )
			self.CURRENT_DEST_CC[ 1 ] = INSANITY_CCS[ end_cc ]

            StartThread( function() self:UpdateCCLerp( length ) end, inst.GUID )
        end, GetWorld())
end

function ColourCubeManager:GetCCToActivate()
	local clock = GetClock()
	if clock then
		local CURRENT_SEASON = GetSeasonManager():GetSeason()
		local season = SEASON_CCS[ CURRENT_SEASON ]
		
		if clock:IsDay() then
			return season.DAY
		elseif clock:IsDusk() then
			return season.DUSK
		elseif clock:IsNight() then
			return season.NIGHT
		end
	end
end


function ColourCubeManager:UpdateAndTransitionCC( index, inst, time )
	local cc = self:GetCCToActivate()
	local current_cc = self.CURRENT_DEST_CC[ index ]
	PostProcessor:SetColourCubeData( index, current_cc, cc )
	self.CURRENT_DEST_CC[ index ] = cc

	StartThread( function()
		local time_left = time
		local tick_time = TheSim:GetTickTime()

		while time_left > 0 do
			local lerp = 1.0 - math.min( 1, math.max( 0, time_left / time ) )
			PostProcessor:SetColourCubeLerp( 0, lerp )
			time_left = time_left - tick_time
			Yield()
		end
	end, inst.GUID )
end


return ColourCubeManager