local ModuleDefs = require("wx78_moduledefs")



local RT_MODULES = {}

local function AddRTModule(mod_data, mob_data)
	table.insert(ModuleDefs.module_definitions, mod_data)
	ModuleDefs.AddNewModuleDefinition(mod_data)
	
	local modname = mod_data.name
	
	for mob,num in pairs(mob_data) do
		ModuleDefs.AddCreatureScanDataDefinition(mob, modname, num)
	end
	
	RT_MODULES[modname] = true
end



-- Copied from wx78_moduledefs
local function maxhealth_change(inst, wx, amount, isloading)
	if wx.components.health ~= nil then
		local current_health_percent = wx.components.health:GetPercent()
		
		wx.components.health.maxhealth = wx.components.health.maxhealth + amount
		
		if not isloading then
			wx.components.health:SetPercent(current_health_percent)
			
			-- We want to force a badge pulse, but also maintain the health percent as much as we can.
			local badgedelta = (amount > 0 and 0.01) or -0.01
			wx.components.health:DoDelta(badgedelta, false, nil, true)
		end
	end
end



-- Radiation immunity circuit
local function MaxResist_OnActivate(inst, wx, isloading)
	wx._maxresist_modules = (wx._maxresist_modules or 0) + 1
	
	if wx.components.radiation ~= nil then
		if not isloading and wx._maxresist_modules == 1 then
			wx.components.radiation:SetPercent(0, false)
		end
		
		wx.components.radiation:SetIgnore(true)
	end
	
	maxhealth_change(inst, wx, TUNING.WX78_MAXHEALTH_BOOST, isloading)
end

local function MaxResist_OnDeactivate(inst, wx)
	wx._maxresist_modules = math.max(0, wx._maxresist_modules - 1)
	
	if wx.components.radiation ~= nil then
		if wx._maxresist_modules == 0 then
			wx.components.radiation:SetIgnore(false)
		end
	end
	
	maxhealth_change(inst, wx, -TUNING.WX78_MAXHEALTH_BOOST)
end

local MAXRESIST_MODULE_DATA = {
	name = "maxresist",
	slots = 1,
	activatefn = MaxResist_OnActivate,
	deactivatefn = MaxResist_OnDeactivate,
}

local MAXRESIST_MODULE_MOBS = {
	mutatedhound = 2,
	mutated_penguin = 2,
	rt_pawn = 4,
	hound_robomutt = 4,
}

AddRTModule(MAXRESIST_MODULE_DATA, MAXRESIST_MODULE_MOBS)



-- To make our modules even show up in the UI -_-
AddClassPostConstruct("widgets/upgrademodulesdisplay", function(self)
	local _old_onmoduleadded = self.OnModuleAdded
	
	function self:OnModuleAdded(moduledefinition_index, ...)
		local new_chip = self.chip_objectpool[self.chip_poolindex]
		
		_old_onmoduleadded(self, moduledefinition_index, ...)
		
		local module_def = ModuleDefs.GetModuleDefinitionFromNetID(moduledefinition_index)
		
		if module_def == nil then
			return
		end
		
		local modname = module_def.name
		
		if RT_MODULES[modname] then
			new_chip:GetAnimState():OverrideSymbol("movespeed2_chip", "rtstatus_wx", modname.."_chip")
		end
	end
end)

-- And to give modules the proper dropped on the ground animation
for modname,_ in pairs(RT_MODULES) do
	AddPrefabPostInit("wx78module_"..modname, function(inst)
		inst.AnimState:SetBank("rt_chips")
		inst.AnimState:SetBuild("rt_chips")
		inst.AnimState:PlayAnimation(modname == "maxresist" and "resist" or modname) -- to-do temporary hack until anim name is changed
	end)
end