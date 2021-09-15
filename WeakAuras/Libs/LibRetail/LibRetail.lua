local MAJOR_VERSION = "LibRetail"
local MINOR_VERSION = 2
if not LibStub then error(MAJOR_VERSION .. " requires LibStub.") end
local lib, oldversion = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

LibStub("AceTimer-3.0"):Embed(lib)

-- Lua APIs
local pairs, ipairs, pcall, print = pairs, ipairs, pcall, print

local math_ceil, math_floor = math.ceil, math.floor

function lib.tIndexOf(tbl, item)
	for i, v in ipairs(tbl) do
		if item == v then
			return i;
		end
	end
end

function lib.tInvert(tbl)
	local inverted = {};
	for k, v in pairs(tbl) do
		inverted[v] = k;
	end
	return inverted;
end

function lib.xpcall(func, errorHandler, ...)
	-- errorHandler();
	return pcall(func, ...)
end

function lib.Round(value)
	if value < 0.0 then
		return math_ceil(value - .5);
	end
	return math_floor(value + .5);
end
