local easing = require("easing")

local AVERAGE_WALK_SPEED = 1
local WALK_SPEED_VARIATION = 4
local SPEED_VAR_INTERVAL = .5
local ANGLE_VARIANCE = 10

local assets =
{
    Asset("ANIM", "anim/dustdevil.zip"),
}

local prefabs =
{
    "dustdevil",
	"dustdevil_fx",
	"ash",
}

--[[local function CheckGround(inst)
    if not inst:IsOnValidGround() then
        inst.AnimState:PlayAnimation("tornado_pst")
        inst:PushEvent("detachchild")
        inst:Remove()
    end
end]]


local function DoDirectionChange(inst, data)

    if not inst.entity:IsAwake() then return end

    if data and data.angle and data.velocity and inst.components.blowinwind then
        if inst.angle == nil then
            inst.angle = math.clamp(GetRandomWithVariance(data.angle, ANGLE_VARIANCE), 0, 360)
            inst.components.blowinwind:Start(inst.angle, data.velocity)
        else
            inst.angle = math.clamp(GetRandomWithVariance(data.angle, ANGLE_VARIANCE), 0, 360)
            inst.components.blowinwind:ChangeDirection(inst.angle, data.velocity)
        end
    end
end


local function ontornadolifetime(inst)
    inst.task = nil
    inst.sg:GoToState("despawn")
	SpawnPrefab("ash").Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function SetDuration(inst, duration)
    if inst.task ~= nil then
        inst.task:Cancel()		
    end
    inst.task = inst:DoTaskInTime(duration, ontornadolifetime)
end

local function DoDust(inst)		
			SpawnPrefab("dustdevil_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function tornado_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	inst:AddTag("scarytoprey")
	
	inst.Transform:SetScale(1, GetRandomMinMax(0.5, 2), 1)

    inst.AnimState:SetFinalOffset(2)
    inst.AnimState:SetBank("dustdevil")
    inst.AnimState:SetBuild("dustdevil")
    inst.AnimState:PlayAnimation("tornado_pre")
    inst.AnimState:PushAnimation("tornado_loop")

    inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tornado", "spinLoop")

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("locomotor")
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "dustdevil_speed_mod", .5)
    --[[inst.components.locomotor.walkspeed = TUNING.TORNADO_WALK_SPEED 
    inst.components.locomotor.runspeed = TUNING.TORNADO_WALK_SPEED]]
	
	inst:AddComponent("heater")
    inst.components.heater.heat = 40

	inst:AddComponent("blowinwind")
	inst.components.blowinwind:Start()
    inst.angle = (TheWorld and TheWorld.components.worldwind) and TheWorld.components.worldwind:GetWindAngle() or nil
    inst:ListenForEvent("windchange", function(world, data)
        DoDirectionChange(inst, data)
    end, TheWorld)
    if inst.angle ~= nil then
        inst.angle = math.clamp(GetRandomWithVariance(inst.angle, ANGLE_VARIANCE), 0, 360)
        inst.components.blowinwind:Start(inst.angle)
    end
	
	--CheckGround(inst)
	
    inst:SetStateGraph("SGdustdevil")

    inst.persists = false

	
	if inst.dusttask == nil then
		inst.dusttask = inst:DoPeriodicTask(0.2, DoDust, FRAMES, inst)
	end

	--[[inst:DoTaskInTime(1, function()
    SpawnPrefab("dustdevil_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())
	end)]]

    inst.SetDuration = SetDuration
    inst:SetDuration(TUNING.DUSTDEVIL_LIFETIME)

		
    return inst
end


return Prefab("dustdevil", tornado_fn, assets)
