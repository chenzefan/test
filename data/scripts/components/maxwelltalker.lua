local MaxwellTalker = Class(function(self, inst)
	self.inst = inst
	self.speech = nil
	self.speeches = nil
	self.canskip = false
	self.inputhandlers = {}
    table.insert(self.inputhandlers, TheInput:AddMouseButtonHandler(MOUSEBUTTON_LEFT, true, function() self:OnClick() end))
    table.insert(self.inputhandlers, TheInput:AddMouseButtonHandler(MOUSEBUTTON_RIGHT, true, function() self:OnClick() end))
    table.insert(self.inputhandlers, TheInput:AddKeyDownHandler(KEY_SPACE, function() self:OnClick() end))
    table.insert(self.inputhandlers, TheInput:AddKeyDownHandler(KEY_ENTER, function() self:OnClick() end))
end)

function MaxwellTalker:OnCancel()
	self.inst.SoundEmitter:KillSound("talk")	--ensures any talking sounds have stopped
	self.inst:DoTaskInTime(.4, function() self.inst.SoundEmitter:PlaySound("dontstarve/maxwell/disappear") end)
	if self.inst.speech.disappearanim then self.inst.AnimState:PlayAnimation(self.inst.speech.disappearanim, false) end	--plays the disappear animation and removes from scene
	self.inst:ListenForEvent("animqueueover", function() self.inst:Remove() end)	
	self.inst.wilson.sg:GoToState("wakeup") 
	self.inst.wilson:DoTaskInTime(1.5, function() self.inst.wilson.components.playercontroller:Enable(true) end)
	TheCamera:SetDefault()
end

function MaxwellTalker:OnClick()
	if self.canskip then
		scheduler:KillTask(self.inst.task)
		self:OnCancel()
		for k,v in pairs(self.inputhandlers) do
	        v:Remove()
	    end
	end
end

function MaxwellTalker:Initialize()
	self.inst.speech = self.speeches[self.speech or "NULL_SPEECH"] --This would be specified through whatever spawns this at the start of a level

	if self.inst.speech and self.inst.speech.disableplayer then
		self.inst.wilson = GetPlayer()
        self.inst.wilson.components.playercontroller:Enable(false)
        self.inst.wilson.sg:GoToState("sleep")		

        local pt = Vector3(self.inst.wilson.Transform:GetWorldPosition()) + TheCamera:GetRightVec()*4
        self.inst.Transform:SetPosition(pt.x,pt.y,pt.z)
        self.inst:FacePoint(Vector3(self.inst.wilson.Transform:GetWorldPosition()))
        	
        self.inst:Hide()

        --zoom in
        TheCamera:SetOffset( (Vector3(self.inst.Transform:GetWorldPosition()) - Vector3(self.inst.wilson.Transform:GetWorldPosition()))*.5  + Vector3(0,2,0) )
        TheCamera:SetDistance(15)
        TheCamera:Snap()   	
	end
end

function MaxwellTalker:DoTalk()	
	self.inst.speech = self.speeches[self.speech or "NULL_SPEECH"] --This would be specified through whatever spawns this at the start of a level
	self.inst:Show()		
	if self.inst.speech then
			if self.inst.speech.appearanim then self.inst.AnimState:PlayAnimation(self.inst.speech.appearanim) end
			if self.inst.speech.idleanim then self.inst.AnimState:PushAnimation(self.inst.speech.idleanim, true) end
			Sleep(0.4)
			self.inst.SoundEmitter:PlaySound("dontstarve/maxwell/disappear")
			Sleep(1)
			self.canskip = true
			local length = #self.inst.speech or 1
			for k, section in ipairs(self.inst.speech) do --the loop that goes on while the speech is happening
				local wait = section.wait or 1

				if section.anim then --If there's a custom animation it plays it here.
					self.inst.AnimState:PlayAnimation(section.anim)
					if self.inst.speech.idleanim then self.inst.AnimState:PushAnimation(self.inst.speech.idleanim, true) end
				end

		        if section.string then --If there is speech to be said, it displays the text and overwrites any custom anims with the talking anims
		        	if self.inst.speech.dialogpreanim then self.inst.AnimState:PlayAnimation(self.inst.speech.dialogpreanim) end
		        	if self.inst.speech.dialoganim then self.inst.AnimState:PlayAnimation(self.inst.speech.dialoganim, true) end
			        self.inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP", "talk")
			        if self.inst.components.talker then
						self.inst.components.talker:Say(section.string, wait)
					end
				end

				if section.sound then	--If there's an extra sound to be played it plays here.
					self.inst.SoundEmitter:PlaySound(section.sound)
				end

				Sleep(wait)	--waits for the allocated time.

				if section.string then	--If maxwell was talking it winds down here and stops the anim.
					self.inst.SoundEmitter:KillSound("talk")
			        if self.inst.speech.dialogpostanim then self.inst.AnimState:PlayAnimation(self.inst.speech.dialogpostanim) end
		        end

		       	if self.inst.speech.idleanim then  self.inst.AnimState:PushAnimation(self.inst.speech.idleanim, true) end--goes to an idle animation
		        Sleep(1)	--pauses between lines
			end
		

		self.inst.SoundEmitter:KillSound("talk")	--ensures any talking sounds have stopped
		self.inst:DoTaskInTime(.4, function()self.inst.SoundEmitter:PlaySound("dontstarve/maxwell/disappear") end)
		if self.inst.speech.disappearanim then self.inst.AnimState:PlayAnimation(self.inst.speech.disappearanim, false) end	--plays the disappear animation and removes from scene
		self.inst:ListenForEvent("animqueueover", function() self.inst:Remove() end)

		if self.inst.speech.disableplayer and self.inst.wilson and self.inst.wilson.sg.currentstate.name == "sleep" then		
			self.inst.wilson.sg:GoToState("wakeup") 
			Sleep(1.5)
			self.inst.wilson.components.playercontroller:Enable(true)
			TheCamera:SetDefault()
		end
	end
	for k,v in pairs(self.inputhandlers) do
	        v:Remove()
	end
end

function MaxwellTalker:SetSpeech(speech)
	if speech then self.speech = speech end
end

return MaxwellTalker