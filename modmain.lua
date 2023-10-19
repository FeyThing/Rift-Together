GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local containers = require "containers"
local smelterrecipe = require "main/smelterrecipe"

GLOBAL.CHEATS_ENABLED = true

local ToLoad = require("main/to_load")
PrefabFiles = ToLoad.Prefabs
Assets = ToLoad.Assets
for k, v in ipairs(ToLoad.MiniMaps) do
    AddMinimapAtlas(v)
end

GLOBAL.UpvalueHacker = require("tools/upvaluehacker")

modimport("scripts/main/tuning.lua")
modimport("scripts/main/strings.lua")
modimport("scripts/main/recipes.lua")
modimport("scripts/main/patches.lua")

---sound---


TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.RATCHET = { "owrench" }
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["owrench"] = {
   atlas = "images/inventoryimages/owrench.xml",
   image = "owrench.tex",
}

local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}

-----------------------
modimport("scripts/stategraphs/SGannihilator")
modimport("scripts/util/nefarious_powers")
modimport("scripts/stategraphs/SGratchet")
modimport("scripts/util/ratchet_dodge")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("ratchet", "MALE", skin_modes)
AddModCharacter("nefarious", "MALE")

local params = {}

---- OmniWrench
params.owrench =
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
    }

    function params.owrench.itemtestfn(container, item, slot)
        return item.prefab == "cryomod" or item.prefab == "napalmmod" or item.prefab == "shockmod"
    end

--- Smelter
params.vullard_smelter = 
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
--[[
		buttoninfo =
        {
            text = "Refine",
            position = Vector3(0, -100, 0),
        },
]]
		},
		type = "chest",
}

function params.vullard_smelter.itemtestfn(container, item, slot)
	return smelterrecipe[item.prefab] and (slot == 1 or slot == 2 and container.inst.on)
end	

for k, v in pairs(params) do
    containers.params[k] = v
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
