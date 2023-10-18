local _G = GLOBAL

local CFENV = env
GLOBAL.setfenv(1, GLOBAL)

-- Add the Caffeinated component to the players.
local function ListenForPlayers(inst)
    if _G.TheWorld.ismastersim then
        inst:ListenForEvent("ms_playerspawn", function(src, player)
		if player then
				if player.components.radiation == nil then
					player:AddComponent("radiation")
				end
			end
		end)
	end
	end

local function OnRadiationDirty(inst)
    if inst._parent ~= nil then
        local data =
        {
            old = inst._oldradiation,
            new = inst.radiation:value(),
        }
        inst._oldradiation = data.new
        inst._parent:PushEvent("radiationdelta", data)
    else
        inst._oldradiation = 0
    end
end

local function GetRadiation(inst)
    if inst.components.radiation ~= nil then
        return inst.components.radiation:GetPercent()
    elseif inst.player_classified ~= nil then
        return inst.player_classified.radiation:value()
    else
        return 0
    end
end

local function GetRadiationRateScale(inst)
	return RATE_SCALE.DECREASE_LOW
end

-- local function AddPostClassConstruct(inst)
-- 	local UpvalueHacker.GetUpvalue(inst, "OnPlayerActivated", "OnPlayerActivated")
-- end

CFENV.AddPrefabPostInit("player_classified", function(inst)

    inst._oldradiation = 0
	inst.radiation = net_byte(inst.GUID, "radiation", "radiationdirty")
	inst.radiationratescale = net_tinybyte(inst.GUID, "radiation.ratescale", "radiationdirty")

	-- if not TheWorld.ismastersim then
		inst:ListenForEvent("radiationdirty", OnRadiationDirty)
	-- end

	if not TheWorld.ismastersim then
        if inst._parent ~= nil then
            inst._oldradiation = inst.radiation:value()
		end
	end

end)

CFENV.AddPrefabPostInit("world", ListenForPlayers)

-- Client
CFENV.AddPlayerPostInit(function(inst)
	inst.GetRadiation = GetRadiation
	inst.GetRadiationRateScale = GetRadiationRateScale
end)