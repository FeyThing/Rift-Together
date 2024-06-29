local WIDTH, HEIGHT
local MAXRADIATION = TUNING.MAX_TILE_RAD
local FALLOFF_INTERVAL = 5
local FALLOFF_DELAY_PER_TILE = 30
local FALLOFF_AMOUNT = 0.1

return Class(function(self, inst)
	assert(TheWorld.ismastersim, "Radiation Manager should not exist on client")

	-- [ Public fields ] --

	self.inst = inst

	-- [ Private fields ] --
	local _world = TheWorld
	local _map = _world.Map

	local _radiationgrid
	local _recent_radiation_increase -- Used to manage when to start the falloff per tile
	local _falloff_task
	-- local _particle_manager -- -[TODO]-

	-- [ Functions ] --
	local function SetRadiation(index, radiation)
		if 0 <= index and index < WIDTH*HEIGHT then
			_radiationgrid:SetDataAtIndex(index, math.clamp(radiation, 0, MAXRADIATION))
		end
	end

	local function SetRadiationIncreaseAtIndex(index)
		if _recent_radiation_increase[index] ~= nil then
			_recent_radiation_increase[index]:Cancel()
			_recent_radiation_increase[index] = nil
		end

		_recent_radiation_increase[index] = self.inst:DoTaskInTime(FALLOFF_DELAY_PER_TILE, function()
			_recent_radiation_increase[index] = nil
		end)
	end

	local function DoFalloff()
		for x = 0, WIDTH - 1 do
			for y = 0, HEIGHT - 1 do
				local index = _radiationgrid:GetIndex(x, y)
				local radiation = _radiationgrid:GetDataAtIndex(index)
				local was_recently_increased = _recent_radiation_increase[index]

				if radiation and radiation > 0 and was_recently_increased == nil then
					if radiation - FALLOFF_AMOUNT < 0 then
						SetRadiation(index, 0)
					end

					SetRadiation(index, radiation - FALLOFF_AMOUNT)
				end
			end
		end
	end

	-- [ Initialization ] --
	local function InitializeDataGrids()
		if _radiationgrid then return end

		WIDTH, HEIGHT = _map:GetSize()
		_radiationgrid = DataGrid(WIDTH, HEIGHT) -- This grid contains the radiation information
		_recent_radiation_increase = {  }

		_world:RemoveEventCallback("worldmapsetsize", InitializeDataGrids)
		self:StartFalloff()
	end

	inst:ListenForEvent("worldmapsetsize", InitializeDataGrids, _world)

	-- [ Methods ] --
	function self:StartFalloff()
		self:StopFalloff()

		_falloff_task = inst:DoPeriodicTask(FALLOFF_INTERVAL, DoFalloff)
	end

	function self:StopFalloff()
		if _falloff_task then
			_falloff_task:Cancel()
			_falloff_task = nil
		end
	end

	function self:DoDeltaAtPoint(x, y, z, radiation_delta)
		if radiation_delta and radiation_delta ~= 0 then
			local index = _radiationgrid:GetIndex(_map:GetTileCoordsAtPoint(x, y, z))
			local radiation = _radiationgrid:GetDataAtIndex(index)
			
			SetRadiation(index, (radiation or 0) + radiation_delta)

			if radiation_delta > 0 then
				SetRadiationIncreaseAtIndex(index)
			end
		end
	end

	function self:DoDeltaAtTile(x, y, radiation_delta)
		if radiation_delta and radiation_delta ~= 0 then
			local index = _radiationgrid:GetIndex(x, y)
			local radiation = _radiationgrid:GetDataAtIndex(index)
			
			SetRadiation(index, (radiation or 0) + radiation_delta)

			if radiation_delta > 0 then
				SetRadiationIncreaseAtIndex(index)
			end
		end
	end

	function self:ClearAtPoint(x, y, z)
		local index = _radiationgrid:GetIndex(_map:GetTileCoordsAtPoint(x, y, z))
		SetRadiation(index, 0)
	end

	function self:GetAtPoint(x, y, z)
		return _radiationgrid:GetDataAtPoint(_map:GetTileCoordsAtPoint(x, y, z)) or 0
	end

	function self:GetGrid()
		return _radiationgrid
	end

	-- [ Saving/Loading ] --
	function self:OnSave()
		return ZipAndEncodeSaveData(_radiationgrid:Save())
	end

	function self:OnLoad(data)
		data = DecodeAndUnzipSaveData(data)
		if data then
			_radiationgrid:Load(data)
		end
	end

	-- [ Debug ] ---
	function self:GetDebugString()
		local x, y = _map:GetTileCoordsAtPoint(ConsoleCommandPlayer().Transform:GetWorldPosition())
		return _radiationgrid:GetDataAtIndex(_radiationgrid:GetIndex(x, y))
	end

	function self:DebugDelta(delta)
		if ThePlayer then
			local x, y, z = ThePlayer.Transform:GetWorldPosition()
			self:DoDeltaAtPoint(x, y, z, delta)
		end
	end

	-- AddPlayerPostInit(function(inst) -- LukaS: Use to check radiation on your position every 0.5s, place this in modmain.lua
	-- 	if not _G.TheWorld.ismastersim then
	-- 		return
	-- 	end

	-- 	inst:DoPeriodicTask(0.5, function()
	-- 		local rad = _G.TheWorld.components.radiationmanager:GetDebugString()
	-- 		_G.TheNet:Announce("Tile rad - "..tostring(rad or "nil"))
	-- 	end)
	-- end)
end)
