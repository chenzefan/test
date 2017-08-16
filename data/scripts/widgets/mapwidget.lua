local Widget = require "widgets/widget"
local Image = require "widgets/image"

MapWidget = Class(Widget, function(self, owner)
    Widget._ctor(self, "MapWidget")
	self.owner = owner

    self.bg = self:AddChild(Image("images/hud.xml", "map.tex"))
    self.bg:SetVRegPoint(ANCHOR_MIDDLE)
    self.bg:SetHRegPoint(ANCHOR_MIDDLE)
    self.bg:SetVAnchor(ANCHOR_MIDDLE)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
    self.bg:SetScaleMode(SCALEMODE_FILLSCREEN)
	self.bg.inst.ImageWidget:SetBlendMode( BLENDMODE.Premultiplied )
    
    self.minimap = self.owner.HUD.minimap.MiniMap
    
    self.img = self:AddChild(Image())
    self.img:SetHAnchor(ANCHOR_MIDDLE)
    self.img:SetVAnchor(ANCHOR_MIDDLE)
    self.img.inst.ImageWidget:SetBlendMode( BLENDMODE.Additive )    

    self.inputhandlers = {}
    table.insert(self.inputhandlers, TheInput:AddMoveHandler(function(x, y) self:UpdatePosition(x, y) end))
    
	self.lastpos = nil
end)


function MapWidget:OnRemoveEntity()
    for k,v in pairs(self.inputhandlers) do
        v:Remove()
    end
end


function MapWidget:SetTextureHandle(handle)
	self.img.inst.ImageWidget:SetTextureHandle( handle )
end

function MapWidget:OnZoomIn( )
	if self.shown then
		self.minimap:Zoom( -1 )
	end
end

function MapWidget:OnZoomOut( )
	if self.shown then
		self.minimap:Zoom( 1 )
	end
end

function MapWidget:Update()
	local handle = self.minimap:GetTextureHandle()
	self:SetTextureHandle( handle )
end

function MapWidget:OnControl(control, down)
	if not down then return false end
	if not self.shown then return false end
	
	local s = -10
	
	if control == CONTROL_ZOOM_IN then
		self:OnZoomIn()
	elseif control == CONTROL_ZOOM_OUT then
		self:OnZoomOut()
	elseif control == CONTROL_ROTATE_LEFT then
		GetPlayer().components.playercontroller:RotLeft()
	elseif control == CONTROL_ROTATE_RIGHT then
		GetPlayer().components.playercontroller:RotRight()
	elseif control == CONTROL_MOVE_LEFT then
		self.minimap:Offset( -s, 0 )
	elseif control == CONTROL_MOVE_RIGHT then
		self.minimap:Offset( s, 0 )
	elseif control == CONTROL_MOVE_UP then
		self.minimap:Offset( 0, s )
	elseif control == CONTROL_MOVE_DOWN then
		self.minimap:Offset( 0, -s )
	else
		return false
	end
	
	return true
	
end


function MapWidget:UpdatePosition( x, y )
	if not self.shown then return end
	
	if TheInput:IsControlPressed(CONTROL_PRIMARY) then
		
		if self.lastpos then
			local scale = 0.5
			local dx = scale * ( x - self.lastpos.x )
			local dy = scale * ( y - self.lastpos.y )
			self.minimap:Offset( dx, dy )
		end
		
		self.lastpos = Vector3(x,y,0)
	else
		self.lastpos = nil
	end
end

function MapWidget:OnShow()
	self.minimap:ResetOffset()
end

function MapWidget:OnHide()
	self.lastpos = nil
end
