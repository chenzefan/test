require "events"

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
    self.mouseoversenabled = true
    
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

function Input:OnControl(control, value)
    --print("Input:OnControl", control, value)
    self.oncontrol:HandleEvent(control, value)
    self.oncontrol:HandleEvent("oncontrol", control, value)
end

function Input:OnMouseButton(button, down, x,y)
    if down then
        self.onmousedown:HandleEvent(button, x, y)
    else
        self.onmouseup:HandleEvent(button, x, y)
    end
    
    if self.hoverinst then
        if button == MOUSEBUTTON_LEFT then
            self.hoverinst:PushEvent(down and "leftmousedown" or "leftmouseup", {x = x, y = y})
        elseif button == MOUSEBUTTON_RIGHT then
            self.hoverinst:PushEvent(down and "rightmousedown" or "rightmouseup", {x = x, y = y})
        end
    end
end

function Input:OnKey(key, down)
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

function Input:DisableMouseovers()
    self.mouseoversenabled = false

    if self.hoverinst then
        self.hoverinst:PushEvent("mouseout")
        self.hoverinst = nil
    end
end

function Input:EnableMouseovers()
    self.mouseoversenabled = true
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
    local value = TheSim:GetControl(control)
    if 0 == value then
        return false
    else
        return true
    end
end

function Input:OnUpdate()
    if self.mouseoversenabled then

        self.entitiesundermouse = TheSim:GetEntitiesAtScreenPoint(TheSim:GetPosition())
        
        local inst = self.entitiesundermouse[1]
        if inst ~= self.hoverinst then
            if inst then
                inst:PushEvent("mouseover")
            end

            if self.hoverinst then
                self.hoverinst:PushEvent("mouseout")
            end
            
            self.hoverinst = inst
        end
    end
end

---------------- Globals

TheInput = Input()

function OnPosition(x, y)
    TheInput:UpdatePosition(x,y)
end

function OnControl(control, value)
    TheInput:OnControl(control, value)
end

function OnMouseButton(button, is_up, x, y)
    TheInput:OnMouseButton(button, is_up, x,y)
end

function OnInputKey(key, is_up)
    TheInput:OnKey(key, is_up)
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
