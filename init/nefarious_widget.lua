local function OnUpdateEnergy(inst)
    if GLOBAL.ThePlayer then
		if not GLOBAL.ThePlayer.UpdateBadges then return end
		GLOBAL.ThePlayer.UpdateBadges()
    end
end

local function Dirtyenergyupdate(inst)
    if inst.components.nefarious_energy.current ~= 0 then
        inst.current_energy:set(math.floor(inst.components.nefarious_energy.current))
    else
        if not inst.energyupdate then
            inst.current_energy:set(1)
            inst.energyupdate = true
        else
            inst.current_energy:set(math.floor(inst.components.nefarious_energy.current))
        end
    end
end

-- Adds things to the player after initialization
AddPlayerPostInit(function(inst)
    if inst.prefab == "nefarious" then

        inst:AddComponent("nefarious_energy")
        inst.current_energy = GLOBAL.net_ushortint(inst.GUID, "nefarious_energy.current","nefarious_energy_dirty")

		if not GLOBAL.TheNet:IsDedicated() then
            inst:ListenForEvent("nefarious_energy_dirty", 
            function(inst)
                 OnUpdateEnergy(inst) 
            end)
            inst:DoPeriodicTask(0.3,function (inst)
                if inst.energyhud then
                    local currentPlaform = inst:GetCurrentPlatform()
                    if currentPlaform ~= nil and currentPlaform.components.healthsyncer ~= nil 
                    and GLOBAL.KnownModIndex:IsModEnabled("workshop-376333686") then
                        inst.energyhud:SetPosition(-125,35,0)
                    elseif GLOBAL.KnownModIndex:IsModEnabled("workshop-376333686") then
                        inst.energyhud:SetPosition(-62,-52,0)
                    elseif currentPlaform ~= nil and currentPlaform.components.healthsyncer ~= nil then
                        inst.energyhud:SetPosition(-120, 20,0)
                    else
                        inst.energyhud:SetPosition(-80,-40,0)
                    end
                    if not inst:HasTag("playerghost") then
                        inst.energyhud:Show()
                    else
                        inst.energyhud:Hide()
                    end
                end
            end)
        end
        

        if GLOBAL.TheWorld.ismastersim then
            inst:DoPeriodicTask(0.3, function()
                Dirtyenergyupdate(inst)
            end)
        end
    end
end)
