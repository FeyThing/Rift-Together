local assets =
{
    Asset("ANIM", "anim/hound_basic.zip"),
    Asset("ANIM", "anim/hound_basic_water.zip"),
    Asset("ANIM", "anim/hound_robomutt.zip"),    
    Asset("SOUND", "sound/hound.fsb"),
}

local prefabs =
{ 
    "gears",
	"raritaniumore",
	"electrichitsparks",
}

local brain = require("brains/robomutthoundbrain")

local sounds =
{
    pant = "dontstarve/creatures/hound/pant",
    attack = "dontstarve/creatures/hound/attack",
    bite = "dontstarve/creatures/hound/bite",
    bark = "dontstarve/creatures/hound/bark",
    death = "dontstarve/creatures/hound/death",
    sleep = "dontstarve/creatures/hound/sleep",
    growl = "dontstarve/creatures/hound/growl",
    howl = "dontstarve/creatures/together/clayhound/howl",
    hurt = "dontstarve/creatures/hound/hurt",
}

SetSharedLootTable( 'hound_robomutt',
{
    {'trinket_6', 		1.0},
	{'raritaniumore', 0.325},
    
})

local WAKE_TO_FOLLOW_DISTANCE = 8
local SLEEP_NEAR_HOME_DISTANCE = 10
local SHARE_TARGET_DIST = 30
local HOME_TELEPORT_DIST = 30

local NO_TAGS = {"FX","NOCLICK","DECOR","INLIMBO"}
local FREEZABLE_TAGS = { "freezable" }

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or (inst.components.follower and inst.components.follower.leader and not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE))
end

local function ShouldSleep(inst)
    return inst:HasTag("pet_hound")
        and not TheWorld.state.isday
        and not (inst.components.combat and inst.components.combat.target)
        and not (inst.components.burnable and inst.components.burnable:IsBurning())
        and (not inst.components.homeseeker or inst:IsNear(inst.components.homeseeker.home, SLEEP_NEAR_HOME_DISTANCE))
end

local function OnNewTarget(inst, data)
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local RETARGET_CANT_TAGS = { "wall", "scrapmound", "hound", "houndfriend" }
local function retargetfn(inst)
    local leader = inst.components.follower.leader
    if leader ~= nil and leader.sg ~= nil and leader.sg:HasStateTag("statue") then
        return
    end
    local playerleader = leader ~= nil and leader:HasTag("player")
    local ispet = inst:HasTag("pet_hound")
    return (leader == nil or
            (ispet and not playerleader) or
            inst:IsNear(leader, TUNING.HOUND_FOLLOWER_AGGRO_DIST))
        and FindEntity(
                inst,
                (ispet or leader ~= nil) and TUNING.HOUND_FOLLOWER_TARGET_DIST or TUNING.HOUND_TARGET_DIST,
                function(guy)
                    return guy ~= leader and inst.components.combat:CanTarget(guy)
                end,
                nil,
                RETARGET_CANT_TAGS
            )
        or nil
end

local function KeepTarget(inst, target)
    local leader = inst.components.follower.leader
    local playerleader = leader ~= nil and leader:HasTag("player")
    local ispet = inst:HasTag("pet_hound")
    return (leader == nil or
            (ispet and not playerleader) or
            inst:IsNear(leader, TUNING.HOUND_FOLLOWER_RETURN_DIST))
        and inst.components.combat:CanTarget(target)
        and (not (ispet or leader ~= nil) or
            inst:IsNear(target, TUNING.HOUND_FOLLOWER_TARGET_KEEP))
end

local function Static(inst)
	local x, y, z = inst.Transform:GetWorldPosition()

	local sparkx = x + math.random(-2, 2)
	local sparkz = z + math.random(-2, 2)
    SpawnPrefab("sparks").Transform:SetPosition(sparkx, 0 + 0.25 * math.random(), sparkz)
end

local function discharge(inst)
    inst:RemoveTag("charged")
    inst.AnimState:ClearBloomEffectHandle()
    inst.charged = false
    inst.chargeleft = nil
	inst.task:Cancel()
end

local function ReduceCharges(inst)
    if inst.chargeleft then
        inst.chargeleft = inst.chargeleft - 1
        if inst.chargeleft <= 0 then
            discharge(inst)
        end
    end
end

local function setcharged(inst, instant)
    inst:AddTag("charged")
    inst.AnimState:Show("fx")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.charged = true
    inst.chargeleft = 1
    inst:WatchWorldState("cycles", ReduceCharges)
	inst.task = inst:DoPeriodicTask(0.5, Static)
end

local function IsChargedHound(dude)
    return dude:HasTag("charged")
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, SHARE_TARGET_DIST,
        function(dude)
            return not (dude.components.health ~= nil and dude.components.health:IsDead())
                and (dude:HasTag("hound") or dude:HasTag("houndfriend"))
                and data.attacker ~= (dude.components.follower ~= nil and dude.components.follower.leader or nil)
        end, 5)
		if data ~= nil and data.attacker ~= nil then
        if inst.charged then
            if data.attacker.components.health ~= nil and not data.attacker.components.health:IsDead() and
                (data.weapon == nil or ((data.weapon.components.weapon == nil or data.weapon.components.weapon.projectile == nil) and data.weapon.components.projectile == nil)) and
                not (data.attacker.components.inventory ~= nil and data.attacker.components.inventory:IsInsulated()) then

                data.attacker.components.health:DoDelta(-TUNING.LIGHTNING_GOAT_DAMAGE, nil, inst.prefab, nil, inst)
                if data.attacker:HasTag("player") and not data.attacker.sg:HasStateTag("dead") then
                    data.attacker.sg:GoToState("electrocute")
                end
            end
        elseif data.stimuli == "electric" or (data.weapon ~= nil and data.weapon.components.weapon ~= nil and data.weapon.components.weapon.stimuli == "electric") then
            setcharged(inst)
        end

        inst.components.combat:SetTarget(data.attacker)
        inst.components.combat:ShareTarget(data.attacker, 20, IsChargedHound, 3)
    end
end

local function OnAttackOther(inst, data)
    inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST,
        function(dude)
            return not (dude.components.health ~= nil and dude.components.health:IsDead())
                and (dude:HasTag("hound") or dude:HasTag("houndfriend"))
                and data.target ~= (dude.components.follower ~= nil and dude.components.follower.leader or nil)
        end, 5)
end

local function GetReturnPos(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local rad = 2
    local angle = math.random() * 2 * PI
    return x + rad * math.cos(angle), y, z - rad * math.sin(angle)
end

local function DoReturn(inst)
    --print("DoReturn", inst)
    if inst.components.homeseeker ~= nil and inst.components.homeseeker:HasHome() then
        if inst:HasTag("pet_hound") then
            if inst.components.homeseeker.home:IsAsleep() and not inst:IsNear(inst.components.homeseeker.home, HOME_TELEPORT_DIST) then
                inst.Physics:Teleport(GetReturnPos(inst.components.homeseeker.home))
            end
        elseif inst.components.homeseeker.home.components.childspawner ~= nil then
            inst.components.homeseeker.home.components.childspawner:GoHome(inst)
        end
    end
end

local function OnEntitySleep(inst)
    --print("OnEntitySleep", inst)
    if not TheWorld.state.isday then
        DoReturn(inst)
    end
end

local function OnStopDay(inst)
    --print("OnStopDay", inst)
    if inst:IsAsleep() then
        DoReturn(inst)
    end
end


local function OnSpawnedFromHaunt(inst)
    if inst.components.hauntable ~= nil then
        inst.components.hauntable:Panic()
    end
end

local function OnSave(inst, data)
    data.ispet = inst:HasTag("pet_hound") or nil
    --print("OnSave", inst, data.ispet)
	
    if inst.charged then
        data.charged = inst.charged
        data.chargeleft = inst.chargeleft
    end
end

local function OnLoad(inst, data)
    --print("OnLoad", inst, data.ispet)
    if data ~= nil and data.ispet then
        inst:AddTag("pet_hound")
        if inst.sg ~= nil then
            inst.sg:GoToState("idle")
        end
    end
	
	if data and data.charged and data.chargeleft then
        setcharged(inst, true)
        inst.chargeleft = data.chargeleft
    end
	
end

local function getstatus(inst)
    return inst.charged and "CHARGED" or nil
end

local function OnStartFollowing(inst, data)
    if inst.leadertask ~= nil then
        inst.leadertask:Cancel()
        inst.leadertask = nil
    end
    if data == nil or data.leader == nil then
        inst.components.follower.maxfollowtime = nil
    elseif data.leader:HasTag("player") then
        inst.components.follower.maxfollowtime = TUNING.HOUNDWHISTLE_EFFECTIVE_TIME * 1.5
    else
        inst.components.follower.maxfollowtime = nil
        if inst.components.entitytracker:GetEntity("leader") == nil then
            inst.components.entitytracker:TrackEntity("leader", data.leader)
        end
    end
end

local function RestoreLeader(inst)
    inst.leadertask = nil
    local leader = inst.components.entitytracker:GetEntity("leader")
    if leader ~= nil and not leader.components.health:IsDead() then
        inst.components.follower:SetLeader(leader)
        leader:PushEvent("restoredfollower", { follower = inst })
    end
end

local function OnStopFollowing(inst)
    inst.leader_offset = nil
    if not inst.components.health:IsDead() then
        local leader = inst.components.entitytracker:GetEntity("leader")
        if leader ~= nil and not leader.components.health:IsDead() then
            inst.leadertask = inst:DoTaskInTime(.2, RestoreLeader)
        end
    end
end

local function fncommon(bank, build, morphlist, custombrain, tag, data)
	data = data or {}

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 10, .5)

    inst.DynamicShadow:SetSize(2.5, 1.5)
    inst.Transform:SetFourFaced()

    inst:AddTag("scarytoprey")
    inst:AddTag("scarytooceanprey")
    inst:AddTag("monster")
	inst:AddTag("chess")
    inst:AddTag("hostile")
    inst:AddTag("hound")
    inst:AddTag("canbestartled")
	inst:AddTag("lightningrod")

    if tag ~= nil then
        inst:AddTag(tag)
	end

    inst.AnimState:SetBank(bank)
    inst.AnimState:SetBuild(build)
    inst.AnimState:PlayAnimation("idle")


    inst:AddComponent("spawnfader")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst.sounds = sounds

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph

    inst:SetStateGraph("SGhound")

	inst.components.locomotor:SetAllowPlatformHopping(true)

    inst:SetBrain(custombrain or brain)

    inst:AddComponent("follower")
    inst:AddComponent("entitytracker")

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(300)

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_MED

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.FIREHOUND_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.MOONHOUND_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(3, retargetfn)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst.components.combat:SetHurtSound(inst.sounds.hurt)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('hound_robomutt')

    inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = getstatus
    
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater:SetStrongStomach(true) -- can eat monster meat!

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
    inst:ListenForEvent("newcombattarget", OnNewTarget)

    inst:WatchWorldState("stopday", OnStopDay)
    inst.OnEntitySleep = OnEntitySleep

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("onattackother", OnAttackOther)
    inst:ListenForEvent("startfollowing", OnStartFollowing)
    inst:ListenForEvent("stopfollowing", OnStopFollowing)
	
	inst:ListenForEvent("lightningstrike", setcharged)
    inst.setcharged = setcharged

    return inst
end


local function fnrobomutt()
    local inst = fncommon("hound", "hound_robomutt", nil, nil, "hound_robomutt", false)

    if not TheWorld.ismastersim then
        return inst
    end

    MakeMediumFreezableCharacter(inst, "hound_body")
    MakeMediumBurnableCharacter(inst, "hound_body")

	inst.components.freezable:SetDefaultWearOffTime(TUNING.MOONHOUND_FREEZE_WEAR_OFF_TIME)

    inst.components.combat:SetDefaultDamage(TUNING.FIREHOUND_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.MOONHOUND_ATTACK_PERIOD)
    inst.components.locomotor.runspeed = TUNING.MOONHOUND_SPEED
    inst.components.health:SetMaxHealth(300)

	inst.components.combat.bonusdamagefn = function(inst, target, damage, weapon)
        return not (target:HasTag("shockabsorbers") or (target.components.inventory ~= nil and target.components.inventory:IsInsulated()))
            and 20 * (target.components.moisture ~= nil and target.components.moisture:GetMoisturePercent() or (target:GetIsWet() and 1 or 0))
            or 0				
    end
    
    inst:ListenForEvent("death", function(inst)
        SpawnPrefab("wx78_big_spark"):AlignToTarget(inst)
        local x,y,z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, 4, {}, NO_TAGS) 
        for _,ent in pairs(ents) do
            if ent.components.health then					
                if ent:HasTag("player") then
                    if not (ent.components.inventory and ent.components.inventory:IsInsulated()) then
                        ent.components.combat:GetAttacked(inst, -10)
                        ent.sg:GoToState("electrocute")
                    end
                else
                    if ent ~= nil and ent.components.health ~= nil and not (ent:HasTag("structure") or ent:HasTag("wall")) then
                        ent.components.combat:GetAttacked(inst, -5)								
                    end
                end
            end
            if ent.setcharged then 
                ent:setcharged()
            end
        end
    end)
    
    inst.shockvictim = function(inst, attacker)
        if attacker and attacker.components.health and not attacker.components.health:IsDead() then
            SpawnPrefab("electrichitsparks"):AlignToTarget(inst, attacker, true)					
        end
    end
    
    inst:ListenForEvent("onattackother", function(inst, data)
        if math.random() <= 0.15 and data.target then
            inst:shockvictim(data.target)
            data.target.components.health:DoDelta(-5*2)
        end
    end)

    return inst
end

return Prefab("hound_robomutt", fnrobomutt, assets, prefabs)

