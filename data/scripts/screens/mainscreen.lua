local Screen = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Menu = require "widgets/menu"
local Text = require "widgets/text"
local Image = require "widgets/image"
local UIAnim = require "widgets/uianim"
local Widget = require "widgets/widget"
require "os"

require "screens/worldgenscreen"
require "screens/popupdialog"
require "screens/playerhud"
require "screens/optionsscreen"
require "screens/emailsignupscreen"
require "screens/loadgamescreen"
require "screens/creditsscreen"
require "screens/modsscreen"
require "screens/controlsscreen"
require "screens/morguescreen"


local menu_spacing = 70
local bottom_offset = 60


MainScreen = Class(Screen, function(self, profile)
	Screen._ctor(self, "MainScreen")
    self.profile = profile
	self.log = true
	self:AddEventHandler("onsetplayerid", function(...) self:OnSetPlayerID(...) end)
	self:DoInit() 
	self.default_focus = self.menu
end)

function MainScreen:OnSetPlayerID(playerid)
	if self.playerid then
		self.playerid:SetString(STRINGS.UI.MAINSCREEN.GREETING.. " "..playerid)
	end
end

function MainScreen:OnControl(control, down)
	if MainScreen._base.OnControl(self, control, down) then return true end
	
	if not down and control == CONTROL_CANCEL then
		if not self.mainmenu then
			self:MainMenu()
			return true
		end
	end
end

function MainScreen:OnRawKey( key, down )

	if not self.focus then return end

	if not down and CHEATS_ENABLED then
		if key == KEY_RSHIFT then
			if TheInput:IsKeyDown(KEY_CTRL) then
				SaveGameIndex:DeleteSlot(1)
			elseif not SaveGameIndex:GetCurrentMode(1) then
				local function onsaved()
				    StartNextInstance({reset_action=RESET_ACTION.LOAD_SLOT, save_slot = 1})
				end
				SaveGameIndex:StartSurvivalMode(1, "wilson", {}, onsaved)
			else
    			StartNextInstance({reset_action=RESET_ACTION.LOAD_SLOT, save_slot = 1})
    		end
    		return true
		elseif key >= KEY_1 and key <= KEY_7 then
			local level_num = key - KEY_1 + 1
			
			local function onstart()
				StartNextInstance({reset_action=RESET_ACTION.LOAD_SLOT, save_slot = 1})
			end
			SaveGameIndex:FakeAdventure(onstart, 1, level_num)
			return true    		
		elseif key == KEY_0 then
			local function onstart()
				StartNextInstance({reset_action=RESET_ACTION.LOAD_SLOT, save_slot = 1})
			end
			SaveGameIndex:DeleteSlot(1, function() SaveGameIndex:EnterCave(onstart, 1, 1) end)
			return true
		elseif key == KEY_9 then
			local function onstart()
				StartNextInstance({reset_action=RESET_ACTION.LOAD_SLOT, save_slot = 1})
			end
			SaveGameIndex:DeleteSlot(1, function() SaveGameIndex:EnterCave(onstart, 1, 1, 2) end)
			return true
		elseif key == KEY_MINUS then
			StartNextInstance({reset_action="test", save_slot = 1})
			return true
		elseif key == KEY_M then
			self:OnModsButton()
			return true
		end
	end
end

function MainScreen:Buy()
	TheSim:SendJSMessage("MainScreen:Buy")
	TheFrontEnd:GetSound():KillSound("FEMusic")
end

function MainScreen:EnterKey()
	TheSim:SendJSMessage("MainScreen:EnterKey")
end

function MainScreen:SendGift()
	TheSim:SendJSMessage("MainScreen:Gift")
	TheFrontEnd:GetSound():KillSound("FEMusic")
end

function MainScreen:ProductKeys()
	TheSim:SendJSMessage("MainScreen:ProductKeys")
end

local function CheckTesting(fn)
	return function()
		
		if BRANCH == "staging" then
			TheFrontEnd:PushScreen(PopupDialogScreen(STRINGS.UI.MAINSCREEN.TESTING, STRINGS.UI.MAINSCREEN.TESTINGDETAIL,{
						{text=STRINGS.UI.MAINSCREEN.TESTINGYES, cb = function() fn() end},
						{text=STRINGS.UI.MAINSCREEN.TESTINGNO, cb = function() end}  
						}))
		else
			fn()
		end
	end
end


function MainScreen:Settings()
	TheFrontEnd:PushScreen(OptionsScreen(false))
end

function MainScreen:OnControlsButton()
	TheFrontEnd:PushScreen(ControlsScreen())
end

function MainScreen:EmailSignup()
	TheFrontEnd:PushScreen(EmailSignupScreen())
end

function MainScreen:Forums()
	VisitURL("http://forums.kleientertainment.com/index.php?/forum/5-dont-starve/")
end

function MainScreen:Rate()
	TheSim:SendJSMessage("MainScreen:Rate")
end

function MainScreen:Logout()
	TheSim:SendJSMessage("MainScreen:Logout")
end

function MainScreen:Quit()
	TheFrontEnd:PushScreen(PopupDialogScreen(STRINGS.UI.MAINSCREEN.ASKQUIT, STRINGS.UI.MAINSCREEN.ASKQUITDESC, {{text=STRINGS.UI.MAINSCREEN.YES, cb = function() RequestShutdown() end },{text=STRINGS.UI.MAINSCREEN.NO, cb = function() TheFrontEnd:PopScreen() end}  }))
end

local function get_timezone()
  local now = os.time()
  return os.difftime(now, os.time(os.date("!*t", now)))
end

local function GetDaysToUpdate()
    --require("date")
    local local_tz = get_timezone()
    
    local klei_tz = 28800--The time zone offset for vancouver
    local update_times =
		{
			os.time{year=2013, day=9, month=4, hour=13} - klei_tz,
			os.time{year=2013, day=18, month=4, hour=13} - klei_tz,
			os.time{year=2013, day=21, month=5, hour=13} - klei_tz,
			os.time{year=2013, day=11, month=6, hour=13} - klei_tz,
			os.time{year=2013, day=2, month=7, hour=13} - klei_tz,
			os.time{year=2013, day=26, month=7, hour=13} - klei_tz, -- modified for late release
			os.time{year=2013, day=20, month=8, hour=13} - klei_tz,
			os.time{year=2013, day=10, month=9, hour=13} - klei_tz,
			os.time{year=2013, day=1, month=10, hour=13} - klei_tz,
			os.time{year=2013, day=22, month=10, hour=13} - klei_tz,
		}
    table.sort(update_times)
    
    local build_time = TheSim:GetBuildDate()
    
    local last_build = build_time
    local now = os.time() - local_tz
    
    for k,v in ipairs(update_times) do
		if v > build_time then
			local seconds = v - now
			return math.ceil( (((seconds / 60) / 60) / 24) ), math.ceil( ((((now - last_build) / 60) / 60) / 24) )
		else
			last_build = v
		end
    end
end


function MainScreen:OnExitButton()
	if PLATFORM == "NACL" then
		self:Logout()
	else
		self:Quit()
	end
end


	
	
function MainScreen:UpdateDaysUntil()
	local days_until, days_since = GetDaysToUpdate()
	if days_until and days_since then
		if days_since <= 1 then
			self.days_since_string = string.format(STRINGS.UI.MAINSCREEN.FRESHBUILD)
		else
			self.days_since_string = string.format(STRINGS.UI.MAINSCREEN.LASTBUILDDAYS, days_since)
		end
		
		if days_until <= 1 then
			self.days_until_string = string.format(STRINGS.UI.MAINSCREEN.NEXTBUILDIMMINENT)
		else
			self.days_until_string = string.format(STRINGS.UI.MAINSCREEN.NEXTUPDATEDAYS, days_until) 
		end

		if days_until < 2 then
			self.daysuntilanim:GetAnimState():PlayAnimation("coming", true)
		elseif days_until < 7 then
			self.daysuntilanim:GetAnimState():PlayAnimation("about", true)
		else
			self.daysuntilanim:GetAnimState():PlayAnimation("fresh", true)
		end
		
		self.daysuntiltext:SetString( self.days_until_string)
	    
	else
		self.daysuntilanim:Hide()
		self.daysuntiltext:Hide()
	end
end


function MainScreen:DoInit( )
	
	TheFrontEnd:GetGraphicsOptions():DisableStencil()
	TheFrontEnd:GetGraphicsOptions():DisableLightMapComponent()
	
	TheFrontEnd:GetSound():PlaySound("dontstarve/music/music_FE","FEMusic")

	if PLATFORM == "NACL" then	
		TheSim:RequestPlayerID()
	end

	self.bg = self:AddChild(Image("images/ui.xml", "bg_plain.tex"))
    self.bg:SetTint(BGCOLOURS.RED[1],BGCOLOURS.RED[2],BGCOLOURS.RED[3], 1)

    self.bg:SetVRegPoint(ANCHOR_MIDDLE)
    self.bg:SetHRegPoint(ANCHOR_MIDDLE)
    self.bg:SetVAnchor(ANCHOR_MIDDLE)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
    self.bg:SetScaleMode(SCALEMODE_FILLSCREEN)
    
    self.fixed_root = self:AddChild(Widget("root"))
    self.fixed_root:SetVAnchor(ANCHOR_MIDDLE)
    self.fixed_root:SetHAnchor(ANCHOR_MIDDLE)
    self.fixed_root:SetScaleMode(SCALEMODE_PROPORTIONAL)

    local left_buffer = 175
	self.menu = self.fixed_root:AddChild(Menu(nil, -menu_spacing))
	

   
    self.shield = self.fixed_root:AddChild(Image("images/fepanels.xml", "panel_shield.tex"))
    self.shield:SetVRegPoint(ANCHOR_MIDDLE)
    self.shield:SetHRegPoint(ANCHOR_MIDDLE)

    self.banner = self.shield:AddChild(Image("images/ui.xml", "update_banner.tex"))
    self.banner:SetVRegPoint(ANCHOR_MIDDLE)
    self.banner:SetHRegPoint(ANCHOR_MIDDLE)
    self.banner:SetPosition(0, -210, 0)
    self.updatename = self.banner:AddChild(Text(BUTTONFONT, 30))
    self.updatename:SetPosition(0,8,0)
    local suffix = ""
    if BRANCH == "dev" then
		suffix = " (internal)"
    elseif BRANCH == "staging" then
		suffix = " (preview)"
    end
    self.updatename:SetString(STRINGS.UI.MAINSCREEN.UPDATENAME .. suffix)
    self.updatename:SetColour(0,0,0,1)

	--bottom left node - days until update indicator and sign up button    
	self.bottom_left_stuff = self.fixed_root:AddChild(Widget("bl"))
	self.bottom_left_stuff:SetPosition(-RESOLUTION_X/2 + left_buffer, -RESOLUTION_Y/2 + 200, 0)
	
	self.signup_button = self.bottom_left_stuff:AddChild(ImageButton())
    self.signup_button:SetPosition(0, -150, 0)
    self.signup_button:SetText(STRINGS.UI.MAINSCREEN.NOTIFY)
    self.signup_button:SetOnClick( function() self:EmailSignup() end )

	--[[
	self.forum_button = self.bottom_left_stuff:AddChild(ImageButton())
    self.forum_button:SetPosition(200, -150, 0)
    self.forum_button:SetText(STRINGS.UI.MAINSCREEN.FORUM)
    self.forum_button:SetOnClick( function() self:Forums() end )
--]]


    self.daysuntilanim = self.bottom_left_stuff:AddChild(UIAnim())
    self.daysuntilanim:GetAnimState():SetBuild("build_status")
    self.daysuntilanim:GetAnimState():SetBank("build_status")
    self.daysuntilanim:SetPosition(20,0,0)
    
    self.daysuntiltext = self.bottom_left_stuff:AddChild(Text(UIFONT, 30))
    self.daysuntiltext:SetHAlign(ANCHOR_MIDDLE)
    self.daysuntiltext:SetPosition(0,-80,0)
	self.daysuntiltext:SetRegionSize( 200, 50 )
	self.daysuntiltext:SetClickable(false)
	self:UpdateDaysUntil()
	
    
	self.motd = self.fixed_root:AddChild(Widget("motd"))
	self.motd:SetScale(.9,.9,.9)
	self.motd:SetPosition(-RESOLUTION_X/2+left_buffer, RESOLUTION_Y/2-200, 0)
	
	self.motdbg = self.motd:AddChild( Image( "images/globalpanels.xml", "panel.tex" ) )
	self.motdbg:SetScale(.75*.9,.75,.75)
	self.motd.motdtitle = self.motdbg:AddChild(Text(TITLEFONT, 50))
    self.motd.motdtitle:SetPosition(0, 130, 0)
	self.motd.motdtitle:SetRegionSize( 350, 60)
	self.motd.motdtitle:SetString(STRINGS.UI.MAINSCREEN.MOTDTITLE)

	self.motd.motdtext = self.motd:AddChild(Text(NUMBERFONT, 30))
    self.motd.motdtext:SetHAlign(ANCHOR_MIDDLE)
    self.motd.motdtext:SetVAlign(ANCHOR_TOP)
    self.motd.motdtext:SetPosition(0, -20, 0)
	self.motd.motdtext:SetRegionSize( 250, 160)
	self.motd.motdtext:SetString(STRINGS.UI.MAINSCREEN.MOTD)
	
	self.motd.button = self.motd:AddChild(ImageButton())
    self.motd.button:SetPosition(0, -100, 0)
    self.motd.button:SetText(STRINGS.UI.MAINSCREEN.MOTDBUTTON)
    self.motd.button:SetOnClick( function() VisitURL("http://bit.ly/ds-soundtrack") end )
	self.motd.motdtext:EnableWordWrap(true)   
    
	self.playerid = self.fixed_root:AddChild(Text(NUMBERFONT, 35))
	self.playerid:SetPosition(RESOLUTION_X/2 -400, RESOLUTION_Y/2 -60, 0)    
	self.playerid:SetRegionSize( 600, 50)
	self.playerid:SetHAlign(ANCHOR_RIGHT)


	if PLATFORM == "NACL" then

		self.purchasebutton = self.fixed_root:AddChild(ImageButton("images/ui.xml", "special_button.tex", "special_button_over.tex"))
		self.purchasebutton:SetScale(.5,.5,.5)
		self.purchasebutton:SetPosition(450,200,0)
		self.purchasebutton:SetFont(BUTTONFONT)
		self.purchasebutton:SetTextSize(80)

		if not IsGamePurchased() then
			self.purchasebutton:SetOnClick( function() self:Buy() end)
			self.purchasebutton:SetText( STRINGS.UI.MAINSCREEN.BUYNOW )
		else
			self.purchasebutton:SetOnClick( function() self:SendGift() end)
			self.purchasebutton:SetText( STRINGS.UI.MAINSCREEN.GIFT )
		end	
	end

	--focus moving
	self.motd.button:SetFocusChangeDir(MOVE_DOWN, self.signup_button)
	self.motd.button:SetFocusChangeDir(MOVE_RIGHT, self.menu)

	self.signup_button:SetFocusChangeDir(MOVE_UP, self.motd.button)
	self.signup_button:SetFocusChangeDir(MOVE_RIGHT, self.menu, -1)

	--[[
	self.forum_button:SetFocusChangeDir(MOVE_UP, self.motd.button)
	self.forum_button:SetFocusChangeDir(MOVE_RIGHT, self.menu, -1)
	self.forum_button:SetFocusChangeDir(MOVE_LEFT, self.signup_button)
	--]]
	
	local function left_from_menu()
		local focus = self:GetDeepestFocus();
		
		local up_diff = math.abs(focus:GetPosition().y - self.motd.button:GetPosition().y)
		local down_diff = math.abs(focus:GetPosition().y - self.signup_button:GetPosition().y)
		
		return up_diff < down_diff and self.motd.button or self.signup_button
	end

	self.menu:SetFocusChangeDir(MOVE_LEFT, left_from_menu)
	self:MainMenu()
	self.menu:SetFocus()
	
	if PLATFORM == "PS4" then
	    self.bottom_left_stuff:Hide()
	    self.motd:Hide()
	end
end




function MainScreen:Refresh()
	self:MainMenu()
	TheFrontEnd:GetSound():PlaySound("dontstarve/music/music_FE","FEMusic")
end

function MainScreen:ShowMenu(menu_items)
	self.mainmenu = false
	self.menu:Clear()
	
	for k,v in ipairs(menu_items) do
		self.menu:AddItem(v.text, v.cb, v.offset)
	end

	--self.menu:SetPosition(500, 0, 0)

	self.menu:SetPosition(RESOLUTION_X/2 -200 ,-RESOLUTION_Y/2 + bottom_offset + menu_spacing * (#menu_items-1),0)
	self.menu:SetFocus()
end


function MainScreen:DoOptionsMenu()
	local menu_items = {}



	if PLATFORM == "NACL" then
		table.insert( menu_items, {text=STRINGS.UI.MAINSCREEN.ACCOUNTINFO, cb= function() self:ProductKeys() end})
		if IsGamePurchased() then
			table.insert( menu_items, {text=STRINGS.UI.MAINSCREEN.ENTERKEY, cb= function() self:EnterKey() end})
		end
	end
	
	
	table.insert( menu_items, {text=STRINGS.UI.MAINSCREEN.SETTINGS, cb= function() self:Settings() end})
	table.insert(menu_items, {text=STRINGS.UI.MAINSCREEN.CONTROLS, cb= function() self:OnControlsButton() end})
	
	table.insert(menu_items, {text=STRINGS.UI.MAINSCREEN.CREDITS, cb= function() self:OnCreditsButton() end})
	
	if PLATFORM == "WIN32_STEAM" then
		table.insert( menu_items, {text=STRINGS.UI.MAINSCREEN.MOREGAMES, cb= function() VisitURL("http://store.steampowered.com/search/?developer=Klei%20Entertainment") end})
	end
	
	if BRANCH ~= "release" then
		table.insert( menu_items, {text=STRINGS.UI.MAINSCREEN.CHEATS, cb= function() self:CheatMenu() end})
	end
	
	table.insert( menu_items, {text=STRINGS.UI.MAINSCREEN.CANCEL, cb= function() self:MainMenu() end})
	self:ShowMenu(menu_items)
end

function MainScreen:OnModsButton()
	TheFrontEnd:PushScreen(ModsScreen(function(needs_reset)
		if needs_reset then
			SimReset()
		end

		TheFrontEnd:PopScreen()
	end))
end

function MainScreen:ResetProfile()
	TheFrontEnd:PushScreen(PopupDialogScreen(STRINGS.UI.MAINSCREEN.RESETPROFILE, STRINGS.UI.MAINSCREEN.SURE, {{text=STRINGS.UI.MAINSCREEN.YES, cb = function() self.profile:Reset() TheFrontEnd:PopScreen() end},{text=STRINGS.UI.MAINSCREEN.NO, cb = function() TheFrontEnd:PopScreen() end}  }))
end

function MainScreen:UnlockEverything()
	TheFrontEnd:PushScreen(PopupDialogScreen(STRINGS.UI.MAINSCREEN.UNLOCKEVERYTHING, STRINGS.UI.MAINSCREEN.SURE, {{text=STRINGS.UI.MAINSCREEN.YES, cb = function() self.profile:UnlockEverything() TheFrontEnd:PopScreen() end},{text=STRINGS.UI.MAINSCREEN.NO, cb = function() TheFrontEnd:PopScreen() end}  }))
end

function MainScreen:OnCreditsButton()
	TheFrontEnd:GetSound():KillSound("FEMusic")
	TheFrontEnd:PushScreen( CreditsScreen() )
end
	
function MainScreen:MorgueMenu()
	TheFrontEnd:GetSound():KillSound("FEMusic")
	TheFrontEnd:PushScreen( MorgueScreen() )
end

function MainScreen:CheatMenu()
	local menu_items = {}
	table.insert( menu_items, {text=STRINGS.UI.MAINSCREEN.UNLOCKEVERYTHING, cb= function() self:UnlockEverything() end})
	table.insert( menu_items, {text=STRINGS.UI.MAINSCREEN.RESETPROFILE, cb= function() self:ResetProfile() end})
	table.insert( menu_items, {text=STRINGS.UI.MAINSCREEN.CANCEL, cb= function() self:DoOptionsMenu() end})
	self:ShowMenu(menu_items)
end

function MainScreen:DoGenerateDEMOWorld()
	self.menu:Disable()
	StartNextInstance({reset_action=RESET_ACTION.DO_DEMO, save_slot = 1})
end

function MainScreen:MainMenu()
	
	local menu_items = {}
	local purchased = IsGamePurchased()
	if purchased then
		table.insert( menu_items, {text=STRINGS.UI.MAINSCREEN.PLAY, cb= function() TheFrontEnd:PushScreen(LoadGameScreen())end, offset = Vector3(0,20,0)})
	else
		table.insert(menu_items, {text=STRINGS.UI.MAINSCREEN.PLAYDEMO, cb= function() self:DoGenerateDEMOWorld() end})
		table.insert(menu_items, {text=STRINGS.UI.MAINSCREEN.ENTERPRODUCTKEY, cb= function() self:EnterKey() end})
	end

	table.insert( menu_items, {text=STRINGS.UI.MORGUESCREEN.MORGUE, cb= function() self:MorgueMenu() end})

	if PLATFORM ~= "NACL" and PLATFORM ~= "PS4" then
		table.insert( menu_items, {text=STRINGS.UI.MAINSCREEN.MODS, cb= function() self:OnModsButton() end})
	end

	table.insert(menu_items, {text=STRINGS.UI.MAINSCREEN.OPTIONS, cb= function() self:DoOptionsMenu() end})
	
	if PLATFORM ~= "PS4" then
	    table.insert(menu_items, {text=STRINGS.UI.MAINSCREEN.FORUM, cb= function() self:Forums() end})
	end
	
	
	if PLATFORM == "NACL" then
		table.insert( menu_items, {text=STRINGS.UI.MAINSCREEN.LOGOUT, cb= function() self:OnExitButton() end})
	elseif PLATFORM ~= "PS4" then
		table.insert( menu_items, {text=STRINGS.UI.MAINSCREEN.EXIT, cb= function() self:OnExitButton() end})
	end
	self:ShowMenu(menu_items)
	self.mainmenu = true
end
