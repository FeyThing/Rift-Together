local Containers = require "containers"
local SmelterRecipes = require "main/smelterrecipe"

local params = {
    owrench =
    {
        widget =
        {
            slotpos =
            {
                Vector3(-75, 5,  0),
                Vector3(0, 5,  0),
				Vector3(75, 5,  0),
            },
            --[[slotbg =
            {
               { image = "omegamods.tex" },
            },]]
            animbank = "ui_ratchet_3x1",
            animbuild = "ui_ratchet_3x1",
            pos = Vector3(0, 30, 0),
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
                Vector3(0,  5,  0),
            },

            animbank = "ui_alterguardianhat_1x1",
            animbuild = "ui_alterguardianhat_1x1",
            pos = Vector3(0, 30, 0),
        },
        --usespecificslotsforitems = true,
        type = "hand_inv",
        excludefromcrafting = true,
        itemtestfn = function(container, item, slot)
            return item:HasTag("rnc_mod") 
        end,
    },
    vullard_smelter = 
	{
		widget = 
		{
			slotpos =
			{
				Vector3(-72, 0, 0),
				--Vector3(0, 0, 0),
				Vector3(72, 0, 0), 
			},
			animbank = "ui_ratchet_3x1",
			animbuild = "ui_ratchet_3x1",
			pos = Vector3(0, 200, 0),
			side_align_tip = 160,
            -- buttoninfo =
            -- {
            --     text = "Refine",
            --     position = Vector3(0, -100, 0),
            -- },
		},
		type = "chest",
        itemtestfn = function(container, item, slot)
            return SmelterRecipes[item.prefab] and (slot == 1 or slot == 2 and container.inst.on)
        end,
    },
}

for k, v in pairs(params) do
    Containers.params[k] = v
    Containers.MAXITEMSLOTS = math.max(Containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
