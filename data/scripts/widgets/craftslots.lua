require "class"

local TileBG = require "widgets/tilebg"
local InventorySlot = require "widgets/invslot"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local Widget = require "widgets/widget"
local TabGroup = require "widgets/tabgroup"
local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"
local CraftSlot = require "widgets/craftslot"

local CraftSlots = Class(Widget, function(self, num, owner)
    Widget._ctor(self, "CraftSlots")
    
    self.slots = {}
    for k = 1, num do
        local slot = CraftSlot(HUD_ATLAS, "craft_slot.tex", owner)
        self.slots[k] = slot
        self:AddChild(slot)
    end

end)

function CraftSlots:Clear()
    for k,v in ipairs(self.slots) do
        v:Clear()
    end
end

function CraftSlots:CloseAll()
    for k,v in ipairs(self.slots) do
        v:Close()
    end
end


return CraftSlots
