
--[[


[---|---|---|---]
[---|---|---|---]
[---|---|---|---]
[---|---|---|---]

:SetTexCoord( 0, .25, 0, .25 )	-- Coordinate Meaning: Left, Right, Top, Bottom,  -- Default: 0, 1, 0, 1 -- From: TopLeft

--]]

local function SetCubeframeTexture(frame, texture)
	for name, object in pairs(frame.Textures) do
		object:SetTexture(texture)
	end
end

local function SetCubeframeBodySize(frame, width, height)
	frame:SetSize(width, height)
end

local function  SetCubeframeBorderSize(frame, width, height)
	frame.Border:SetPoint("LEFT", frame, "LEFT", -width, 0)
	frame.Border:SetPoint("RIGHT", frame, "RIGHT", width, 0)
	frame.Border:SetPoint("TOP", frame, "TOP", 0, height)
	frame.Border:SetPoint("BOTTOM", frame, "BOTTOM", 0, -height)
end

local function SetCubeframeSize(frame, width, height, border)
	SetCubeframeBodySize(frame, width, height)
	SetCubeframeBorderSize(frame, border, border)
end

function CreateTidyPlatesCubeframe(parent)
	local frame = CreateFrame("Frame", nil, parent)		-- Body Frame
	frame.Border = CreateFrame("Frame", nil, frame)	-- Border Frame
	
	--frame:SetSize(128, 32)
	--SetCubeframeBorderSize(frame, 16, 16)
	
	frame.Textures = {}
	-- Corners
	frame.Textures.TopLeftTexture = frame:CreateTexture(nil, "ARTWORK")
	frame.Textures.TopLeftTexture:SetTexCoord( 0, .25, 0, .25 )
	frame.Textures.TopLeftTexture:SetPoint("TOPLEFT", frame.Border)
	frame.Textures.TopLeftTexture:SetPoint("BOTTOMRIGHT", frame, "TOPLEFT")
	
	frame.Textures.TopRightTexture = frame:CreateTexture(nil, "ARTWORK")
	frame.Textures.TopRightTexture:SetTexCoord( .75, 1, 0, .25 )
	frame.Textures.TopRightTexture:SetPoint("TOPRIGHT", frame.Border)
	frame.Textures.TopRightTexture:SetPoint("BOTTOMLEFT", frame, "TOPRIGHT")
	
	frame.Textures.BottomLeftTexture = frame:CreateTexture(nil, "ARTWORK")
	frame.Textures.BottomLeftTexture:SetTexCoord( 0, .25, .75, 1 )
	frame.Textures.BottomLeftTexture:SetPoint("BOTTOMLEFT", frame.Border)
	frame.Textures.BottomLeftTexture:SetPoint("TOPRIGHT", frame, "BOTTOMLEFT")
	
	frame.Textures.BottomRightTexture = frame:CreateTexture(nil, "ARTWORK")
	frame.Textures.BottomRightTexture:SetTexCoord( .75, 1, .75, 1 )
	frame.Textures.BottomRightTexture:SetPoint("BOTTOMRIGHT", frame.Border)
	frame.Textures.BottomRightTexture:SetPoint("TOPLEFT", frame, "BOTTOMRIGHT")
	
	-- Sides
	-- [[
	frame.Textures.TopMiddleTexture = frame:CreateTexture(nil, "ARTWORK")
	frame.Textures.TopMiddleTexture:SetTexCoord( .25, .75, 0, .25 )
	frame.Textures.TopMiddleTexture:SetPoint("TOP", frame.Border)
	frame.Textures.TopMiddleTexture:SetPoint("BOTTOM", frame, "TOP")
	frame.Textures.TopMiddleTexture:SetPoint("LEFT", frame)
	frame.Textures.TopMiddleTexture:SetPoint("RIGHT", frame)
	
	frame.Textures.BottomMiddleTexture = frame:CreateTexture(nil, "ARTWORK")
	frame.Textures.BottomMiddleTexture:SetTexCoord( .25, .75, .75, 1 )
	frame.Textures.BottomMiddleTexture:SetPoint("BOTTOM", frame.Border)
	frame.Textures.BottomMiddleTexture:SetPoint("TOP", frame, "BOTTOM")
	frame.Textures.BottomMiddleTexture:SetPoint("LEFT", frame)
	frame.Textures.BottomMiddleTexture:SetPoint("RIGHT", frame)
	
	frame.Textures.LeftMiddleTexture = frame:CreateTexture(nil, "ARTWORK")
	frame.Textures.LeftMiddleTexture:SetTexCoord( 0, .25, .25, .75 )
	frame.Textures.LeftMiddleTexture:SetPoint("LEFT", frame.Border)
	frame.Textures.LeftMiddleTexture:SetPoint("TOP", frame)
	frame.Textures.LeftMiddleTexture:SetPoint("BOTTOM", frame)
	frame.Textures.LeftMiddleTexture:SetPoint("RIGHT", frame, "LEFT")
	
	frame.Textures.RightMiddleTexture = frame:CreateTexture(nil, "ARTWORK")
	frame.Textures.RightMiddleTexture:SetTexCoord( .75, 1, .25, .75 )
	frame.Textures.RightMiddleTexture:SetPoint("RIGHT", frame.Border)
	frame.Textures.RightMiddleTexture:SetPoint("TOP", frame)
	frame.Textures.RightMiddleTexture:SetPoint("BOTTOM", frame)
	frame.Textures.RightMiddleTexture:SetPoint("LEFT", frame, "RIGHT")
	--]]
	-- Center
	frame.Textures.CenterTexture = frame:CreateTexture(nil, "ARTWORK")
	frame.Textures.CenterTexture:SetTexCoord( .25, .75, .25, .75 )
	frame.Textures.CenterTexture:SetAllPoints(frame)
	
	-- Functions
	frame.SetTexture = SetCubeframeTexture
	frame.SetCubeframeBodySize = SetCubeframeBodySize
	frame.SetCubeframeBorderSize = SetCubeframeBorderSize
	--frame.SetCubeframeSize = SetCubeframeSize
	
	return frame
end

--[[
TestCube = CreateTidyPlatesCubeframe(nil)
TestCube:SetPoint("CENTER", WorldFrame)
TestCube:SetCubeframeBodySize(128, 64)
TestCube:SetCubeframeBorderSize(64, 32)
TestCube:SetTexture("Interface\\Addons\\TidyPlates_Neon\\TestBorder2")

-- /run TestCube:SetCubeframeBodySize(128, 128)
-- /run TestCube:SetCubeframeBorderSize(40, 20)
-- /run TestCube:SetCubeframeBorderSize(70, 35)
--]]



