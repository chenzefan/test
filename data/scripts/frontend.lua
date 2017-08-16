local easing = require("easing")
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local Image = require "widgets/image"


FrontEnd = Class(function(self, name)
	self.screenstack = {}
	
	self.screenroot = Widget("screenroot")
	self.overlayroot = Widget("overlayroot")
	
	------ CONSOLE -----------	
	
	self.consoletext = Text(BODYTEXTFONT, 20, "CONSOLE TEXT")
	self.consoletext:SetVAlign(ANCHOR_BOTTOM)
	self.consoletext:SetHAlign(ANCHOR_LEFT)
    self.consoletext:SetVAnchor(ANCHOR_MIDDLE)
    self.consoletext:SetHAnchor(ANCHOR_MIDDLE)
	self.consoletext:SetScaleMode(SCALEMODE_PROPORTIONAL)

	self.consoletext:SetRegionSize(900, 400)
	self.consoletext:SetPosition(0,0,0)
	self.consoletext:Hide()
    -----------------



    self.blackoverlay = Image("images/global.xml", "square.tex")
    self.blackoverlay:SetVRegPoint(ANCHOR_MIDDLE)
    self.blackoverlay:SetHRegPoint(ANCHOR_MIDDLE)
    self.blackoverlay:SetVAnchor(ANCHOR_MIDDLE)
    self.blackoverlay:SetHAnchor(ANCHOR_MIDDLE)
    self.blackoverlay:SetScaleMode(SCALEMODE_FILLSCREEN)
	self.blackoverlay:SetClickable(false)
	self.blackoverlay:Hide()
	self.overlayroot:AddChild(self.blackoverlay)
	
    
    self.title = Text(TITLEFONT, 100)
    self.title:SetPosition(0, -30, 0)
    self.title:Hide()
    self.title:SetVAnchor(ANCHOR_MIDDLE)
    self.title:SetHAnchor(ANCHOR_MIDDLE)
	self.overlayroot:AddChild(self.title)
	
    self.subtitle = Text(TITLEFONT, 70)
    self.subtitle:SetPosition(0, 70, 0)
    self.subtitle:Hide()
    self.subtitle:SetVAnchor(ANCHOR_MIDDLE)
    self.subtitle:SetHAnchor(ANCHOR_MIDDLE)
	self.overlayroot:AddChild(self.subtitle)

	self.gameinterface = CreateEntity()
	self.gameinterface.entity:AddSoundEmitter()
	self.gameinterface.entity:AddGraphicsOptions()

	TheInput:AddKeyHandler(function(key, down) self:OnRawKey(key, down) end )
	TheInput:AddTextInputHandler(function(text) self:OnTextInput(text) end )

	self.displayingerror = false

	self.tracking_mouse = false
end)


function FrontEnd:GetFocusWidget()
	if #self.screenstack > 0 then
		return self.screenstack[#self.screenstack]:GetDeepestFocus()
	end
end

function FrontEnd:OnFocusMove(dir, down)
	
	if self.focus_locked then return true end

	if #self.screenstack > 0 then
		if self.screenstack[#self.screenstack]:OnFocusMove(dir, down) then
			self.tracking_mouse = false
			return true
		else
			if self.tracking_mouse and down and self.screenstack[#self.screenstack]:SetDefaultFocus() then
				self.tracking_mouse = false
				return true
			end
		end
	end
end

function FrontEnd:OnControl(control, down)
--	print ("FE:Oncontrol", control, down)
	--handle focus moves
	if control == CONTROL_FOCUS_UP then
		return self:OnFocusMove(MOVE_UP, down)
	elseif control == CONTROL_FOCUS_DOWN then
		return self:OnFocusMove(MOVE_DOWN, down)
	elseif control == CONTROL_FOCUS_LEFT then
		return self:OnFocusMove(MOVE_LEFT, down)
	elseif control == CONTROL_FOCUS_RIGHT then
		return self:OnFocusMove(MOVE_RIGHT, down)
	end

	if #self.screenstack > 0 then
		local screen = self.screenstack[#self.screenstack]
		if control == CONTROL_PRIMARY then control = CONTROL_ACCEPT end  --map this one for buttons

		if screen:OnControl(control, down) then return true end
	end


	if not down and control == CONTROL_OPEN_DEBUG_CONSOLE then
		self:PushScreen(ConsoleScreen())
		return true
	end

	if not down and control == CONTROL_TOGGLE_LOG then
		if self.consoletext.shown then 
			self:HideConsoleLog()
		else
			self:ShowConsoleLog()
		end
		return true
	end

	if not down and control == CONTROL_TOGGLE_DEBUGRENDER then
			    if TheInput:IsKeyDown(KEY_CTRL) then
				    TheSim:SetDebugPhysicsRenderEnabled(not TheSim:GetDebugPhysicsRenderEnabled())
			    else
				    TheSim:SetDebugRenderEnabled(not TheSim:GetDebugRenderEnabled())
			    end
		return true
	end


--[[
		elseif control == CONTROL_CANCEL then
			return screen:OnCancel(down)
--]]
end

function FrontEnd:ShowTitle(text,subtext)
	self.title:SetString(text)
	self.title:Show()
	self.subtitle:SetString(subtext)
	self.subtitle:Show()
end

function FrontEnd:LockFocus(lock)
	self.focus_locked = lock
end

function FrontEnd:HideTitle()
	self.title:Hide()
	self.subtitle:Hide()
end

function FrontEnd:SendScreenEvent(type, message)
	if #self.screenstack > 0 then
		self.screenstack[#self.screenstack]:HandleEvent(type, message)
	end
end


function FrontEnd:GetSound()
	return self.gameinterface.SoundEmitter
end

function FrontEnd:GetGraphicsOptions()
	return self.gameinterface.GraphicsOptions
end

function FrontEnd:SetFadeLevel(alpha)
	--print ("SET FADE LEVEL", alpha)
	if alpha <= 0 then
		if self.blackoverlay then
			self.blackoverlay:Hide()
		end
	else
		self.blackoverlay:Show()
		self.blackoverlay:SetTint(0,0,0,alpha)
	end
end

function FrontEnd:DoFadingUpdate(dt)
	dt = math.min(dt, 1/30)
	if self.fade_delay_time then
		self.fade_delay_time = self.fade_delay_time - dt
		if self.fade_delay_time <= 0 then
			self.fade_delay_time = nil
			if self.delayovercb then
				self.delayovercb()
				self.delayovercb = nil
			end
		end
		return
	elseif self.fadedir ~= nil then
		self.fade_time = self.fade_time + dt
		
		local alpha = 0
		if self.fadedir then
			alpha = easing.inOutCubic(self.fade_time, 1, -1, self.total_fade_time)
		else
			alpha = easing.outCubic(self.fade_time, 0, 1, self.total_fade_time)
		end
		
		self:SetFadeLevel(alpha)
		if self.fade_time >= self.total_fade_time then
			self.fadedir = nil
			if self.fadecb then
				local cb = self.fadecb
				self.fadecb = nil
				cb()
			end
		end
	end
end

function FrontEnd:UpdateConsoleOutput()
    local consolestr = table.concat(GetConsoleOutputList(), "\n") 
    consolestr = consolestr.."\n(Press CTRL+L to close this log)"
   	self.consoletext:SetString(consolestr)
end

function FrontEnd:Update(dt)

	if self.consoletext.shown then
		self:UpdateConsoleOutput()
	end

	self:DoFadingUpdate(dt)
	
	if #self.screenstack > 0 then
		self.screenstack[#self.screenstack]:OnUpdate(dt)
	end	

	if self.tracking_mouse and not self.focus_locked then
		local entitiesundermouse = TheSim:GetEntitiesAtScreenPoint(TheSim:GetPosition())
		local hover_inst = entitiesundermouse[1]
		

		if hover_inst and hover_inst.widget then
			--print ("new focus!", hover_inst )
			hover_inst.widget:SetFocus()
		else
			if #self.screenstack > 0 then
				self.screenstack[#self.screenstack]:SetFocus()
			end
		end
	end

end

function FrontEnd:PushScreen(screen)
	self.focus_locked = false
	TheInputProxy:FlushInput()
	self.tracking_mouse = false
	--jcheng: don't allow any other screens to push if we're displaying an error
	
	if not TheFrontEnd:IsDisplayingError() then
		Print(VERBOSITY.DEBUG, 'FrontEnd:PushScreen', screen.name)
		if #self.screenstack > 0 then
			self.screenstack[#self.screenstack]:OnBecomeInactive()
		end

		self.screenroot:AddChild(screen)
		table.insert(self.screenstack, screen)
		screen:SetDefaultFocus()
		screen:OnBecomeActive()

		--print(screen:GetDeepestFocus())
		--self:Fade(true, 2)
	end
end

function FrontEnd:ClearScreens()

	if #self.screenstack > 0 then
		self.screenstack[#self.screenstack]:OnLoseFocus()
	end

	while #self.screenstack > 0 do
		self.screenstack[#self.screenstack]:OnDestroy()
		table.remove(self.screenstack, #self.screenstack)
	end

end

function FrontEnd:ShowConsoleLog()
	self.consoletext:Show()
end

function FrontEnd:HideConsoleLog()
	self.consoletext:Hide()
end

function FrontEnd:DoFadeIn(time_to_take)
	self:Fade(true, time_to_take)	
end

function FrontEnd:Fade(in_or_out, time_to_take, cb, fade_delay_time, delayovercb)
	
	self.fadedir = in_or_out
	self.total_fade_time = time_to_take
	self.fadecb = cb
	self.fade_time = 0
	if in_or_out then
		self:SetFadeLevel(1)
	end
	self.fade_delay_time = fade_delay_time
	self.delayovercb = delayovercb
end

function FrontEnd:PopScreen(screen)
	self.focus_locked = false
	TheInputProxy:FlushInput()
	self.tracking_mouse = false

	local old_head = #self.screenstack > 0 and self.screenstack[#self.screenstack]
	if screen then
		Print(VERBOSITY.DEBUG,'FrontEnd:PopScreen', screen.name)
		for k,v in ipairs(self.screenstack) do
			if v == screen then
				if old_head == v then 
					screen:OnBecomeInactive()
				end
				table.remove(self.screenstack, k)
				screen:OnDestroy()
				self.screenroot:RemoveChild(screen)
				break
			end
		end
	else
		Print(VERBOSITY.DEBUG,'FrontEnd:PopScreen')
		if #self.screenstack > 0 then
			local screen = self.screenstack[#self.screenstack]
			table.remove(self.screenstack, #self.screenstack)
			screen:OnBecomeInactive()
			screen:OnDestroy()
			self.screenroot:RemoveChild(screen)
		end
		
	end

	if #self.screenstack > 0 and old_head ~= self.screenstack[#self.screenstack] then
		self.screenstack[#self.screenstack]:SetFocus()
		self.screenstack[#self.screenstack]:OnBecomeActive()
		--self:Fade(true, 1)
	end
end

function FrontEnd:GetActiveScreen()
	if #self.screenstack > 0 and self.screenstack[#self.screenstack] then
		return self.screenstack[#self.screenstack]
	else
		return nil
	end
end

function FrontEnd:ShowScreen(screen)
	self:ClearScreens()	
	if screen then
		self:PushScreen(screen)
	end
end

function FrontEnd:OnRawKey(key, down)
--	print("FrontEnd:OnRawKey()", key, down)
	local screen = self:GetActiveScreen()
    if screen then
		if not screen:OnRawKey(key, down) then
			if PLATFORM ~= "NACL" and CHEATS_ENABLED then
				DoDebugKey(key, down)
			end
		end
	end
end

function FrontEnd:OnTextInput(text)
--	print("FrontEnd:OnTextInput()", text)
	local screen = self:GetActiveScreen()
    if screen then
		screen:OnTextInput(text)
	end
end

function FrontEnd:DisplayError(screen)
	if self.displayingerror == false then
	    print("SCRIPT ERROR! Showing error screen")
		
		self:ShowScreen(screen)
		self.overlayroot:Hide()
		self.consoletext:Hide()
		self.blackoverlay:Hide()
		self.title:Hide()
		self.subtitle:Hide()
		
		self.displayingerror = true
	end
end

function FrontEnd:IsDisplayingError()
	return self.displayingerror
end

function FrontEnd:OnMouseButton(button, down, x, y)
	self.tracking_mouse = true

	if #self.screenstack > 0 then
		if self.screenstack[#self.screenstack]:OnMouseButton(button, down, x, y) then return true end
	end

	if PLATFORM ~= "NACL" and CHEATS_ENABLED then
		return DoDebugMouse(button, down, x, y)
	end
end

function FrontEnd:OnMouseMove(x,y)

	if self.lastx and self.lasty and self.lastx ~= x and self.lasty ~= y then
		self.tracking_mouse = true
	end

	self.lastx = x
	self.lasty = y
end
