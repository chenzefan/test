require "widget"

Image = Class(Widget, function(self, tex)
    Widget._ctor(self, "Image")
   
    self.inst.entity:AddImageWidget()
    
    if tex then
		self:SetTexture(tex)
    end
end)

function Image:SetAlphaRange(min, max)
	self.inst.ImageWidget:SetAlphaRange(min, max)
end

function Image:SetTexture(tex)
	self.texture = resolvefilepath(tex)
    self.inst.ImageWidget:SetTexture(self.texture)
end

function Image:SetMouseOverTexture(tex)
    self.mouseovertex = resolvefilepath(tex)
end

function Image:SetDisabledTexture(tex)
	self.disabledtex = resolvefilepath(tex)
end

function Image:SetSize(w,h)
    if type(w) == "number" then
        self.inst.ImageWidget:SetSize(w,h)
    else
        self.inst.ImageWidget:SetSize(w[1],w[2])
    end
end

function Image:GetSize()
    local w, h = self.inst.ImageWidget:GetSize()
    return w, h
end

function Image:ScaleToSize(w, h)
	local w0, h0 = self.inst.ImageWidget:GetSize()
	local scalex = w / w0
	local scaley = h / h0
	self:SetScale(scalex, scaley, 1)
end

function Image:SetTint(r,g,b,a)
    self.inst.ImageWidget:SetTint(r,g,b,a)
end

function Image:SetVRegPoint(anchor)
    self.inst.ImageWidget:SetVAnchor(anchor)
end

function Image:SetHRegPoint(anchor)
    self.inst.ImageWidget:SetHAnchor(anchor)
end

function Image:OnMouseOver()
	--print("Image:OnMouseOver", self)
	if self.enabled and self.mouseovertex then
		self.inst.ImageWidget:SetTexture(self.mouseovertex)
	end
	Widget.OnMouseOver( self )
end

function Image:OnMouseOut()
	--print("Image:OnMouseOut", self)
	if self.enabled and self.mouseovertex then
		self.inst.ImageWidget:SetTexture(self.texture)
	end
	Widget.OnMouseOut( self )
end

function Image:OnEnable()
    if self.mouse_over_self then
		self:OnMouseOver()
	else
		self.inst.ImageWidget:SetTexture(self.texture)
	end
end

function Image:OnDisable()
	self.inst.ImageWidget:SetTexture(self.disabledtex)
end

