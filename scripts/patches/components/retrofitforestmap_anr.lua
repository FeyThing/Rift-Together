local GetModConfigData = GetModConfigData

local modnameFancy = "Rift-Together"
local modnameActual = KnownModIndex:GetModActualName(modnameFancy)
local torren_retrofit

local function RetrofitTorrenIV()
    local TheWorld = _G.TheWorld
    
    local node_indices = {}
    for k, v in ipairs(TheWorld.topology.ids) do
        if string.find(v, "Torren IV") then
            table.insert(node_indices, k)
        end
    end
    if #node_indices == 0 then
        return false
    end
    
    local tags = {"torrenarea"}
    for k, v in ipairs(node_indices) do
        if TheWorld.topology.nodes[v].tags == nil then
            TheWorld.topology.nodes[v].tags = {}
        end
        for i, tag in ipairs(tags) do
            if not table.contains(TheWorld.topology.nodes[v].tags, tag) then
                table.insert(TheWorld.topology.nodes[v].tags, tag)
            end
        end
    end
    for i, node in ipairs(TheWorld.topology.nodes) do
        if table.contains(node.tags, "torrenarea") then
            TheWorld.Map:RepopulateNodeIdTileMap(i, node.x, node.y, node.poly, 10000, 2.1)
        end
    end
    
    return true
end

function ChangeTorrenIVConfigs(config, value)
    local configs = KnownModIndex:LoadModConfigurationOptions("Rift-Together", false)
    if configs ~= nil then
        for i, v in ipairs(configs) do
            if v.name == config then
                v.saved = value
                print("Changed "..config.." to "..value)
            end
        end
    end
    KnownModIndex:SaveConfigurationOptions(function() end, "Rift-Together", configs, false)
end

return function(self)
local oldonpostinit_forest = self.OnPostInit
    function self:OnPostInit(...)
	
	
if modnameActual == nil then
print(string.format("Mod '%s' not found", modnameFancy))
	else
	torren_retrofit = GetModConfigData("biome_retrofit", modnameActual)
	
	if torren_retrofit == 1 then            -- retrofit full island
            local success = RetrofitTorrenIV()
            if success then
                _G.TheWorld.Map:RetrofitNavGrid()
                _G.ChangeTorrenIVConfigs("biome_retrofit", 0)
                self.requiresreset = true
            end
        end
        
        return oldonpostinit_forest(self, ...)
		end		
    end       
end 

