local Containers = require "containers"
local Smelter = require "main/smelterrecipe"

local params = {
    owrench =
    {
        widget =
        {
            slotpos =
            {
                _G.Vector3(-75, 5,  0),
                _G.Vector3(0, 5,  0),
				_G.Vector3(75, 5,  0),
            },
			        slotbg =
			{
            {image = "omegamods.tex", atlas = "images/omegamods.xml" },
			{image = "omegamods.tex", atlas = "images/omegamods.xml" },
			{image = "omegamods.tex", atlas = "images/omegamods.xml" },			
			},
            animbank = "ui_ratchet_3x1",
            animbuild = "ui_ratchet_3x1",
            pos = _G.Vector3(0, 30, 0),
        },
        --usespecificslotsforitems = true,
        type = "hand_inv",
        excludefromcrafting = true,
        itemtestfn = function(container, item, slot)
            return item:HasTag("rnc_mod") --item.prefab == "cryomod" or item.prefab == "napalmmod" or item.prefab == "shockmod"
        end,
    },
	    rarisword =
    {
        widget =
        {
            slotpos =
            {
                _G.Vector3(0,  -10,  0),
            },
			slotbg =
			{
            {image = "omegamods.tex", atlas = "images/omegamods.xml" },			
			},

            animbank = "ui_ratchet_1x1",
            animbuild = "ui_ratchet_1x1",
            pos = _G.Vector3(0, 50, 0),
        },
        --usespecificslotsforitems = true,
        type = "hand_inv",
        excludefromcrafting = true,
        itemtestfn = function(container, item, slot)
            return item:HasTag("rnc_mod") 
        end,
    },
	rt_anvil = 
	{
		widget = 
		{
			slotpos =
			{
				_G.Vector3(-72, 0, 0),			
				_G.Vector3(72, 0, 0), 
			},
			slotbg =
			{
            {image = "forgealloy.tex", atlas = "images/forgeores.xml" },
			{image = "anvilweapon.tex", atlas = "images/forgefire.xml" },		
			},
			animbank = "ui_anvil",
			animbuild = "ui_anvil",
			pos = _G.Vector3(0, 200, 0),
			side_align_tip = 160,
		},
		type = "chest",
        itemtestfn = function(container, item, slot)
            return 
        end,
    },	
    vullard_smelter = 
	{
		widget = 
		{
			slotpos =
			{
				_G.Vector3(-74, -3, 0),
				_G.Vector3(-74, 74, 0),
				_G.Vector3(77, -43, 0),
				_G.Vector3(-74, -80, 0), 
			},
			slotbg =
			{
            {image = "forgeores.tex", atlas = "images/forgeores.xml" },
			{image = "forgefire.tex", atlas = "images/forgefire.xml" },
			{image = "forgealloy.tex", atlas = "images/forgealloy.xml" },
			{image = "forgeores.tex", atlas = "images/forgeores.xml" },			
			},
			animbank = "ui_smelter",
			animbuild = "ui_smelter",
			pos = _G.Vector3(0, 200, 0),
			side_align_tip = 160,
			buttoninfo =
			{
				text = _G.STRINGS.ACTIONS.VULLARD_SMELT,
				position = _G.Vector3(0, -100, 0),
				fn = function(inst, doer)
					if inst.components.container ~= nil then
						_G.BufferedAction(doer, inst, _G.ACTIONS.VULLARD_SMELT):Do()
					elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
						_G.SendRPCToServer(_G.RPC.DoWidgetButtonAction, _G.ACTIONS.VULLARD_SMELT.code, inst, _G.ACTIONS.VULLARD_SMELT.mod_name)
					end
				end,
				validfn = function(inst)
					return Smelter.IsReadyToSmelt(inst)
				end,
			},
		},
		usespecificslotsforitems = true,
		type = "chest",
        itemtestfn = function(container, item, slot)
            if slot == nil and Smelter.IsValidSmelterItem(item) then
				return true
			elseif slot == 1 or slot == 4 then
				return Smelter.GetAlloyRecipe(item) ~= nil or Smelter.IsAlloy(item) or Smelter.GetScraps(item) ~= nil
			elseif slot == 2 then
				return Smelter.IsReinforceableWeapon(item)
			elseif slot == 3 then
				return false -- to-do players shouldn't put items here but I'll try a hack later to let the Smelter gives itself items
			end
			
			return false
        end,
    },
}

for k, v in pairs(params) do
    Containers.params[k] = v
    Containers.MAXITEMSLOTS = math.max(Containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
