require "class"

local TileBG = require "widgets/tilebg"
local InventorySlot = require "widgets/invslot"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local Widget = require "widgets/widget"
local TabGroup = require "widgets/tabgroup"
local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"
local CraftSlots = require "widgets/craftslots"

require "widgets/widgetutil"


CRAFTING_CONSTANTS = 
{
    CRAFT_POS = 145,
	TABBAR_HEIGHT = 750,
	NUM_SLOTS = 7,
}


local Crafting = Class(Widget, function(self, crafttabs, owner)
    Widget._ctor(self, "Crafting")
    self.craft_pos = CRAFTING_CONSTANTS.CRAFT_POS
    self.crafttabs = crafttabs
	self.owner = owner


    self.bg = self:AddChild(TileBG(HUD_ATLAS, "craft_slotbg.tex", "craft_sep.tex", nil, false))
    self.bg:SetNumTiles(CRAFTING_CONSTANTS.NUM_SLOTS)
	local slot_w, slot_h = self.bg:GetSlotSize()
    local w, h = self.bg:GetSize()
    self:SetPosition(w/2 + 30, 0, 0)
    

    --slots
    self.craftslots = CraftSlots(CRAFTING_CONSTANTS.NUM_SLOTS, self.owner)
    self:AddChild(self.craftslots)
    for k = 1, #self.craftslots.slots do
		local slotpos = self.bg:GetSlotPos(k)
        self.craftslots.slots[k]:SetPosition( slotpos.x,slotpos.y,slotpos.z )
    end

    --buttons
    self.downbutton = self:AddChild(ImageButton(HUD_ATLAS, "craft_end_normal.tex", "craft_end_normal_mouseover.tex", "craft_end_normal_disabled.tex"))
    local but_w, but_h = self.downbutton:GetSize()
    self.downbutton:SetPosition(0, - self.bg.length/2 - but_h/2 + slot_h/2,0)
    self.downbutton:SetOnClick(function() self:ScrollUp() end)
    self.upbutton = self:AddChild(ImageButton(HUD_ATLAS, "craft_end_normal.tex", "craft_end_normal_mouseover.tex", "craft_end_normal_disabled.tex"))
    self.upbutton:SetScale(Vector3(1, -1, 1))
    self.upbutton:SetPosition(0, self.bg.length/2 + but_h/2 - slot_h/2,0)
    self.upbutton:SetOnClick(function() self:ScrollDown() end)
    
	-- start slightly scrolled down
    self.idx = -1
    self.scrolldir = true
    self:UpdateRecipes()
    
end)

function Crafting:SetFilter(filter)
    local new_filter = filter ~= self.filter
    self.filter = filter
    
    if new_filter then 
        self:UpdateRecipes()
    end
end

function Crafting:Close()
    self:Disable() 
	self:MoveTo(Vector3(self.craft_pos,0,0), Vector3(-64,0,0), .33)
	
	self.craftslots:CloseAll()
end

function Crafting:Open()
	self:Show() 
	self:Enable() 
	self:MoveTo(Vector3(-64,0,0), Vector3(self.craft_pos,0,0), .33)
end


function Crafting:UpdateRecipes()
    self.craftslots:Clear()
    if self.owner and self.owner.components.builder then
        
        local recipes = GetAllRecipes()
        --local recipes = self.owner.components.builder.recipes
        local offset = 1
        self.valid_recipes = {}
        
        for k,v in pairs(recipes) do
            local knows = self.owner.components.builder:KnowsRecipe(v.name)
            local show = ((not self.filter) or self.filter(v.name)) and (knows or ShouldHintRecipe(v.level, self.owner.components.builder.accessible_tech_trees))
            if show then
                table.insert(self.valid_recipes, v)
            end
        end
        table.sort(self.valid_recipes, function(a,b) return a.sortkey < b.sortkey end)
        
        local shown_num = 0

        local num = math.min(CRAFTING_CONSTANTS.NUM_SLOTS, #self.valid_recipes)

        if self.idx > #self.valid_recipes+2-CRAFTING_CONSTANTS.NUM_SLOTS then
            self.idx = #self.valid_recipes+2-CRAFTING_CONSTANTS.NUM_SLOTS -- the +2 is because of the blank at either end, effectively "two more recipes"
        end
        if self.idx < 0 then
            self.idx = 0
        end

        for k = 0,num do  -- 0 is one blank before the first recipe
            local recipe_idx = (self.idx + k )
            
            local recipe = self.valid_recipes[recipe_idx]
            
            if recipe then
                
                local show = (not self.filter) or self.filter(recipe.name) 
                if show then
                    local slot = self.craftslots.slots[CRAFTING_CONSTANTS.NUM_SLOTS - k]
                    if slot then
                        slot:SetRecipe( recipe.name )
                        shown_num = shown_num + 1
                    end
                end
            end
        end
        
        if shown_num == 0 then
            --self:Disable() 
            --self:MoveTo(Vector3(self.inst.UITransform:GetLocalPosition()), Vector3(-64,0,0), .33)
            self.crafttabs.tabs:DeselectAll()
        end
        
        
        
        if self.idx > 0 then
            self.upbutton:Enable()
        else
            self.upbutton:Disable()
        end

        --print (CRAFTING_CONSTANTS.NUM_SLOTS, self.idx, #self.valid_recipes)
        
        if (CRAFTING_CONSTANTS.NUM_SLOTS-2)+self.idx < #self.valid_recipes then
            self.downbutton:Enable()
        else
            self.downbutton:Disable()
        end
        
    end
end

function Crafting:ScrollUp()
	if not IsHUDPaused() then
        self.idx = self.idx + 1
		self:UpdateRecipes()
		
		self.owner.SoundEmitter:PlaySound("dontstarve/HUD/craft_up")
	end
end

function Crafting:ScrollDown()
	if not IsHUDPaused() then
		self.idx = self.idx - 1
		self:UpdateRecipes()
		self.owner.SoundEmitter:PlaySound("dontstarve/HUD/craft_down")
	end
end

return Crafting
