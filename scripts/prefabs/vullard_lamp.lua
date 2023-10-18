local assets =
{
    Asset("ANIM", "anim/vullard_post.zip"),
    Asset("ANIM", "anim/vullard_post_build.zip"),   
}

local INTENSITY = 0.6

--------------------------------------------------------------------------------------------------

--//CONTENT//
--1. Light fades
--2. Light effects
--3. Trades
--4. Miscellaneous
--5. Fn

--------------------------------------------------------------------------------------------------
--1. Light fades

local function fadein(inst)
    inst.components.fader:StopAll()
    inst.AnimState:PlayAnimation("on")
    inst.AnimState:PushAnimation("idle", true)
    inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    inst.Light:Enable(true)
	inst.AnimState:Show("FIRE")
    inst.AnimState:Show("GLOW")        
    inst.lighton = true
	inst.components.fader:Fade(0, INTENSITY, 3+math.random()*2, function(v) inst.Light:SetIntensity(v) end)
          
end

local function fadeout(inst)
    inst.components.fader:StopAll()
    inst.AnimState:PlayAnimation("off")    
    inst.AnimState:PushAnimation("idle", true)
	inst.AnimState:Hide("FIRE")
    inst.AnimState:Hide("GLOW")        
    inst.lighton = false
	inst.components.fader:Fade(INTENSITY, 0, .75+math.random()*1, function(v) inst.Light:SetIntensity(v) end)
    
end

local function updatelight(inst)
    if not TheWorld.state.isday then
        if not inst.lighton then
            inst:DoTaskInTime(math.random()*2, function() fadein(inst) end)
        end

    elseif TheWorld.state.isday then
        if inst.lighton then
            inst:DoTaskInTime(math.random()*2, function() fadeout(inst) end)            
        end
       
    end
end



local function GetStatus(inst)
    return not inst.lighton and "ON" or nil
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
    inst:DoTaskInTime(0, function() updatelight(inst) end)
end


local function onsave (inst, data)
    if inst.lighton then
        data.lighton = inst.lighton
    end   
end       

local function onload(inst, data)
    if data then
        if data.lighton then 
            fadein(inst)
            inst.Light:Enable(true)
            inst.Light:SetIntensity(INTENSITY)            
            inst.AnimState:Show("FIRE")
            inst.AnimState:Show("GLOW")        
            inst.lighton = true
		end
    end
end

-----------------------------------------------------------------------------------------------------------------
--5. fn

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddPhysics()
    inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
    
	inst.MiniMapEntity:SetIcon("vullard_lamp.tex")
    
    MakeObstaclePhysics(inst, 0.25)
    MakeSnowCoveredPristine(inst)
        
    local light = inst.entity:AddLight()
    inst.Light:Enable(false)
    inst.Light:EnableClientModulation(true)
    inst.Light:SetColour(197/255, 197/255, 10/255)
    inst.Light:SetFalloff(0.9)
    inst.Light:SetIntensity(INTENSITY)
    inst.Light:SetRadius(5)

    inst.AnimState:Hide("FIRE")
    inst.AnimState:Hide("GLOW")
    inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:SetBuild("lamp_post2_city_build")

    inst.AnimState:SetBank("lamp_post")
    inst.AnimState:SetRayTestOnBB(true)

    inst:AddTag("CITY_LAMP")
    inst:AddTag("lightsource")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("fader")
    inst:WatchWorldState("iscavedusk", function() updatelight(inst) end)
    inst:WatchWorldState("iscaveday", function() updatelight(inst) end)
    
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus  
   	
    inst:AddComponent("lootdropper")
    inst:AddComponent("sanityaura")

	inst:ListenForEvent("onbuilt", onbuilt)
        
    inst.OnSave = onsave
    inst.OnLoad = onload
    
    return inst
end

return Prefab("vullard_lamp", fn, assets),
MakePlacer("vullard_lamp_placer", "vullard_post", "vullard_post_build", "idle", false, false, true)
  

