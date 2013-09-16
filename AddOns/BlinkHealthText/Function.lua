-- ∂®“Â≈‰÷√
local Simple_Frames,sf = {},{};
-- øÚº‹±£¥Ê
local f = CreateFrame("Frame", nil, UIParent);
f:SetScript("OnUpdate", function(self, elapsed)
	for frame, _ in pairs(sf) do
		frame.duration = frame.duration - elapsed;
		if (frame.duration <= 0) then			
			Frame_Save(frame, frame.layout_id);
			sf[frame] = nil;
		end
	end
end);
function Frame_Save(frame, id)	
	if (frame and id) then
		local left = frame:GetLeft();
		local top = frame:GetTop();
		local width = frame:GetWidth();
		local height = frame:GetHeight();	
		
		if (left and top and width and height) then
			Simple_Frames[id] = {};
			Simple_Frames[id].X = math.floor(left + 0.5);
			Simple_Frames[id].Y = math.floor(top + 0.5);
			Simple_Frames[id].W = math.floor(width + 0.5);
			Simple_Frames[id].H = math.floor(height + 0.5);
		end
	end
end

-- øÚº‹∂¡»°
function Frame_Load(frame, id)
	if (frame and Simple_Frames[id]) then
		frame:ClearAllPoints();
		frame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", Simple_Frames[id].X, Simple_Frames[id].Y);
		frame:SetWidth(Simple_Frames[id].W);
		frame:SetHeight(Simple_Frames[id].H);		
	end
end
-- øÚº‹–¸Õ£¥Û–°
function Frame_StopMovingOrSizing(self)
	if (self.originalStopMovingOrSizing) then
		self.originalStopMovingOrSizing(self);
	end
	
	-- Debug(format("%s OnMoving!", self:GetName()))
	self.duration = 1;
	sf[self] = true;	
end

-- øÚº‹◊¢≤·
function RegisterForSaveFrame(frame, id, no_load)
	assert(frame ~= nil, "frame must be assigned.");
	assert(type(frame) == "table", "RegisterForSaveFrame: the first parameter must be frame object.");

	if (not id) then
		id = frame:GetName();
	end

	assert(id ~= nil, "The frame has no name, can not be used as default id.");

	frame.layout_id = id;

	if (not frame.rfsf_hooked) then
		frame.rfsf_hooked = true;
		frame.originalStopMovingOrSizing = frame.StopMovingOrSizing;
		frame.StopMovingOrSizing = Frame_StopMovingOrSizing;
	end

	if (not no_load) then
		Frame_Load(frame, id);
	end
end