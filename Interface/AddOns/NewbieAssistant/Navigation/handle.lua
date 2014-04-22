-- Author      : s1172
-- Create Date : 2013/6/24 11:55:03

NAMapHandler = class("NAMapHandler")

local abs = math.abs
local tinsert = table.insert

function NAMapHandler:initialize(tiles)
	self.tiles = tiles
end

function NAMapHandler:getNode(location)
	if location.x > #self.tiles[1] or location.y > #self.tiles then
		return nil
	end
	if location.x < 1 or location.y < 1 then
		return nil
	end
	if self.tiles[location.x][location.y] == 1 then
		return nil
	end

	return Node(location, 1, location.y * #self.tiles[1] + location.x)
end

function NAMapHandler:getAdjacentNodes(curnode, dest)
	local result = {}
	local cl = curnode.location
	local dl = dest

	local n = false

	-- 右
	n = self:_handleNode(cl.x + 1, cl.y, curnode, dl.x, dl.y)
	if n then
		tinsert(result, n)
	end

	-- 左
	n = self:_handleNode(cl.x - 1, cl.y, curnode, dl.x, dl.y)
	if n then
		tinsert(result, n)
	end

	-- 下
	n = self:_handleNode(cl.x, cl.y + 1, curnode, dl.x, dl.y)
	if n then
		tinsert(result, n)
	end

	-- 上
	n = self:_handleNode(cl.x, cl.y - 1, curnode, dl.x, dl.y)
	if n then
		tinsert(result, n)
	end

	-- 右上
	n = self:_handleNode(cl.x + 1, cl.y - 1, curnode, dl.x, dl.y)
	if n then
		tinsert(result, n)
	end

	-- 左上
	n = self:_handleNode(cl.x - 1, cl.y - 1, curnode, dl.x, dl.y)
	if n then
		tinsert(result, n)
	end

	-- 右下
	n = self:_handleNode(cl.x + 1, cl.y + 1, curnode, dl.x, dl.y)
	if n then
		tinsert(result, n)
	end

	-- 左下
	n = self:_handleNode(cl.x - 1, cl.y + 1, curnode, dl.x, dl.y)
	if n then
		tinsert(result, n)
	end

	return result
end

function NAMapHandler:locationsAreEqual(a, b)
	return a.x == b.x and a.y == b.y
end


function NAMapHandler:_handleNode(x, y, fromnode, destx, desty)
	-- Fetch a Node for the given location and set its parameters
	local loc = {
		x = x,
		y = y
	}

	local n = self:getNode(loc)

	if n ~= nil then
		local dx = abs(x - destx)--*20.04
		local dy = abs(y - desty)--*13.36
		local emCost = dx + dy

		n.mCost = n.mCost + fromnode.mCost
		n.score = n.mCost + emCost
		n.parent = fromnode

		return n
	end

	return nil
end

