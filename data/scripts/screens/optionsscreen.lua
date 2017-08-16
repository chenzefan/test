require "util"
require "screen"
require "button"
require "animbutton"
require "image"
require "uianim"
require "spinner"
require "numericspinner"

require "screens/popupdialog"

local spinner_images = {
	arrow_normal = "data/images/spin_arrow.tex",
	arrow_over = "data/images/spin_arrow_over.tex",
	arrow_disabled = "data/images/spin_arrow_disabled.tex",
	bgtexture = "data/images/spinner.tex",
}

local text_font = DEFAULTFONT--NUMBERFONT

local enableDisableOptions = { { text = STRINGS.UI.OPTIONS.DISABLED, data = false }, { text = STRINGS.UI.OPTIONS.ENABLED, data = true } }
local spinnerFont = { font = text_font, size = 30 }
local spinnerHeight = 64

local function GetResolutionString( w, h )
	--return string.format( "%dx%d @ %dHz", w, h, hz )
	return string.format( "%d x %d", w, h )
end

local function SortKey( data )
	local key = data.w * 16777216 + data.h * 65536-- + data.hz
	return key
end

local function ValidResolutionSorter( a, b )
	return SortKey( a.data ) < SortKey( b.data )
end

local function GetDisplays()
	local gOpts = TheFrontEnd:GetGraphicsOptions()
	local num_displays = gOpts:GetNumDisplays()
	local displays = {}
	for i = 0, num_displays - 1 do
		local display_name = gOpts:GetDisplayName( i )
		table.insert( displays, { text = display_name, data = i } )
	end
	
	return displays
end

local function GetRefreshRates( display_id, resolution_id )
	local gOpts = TheFrontEnd:GetGraphicsOptions()
	
	local w, h, bpp, hz = gOpts:GetDisplayMode( display_id, resolution_id )
	local num_refresh_rates = gOpts:GetNumRefreshRates( display_id, w, h )
	
	local refresh_rates = {}
	for i = 0, num_refresh_rates - 1 do
		local refresh_rate = gOpts:GetRefreshRate( display_id, w, h, i )
		table.insert( refresh_rates, { text = string.format( "%d", refresh_rate ), data = refresh_rate } )
	end
	
	return refresh_rates
end


local function GetDisplayModes( display_id )
	local gOpts = TheFrontEnd:GetGraphicsOptions()
	local num_modes = gOpts:GetNumDisplayModes( display_id )
	
	local res_data = {}
	for i = 0, num_modes - 1 do
		local w, h, bpp, hz = gOpts:GetDisplayMode( display_id, i )
		if ( bpp == 24 or bpp == 32 ) then
			local res_str = GetResolutionString( w, h )
			res_data[ res_str ] = { w = w, h = h, bpp = bpp, hz = hz, idx = i }
		end
	end

	local valid_resolutions = {}
	for res_str, data in pairs( res_data ) do
		table.insert( valid_resolutions, { text = res_str, data = data } )
	end

	table.sort( valid_resolutions, ValidResolutionSorter )

	local result = {}
	for k, v in pairs( valid_resolutions ) do
		table.insert( result, { text = v.text, data = v.data.idx } )
	end

	return result
end

OptionsScreen = Class(Screen, function(self, in_game)
	Screen._ctor(self, "OptionsScreen")
	self.in_game = in_game
	--TheFrontEnd:DoFadeIn(2)

	local graphicsOptions = TheFrontEnd:GetGraphicsOptions()

	self.options = {
		fxvolume = TheMixer:GetLevel( "set_sfx" ) * 10,
		musicvolume = TheMixer:GetLevel( "set_music" ) * 10,
		ambientvolume = TheMixer:GetLevel( "set_ambience" ) * 10,
		bloom = graphicsOptions:IsBloomEnabled(),
		distortion = graphicsOptions:IsDistortionEnabled(),
		hudSize = Profile:GetHUDSize(),
	}

	--[[if PLATFORM == "WIN32_STEAM" and not self.in_game then
		self.options.steamcloud = TheSim:GetSetting("STEAM", "DISABLECLOUD") ~= "true"
	end--]]

	if PLATFORM ~= "NACL" then

		self.options.display = graphicsOptions:GetFullscreenDisplayID()
		self.options.refreshrate = graphicsOptions:GetFullscreenDisplayRefreshRate()
		self.options.fullscreen = graphicsOptions:IsFullScreen()

		local mode_id = graphicsOptions:GetCurrentDisplayModeID( self.options.display )
		self.options.resolution = mode_id
	end

	self.working = deepcopy( self.options )
	self:DoInit()
	self:InitializeSpinners()
end)

function OptionsScreen:OnKeyUp( key )
	if key == KEY_ENTER then
		self:Accept()
	elseif key == KEY_ESCAPE then
		self:Close()
	end
end

function OptionsScreen:Accept()
	self:Save(function() self:Close() end )
end

function OptionsScreen:Save(cb)
	self.options = deepcopy( self.working )

	Profile:SetVolume( self.options.ambientvolume, self.options.fxvolume, self.options.musicvolume )
	Profile:SetBloomEnabled( self.options.bloom )
	Profile:SetDistortionEnabled( self.options.distortion )
	Profile:SetHUDSize( self.options.hudSize )
	
	Profile:Save( function() if cb then cb() end end)	
end

function OptionsScreen:RevertChanges()
	self:Restore()
end

function OptionsScreen:Restore()
	self.working = deepcopy( self.options )
	self:Apply()
	self:ApplyAndConfirm( true )
	self:InitializeSpinners()
end

function OptionsScreen:ApplyAndConfirm( force )
	if not self.applying then
		self.applying = true

		if PLATFORM ~= "NACL" then
			local gopts = TheFrontEnd:GetGraphicsOptions()
			gopts:SetDisplayMode( self.working.display, self.working.resolution, self.working.fullscreen )
		end

		if not force then
			local this = self
			TheFrontEnd:PushScreen(
				PopupDialogScreen( STRINGS.UI.OPTIONS.ACCEPTTITLE, STRINGS.UI.OPTIONS.ACCEPTBODY,
				  { { text = STRINGS.UI.OPTIONS.ACCEPT, cb =
						function()
							this:Save()
						end
					},
					{ text = STRINGS.UI.OPTIONS.CANCEL, cb =
						function()
							print( "CANCEL" )
							this:Restore()
						end
					}
				  },
				  { timeout = 10, cb =
					function()
						TheFrontEnd:PopScreen()
						this:Restore()
					end
				  }
				)
			)
		end
		self:InitializeSpinners()
		self.applying = false
	end
end

function OptionsScreen:Apply( force )
	TheMixer:SetLevel("set_sfx", self.working.fxvolume / 10 )
	TheMixer:SetLevel("set_music", self.working.musicvolume / 10 )
	TheMixer:SetLevel("set_ambience", self.working.ambientvolume / 10 )
	
	local gopts = TheFrontEnd:GetGraphicsOptions()
	gopts:SetBloomEnabled( self.working.bloom )
	gopts:SetDistortionEnabled( self.working.distortion )
end

function OptionsScreen:Close()
	--TheFrontEnd:DoFadeIn(2)
	TheFrontEnd:PopScreen()
end	

local function MakeMenu(offset, menuitems)
	local menu = Widget("OptionsMenu")	
	local pos = Vector3(0,0,0)
	for k,v in ipairs(menuitems) do
		local button = menu:AddChild(AnimButton("button"))
	    button:SetPosition(pos)
	    button:SetText(v.text)
	    button.text:SetColour(0,0,0,1)
	    button:SetOnClick( v.cb )
	    button:SetFont(BUTTONFONT)
	    button:SetTextSize(40)    
	    pos = pos + offset  
	end
	return menu
end

function OptionsScreen:AddSpinners( data, user_offset )
	local master_group = self.root:AddChild( Widget( "SpinnerGroup" ) )

	local offset = { 0, 0, 0 }
	if user_offset then
		offset[1] = offset[1] + user_offset[1]
		offset[2] = offset[2] + user_offset[2]
		offset[3] = offset[3] + user_offset[3]
	end
	master_group:SetPosition( offset[1], offset[2], offset[2] )

	local label_width = 200
	for idx, entry in ipairs( data ) do
		local text = entry[1]
		local spinner = entry[2]

		local group = master_group:AddChild( Widget( "SpinnerGroup" ) )
		group:SetPosition( 0, ( idx - 1 ) * -75 + 25, 0 )

		local label = group:AddChild( Text( DEFAULTFONT, 30, text ) )
		label:SetPosition( 0.5 * label_width, 0, 0 )
		label:SetRegionSize( label_width, 50 )
		label:SetHAlign( ANCHOR_RIGHT )
		
		group:AddChild( spinner )
		spinner:SetPosition( label_width + 32, 0, 0 )
	end
	
	return master_group
end

function OptionsScreen:DoInit()
    self.bg = self:AddChild(Image("data/images/bg_red.tex"))
    self.bg:SetVRegPoint(ANCHOR_MIDDLE)
    self.bg:SetHRegPoint(ANCHOR_MIDDLE)
    self.bg:SetVAnchor(ANCHOR_MIDDLE)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
    self.bg:SetScaleMode(SCALEMODE_FILLSCREEN)
    
	self.root = self:AddChild(Widget("ROOT"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0,0,0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    
	local shield = self.root:AddChild( Image( "data/images/panel.tex" ) )
	shield:SetPosition( 0,0,0 )
	shield:SetSize( 1000, 700 )	
    
    
	local menu_items = {
		{ text = STRINGS.UI.OPTIONS.REVERT, cb = function() self:RevertChanges() end },
		{ text = STRINGS.UI.OPTIONS.CLOSE, cb = function() self:Accept() end },
	}
	
	if PLATFORM ~= "NACL" then
		table.insert(menu_items, 1, { text = STRINGS.UI.OPTIONS.APPLY, cb = function() self:ApplyAndConfirm() end })
	end

	local menu_spacing = 60
	local bottom_offset = 60
	self.menu = self.root:AddChild( MakeMenu( Vector3(0, -menu_spacing, 0), menu_items) )
	self.menu:SetPosition(RESOLUTION_X/2 -200 ,-RESOLUTION_Y/2 + bottom_offset + menu_spacing * (#menu_items-1),0)


	local this = self
	
	if PLATFORM ~= "NACL" then
		local gOpts = TheFrontEnd:GetGraphicsOptions()
	
		self.fullscreenSpinner = self.root:AddChild(Spinner( enableDisableOptions, 150, spinnerHeight, spinnerFont, spinner_images ))
		self.fullscreenSpinner.OnChanged =
			function( self, data )
				this.working.fullscreen = data
				this:UpdateResolutionsSpinner()
			end
		
		if gOpts:IsFullScreenEnabled() then
			self.fullscreenSpinner:Enable()
		else
			self.fullscreenSpinner:Disable()
		end

		local valid_displays = GetDisplays()
		self.displaySpinner = self.root:AddChild(Spinner( valid_displays, 150, spinnerHeight, spinnerFont, spinner_images ))
		self.displaySpinner.OnChanged =
			function( self, data )
				this.working.display = data
				this:UpdateResolutionsSpinner()
				this:UpdateRefreshRatesSpinner()
			end
		
		local refresh_rates = GetRefreshRates( self.working.display, self.working.resolution )
		self.refreshRateSpinner = self.root:AddChild(Spinner( refresh_rates, 150, spinnerHeight, spinnerFont, spinner_images ))
		self.refreshRateSpinner.OnChanged =
			function( self, data )
				this.working.refreshrate = data
			end

		local modes = GetDisplayModes( self.working.display, self.working.refreshrate )
		self.resolutionSpinner = self.root:AddChild(Spinner( modes, 150, spinnerHeight, spinnerFont, spinner_images ))
		self.resolutionSpinner.OnChanged =
			function( self, data )
				this.working.resolution = data
				this:UpdateRefreshRatesSpinner()
			end						
	end
	

	self.bloomSpinner = self.root:AddChild(Spinner( enableDisableOptions, 150, spinnerHeight, spinnerFont, spinner_images ))
	self.bloomSpinner.OnChanged =
		function( self, data )
			this.working.bloom = data
			this:Apply()
		end
		
	self.distortionSpinner = self.root:AddChild(Spinner( enableDisableOptions, 150, spinnerHeight, spinnerFont, spinner_images ))
	self.distortionSpinner.OnChanged =
		function( self, data )
			print( "DISTORTION", data )
			this.working.distortion = data
			this:Apply()
		end

	self.fxVolume = self.root:AddChild(NumericSpinner( 0, 10, 50, spinnerHeight, spinnerFont, spinner_images ))
	self.fxVolume.OnChanged =
		function( self, data )
			this.working.fxvolume = data
			this:Apply()
		end

	self.musicVolume = self.root:AddChild(NumericSpinner( 0, 10, 50, spinnerHeight, spinnerFont, spinner_images ))
	self.musicVolume.OnChanged =
		function( self, data )
			this.working.musicvolume = data
			this:Apply()
		end

	self.ambientVolume = self.root:AddChild(NumericSpinner( 0, 10, 50, spinnerHeight, spinnerFont, spinner_images ))
	self.ambientVolume.OnChanged =
		function( self, data )
			this.working.ambientvolume = data
			this:Apply()
		end
		
	self.hudSize = self.root:AddChild(NumericSpinner( 0, 10, 50, spinnerHeight, spinnerFont, spinner_images ))
	self.hudSize.OnChanged =
		function( self, data )
			this.working.hudSize = data
			this:Apply()
		end
		
		
	local gfx_spinners = {}
	local sound_spinners = {}
	
	local gfx_pos = nil
	local sound_pos = nil
	local bg_pos = nil
	local bg_size = nil
	
	
	if PLATFORM ~= "NACL" then
		table.insert( gfx_spinners , { STRINGS.UI.OPTIONS.BLOOM, self.bloomSpinner } )
		table.insert( gfx_spinners , { STRINGS.UI.OPTIONS.DISTORTION, self.distortionSpinner } )

		table.insert( gfx_spinners, { STRINGS.UI.OPTIONS.FULLSCREEN, self.fullscreenSpinner } )
		table.insert( gfx_spinners, { STRINGS.UI.OPTIONS.DISPLAY, self.displaySpinner } )
		table.insert( gfx_spinners, { STRINGS.UI.OPTIONS.RESOLUTION, self.resolutionSpinner } )
		table.insert( gfx_spinners, { STRINGS.UI.OPTIONS.REFRESHRATE, self.refreshRateSpinner } )

		gfx_pos = { -RESOLUTION_X/2+175, 150, 0 }
		sound_pos = { 0, 0, 0 }
		
	else
		table.insert( sound_spinners, { "Bloom:", self.bloomSpinner } )
		table.insert( sound_spinners, { "Distortion:", self.distortionSpinner } )
		
		gfx_pos = { -RESOLUTION_X/2+175, 0, 0 }
		sound_pos = { 0, 0, 0 }
	end

	table.insert( sound_spinners, { "FX:", self.fxVolume } )
	table.insert( sound_spinners, { "Music:", self.musicVolume } )
	table.insert( sound_spinners, { "Ambient:", self.ambientVolume } )
	table.insert( sound_spinners, { "HUD size:", self.hudSize} )


	local gfx_group = self:AddSpinners( gfx_spinners, gfx_pos )
	local sound_group = self:AddSpinners( sound_spinners, sound_pos )
	
	
end

local function EnabledOptionsIndex( enabled )
	if enabled then
		return 2
	else
		return 1
	end
end

function OptionsScreen:InitializeSpinners()
	if PLATFORM ~= "NACL" then
		self.fullscreenSpinner:SetSelectedIndex( EnabledOptionsIndex( self.working.fullscreen ) )
		self:UpdateDisplaySpinner()
		self:UpdateResolutionsSpinner()
		self:UpdateRefreshRatesSpinner()
	end

	--[[if PLATFORM == "WIN32_STEAM" and not self.in_game then
		self.steamcloudSpinner:SetSelectedIndex( EnabledOptionsIndex( self.working.steamcloud ) )
	end
	--]]
	
	self.bloomSpinner:SetSelectedIndex( EnabledOptionsIndex( self.working.bloom ) )
	self.distortionSpinner:SetSelectedIndex( EnabledOptionsIndex( self.working.distortion ) )

	local spinners = { fxvolume = self.fxVolume, musicvolume = self.musicVolume, ambientvolume = self.ambientVolume }
	for key, spinner in pairs( spinners ) do
		local volume = self.working[ key ] or 7
		spinner:SetSelectedIndex( math.floor( volume + 0.5 ) )
	end
	
	self.hudSize:SetSelectedIndex( self.working.hudSize or 5)
end

function OptionsScreen:UpdateDisplaySpinner()
	if PLATFORM ~= "NACL" then
		local graphicsOptions = TheFrontEnd:GetGraphicsOptions()
		local display_id = graphicsOptions:GetFullscreenDisplayID() + 1
		self.displaySpinner:SetSelectedIndex( display_id )
	end
end

function OptionsScreen:UpdateRefreshRatesSpinner()
	if PLATFORM ~= "NACL" then
		local current_refresh_rate = self.working.refreshrate
		
		local refresh_rates = GetRefreshRates( self.working.display, self.working.resolution )
		self.refreshRateSpinner:SetOptions( refresh_rates )
		
		for idx, refresh_rate_data in ipairs( refresh_rates ) do
			if refresh_rate_data.data == current_refresh_rate then
				self.refreshRateSpinner:SetSelectedIndex( idx )
				break
			end
		end
		
		self.working.refreshrate = self.refreshRateSpinner:GetSelected().data		
	end
end

function OptionsScreen:UpdateResolutionsSpinner()
	if PLATFORM ~= "NACL" then
		local resolutions = GetDisplayModes( self.working.display, self.working.refreshrate )
		self.resolutionSpinner:SetOptions( resolutions )
	
		if self.fullscreenSpinner:GetSelected().data then
			self.displaySpinner:Enable()
			self.refreshRateSpinner:Enable()
			self.resolutionSpinner:Enable()

			local spinner_idx = 1
			if self.working.resolution then
				for idx, res_data in pairs( GetDisplayModes( self.working.display, self.working.refreshrate ) ) do
					if res_data.data == self.working.resolution then
						spinner_idx = idx
						break
					end
				end
			end
			self.resolutionSpinner:SetSelectedIndex( spinner_idx )
		else
			self.displaySpinner:Disable()
			self.refreshRateSpinner:Disable()
			self.resolutionSpinner:Disable()
		end
	end
end

