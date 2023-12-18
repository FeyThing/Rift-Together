
--[[local OldGetSkilltreeBG = GLOBAL.GetSkilltreeBG
function GLOBAL.GetSkilltreeBG(imagename, ...)
    if imagename == "ratchet_background.tex" then
        return "images/ratchet_skilltree.xml"
    else
        return OldGetSkilltreeBG(imagename, ...)
    end
end

local SkillTreeDefs = require("prefabs/skilltree_defs")

local CreateSkillTree = function()
	print("Creating a skilltree for Ratchet")
	local BuildSkillsData = require("prefabs/skilltree_ratchet") -- Load in the skilltree

    if BuildSkillsData then
        local data = BuildSkillsData(SkillTreeDefs.FN)

        if data then
            SkillTreeDefs.CreateSkillTreeFor("ratchet", data.SKILLS)
            SkillTreeDefs.SKILLTREE_ORDERS["ratchet"] = data.ORDERS
			print("Created Ratchet's skilltree")
        end
    end
end
CreateSkillTree();]]

GLOBAL.owrench_init_fn = function(inst, build_name)
    GLOBAL.basic_init_fn(inst, build_name, "owrench" )
end

GLOBAL.owrench_clear_fn = function(inst)
    GLOBAL.basic_clear_fn(inst, "owrench" )
end


local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}

RegisterInventoryItemAtlas(GLOBAL.resolvefilepath("images/rnc_inventoryimages.xml"), "ms_owrench_hammer.tex")


if GetModConfigData("Ratchet And Clank Characters") == 1 then
		AddModCharacter("ratchet", "MALE", skin_modes)
		--AddModCharacter("nefarious", "MALE", skin_modes)

	end
	


