local assets = {
    Asset("ANIM", "anim/radioactive_barrel.zip"),
    --Asset("MINIMAP_IMAGE", "barrel_radioactive")
}

local prefabs = {
    "collapse_small",
}

local SEA_TAGS = {"barrel", "frozen"}
local SEA_CANT_TAGS = {"irreplaceable", "INLIMBO"}

local function OnInit(inst)
    local rad = TUNING.TOXIC_TILE_RADIUS
    
    if inst.deepened == nil then
        local map = TheWorld.Map
        local pt = inst:GetPosition()
        local x, y = map:GetTileCoordsAtPoint(pt:Get())
        local _x = x - rad
        local _y = y - rad
        
		
        local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, TUNING.TOXIC_RADIUS * 2, nil, SEA_CANT_TAGS, SEA_TAGS)		
        for i, v in ipairs(ents) do
		if v ~= inst then
            v:Remove()
			end		
		end
		
        local i = -rad
        while i < rad do
            local j = -rad
            while j < rad do
                _x = _x - 1
                
                local current_tile = map:GetTile(_x, _y)
                if not TileGroupManager:IsLandTile(current_tile) then
                    map:SetTile(_x, _y, WORLD_TILES.OCEAN_TOXIC)
                end
                
                j = j + 1
            end
            _x = x + rad
            _y = _y + 1
            
            i = i + 1
        end
        
        inst.deepened = true
    end
end

local function onhammered(inst)
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end


local function MakeBarrel(name)
    local function fn()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()
        inst.entity:AddMiniMapEntity()
		inst.entity:AddLight()

        --inst.MiniMapEntity:SetIcon("barrel_radioactive.tex")

        MakeWaterObstaclePhysics(inst, 0.80, 2, 0.75)

        MakeInventoryFloatable(inst, "med", nil, 0.85)

        inst.Light:SetFalloff(0.7)
		inst.Light:SetIntensity(1)
		inst.Light:SetRadius(0.5)
		inst.Light:SetColour(25/255,255/255,100/255)
		inst.Light:Enable(false)

        inst.AnimState:SetBank("radioactive_barrel")
        inst.AnimState:SetBuild("radioactive_barrel")

        inst.AnimState:PlayAnimation("idle", true)
        
        inst.entity:SetPristine()
		
		inst:AddTag("barrel")

        if not TheWorld.ismastersim then
            return inst
        end

        local land_time = (POPULATING and math.random()*5*FRAMES) or 0
        inst:DoTaskInTime(land_time, function(inst)
            inst.components.floater:OnLandedServer()
        end)

        inst:AddComponent("inspectable")
        
		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
		inst.components.workable:SetWorkLeft(5)
		inst.components.workable:SetOnFinishCallback(onhammered)

		inst:AddComponent("radiationsource")
        inst.components.radiationsource:SetRadius(12)
        inst.components.radiationsource:SetContaminationAmount(0.1)
        inst.components.radiationsource:SetRadiationAmount(4)
        inst.components.radiationsource:ShouldContaminateTiles(true)

        inst:ListenForEvent("floater_startfloating", function(inst) inst.AnimState:PlayAnimation("idle_water", true) end)
		inst:ListenForEvent("floater_startfloating", OnInit)

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
		
end

local function spawnerfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

    return inst
end

return MakeBarrel("barrel_radioactive"),
	   MakeBarrel("barrel_radioactive_spawner", spawnerfn, assets, prefabs)
