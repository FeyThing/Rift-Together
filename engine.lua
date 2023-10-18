--[[	Copyright © 2015 Ysovuka/Kzisor	 ]]
local _G = _G or GLOBAL
local _M = _M or env

local assert = _G.assert
local error = assert( _G.error )
local rawget = assert( _G.rawget )
local setmetatable = assert( _G.setmetatable )
local setfenv = assert( _G.setfenv )
local _IDENTIFIER = modname
local filter = "!core/?.lua;!core/screens/?.lua;!core/widgets/?.lua"
_M.filters = string.gsub(filter, "%!", MODROOT)
if rawget(_G.package.loaded, _IDENTIFIER) then
	return _G.package.loaded[_IDENTIFIER]
end

local function preload_searcher(self, name)
	return self.package.preload[name] ~= nil and self.package.preload[name] or "No field package[ '"..name.."' ] found."
end

local function default_searcher(self, name, filters)
	name = name:gsub("[\\]", "/")
	local fail_pieces = {}
	local paths = string.format( "%s;%s", filters, self.package.path)
	for pathspec in string.gmatch(paths, "[^;]+") do
		local path = pathspec:gsub("%?", name, 1)		
		if _G.kleifileexists(path) then
			local fn = _G.kleiloadlua(path)
			return type(fn) == "function" and fn or error(tostring(fn or "Unknown error"), 3)
		else
			table.insert(fail_pieces, "\tNo file '"..path.."' found.")
		end
	end
	return table.concat(fail_pieces, "\n")
end

local function CreateNewEnvironment(env)
	setmetatable(env, {
		__index = _G and function(t, k)
				return rawget(_G, k) or rawget(ModManager, k)
			end,
		})
	return env
end

local Requirer = Class(function(self, default_env, load_once)
	default_env = CreateNewEnvironment(default_env or _G)
	self.package =
	{
		path = MODROOT.."?.lua",
		searchers = { preload_searcher, default_searcher },
		preload = {},
		loaded = {},
	}
	self.package.loaders = self.package.searchers
	function self:GetDefaultEnvironment()
		return default_env
	end
end)

function _M.IsWorldGenerating()
	if _M.worldgen ~= worldgen then
		_M.worldgen = worldgen
	end
	return _M.worldgen
end

function Requirer:GetEnvironment()
	return self.env or self:GetDefaultEnvironment()
end

function _M.Initialize()
	_G[_IDENTIFIER]( "main" )( _M.IsWorldGenerating() )
end

function Requirer:SetEnviornment(env)
	self.env = env
end

function Requirer:__call(name)
	local fail_pieces = {}
	for _, searcher in ipairs(self.package.searchers) do
		local fn = searcher(self, name, _M.filters)
		if type(fn) == "function" then
			_G.setfenv(fn, self:GetEnvironment())
			if load_once and _G.package.loaded[name] then
				return _G.package.loaded[name]
			elseif load_once and self.package.loaded[name] then
				return self.package.loaded[name]
			else
				self.package.loaded[name] = fn(name) or self.package.loaded[name] or true
				_G.package.loaded[name] = self.package.loaded[name]
				return fn(name) or self.package.loaded[name]
			end
		elseif type(fn) == "string" then
			table.insert(fail_pieces, fn)
		end
	end
	table.insert(fail_pieces, 1, ("Mod module '%s' not found:"):format(name))
	return error(table.concat(fail_pieces, "\n"), 2)
end

function Requirer:ExportAs(id)
	_G.package.loaded[id] = self
end

local ModRequirer = Class(Requirer, function(self, load_once)
	Requirer._ctor(self, _M, load_once)
end)

function ModRequirer:GetModEnvironment()
	return self:GetDefaultEnvironment()
end

function ModRequirer:GetModInfo()
	return self:GetModEnvironment().modinfo
end
_M.Map = {}
_M.Load = ModRequirer()
_G[_IDENTIFIER] = ModRequirer()