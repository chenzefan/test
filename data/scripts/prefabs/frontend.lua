local assets =
{
  --FE

    Asset("ANIM", "anim/credits.zip"),

    Asset("ATLAS", "bigportraits/locked.xml"),
    Asset("IMAGE", "bigportraits/locked.tex"),
    
    Asset("ATLAS", "images/fepanels.xml"),
    Asset("IMAGE", "images/fepanels.tex"),
    
    Asset("IMAGE", "images/customisation.tex" ),
    Asset("ATLAS", "images/customisation.xml" ),
    
	Asset("ATLAS", "images/selectscreen_portraits.xml"),
	Asset("IMAGE", "images/selectscreen_portraits.tex"),
	
    Asset("ANIM", "anim/portrait_frame.zip"),
    Asset("ANIM", "anim/scroll_arrow.zip"),

    Asset("ANIM", "anim/build_status.zip"),
    Asset("ANIM", "anim/savetile.zip"),
}

-- Add all the characters by name
for i,char in ipairs(CHARACTERLIST) do
	table.insert(assets, Asset("ATLAS", "bigportraits/"..char..".xml"))
	table.insert(assets, Asset("IMAGE", "bigportraits/"..char..".tex"))
	--table.insert(assets, Asset("IMAGE", "images/selectscreen_portraits/"..char..".tex"))
	--table.insert(assets, Asset("IMAGE", "images/selectscreen_portraits/"..char.."_silho.tex"))
end

--we don't actually instantiate this prefab. It's used for controlling asset loading
local function fn(Sim)
    return CreateEntity()
end

return Prefab( "UI/interface/frontend", fn, assets) 
