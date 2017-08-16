require "events"
local Text = require "widgets/text"

Input = Class(function(self)
    self.onkey = EventProcessor()     -- all keys, down and up, with key param
    self.onkeyup = EventProcessor()   -- specific key up, no parameters
    self.onkeydown = EventProcessor() -- specific key down, no parameters
    self.onmouseup = EventProcessor()
    self.onmousedown = EventProcessor()
    
    self.position = EventProcessor()
    self.oncontrol = EventProcessor()
    self.ontextinput = EventProcessor()
    self.ongesture = EventProcessor()
    
    self.hoverinst = nil
    self.enabledebugtoggle = true

end)

function Input:AddTextInputHandler( fn )
    return self.ontextinput:AddEventHandler("text", fn)
end

function Input:AddKeyUpHandler( key, fn )
    return self.onkeyup:AddEventHandler(key, fn)
end

function Input:AddKeyDownHandler( key, fn )
    return self.onkeydown:AddEventHandler(key, fn)
end

function Input:AddKeyHandler( fn )
    return self.onkey:AddEventHandler("onkey", fn)
end

function Input:AddMouseButtonHandler( button, down, fn)
    if down then
        return self.onmousedown:AddEventHandler(button, fn)
    else
        return self.onmouseup:AddEventHandler(button, fn)
    end
end

function Input:AddMoveHandler( fn )
    return self.position:AddEventHandler("move", fn)
end

function Input:AddControlHandler(control, fn)
    return self.oncontrol:AddEventHandler(control, fn)
end

function Input:AddGeneralControlHandler(fn)
    return self.oncontrol:AddEventHandler("oncontrol", fn)
end

function Input:AddControlMappingHandler(fn)
    return self.oncontrol:AddEventHandler("onmap", fn)
end

function Input:AddGestureHandler( gesture, fn )
    return self.ongesture:AddEventHandler(gesture, fn)
end

function Input:UpdatePosition(x,y)
    --print("Input:UpdatePosition", x, y)
    self.position:HandleEvent("move", x, y)
end

function Input:OnControl(control, digitalvalue, analogvalue)
    if not TheFrontEnd:OnControl(control, digitalvalue) then
        self.oncontrol:HandleEvent(control, digitalvalue, analogvalue)
        self.oncontrol:HandleEvent("oncontrol", control, digitalvalue, analogvalue)
    end
end

function Input:OnMouseMove(x,y)
	TheFrontEnd:OnMouseMove(x,y)
end

function Input:OnMouseButton(button, down, x,y)
	TheFrontEnd:OnMouseButton(button, down, x,y)
end

function Input:OnRawKey(key, down)
	self.onkey:HandleEvent("onkey", key, down)

	if down then
		self.onkeydown:HandleEvent(key)
	else
		self.onkeyup:HandleEvent(key)
	end
end

function Input:OnText(text)
	--print("Input:OnText", text)
	self.ontextinput:HandleEvent("text", text)
end

function Input:OnGesture(gesture)
	self.ongesture:HandleEvent(gesture)
end

function Input:OnControlMapped(deviceId, controlId, inputId, hasChanged)
    self.oncontrol:HandleEvent("onmap", deviceId, controlId, inputId, hasChanged)
end

function Input:OnFrameStart()
    self.hoverinst = nil
    self.hovervalid = false
end

function Input:GetScreenPosition()
    local x, y = TheSim:GetPosition()
    return Vector3(x,y,0)
end

function Input:GetWorldPosition()
    local x,y,z = TheSim:ProjectScreenPos(TheSim:GetPosition())
    if x and y and z then
        return Vector3(x,y,z)
    end
end

function Input:GetAllEntitiesUnderMouse()
    return self.entitiesundermouse or {}
end

function Input:GetWorldEntityUnderMouse()
    if self.hoverinst and self.hoverinst.Transform then
        return self.hoverinst 
    end
end


function Input:EnableDebugToggle(enable)
    self.enabledebugtoggle = enable
end

function Input:IsDebugToggleEnabled()
    return self.enabledebugtoggle
end

function Input:GetHUDEntityUnderMouse()
    if self.hoverinst and not self.hoverinst.Transform then
        return self.hoverinst 
    end
end

function Input:IsMouseDown(button)
    return TheSim:GetMouseButtonState(button)
end

function Input:IsKeyDown(key)
    return TheSim:IsKeyDown(key)
end

function Input:IsControlPressed(control)
    return TheSim:GetDigitalControl(control)
end

function Input:GetAnalogControlValue(control)
    return TheSim:GetAnalogControl(control)
end

function Input:OnUpdate()
    self.entitiesundermouse = TheSim:GetEntitiesAtScreenPoint(TheSim:GetPosition())
    
    local inst = self.entitiesundermouse[1]
    if inst ~= self.hoverinst then
        
        if inst and inst.Transform then
            inst:PushEvent("mouseover")
        end

        if self.hoverinst and self.hoverinst.Transform then
            self.hoverinst:PushEvent("mouseout")
        end
        
        self.hoverinst = inst
    end
end

---------------- Globals

TheInput = Input()

function OnPosition(x, y)
    TheInput:UpdatePosition(x,y)
end

function OnControl(control, digitalvalue, analogvalue)
    TheInput:OnControl(control, digitalvalue, analogvalue)
end

function OnMouseButton(button, is_up, x, y)
    TheInput:OnMouseButton(button, is_up, x,y)
end

function OnMouseMove(x, y)
    TheInput:OnMouseMove(x, y)
end

function OnInputKey(key, is_up)
    TheInput:OnRawKey(key, is_up)
end

function OnInputText(text)
	TheInput:OnText(text)
end

function OnGesture(gesture)
	TheInput:OnGesture(gesture)
end

function OnControlMapped(deviceId, controlId, inputId, hasChanged)
    TheInput:OnControlMapped(deviceId, controlId, inputId, hasChanged)
end

return Input
