PlayerProfile = Class(function(self)
    self.persistdata = 
    {
        xp = 0,
        unlocked_worldgen = {},
        unlocked_characters = {},        
        render_quality = RENDER_QUALITY.DEFAULT,
        characterinthrone = "waxwell",
        -- Controlls should be a seperate file
        controls = {},
        starts = 0,
    }

  	--we should migrate the non-gameplay stuff to a separate file, so that we can save them whenever we want
  
 	if PLATFORM == "NACL" then
        self.persistdata.volume_ambient = 7
        self.persistdata.volume_sfx = 7
        self.persistdata.volume_music = 7
        self.persistdata.HUDSize = 5
	end


    self.dirty = true

end)


function PlayerProfile:Reset()
	
    self.persistdata.xp = 0
	self.persistdata.unlocked_worldgen = {}
	self.persistdata.unlocked_characters = {}
	self.persistdata.characterinthrone = "waxwell"
    --self.persistdata.starts = 0 -- save starts?
	self.dirty = true
	self:Save()
end

function PlayerProfile:UnlockEverything()
    self.persistdata.xp = 0
	self.persistdata.unlocked_characters = {}
	local characters = {'willow', 'wendy', 'wolfgang', 'wilton', 'wx78', 'wickerbottom', 'wes', 'waxwell', 'woodie'}
	for k,v in pairs(characters) do
		self:UnlockCharacter(v)
	end
	self.dirty = true
	self:Save()
end

function PlayerProfile:SetValue(name, value)
    self.dirty = true
    self.persistdata[name] = value
end

function PlayerProfile:GetValue(name)
	return self.persistdata[name]
end

function PlayerProfile:SetVolume(ambient, sfx, music)
	if PLATFORM == "NACL" then
	    self:SetValue("volume_ambient", ambient) 
	    self:SetValue("volume_sfx", sfx) 
	    self:SetValue("volume_music", music) 
	    self.dirty = true
	else
		TheSim:SetSetting("audio", "volume_ambient", tostring(math.floor(ambient))) 
		TheSim:SetSetting("audio", "volume_sfx", tostring(math.floor(sfx)))
		TheSim:SetSetting("audio", "volume_music", tostring(math.floor(music))) 		
	end
end

function PlayerProfile:SetBloomEnabled(enabled)
	if PLATFORM == "NACL" then
		self:SetValue("bloom", enabled)
		self.dirty = true
	else
		TheSim:SetSetting("graphics", "bloom", tostring(enabled)) 
	end
end

function PlayerProfile:GetBloomEnabled()
	if PLATFORM == "NACL" then
		return self:GetValue("bloom")
	else
		return TheSim:GetSetting("graphics", "bloom") == "true"
	end
end

function PlayerProfile:SetHUDSize(size)
	if PLATFORM == "NACL" then
		self:SetValue("HUDSize", size)
		self.dirty = true
	else
		TheSim:SetSetting("graphics", "HUDSize", tostring(size)) 
	end
end

function PlayerProfile:GetHUDSize()
	if PLATFORM == "NACL" then
		return self:GetValue("HUDSize") or 5
	else
		return TheSim:GetSetting("graphics", "HUDSize") or 5
	end
end

function PlayerProfile:SetDistortionEnabled(enabled)
	if PLATFORM == "NACL" then
		self:SetValue("distortion", enabled)
		self.dirty = true
	else
		TheSim:SetSetting("graphics", "distortion", tostring(enabled)) 
	end
end

function PlayerProfile:GetDistortionEnabled()
	if PLATFORM == "NACL" then
		return self:GetValue("distortion")
	else
		return TheSim:GetSetting("graphics", "distortion") == "true"
	end
end

function PlayerProfile:GetVolume()
	if PLATFORM == "NACL" then
    	return self.persistdata.volume_ambient, self.persistdata.volume_sfx, self.persistdata.volume_music
	else

		local amb = TheSim:GetSetting("audio", "volume_ambient")
		if amb == nil then
			amb = 10
		end
		local sfx = TheSim:GetSetting("audio", "volume_sfx")
		if sfx == nil then
			sfx = 10
		end
		local music = TheSim:GetSetting("audio", "volume_music") 
		if music == nil then
			music = 10
		end

		return amb, sfx, music
	end
end


function PlayerProfile:SetRenderQuality(quality)
	self:SetValue("render_quality", quality)
	self.dirty = true
end

function PlayerProfile:GetRenderQuality()
	return self:GetValue("render_quality")
end

----------------------------

function PlayerProfile:IsCharacterUnlocked(character)
    if character == "wilson" then
		return true
    end
    
    if self.persistdata.unlocked_characters[character] then
        return true
	end

	if not table.contains(CHARACTERLIST, character) then
		return true -- mod character
	end

	return false
end

function PlayerProfile:UnlockCharacter(character)
    self.persistdata.unlocked_characters[character] = true
    self.dirty = true
end

function PlayerProfile:GetUnlockedCharacters()
    return self.persistdata.unlocked_characters
end
----------------------------

function PlayerProfile:IsWorldGenUnlocked(area, item)
	if self.persistdata.unlocked_worldgen == nil then
		return false
	end
	
	if self.persistdata.unlocked_worldgen[area] == nil then
		return false
	end
	
    if item == nil or self.persistdata.unlocked_worldgen[area][item] then
        return true
    end
    
    return false
end

function PlayerProfile:UnlockWorldGen(area, item)
	if self.persistdata.unlocked_worldgen == nil then
		self.persistdata.unlocked_worldgen = {}
	end
	
	if self.persistdata.unlocked_worldgen[area] == nil then
		self.persistdata.unlocked_worldgen[area] = {}
	end
	
    self.persistdata.unlocked_worldgen[area][item] = true
    self.dirty = true
end

function PlayerProfile:GetUnlockedWorldGen()
    return self.persistdata.unlocked_worldgen
end


----------------------------


function PlayerProfile:GetSaveName()
    return BRANCH == "release" and "profile" or "profile_"..BRANCH
end

function PlayerProfile:GetXP()
    return self.persistdata.xp
end

function PlayerProfile:SetXP(xp)
    self:SetValue("xp", xp)
end

function PlayerProfile:Save(callback)
	Print( VERBOSITY.DEBUG, "SAVING" )
    if self.dirty then
        local str = json.encode(self.persistdata)
        local insz, outsz = TheSim:SetPersistentString(self:GetSaveName(), str, ENCODE_SAVES, callback)
    else
		if callback then
			callback(true)
		end
    end
end

function PlayerProfile:Load(callback)
    TheSim:GetPersistentString(self:GetSaveName(),
        function(str) 
			self:Set( str, callback )
        end, false)    
end

local function GetValueOrDefault( value, default )
	if value ~= nil then
		return value
	else
		return default
	end
end

function PlayerProfile:Set(str, callback)
	if not str or string.len(str) == 0 then
		print ("could not load ".. self:GetSaveName())
		if callback then
			callback(false)
		end
	else
		print ("loaded ".. self:GetSaveName())
		self.dirty = false

		self.persistdata = TrackedAssert("TheSim:GetPersistentString profile",  json.decode, str)
		if PLATFORM ~= "NACL" then
			-- Copy over old settings
			if self.persistdata.volume_ambient ~= nil and self.persistdata.volume_sfx ~= nil and self.persistdata.volume_music ~= nil then
				print("Copying audio settings from profile to settings.ini")

				self:SetVolume(self.persistdata.volume_ambient, self.persistdata.volume_sfx, self.persistdata.volume_music)
				self.persistdata.volume_ambient = nil 
				self.persistdata.volume_sfx = nil
				self.persistdata.volume_music = nil
				self.dirty = true
			end
		end

		local amb, sfx, music = self:GetVolume()
		Print(VERBOSITY.DEBUG, "volumes", amb, sfx, music )
		
		TheMixer:SetLevel("set_sfx", sfx / 10)
		TheMixer:SetLevel("set_ambience", amb / 10)
		TheMixer:SetLevel("set_music", music / 10)

		if TheFrontEnd then
			local bloom_enabled = GetValueOrDefault( self.persistdata.bloom, true )
			local distortion_enabled = GetValueOrDefault( self.persistdata.distortion, true )

			if PLATFORM ~= "NACL" then
				-- Copy over old settings
				if self.persistdata.bloom ~= nil and self.persistdata.distortion ~= nil and self.persistdata.HUDSize ~= nil then
					print("Copying render settings from profile to settings.ini")
					
					self:SetBloomEnabled(bloom_enabled)
					self:SetDistortionEnabled(distortion_enabled)
					self:SetHUDSize(self.persistdata.HUDSize)
					self.persistdata.bloom = nil
					self.persistdata.distortion = nil
					self.persistdata.HUDSize = nil
					self.dirty = true
				else
					bloom_enabled = self:GetBloomEnabled()
					distortion_enabled = self:GetDistortionEnabled()
				end
			end
			print("bloom_enabled",bloom_enabled)
			TheFrontEnd:GetGraphicsOptions():SetBloomEnabled( bloom_enabled )
			TheFrontEnd:GetGraphicsOptions():SetDistortionEnabled( distortion_enabled )
		end
		
		-- old save data will not have the controls section so create it
		if nil == self.persistdata.controls then
		    self.persistdata.controls = {}
		end
		
	    for idx,entry in pairs(self.persistdata.controls) do
	        TheInputProxy:LoadControls(entry.guid, entry.data)
	    end

		if callback then
			callback(true)
		end
	end
end

function PlayerProfile:SetDirty(dirty)
	self.dirty = dirty
end

function PlayerProfile:GetControls(guid)  
    local controls = nil
    for idx, entry in pairs(self.persistdata.controls) do
        if entry.guid == guid then
            controls = entry.data
        end
    end  
    return controls
end

function PlayerProfile:SetControls(guid, data)  
	
	-- check if this device is already in the list and update if found
	local found = false
    for idx, entry in pairs(self.persistdata.controls) do
        if entry.guid == guid then
            entry.data = data
            found = true
        end
    end  
    
    -- not an existing device so add it
    if not found then
        table.insert(self.persistdata.controls, {["guid"]=guid, ["data"]=data,})
    end

    self.dirty = true
end
