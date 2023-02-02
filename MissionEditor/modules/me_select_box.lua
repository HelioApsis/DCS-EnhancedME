--- Adds a "selection box" utility to the Mission Editor
-- Caveats:
-- 		Selection for statics is very slow, especially for a large number (> 20), I would not recommend it.

local base = _G

module('me_select_box')

local require  = base.require
local math     = base.math
local pairs    = base.pairs
local ipairs   = base.ipairs
local table    = base.table
local print    = base.print
local tostring = base.tostring

local log           = require('log')
local MissionModule = require('me_mission')
local MapWindow     = require('me_map_window')

-- ED uses x and y throughout their functions. However, the mission editor uses X and Z, which I find to be more accurate because they use a Z/X space (X corresponds to the vertical position and Z corresponds to the horizontal position).

-- First corner of the selection box.
local mouseDown = {
	screenX = 0,
	screenY = 0,
}

-- Second corner of the selection box.
local mouseUp = {
	screenX = 0,
	screenY = 0,
}

-- Check if the given group (leader) is inside the boundaries provided
local function groupIsInSelectionBox(group, topLeft, bottomRight)
	return (group.x <= topLeft.x and group.x >= bottomRight.x) and (group.y >= topLeft.z and group.y <= bottomRight.z)
end

local function selectGroup(group)
	-- log.write("LUA-SELECTBOX", log.INFO, "Attempting to select group ID: " .. group.groupId)

	local objects = MapWindow.findUserObjects(group.x, group.y, MapWindow.getMapSize(0, 1))
	-- log.write("LUA-SELECTBOX", log.INFO, SerializeTable(objects))

	for k = #objects, 1, -1 do
		-- Make sure the group hasn't already been selected (hopefully avoids not being able to select groups with units very close to the group leader)
		local selectedGroups = MapWindow.getSelectedGroups()
		if selectedGroups[group.groupId] then
			return
		end
		-- See if we have a map object (avoids trying to select airfields as they are nil)
		local obj = MapWindow.getObjectById(objects[k])
		-- log.write("LUA-SELECTBOX", log.INFO, "Object id " .. objects[k] .. " is " .. tostring(obj))

		if obj then
			MapWindow.callbackSelectUnit(objects[k], true, true, group.x, group.y)
		end
	end

	-- local objId, allowSelection = MapWindow.pickUserObject(group.x, group.y, MapWindow.getMapSize(0, 1), false)
	--MapWindow.callbackSelectUnit(objId, allowSelection, true, group.x, group.y)
end

function HandleMouseDown(x, y, button)
	-- "Button 1" is left mouse button
	if button ~= 1 then
		return
	end

	mouseDown.screenX = x
	mouseDown.screenY = y
	-- log.write("LUA-SELECTBOX", log.INFO, "First Mouse Point Screen Coordinates: X" .. x .. " / Y" .. y)
end

function HandleMouseUp(x, y, button, wasDragged)
	-- We only care if the left mouse button was dragged
	if wasDragged ~= true or button ~= 1 or MapWindow.getSelectedGroup() then
		return
	end

	mouseUp.screenX = x
	mouseUp.screenY = y
	-- log.write("LUA-SELECTBOX", log.INFO, "Second Mouse Point Screen Coordinates: X" .. x .. " / Y" .. y)

	local mouseDownX, mouseDownZ = MapWindow.getMapPoint(mouseDown.screenX, mouseDown.screenY)
	local mouseUpX, mouseUpZ = MapWindow.getMapPoint(mouseUp.screenX, mouseUp.screenY)
	-- Assume a top left to bottom right selection box
	local point1 = {
		x = mouseDownX,
		z = mouseDownZ,
	}
	local point2 = {
		x = mouseUpX,
		z = mouseUpZ,
	}

	-- Second point is a higher x than the first (bottom to top drag)
	if mouseUpX >= mouseDownX then
		point1.x = mouseUpX
		point2.x = mouseDownX
	end
	-- Second point is further left than first (right to left drag)
	if mouseUpZ <= mouseDownZ then
		point1.z = mouseUpZ
		point2.z = mouseDownZ
	end

	-- Unfortunately the best way I've found is to go through all the groups in the mission
	for k, group in pairs(MissionModule.group_by_id) do
		if groupIsInSelectionBox(group, point1, point2) then
			-- log.write("LUA-SELECTBOX", log.INFO, "Sending group for selection. Hidden: " ..tostring(group.hidden) .. ", name: " .. group.name .. ", x/y: " .. group.x .. " / " .. group.y)

			-- Attempt to select the group
			selectGroup(group)
		end
	end
end

-- function SerializeTable(val, name, skipnewlines, depth)
-- 	skipnewlines = skipnewlines or false
-- 	depth = depth or 0

-- 	local tmp = base.string.rep(" ", depth)

-- 	if name then tmp = tmp .. name .. " = " end

-- 	if base.type(val) == "table" then
-- 		tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")

-- 		for k, v in pairs(val) do
-- 			tmp = tmp .. SerializeTable(v, k, skipnewlines, depth + 1) .. "," .. (not skipnewlines and "\n" or "")
-- 		end

-- 		tmp = tmp .. base.string.rep(" ", depth) .. "}"
-- 	elseif base.type(val) == "number" then
-- 		tmp = tmp .. tostring(val)
-- 	elseif base.type(val) == "string" then
-- 		tmp = tmp .. base.string.format("%q", val)
-- 	elseif base.type(val) == "boolean" then
-- 		tmp = tmp .. (val and "true" or "false")
-- 	else
-- 		tmp = tmp .. "\"[inserializeable datatype:" .. base.base.type(val) .. "]\""
-- 	end

-- 	return tmp
-- end
