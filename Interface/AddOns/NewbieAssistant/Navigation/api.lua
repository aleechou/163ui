-- Author      : s1172
-- Create Date : 2013/6/24 11:11:01

local api = CreateFrame("frame", "NewbieAssistantNavigationApi")
local tinsert = table.insert
local sort = table.sort
local MAX_SEGMENTATIONS = 50

api.Lines = {}
api.Frame = NewbieAssistantNavigationFrame
api.PointSize = {8,8}

function api:getIntPart(x)
	local int = math.ceil(x)
	--if int > 0 and int ~= x then
	--	int = int - 1
	--end
	return int
end

--- 获取两点间距离
-- @param StartCoord 起点{x,y} EndCoord 终点 {x,y}
-- @return 两点间距
function api:Diagonal(StartCoord, EndCoord)
	local length
	if type(StartCoord) == "table" and type(EndCoord) == "table" then
		length = math.sqrt(math.pow(StartCoord[1]-EndCoord[1],2)+math.pow(StartCoord[2]-EndCoord[2],2))
	end
	return length
end

function api:HideLine(id)
	if id then
		self.Lines[Id] = self.Lines[Id] or {}

		if #self.Lines[Id] > 0 then
			for i=1, #self.Lines[Id], 1 do
				self.Lines[Id][i]:Hide()
			end
			self.Lines[Id] = {}
		end
	else
		for i,k in pairs(self.Lines) do
			for j,f in pairs(k) do
				f:Hide()
			end
		end
		--self.Lines = {}
	end
end

function api:Draw(Id, startcoord, stopcoord, tiles)
	local s = {
		x = self:getIntPart(startcoord[1]/2),
		y = self:getIntPart(50 - startcoord[2]/2),
	}
	local e = {
		x = self:getIntPart(stopcoord[1]/2),
		y = self:getIntPart(50 - stopcoord[2]/2),
	}
	local path
	if s.y <= e.y then
		path = self:GetPaintingPoints(s, e, tiles)
	else
		path = self:GetPaintingPoints(e, s, tiles)
	end

	if not path then return end

	self.Lines[Id] = self.Lines[Id] or {}
	--print("开始时间:"..time())
	for i,k in pairs(path.nodes) do
		local tex = self:WorldMapPaintingPoint(k.location)
		tinsert(self.Lines[Id], tex)
	end
	--print("结束时间:"..time())
end

function api:WorldMapPaintingPoint(Coord, Color)

	if not type(Coord) == "table" then
		return
	end

	local texture = self.Frame:CreateTexture(nil,"ARTWORK")
	local parent = self.Frame:GetParent()

	local width = parent:GetWidth()
	local height = parent:GetHeight()
	local x = (Coord.x-1) / MAX_SEGMENTATIONS
	local y = 1 - Coord.y / MAX_SEGMENTATIONS
	local xOffset = x * width + 5
	local yOffset = -(y * height) - 3.34

	if not Color then
		texture:SetTexture("Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\circle")
	else
		texture:SetTexture(color.r,color.g,color.b)
	end

	texture:SetPoint('TOPLEFT', parent, 'TOPLEFT', xOffset, yOffset)
	texture:SetSize(self.PointSize[1], self.PointSize[2])
	texture:Show()

	return texture
end

function api:GetLenth(poi1,poi2)
	local length
	if type(poi1) == "table" and type(poi2) == "table" then
		length = math.sqrt(math.pow(poi1.x-poi2.x,2)+math.pow(poi1.y-poi2.y,2))
	end
	return length
end

function api:GetCloestPoint(target, coords)
	--print(target.x,target.y,coords[target.x][target.y])
	if coords[target.x][target.y] == 0 then 
		return target
	end
	
	local len = {}
	local _len = {}

	for i=1, #coords, 1 do
		for j=1, #coords[i], 1 do
			if coords[i][j] == 0 then
				local l = self:GetLenth(target, {x=i,y=j})
				len[l] = {x=i,y=j}
				tinsert(_len, l)
			end
		end
	end

	sort(_len)

	return len[_len[1]]
end

function api:GetPaintingPoints(start,stop,tiles)
	local handler = NAMapHandler(tiles)
	local astar = AStar(handler)

	local s = self:GetCloestPoint(start, tiles)
	local e = self:GetCloestPoint(stop, tiles)

	local path = astar:findPath(s,e)

	return path
end
