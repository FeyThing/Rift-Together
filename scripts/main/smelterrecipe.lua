require("recipe")



-- Alloys
local ALLOY_RECIPES = {
	raritaniumore = {
		numtoget = 3,
		product = "raritanium_bar",
		numtogive = 1,
	},
}

local function GetAlloyRecipe(item)
	return ALLOY_RECIPES[item.prefab]
end

local function GetAlloyRecipeAmounts(item)
	local recipe = GetAlloyRecipe(item)
	
	if recipe ~= nil then
		local stacksize = GetStackSize(item)
		local toget = stacksize - (stacksize % recipe.numtoget)
		local togive = math.floor(stacksize/recipe.numtoget) * recipe.numtogive
		
		return toget, recipe.product, togive
	end
	
	return 0, 0
end

local function IsAlloy(item)
	return item:HasTag("raritanium_bar")
end



-- Weapons
local function IsReinforceableWeapon(item)
	return item:HasTag("weapon")
end



-- Scraps
local INGREDIENTS_TO_RETRIEVE = {
	goldnugget = true,
	transistor = true,
	gears = true,
	moonglass = true,
}

local function GetScraps(item)
	local recipe = AllRecipes[item.prefab]
	
	if recipe ~= nil then
		-- Can never be valid if it's not stackable in this case
		if recipe.numtogive > 1 and item.replica.stackable == nil then
			return nil
		end
		
		local scraps = {}
		
		for _,data in pairs(recipe.ingredients) do
			local ing = data.type
			
			if INGREDIENTS_TO_RETRIEVE[ing] then
				scraps[ing] = data.amount
			end
		end
		
		if next(scraps) ~= nil then
			return scraps, recipe.numtogive
		end
	end
	
	return nil
end

local function GetScrapsAmounts(item)
	local scraps, numtogive = GetScraps(item)
	
	if scraps ~= nil then
		local newscraps = {}
		local stacksize = GetStackSize(item)
		local toget = stacksize - (stacksize % numtogive)
		
		if toget <= 0 then
			return 0, nil
		end
		
		for ing,amount in pairs(scraps) do
			newscraps[ing] = math.floor(stacksize/numtogive) * amount
		end
		
		return toget, newscraps
	end
	
	return 0, nil
end



local function IsValidSmelterItem(item)
	return GetAlloyRecipe(item) ~= nil or IsAlloy(item) or IsReinforceableWeapon(item) or GetScraps(item) ~= nil
end

local function IsReadyToSmelt(inst)
	local container = inst.replica.container
	local smelttype = nil
	local material = container:GetItemInSlot(1)
	local weapon = container:GetItemInSlot(2)
	local alloy_toget, alloy_product, alloy_togive, scraps_toget, scrapdata
	
	if weapon ~= nil then
		if material ~= nil and IsAlloy(material) then
			smelttype = "REINFORCE"
		end
	elseif material ~= nil then
		alloy_toget, alloy_product, alloy_togive = GetAlloyRecipeAmounts(material)
		scraps_toget, scrapdata = GetScrapsAmounts(material)
		
		if alloy_toget > 0 then
			smelttype = "ALLOY"
		elseif scraps_toget > 0 then
			smelttype = "SCRAPS"
		end
	end
	
	local data = {
		smelttype = smelttype,
		material = material,
		weapon = weapon,
		alloy_toget = alloy_toget,
		alloy_product = alloy_product,
		alloy_togive = alloy_togive,
		scraps_toget = scraps_toget,
		scrapdata = scrapdata,
	}
	
	return smelttype ~= nil, data
end

local function ConsumeItems(inst, amount)
	if inst.components.stackable ~= nil then
		inst.components.stackable:Get(amount):Remove()
	else
		inst:Remove()
	end
end

local function SmeltReinforce(inst, data)
	if data.weapon ~= nil and data.material ~= nil then
		-- to-do upgrade weapon here
		ConsumeItems(data.material, 1)
	end
end

local function SmeltAlloy(inst, data)
	if data.material ~= nil then
		ConsumeItems(data.material, data.alloy_toget)
		
		for i=1,data.alloy_togive do
			local alloy = SpawnPrefab(data.alloy_product)
			
			if alloy ~= nil then
				inst.components.container:GiveItem(alloy, 3)
			end
		end
	end
end

local function SmeltScraps(inst, data)
	if data.material ~= nil then
		ConsumeItems(data.material, data.scraps_toget)
		
		for ing,amount in pairs(data.scrapdata) do
			for i=1,amount do
				local scrap = SpawnPrefab(ing)
				
				if scrap ~= nil then
					inst.components.container:GiveItem(scrap, 3)
				end
			end
		end
	end
end

local function DoSmelt(inst, data)
	if data.smelttype == "REINFORCE" then
		SmeltReinforce(inst, data)
	elseif data.smelttype == "ALLOY" then
		SmeltAlloy(inst, data)
	elseif data.smelttype == "SCRAPS" then
		SmeltScraps(inst, data)
	end
end

return {
	ALLOY_RECIPES = ALLOY_RECIPES,
	GetAlloyRecipe = GetAlloyRecipe,
	IsAlloy = IsAlloy,
	GetAlloyRecipeAmounts = GetAlloyRecipeAmounts,
	
	IsReinforceableWeapon = IsReinforceableWeapon,
	
	INGREDIENTS_TO_RETRIEVE = INGREDIENTS_TO_RETRIEVE,
	GetScraps = GetScraps,
	GetScrapsAmounts = GetScrapsAmounts,
	
	IsValidSmelterItem = IsValidSmelterItem,
	IsReadyToSmelt = IsReadyToSmelt,
	
	SmeltReinforce = SmeltReinforce,
	SmeltAlloy = SmeltAlloy,
	SmeltScraps = SmeltScraps,
	DoSmelt = DoSmelt,
}