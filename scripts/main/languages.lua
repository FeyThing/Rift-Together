local translation = GetModConfigData("language")

if translation then
	require("main/strings/strings_"..translation)
end

local NEW_LOADING_TIPS = {
    LOADING_SCREEN_OTHER_TIPS = "SURVIVAL",
    LOADING_SCREEN_SURVIVAL_TIPS = "SURVIVAL",
    LOADING_SCREEN_LORE_TIPS = "LORE",
}

for tip, category in pairs(NEW_LOADING_TIPS) do
    AddLoadingTip(GLOBAL.STRINGS.UI["LOADING_SCREEN_"..category.."_TIPS"], tip)
end

