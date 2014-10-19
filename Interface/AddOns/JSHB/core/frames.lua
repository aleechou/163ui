--
-- JSHB - frame functions
--

function JSHB.GetFrameOffset(frame, side, absolute)
	if (not frame) or (not frame.gapOffsets) then return(0) end
	if (side == "TOP") then
		return frame.gapOffsets[3]
	elseif (side == "BOTTOM") then
		return absolute and frame.gapOffsets[4] or (-frame.gapOffsets[4])
	elseif (side == "LEFT") then
		return absolute and frame.gapOffsets[1] or (-frame.gapOffsets[1])
	elseif (side == "RIGHT") then
		return frame.gapOffsets[2]
	end
	return(0)	
end

-- Basicly a wrapper for CreateFrame() that sets gapOffsets and allows a frame to be recycled.
function JSHB.MakeFrame(recycle, ...)
	local frame = recycle or CreateFrame(...)
	if (frame.gapOffsets) then
		frame.gapOffsets[1] = 0; frame.gapOffsets[2] = 0; frame.gapOffsets[3] = 0; frame.gapOffsets[4] = 0 -- recycle
	else
		frame.gapOffsets = { 0, 0, 0, 0 } -- L, R, T, B
	end
	return frame
end

function JSHB.MakeBackground(parent, d, pre, sizeOverrides, recycle)

	-- Allow for duplicate entries for multiple frame options by just adding in a preface to the options and specifying it upon creation
	local data
	if pre then
		data = {}
		local key,val
		for key,val in pairs(d) do
			-- Only copy items with the "pre" preface.
			if strsub(key, 1, #pre) == pre then
				data[strsub(key, #pre + 1)] = JSHB.DeepCopy(d[key])				
			end
		end
	else
		data = d
	end

	-- Allow MakeBackdrop to always be called and set itself up only if needed
	if (parent == nil) or (data == nil) or ( (not data.enablebackdrop) and (not data.enableborder) ) then
		if (recycle) then
			recycle:Hide()
		end
		return recycle or nil
	end

	local background = recycle or CreateFrame("Frame", nil, parent)
	background:ClearAllPoints()
	background:SetFrameStrata("MEDIUM")
	background:SetFrameLevel( ( (parent:GetFrameLevel() - 1) >= 0) and (parent:GetFrameLevel() - 1) or 0)

	if data.enablebackdrop and data.enableborder then -- Backdrop and border

		background:SetBackdrop( {bgFile = JSHB.GetActiveBackgroundFile(data.backdroptexture),
			tile = data.tile, tileSize = data.tile and data.tilesize or 0,
			edgeFile = JSHB.GetActiveBorderFile(data.bordertexture),
			edgeSize = data.edgesize,
			insets = { left = data.backdropinsets[1], right = data.backdropinsets[2], top = data.backdropinsets[3], bottom = data.backdropinsets[4] }
		})
		background:SetPoint("TOPLEFT", -(data.edgesize) + data.backdropinsets[1] + (sizeOverrides and sizeOverrides[1] or 0),
			data.edgesize + data.backdropinsets[3] + (sizeOverrides and sizeOverrides[3] or 0) )
		background:SetPoint("BOTTOMRIGHT", data.edgesize + data.backdropinsets[2] + (sizeOverrides and sizeOverrides[2] or 0),
			-(data.edgesize) + data.backdropinsets[4] + (sizeOverrides and sizeOverrides[4] or 0) )

		parent.gapOffsets[1] = max(abs( (-(data.edgesize) ) + data.backdropinsets[1] + (sizeOverrides and sizeOverrides[1] or 0) ),
			( (data.backdropoffsets[1] < 0) and abs(data.backdropoffsets[1] + (sizeOverrides and sizeOverrides[1] or 0)) or 0) ) -- LEFT
			
		parent.gapOffsets[2] = max(abs( ( (data.edgesize) ) + data.backdropinsets[2] + (sizeOverrides and sizeOverrides[2] or 0) ),
			( (data.backdropoffsets[3] > 0) and abs(data.backdropoffsets[3] + (sizeOverrides and sizeOverrides[2] or 0)) or 0) ) -- RIGHT
			
		parent.gapOffsets[3] = max(abs( ( (data.edgesize) ) + data.backdropinsets[3] + (sizeOverrides and sizeOverrides[3] or 0) ),
			( (data.backdropoffsets[2] > 0) and abs(data.backdropoffsets[2] + (sizeOverrides and sizeOverrides[3] or 0)) or 0) ) -- TOP
			
		parent.gapOffsets[4] = max(abs( (-(data.edgesize) ) + data.backdropinsets[4] + (sizeOverrides and sizeOverrides[4] or 0) ),
			( (data.backdropoffsets[4] < 0) and abs(data.backdropoffsets[4] + (sizeOverrides and sizeOverrides[4] or 0) ) or 0) ) -- BOTTOM		
		
	elseif data.enablebackdrop then -- Backdrop only
	
		background:SetBackdrop({bgFile = JSHB.GetActiveBackgroundFile(data.backdroptexture),
			tile = data.tile, tileSize = data.tile and data.tilesize or 0,
		})
		background:SetPoint("TOPLEFT", data.backdropoffsets[1] + (sizeOverrides and sizeOverrides[1] or 0),
			data.backdropoffsets[2] + (sizeOverrides and sizeOverrides[3] or 0) )
		background:SetPoint("BOTTOMRIGHT", data.backdropoffsets[3] + (sizeOverrides and sizeOverrides[2] or 0),
			data.backdropoffsets[4] + (sizeOverrides and sizeOverrides[4] or 0) )

		parent.gapOffsets[1] = ( (data.backdropoffsets[1] + (sizeOverrides and sizeOverrides[1] or 0) ) < 0) and
			abs(data.backdropoffsets[1] + (sizeOverrides and sizeOverrides[1] or 0) ) or 0 -- LEFT
			
		parent.gapOffsets[2] = ( (data.backdropoffsets[3] + (sizeOverrides and sizeOverrides[2] or 0) ) > 0) and
			abs(data.backdropoffsets[3] + (sizeOverrides and sizeOverrides[2] or 0) ) or 0 -- RIGHT
			
		parent.gapOffsets[3] = ( (data.backdropoffsets[2] + (sizeOverrides and sizeOverrides[3] or 0) ) > 0) and
			abs(data.backdropoffsets[2] + (sizeOverrides and sizeOverrides[3] or 0) ) or 0 -- TOP
			
		parent.gapOffsets[4] = ( (data.backdropoffsets[4] + (sizeOverrides and sizeOverrides[4] or 0) ) < 0) and
			abs(data.backdropoffsets[4] + (sizeOverrides and sizeOverrides[4] or 0) ) or 0 -- BOTTOM
		
	else -- Border only
	
		background:SetBackdrop( {
			edgeFile = JSHB.GetActiveBorderFile(data.bordertexture),
			edgeSize = data.edgesize,
			insets = { left = data.backdropinsets[1], right = data.backdropinsets[2], top = data.backdropinsets[3], bottom = data.backdropinsets[4] }
		})
		background:SetPoint("TOPLEFT", -(data.edgesize) + data.backdropinsets[1] + (sizeOverrides and sizeOverrides[1] or 0),
			data.edgesize + data.backdropinsets[3] + (sizeOverrides and sizeOverrides[3] or 0) )
		background:SetPoint("BOTTOMRIGHT", data.edgesize + data.backdropinsets[2] + (sizeOverrides and sizeOverrides[2] or 0),
			-(data.edgesize) + data.backdropinsets[4] + (sizeOverrides and sizeOverrides[4] or 0) )
		
		parent.gapOffsets[1] = abs( (-(data.edgesize) ) + data.backdropinsets[1] + (sizeOverrides and sizeOverrides[1] or 0) ) -- LEFT
		parent.gapOffsets[2] = abs( ( (data.edgesize) ) + data.backdropinsets[2] + (sizeOverrides and sizeOverrides[2] or 0) ) -- RIGHT
		parent.gapOffsets[3] = abs( ( (data.edgesize) ) + data.backdropinsets[3] + (sizeOverrides and sizeOverrides[3] or 0) ) -- TOP
		parent.gapOffsets[4] = abs( (-(data.edgesize) ) + data.backdropinsets[4] + (sizeOverrides and sizeOverrides[4] or 0) ) -- BOTTOM
		
	end

	if data.enablebackdrop and data.colorbackdrop then 
		if background.backdrop then
			background.backdrop:SetBackdropColor(unpack(data.backdropcolor) )
		else
			background:SetBackdropColor(unpack(data.backdropcolor) )
		end
	end
	
	if data.enableborder then background:SetBackdropBorderColor(unpack(data.bordercolor) ) end
	
	background:Show()
	return background
end
