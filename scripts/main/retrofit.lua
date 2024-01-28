local OldDoRetrofitting = require("map/retrofit_savedata").DoRetrofitting

require("map/retrofit_savedata").DoRetrofitting = function(savedata, world_map, ...)
    local dirty = false
    if GetModConfigData("biome_retrofit") == 1 and savedata.map ~= nil and savedata.map.prefab == "forest" then
        if savedata.ents ~= nil and savedata.ents.vullard_smelter ~= nil then
            print("Retrofitting for Torren IV - Vullard_Forge found, it seems the island already exists.")
        else
            print("Retrofitting for Torren IV - Looking to generate new island for TorrenIV chunk.")
            require("map/retrofit_torreniv_island").TorrenIVRetrofitting_TorrenIV(GLOBAL.TheWorld.Map, savedata)
        end
        dirty = true
    end
    
    if dirty then
        savedata.map.tiles = world_map:GetStringEncode()
        savedata.map.nodeidtilemap = world_map:GetNodeIdTileMapStringEncode()
    end
    
    OldDoRetrofitting(savedata, world_map, ...)
end

function ChangeTorrenIVConfigs(config, value)
    local configuration_options = KnownModIndex:LoadModConfigurationOptions("workshop-3121596445", false)
    if configuration_options ~= nil then
        for i, v in ipairs(configuration_options) do
            if v.name == config then
                v.saved = value
                print("Changed "..config.." to "..value)
            end
        end
    end
    KnownModIndex:SaveConfigurationOptions(function() end, "workshop-3121596445", configuration_options, false)
end
