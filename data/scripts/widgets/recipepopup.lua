require "class"

local TileBG = require "widgets/tilebg"
local InventorySlot = require "widgets/invslot"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local Widget = require "widgets/widget"
local TabGroup = require "widgets/tabgroup"
local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"
local IngredientUI = require "widgets/ingredientui"

require "widgets/widgetutil"

local RecipePopup = Class(Widget, function(self, parentslot)
    Widget._ctor(self, "Recipe Popup")
    
    self.parentslot = parentslot
    self.bg = self:AddChild(UIAnim())
    self.bg:GetAnimState():SetBank("crafting_submenu")
    self.bg:GetAnimState():SetBuild("crafting_submenu")
    self.bg:GetAnimState():PlayAnimation("off")
    
    self.bg:SetPosition(32,16,0)
    
    self.contents = self:AddChild(Widget(""))
    self.contents:SetPosition(-75,0,0)
    
    self.name = self.contents:AddChild(Text(UIFONT, 45))
    self.name:SetPosition(327, 142, 0)

    self.desc = self.contents:AddChild(Text(BODYTEXTFONT, 30))
    self.desc:SetPosition(325, -5, 0)
    self.desc:SetRegionSize(64*3+20,70)
    self.desc:EnableWordWrap(true)
    
    self.ing = {}
    
    self.button = self.contents:AddChild(ImageButton(UI_ATLAS, "button.tex", "button_over.tex", "button_disabled.tex"))
    self.button:SetScale(.7,.7,.7)
    self.button:SetOnClick(function() if not DoRecipeClick(self.owner, self.recipe) then self.owner.HUD.controls.crafttabs:Close() end end)
    
    
    self.recipecost = self.contents:AddChild(Text(NUMBERFONT, 40))
    self.recipecost:SetHAlign(ANCHOR_LEFT)
    self.recipecost:SetRegionSize(80,50)
    self.recipecost:SetPosition(420,-115,0)--(375, -115, 0)
    self.recipecost:SetColour(255/255, 234/255,0/255, 1)

    self.amulet = self.contents:AddChild(Image( resolvefilepath("images/inventoryimages.xml"), "greenamulet.tex"))
    self.amulet:SetPosition(415, -105, 0)
    self.amulet:SetTooltip(STRINGS.GREENAMULET_TOOLTIP)
    
    self.teaser = self.contents:AddChild(Text(BODYTEXTFONT, 30))
    self.teaser:SetPosition(325, -100, 0)
    self.teaser:SetRegionSize(64*3+20,70)
    self.teaser:EnableWordWrap(true)
    self.teaser:Hide()
end)


function GetHintTextForRecipe(recipe)
    local validmachines = {}
    for k,v in pairs(TUNING.PROTOTYPER_TREES) do
        local canbuild = CanPrototypeRecipe(recipe.level, v)
        if canbuild then
            table.insert(validmachines, {TREE = tostring(k), SCORE = 0})
            --return tostring(k)
        end
    end

    if #validmachines > 0 then
        if #validmachines == 1 then
            --There's only once machine is valid. Return that one.
            return validmachines[1].TREE
        end

        --There's more than one machine that gives the valid tech level! We have to find the "lowest" one.
        for k,v in pairs(validmachines) do
            for rk,rv in pairs(recipe.level) do
                if TUNING.PROTOTYPER_TREES[v.TREE][rk] == rv then
                    v.SCORE = v.SCORE + 1
                end
            end
        end

        -- local bestmachine = nil    
        -- for each req in recipe.level do
        --     for m in validmachines do
        --         if req > 0 and m[req] >= req and m[req] < bestmachine[req] then
        --             bestmachine = m
        --         end
        --     end
        -- end


        table.sort(validmachines, function(a,b) return (a.SCORE) > (b.SCORE) end)

        return validmachines[1].TREE
    end

    return "CANTRESEARCH"
end

function RecipePopup:SetRecipe(recipe, owner)
    --if recipe ~= self.recipe then
        self.recipe = recipe
        self.owner = owner
        
        local knows = owner.components.builder:KnowsRecipe(recipe.name)
        local buffered = owner.components.builder:IsBuildBuffered(recipe.name)
        local can_build = owner.components.builder:CanBuild(recipe.name) or buffered
        local tech_level = owner.components.builder.accessible_tech_trees
        local should_hint = not knows and ShouldHintRecipe(recipe.level, tech_level) and not CanPrototypeRecipe(recipe.level, tech_level)

        local equippedBody = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)

        local showamulet = equippedBody and equippedBody.prefab == "greenamulet"
        
        self.bg:GetAnimState():PlayAnimation("off")
        
        if should_hint then
            self.recipecost:Hide()
            self.button:Hide()
            
            local hint_text = 
            {
                ["SCIENCEMACHINE"] = STRINGS.UI.CRAFTING.NEEDSCIENCEMACHINE,
                ["ALCHEMYMACHINE"] = STRINGS.UI.CRAFTING.NEEDALCHEMYENGINE,
                ["SHADOWMANIPULATOR"] = STRINGS.UI.CRAFTING.NEEDSHADOWMANIPULATOR,
                ["PRESTIHATITATOR"] = STRINGS.UI.CRAFTING.NEEDPRESTIHATITATOR,
                ["CANTRESEARCH"] = STRINGS.UI.CRAFTING.CANTRESEARCH,
                ["ANCIENTALTAR_HIGH"] = STRINGS.UI.CRAFTING.NEEDSANCIENT_FOUR,
            }
            local str = hint_text[GetHintTextForRecipe(recipe)] or "Text not found."
            self.teaser:SetString(str)
            self.teaser:Show()
            showamulet = false
        elseif knows then
            self.teaser:Hide()
            self.recipecost:Hide()
            self.button:Show()
            self.button:SetPosition(320, -105, 0)
            self.button:SetScale(1,1,1)
            
            self.button:SetText(buffered and STRINGS.UI.CRAFTING.PLACE or STRINGS.UI.CRAFTING.BUILD)
            if can_build then
                self.button:Enable()
            else
                self.button:Disable()
            end
        else
        
            self.teaser:Hide()
            self.recipecost:Hide()
            self.button:Show()
            self.button:SetPosition(320, -105, 0)
            self.button:SetScale(1,1,1)
            
            self.button:SetText(STRINGS.UI.CRAFTING.PROTOTYPE)
            if can_build then
                self.button:Enable()
            else
                self.button:Disable()
            end
            
        end 

		if not showamulet then
            self.amulet:Hide()
        else
            self.amulet:Show()
        end
        
        self.name:SetString(self.recipe.descname)
        self.desc:SetString(self.recipe.description)
        
        for k,v in pairs(self.ing) do
            v:Kill()
        end
        self.ing = {}

        local center = 330
        local num = 0
        for k,v in pairs(recipe.ingredients) do num = num + 1 end
        local w = 64
        local div = 10
        
        local offset = center
        if num > 1 then 
            offset = offset - (w/2 + div)*(num-1)
        end
        
        for k,v in pairs(recipe.ingredients) do
        
            local has, num_found = owner.components.inventory:Has(v.type, RoundUp(v.amount * owner.components.builder.ingredientmod))
            
            local ing = self.contents:AddChild(IngredientUI(v.atlas, v.type..".tex", v.amount, num_found, has, STRINGS.NAMES[string.upper(v.type)], owner))
            ing:SetPosition(Vector3(offset, 80, 0))
            offset = offset + (w+ div)
            self.ing[k] = ing
        end

    --end
end

return RecipePopup
