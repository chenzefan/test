local Screen = require "widgets/screen"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Spinner = require "widgets/spinner"
local NumericSpinner = require "widgets/numericspinner"
local Text = require "widgets/text"
local Image = require "widgets/image"
require "screens/popupdialog"
local Toggle = require "widgets/toggle"
local Widget = require "widgets/widget"

local controls_per_screen = 10
local controls_per_scroll = 10


local controls = {    
	--clicking
    CONTROL_PRIMARY,
    CONTROL_SECONDARY,
    
    --click modifiers
    CONTROL_FORCE_INSPECT,
    CONTROL_FORCE_ATTACK,
    
    --actions	
	CONTROL_ATTACK,
    CONTROL_ACTION,
    
    --walking
    CONTROL_MOVE_UP,
    CONTROL_MOVE_DOWN,
    CONTROL_MOVE_LEFT,
    CONTROL_MOVE_RIGHT,

    -- view controls
    CONTROL_ZOOM_IN,
    CONTROL_ZOOM_OUT,
    CONTROL_ROTATE_LEFT,
    CONTROL_ROTATE_RIGHT,

    -- player movement controls
    CONTROL_PAUSE,
    CONTROL_MAP,

	--menu controls
    CONTROL_FOCUS_UP,
    CONTROL_FOCUS_DOWN,
    CONTROL_FOCUS_LEFT,
    CONTROL_FOCUS_RIGHT,
    CONTROL_ACCEPT,
    CONTROL_CANCEL,
    CONTROL_PAGELEFT,
    CONTROL_PAGERIGHT,
    
    --inventory actions and modifiers
    CONTROL_INV_1,
    CONTROL_INV_2,
    CONTROL_INV_3,
    CONTROL_INV_4,
    CONTROL_INV_5,
    CONTROL_INV_6,
    CONTROL_INV_7,
    CONTROL_INV_8,
    CONTROL_INV_9,
    CONTROL_INV_10,

	CONTROL_INSPECT,
    CONTROL_SPLITSTACK,
    CONTROL_TRADEITEM,
    CONTROL_TRADESTACK,
    CONTROL_FORCE_TRADE,
    CONTROL_FORCE_STACK,


	--debugging
    CONTROL_OPEN_DEBUG_CONSOLE,
    CONTROL_TOGGLE_LOG,
    CONTROL_TOGGLE_DEBUGRENDER,
}

-- Get a list of connected input devices and their ids
local function GetInputDevices()
    local numDevices = TheInputProxy:GetInputDeviceCount()
    local devices = {}
    for i = 0, numDevices - 1 do
        if TheInputProxy:IsInputDeviceConnected(i) then
            local name = TheInputProxy:GetInputDeviceName(i)
            table.insert(devices, {text=name, data=i})
        end
    end
    
    return devices
end

ControlsScreen = Class(Screen, function(self, in_game)
    Widget._ctor(self, "ControlsScreen")
    self.in_game = in_game
    self.is_mapping = false
    
    TheInputProxy:StartMappingControls()
    
	self.options = 
	{ 
		preset = {},
		tweak = {}
	}
	
	self.bg = self:AddChild(Image("images/ui.xml", "bg_plain.tex"))
    self.bg:SetTint(BGCOLOURS.RED[1],BGCOLOURS.RED[2],BGCOLOURS.RED[3], 1)

    self.bg:SetVRegPoint(ANCHOR_MIDDLE)
    self.bg:SetHRegPoint(ANCHOR_MIDDLE)
    self.bg:SetVAnchor(ANCHOR_MIDDLE)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
    self.bg:SetScaleMode(SCALEMODE_FILLSCREEN)
    
    self.root = self:AddChild(Widget("root"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    
    local left_col =-RESOLUTION_X*.25 - 60
    local right_col = RESOLUTION_X*.25 - 130
    
    --menu buttons
    
	self.applybutton = self.root:AddChild(ImageButton())
    self.applybutton:SetPosition(left_col, -110, 0)
    self.applybutton:SetText(STRINGS.UI.CONTROLSSCREEN.APPLY)
    self.applybutton.text:SetColour(0,0,0,1)
    self.applybutton:SetOnClick( function() self:Apply() end )
    self.applybutton:SetFont(BUTTONFONT)
    self.applybutton:SetTextSize(40)    
    
	self.resetbutton = self.root:AddChild(ImageButton())
    self.resetbutton:SetPosition(left_col, -180, 0)
    self.resetbutton:SetText(STRINGS.UI.CONTROLSSCREEN.RESET)
    self.resetbutton.text:SetColour(0,0,0,1)
    self.resetbutton:SetOnClick( function() self:LoadDefaultControls() end )
    self.resetbutton:SetFont(BUTTONFONT)
    self.resetbutton:SetTextSize(40)
    
	self.cancelbutton = self.root:AddChild(ImageButton())
    self.cancelbutton:SetPosition(left_col, -250, 0)
    self.cancelbutton:SetText(STRINGS.UI.CONTROLSSCREEN.CANCEL)
    self.cancelbutton.text:SetColour(0,0,0,1)
    self.cancelbutton:SetOnClick( function() self:Cancel() end )
    self.cancelbutton:SetFont(BUTTONFONT)
    self.cancelbutton:SetTextSize(40)

	--set up the device spinner

    self.devices = GetInputDevices()
        
    self.devicepanel = self.root:AddChild(Widget("devicepanel"))
    self.devicepanel:SetPosition(left_col,100,0)
    self.devicepanelbg = self.devicepanel:AddChild(Image("images/globalpanels.xml", "panel.tex"))
    self.devicepanelbg:SetScale(0.8,-0.60, 1)

    self.devicetitle = self.devicepanel:AddChild(Text(TITLEFONT, 50))
    self.devicetitle:SetHAlign(ANCHOR_MIDDLE)
    self.devicetitle:SetPosition(0, 75, 0)
	self.devicetitle:SetRegionSize( 400, 70 )
    self.devicetitle:SetString(STRINGS.UI.CONTROLSSCREEN.DEVICE_TITLE)
	
	self.devicespinner = self.devicepanel:AddChild(Spinner( self.devices, 350 ))
	self.devicespinner:SetPosition(0, -10, 0)
	self.devicespinner:SetTextColour(0,0,0,1)
	self.devicespinner.OnChanged =
		function( _, data )
		    self.control_offset = 0     -- show controls from the first rather than the current page
		    self:Scroll(0)              -- update the scroll arrows
            self:RefreshControls()
		end
		
	--add the controls panel	
	
	self.control_offset = 0
    self.controlspanel = self.root:AddChild(Widget("controlspanel"))
    self.controlspanel:SetPosition(right_col,0,0)
    self.controlspanelbg = self.controlspanel:AddChild(Image("images/fepanels.xml", "panel_controls.tex"))

	self.rightbutton = self.controlspanel:AddChild(AnimButton("scroll_arrow"))
    self.rightbutton:SetPosition(0, -290, 0)
    self.rightbutton:SetRotation(90)
    self.rightbutton:SetOnClick( function() self:Scroll(controls_per_scroll) end)
	
	self.leftbutton = self.controlspanel:AddChild(AnimButton("scroll_arrow"))
    self.leftbutton:SetPosition(0, 275, 0)
    self.leftbutton:SetRotation(-90)
    self.leftbutton:SetOnClick( function() self:Scroll(-controls_per_scroll) end)	
    self.leftbutton:Hide()
	
    self.inputhandlers = {}
    table.insert(self.inputhandlers, TheInput:AddControlMappingHandler(
        function(deviceId, controlId, inputId, hasChanged)  
            self:OnControlMapped(deviceId, controlId, inputId, hasChanged)
        end
    ))
    
	self.controlwidgets = {}
	self:LoadCurrentControls()
	
end)

function ControlsScreen:OnDestroy()
    
    TheInputProxy:StopMappingControls()
    
    for k,v in pairs(self.inputhandlers) do
        v:Remove()
    end
	self._base.OnDestroy(self)
end

function ControlsScreen:MakeDirty()
	self.applybutton:Enable()	
    self.cancelbutton:SetText(STRINGS.UI.CONTROLSSCREEN.CANCEL)
    self.dirty = true
end

function ControlsScreen:MakeClean()
	self.applybutton:Disable()	
    self.cancelbutton:SetText(STRINGS.UI.CONTROLSSCREEN.CLOSE)
    self.dirty = false
end

function ControlsScreen:IsDirty()
    return self.dirty
end

function ControlsScreen:RefreshControls()
	
	local deviceId = self.devicespinner:GetSelectedData()
    --print("Current device is [" .. deviceId .. "]")
    
	for k,v in pairs(self.controlwidgets) do
		v.root:Kill()
	end
	self.controlwidgets = {}
	for k = 1, controls_per_screen do
	
		local idx = self.control_offset+k		
		
		if controls[idx] then
			local controlId = controls[idx]
			local group = self.controlspanel:AddChild(Widget("control"))
			group:SetScale(0.75,0.75,0.75)
			
			local bg = group:AddChild(Image("images/ui.xml", "nondefault_customization.tex"))
			bg:SetPosition(180,0,0)
			bg:SetScale(2.5, 0.95, 1)
			local hasChanged = TheInputProxy:HasMappingChanged(deviceId, controlId)
			if hasChanged then
			    bg:Show()
			else
			    bg:Hide()
			end
			
			local button = group:AddChild(ImageButton())
	        button:SetText(STRINGS.UI.CONTROLSSCREEN.CONTROLS[controlId+1])
	        button.text:SetColour(0,0,0,1)
	        button:SetFont(BUTTONFONT)
	        button:SetTextSize(40)  
			button:SetPosition(-25,0,0)
			--button:SetScale(1.25, 1, 1)
	        button:SetOnClick( 
	            function() 
	                self:MapControl(deviceId, controlId)
	            end 
	        )
	        
            local text = group:AddChild(Text(UIFONT, 40))
            text:SetString(self:GetLocalizedControl(deviceId, controlId))
            text:SetHAlign(ANCHOR_LEFT)
	        text:SetRegionSize( 500, 50 )
			text:SetPosition(325,0,0)
	        text:SetClickable(false)
	        group.text = text
	    
			local spacing = 50
			
			if k <= controls_per_screen then
				group:SetPosition(-150, (controls_per_screen-1)*spacing*.5 - (k-1)*spacing - 10, 0)
			else
				group:SetPosition(150, (controls_per_screen-1)*spacing*.5 - (k-1-controls_per_screen)*spacing- 10, 0)
			end
			
			table.insert(self.controlwidgets, {root = group, bg = bg, id=controlId})
	    
		end
	end	
end

function ControlsScreen:Scroll(dir)
	if (dir > 0 and (self.control_offset + controls_per_screen) < #controls) or
		(dir < 0 and self.control_offset + dir >= 0) then
	
		self.control_offset = self.control_offset + dir
		self:RefreshControls()
	end
	
	if self.control_offset > 0 then
		self.leftbutton:Show()
	else
		self.leftbutton:Hide()
	end
	
	if self.control_offset + controls_per_screen < #controls then
		self.rightbutton:Show()
	else
		self.rightbutton:Hide()
	end
end

function ControlsScreen:LoadDefaultControls()
	TheInputProxy:LoadDefaultControlMapping()
	self:MakeDirty()
	self:RefreshControls()	
end

function ControlsScreen:LoadCurrentControls()
	TheInputProxy:LoadCurrentControlMapping()
	self:MakeClean()
    self:RefreshControls()	
end

function ControlsScreen:MapControl(deviceId, controlId)
    --print("Mapping control [" .. controlIndex .. "] on device [" .. deviceId .. "]")
    local controlIndex = controlId + 1      -- C++ control id is zero-based, we were passed a 1-based (lua) array index
    local loc_text = self:GetLocalizedControl(deviceId, controlId, true)
    local default_text = string.format(STRINGS.UI.CONTROLSSCREEN.DEFAULT_CONTROL_TEXT, loc_text)
    local body_text = STRINGS.UI.CONTROLSSCREEN.CONTROL_SELECT .. "\n\n" .. default_text
    local popup = PopupDialogScreen(STRINGS.UI.CONTROLSSCREEN.CONTROLS[controlIndex], body_text, {})
    popup.text:SetRegionSize(480, 150)
    popup.text:SetPosition(0, -25, 0)
    popup.OnControl = function(_, control, down) self:MapControlInputHandler(control, down) end
	TheFrontEnd:PushScreen(popup)
	
    TheInputProxy:MapControl(deviceId, controlId)
    self.is_mapping = true
end

function ControlsScreen:OnControlMapped(deviceId, controlId, inputId, hasChanged)
    if self.is_mapping then 
        --print("Control [" .. controlId .. "] is now [" .. inputId .. "]")
        TheFrontEnd:PopScreen()
        TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
        for k, v in pairs(self.controlwidgets) do
            if controlId == v.id then
                if hasChanged then
                    v.root.text:SetString(self:GetLocalizedControl(deviceId, controlId))
                    -- hasChanged only refers to the immediate change, but if a control is modified
                    -- and then modified again to the original we shouldn't highlight it 
                    local changedFromOriginal = TheInputProxy:HasMappingChanged(deviceId, controlId)    
                    if changedFromOriginal then
                        v.bg:Show()
                    else
                        v.bg:Hide()
                    end
                end
            end
        end
        
        -- set the dirty flag (if something changed) if it hasn't yet been set
        if not self:IsDirty() and hasChanged then
            self:MakeDirty()      
        end
        
	    self.is_mapping = false
    end 
end

function ControlsScreen:MapControlInputHandler(control, down)
    if not down and control == CONTROL_CANCEL then
        TheInputProxy:CancelMapping()
        self.is_mapping = false
        TheFrontEnd:PopScreen()
    end

end

function ControlsScreen:Cancel()
    if not self.dirty then
	    TheFrontEnd:PopScreen()
	else
	    local popup = PopupDialogScreen(STRINGS.UI.CONTROLSSCREEN.LOSE_CHANGES_TITLE, STRINGS.UI.CONTROLSSCREEN.LOSE_CHANGES_BODY, 
			{{text=STRINGS.UI.CONTROLSSCREEN.YES, cb = function() self.dirty = false TheFrontEnd:PopScreen() self:Cancel() end},
			{text=STRINGS.UI.CONTROLSSCREEN.NO, cb = function() TheFrontEnd:PopScreen() end}  })
		TheFrontEnd:PushScreen(popup)
	end
end

function ControlsScreen:Apply()
    TheInputProxy:ApplyControlMapping()
    for index = 1, #self.devices do
        local guid, data = TheInputProxy:SaveControls(self.devices[index].data)
        if not(nil == guid) and not(nil == data) then
            Profile:SetControls(guid, data)
        end
    end
    Profile:Save()
    self:MakeClean()
    self:RefreshControls()  -- get rid of highlights on modified controls
end

function ControlsScreen:GetLocalizedControl(deviceId, controlId, use_default_mapping)
    
    if nil == use_default_mapping then
        -- default mapping not specified so don't use it
        use_default_mapping = false
    end
    
    local device, numInputs, input1, input2, input3, input4, intParam = TheInputProxy:GetLocalizedControl(deviceId, controlId, use_default_mapping)
    local inputs = {
        [1] = input1,
        [2] = input2,
        [3] = input3,
        [4] = input4,
    }
    local text = ""
    if nil == device then
        text = STRINGS.UI.CONTROLSSCREEN.INPUTS[4][1]
    else
        -- concatenate the inputs
        for idx = 1, numInputs do
            local inputId = inputs[idx]
            text = text .. STRINGS.UI.CONTROLSSCREEN.INPUTS[device][inputs[idx]]
            if idx < numInputs then
                text = text .. " + "
            end
        end
        
        -- process string format params if there are any
        if not (nil == intParam) then
            text = string.format(text, intParam)
        end
    end
    --print ("Input Text:" .. tostring(text))
    return text;
end
