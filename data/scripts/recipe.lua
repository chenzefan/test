require "class"
require "util"

Ingredient = Class(function(self, type, amount)
    self.type = type
    self.amount = amount
end)

local num = 0
Recipes = {}

Recipe = Class(function(self, name, ingredients, tab, level, placer, min_spacing)
    self.name = name
    self.descname = STRINGS.NAMES[string.upper(name)]
    self.description = STRINGS.RECIPE_DESC[string.upper(name)]
    self.ingredients = ingredients
    self.product = name
    self.tab = tab

   	self.image = resolvefilepath("inventoryimages/"..name..".tex")
	self.sortkey = num
	self.level = level or 0
	self.placer = placer
	self.min_spacing = min_spacing or 3.2

	if TheSim then
		TheSim:LoadPrefabs{name}
		if placer then
			TheSim:LoadPrefabs{placer}
		end
	end

	num = num + 1    
    Recipes[name] = self
    
end)



function GetAllRecipes()
	return Recipes
end

function GetRecipe(name)
    return Recipes[name]
end
