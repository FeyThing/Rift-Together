--------------------------------------------------------------------------
--[[ Dependencies ]]
--------------------------------------------------------------------------

--------------------------------------------------------------------------
--[[ Radiation Manager class definition ]]
--------------------------------------------------------------------------
return Class(function(self, inst)

assert(TheWorld.ismastersim, "Radiation Manager should not exist on client")

--------------------------------------------------------------------------
--[[ Private constants ]]
--------------------------------------------------------------------------

--------------------------------------------------------------------------
--[[ Public Member Variables ]]
--------------------------------------------------------------------------

self.inst = inst

--------------------------------------------------------------------------
--[[ Private Member Variables ]]
--------------------------------------------------------------------------

local _world = TheWorld
local particle_mamager
local _map = _world.Map

local _radiationgrid --this grid contains the radiation

--------------------------------------------------------------------------
--[[ Private member functions ]]
--------------------------------------------------------------------------

local function SetRadiation(index, radiation)
	local prev_radiation = _radiationgrid:GetDataAtIndex(index)
	local new_radiation = Clamp(radiation, TheWorld.state.wetness, TUNING.SOIL_MAX_MOISTURE_VALUE) or 0
	if not particle_mamager then
		particle_mamager = TheWorld.net.components.radiation_particle_manager
	end
	if prev_radiation ~= new_radiation then
		_radiationgrid:SetDataAtIndex(index, new_radiation)
		if particle_mamager then
			particle_mamager.update_values:set(DataDumper(_radiationgrid, nil, true))
		end
	end
end

local function InitializeDataGrids()
    if _radiationgrid ~= nil then return end 

	local w, h = _map:GetSize()
	_radiationgrid = DataGrid(w, h)

	self.inst:DoPeriodicTask(TUNING.SOIL_MOISTURE_UPDATE_TIME, function() self:_RefreshRadiation(TUNING.SOIL_MOISTURE_UPDATE_TIME) end)
end
inst:ListenForEvent("worldmapsetsize", InitializeDataGrids, _world)

--------------------------------------------------------------------------
--[[ Private event handlers ]]
--------------------------------------------------------------------------

--------------------------------------------------------------------------
--[[ Private member functions ]]
--------------------------------------------------------------------------
function self:_RefreshRadiation(dt)
	for index, radiation in pairs(_radiationgrid.grid) do

		local tx, ty = _radiationgrid:GetXYFromIndex(index)
		local obj_rate = 0

		SetRadiation(index, radiation + dt * (obj_rate))
	end
end

function self:LongUpdate(dt)
	if _radiationgrid ~= nil then
    	self:_RefreshRadiation(dt)
	end
end

--------------------------------------------------------------------------
--[[ Public member functions ]]
--------------------------------------------------------------------------

function self:AddRadiationAtPoint(x, y, z, radiation_delta)
	if radiation_delta ~= 0 then
		local index = _radiationgrid:GetIndex(_map:GetTileCoordsAtPoint(x, y, z))
		local radiation = _radiationgrid:GetDataAtIndex(index)
		SetRadiation(index, (radiation or 0) + radiation_delta)
	end
end

function self:RemoveRadiationAtPoint(x, y, z, radiation_delta)
	if radiation_delta ~= 0 then
		local index = _radiationgrid:GetIndex(_map:GetTileCoordsAtPoint(x, y, z))
		local radiation = _radiationgrid:GetDataAtIndex(index)
		SetRadiation(index, math.max((radiation or 0) + radiation_delta))
	end
end

function self:GetRadiationAtPoint(x, y, z)
	local radiation = _radiationgrid:GetDataAtPoint(_map:GetTileCoordsAtPoint(x, y, z))
	return radiation or 0
end


--------------------------------------------------------------------------
--[[ Save/Load ]]
--------------------------------------------------------------------------

function self:Grid()
	return _radiationgrid
end

function self:OnSave()
	return ZipAndEncodeSaveData(_radiationgrid:Save())
end

function self:OnLoad(data)
    data = DecodeAndUnzipSaveData(data)
    if data == nil then return end
	_radiationgrid:Load(data)
end

--------------------------------------------------------------------------
--[[ Debug ]]
--------------------------------------------------------------------------

function self:GetDebugString()
	local s = ""

	local target = ConsoleCommandPlayer()
	if target ~= nil and target.Transform ~= nil then
	    local x, y = _map:GetTileCoordsAtPoint(target.Transform:GetWorldPosition())

		local radiation = _radiationgrid:GetDataAtIndex(_radiationgrid:GetIndex(x, y))
		if radiation ~= nil then
			s = s .. "R: ".. string.format("%.3f", radiation)
		end
    end
	return s
end

--------------------------------------------------------------------------
--[[ Initialization ]]
--------------------------------------------------------------------------
end)
