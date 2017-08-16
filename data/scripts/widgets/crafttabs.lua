require "class"

local TileBG = require "widgets/tilebg"
local InventorySlot = require "widgets/invslot"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local Widget = require "widgets/widget"
local TabGroup = require "widgets/tabgroup"
local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"
local Crafting = require "widgets/crafting"


local tab_bg = 
{
    normal = "tab_normal.tex",
    selected = "tab_selected.tex",
    highlight = "tab_highlight.tex",
    overlay = "tab_researchable.tex",
}


local CraftTabs = Class(Widget, function(self, owner)
    
    Widget._ctor(self, "CraftTabs")
    self.owner = GetPlayer()    
	self.owner = owner

    self:SetPosition(0,0,0)
    
    self.crafting = self:AddChild(Crafting(self, self.owner))
    self.crafting:Hide()
    self.bg = self:AddChild(Image("images/hud.xml", "craft_bg.tex"))
    
    self.tabs = self:AddChild(TabGroup())
    self.tabs:SetPosition(-16,0,0)

    self.tabs.onopen = function() self.owner.SoundEmitter:PlaySound("dontstarve/HUD/craft_open") end
    self.tabs.onchange = function() self.owner.SoundEmitter:PlaySound("dontstarve/HUD/craft_open") end
    self.tabs.onclose = function() self.owner.SoundEmitter:PlaySound("dontstarve/HUD/craft_close") end
    self.tabs.onhighlight = function() self.owner.SoundEmitter:PlaySound("dontstarve/HUD/recipe_ready") return .2 end
    self.tabs.onoverlay = function() self.owner.SoundEmitter:PlaySound("dontstarve/HUD/research_available") return .2 end
    
    local tabnames = {}
    for k,v in pairs(RECIPETABS) do
        table.insert(tabnames, v)
    end

    for k,v in pairs(owner.components.builder.custom_tabs) do
        table.insert(tabnames, v)
    end

    table.sort(tabnames, function(a,b) return a.sort < b.sort end)
    
    self.tabs.spacing = CRAFTING_CONSTANTS.TABBAR_HEIGHT/#tabnames
    
    self.tabbyfilter = {}
    for k,v in ipairs(tabnames) do
        local tab = self.tabs:AddTab(v.str, resolvefilepath("images/hud.xml"), v.icon_atlas or resolvefilepath("images/hud.xml"), v.icon, tab_bg.normal, tab_bg.selected, tab_bg.highlight, tab_bg.overlay,
            function() --select fn
                self.crafting:SetFilter( 
                    function(recipe)
                        local rec = GetRecipe(recipe)
                        
                        return rec and rec.tab == v
                    end)
                self.crafting:Open() 
                
            end, 
            function() --deselect fn
                self.crafting:Close()
            end)
        self.tabbyfilter[v] = tab
        
    end
    
    self.inst:ListenForEvent("techtreechange", function(inst, data) self:UpdateRecipes() end, self.owner)
    self.inst:ListenForEvent("itemget", function(inst, data) self:UpdateRecipes() end, self.owner)
    self.inst:ListenForEvent("itemlose", function(inst, data) self:UpdateRecipes() end, self.owner)
    self.inst:ListenForEvent("stacksizechange", function(inst, data) self:UpdateRecipes() end, self.owner)
    self.inst:ListenForEvent("unlockrecipe", function(inst, data) self:UpdateRecipes() end, self.owner)
end)

function CraftTabs:Close()
	self.tabs:DeselectAll()
end

function CraftTabs:Update(dt)
	local x = TheInput:GetScreenPosition().x
	local w,h = TheSim:GetScreenSize()
	if x > w*.33 then
		self:Close()
	end

	if self.needtoupdate then
		self:DoUpdateRecipes()
	end
end

function CraftTabs:UpdateRecipes()
    self.needtoupdate = true
end

function CraftTabs:DoUpdateRecipes()
	if self.needtoupdate then

		self.needtoupdate = false	
		local tabs_to_highlight = {}
		local tabs_to_overlay = {}
		local valid_tabs = {}
	    
		for k,v in pairs(self.tabbyfilter) do
			tabs_to_highlight[v] = 0
			tabs_to_overlay[v] = 0
			valid_tabs[v] = false
		end
	    
		if self.owner.components.builder then
			local current_research_level = self.owner.components.builder.accessible_tech_trees or NO_TECH
			
			
			local recipes = GetAllRecipes()
			for k,rec in pairs(recipes) do

				local tab = self.tabbyfilter[rec.tab]
				local has_researched = self.owner.components.builder:KnowsRecipe(rec.name)
				
				local can_see = has_researched or CanPrototypeRecipe(rec.level, current_research_level)
				local can_build = self.owner.components.builder:CanBuild(rec.name)
				local can_research = false
				
				can_research = not has_researched and can_build and CanPrototypeRecipe(rec.level, current_research_level)
	            
	            valid_tabs[tab] = valid_tabs[tab] or can_see
	            
				if can_build and has_researched then
					if tab then
						tabs_to_highlight[tab] = 1 + (tabs_to_highlight[tab] or 0)
					end
				end
	            
				if can_research then
					if tab then
						tabs_to_overlay[tab] = 1 + (tabs_to_overlay[tab] or 0)
					end
				end
				
			end
		end

		local to_select = nil
		local current_open = nil

		
		for k,v in pairs(valid_tabs) do
			if v then
				self.tabs:ShowTab(k)
			else
				self.tabs:HideTab(k)
			end
		end
		

		for k,v in pairs(tabs_to_highlight) do    
			if v > 0 then
				k:Highlight(v)
			else
				k:UnHighlight()
			end
	        
		end
	    
		for k,v in pairs(tabs_to_overlay) do    
			if v > 0 then
				k:Overlay()
			else
				k:HideOverlay()
			end
		end    
	    
		if self.crafting and self.crafting.shown then
			self.crafting:UpdateRecipes()
		end
	end
end

return CraftTabs
