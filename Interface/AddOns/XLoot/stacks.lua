local XLoot = select(2, ...)
local lib = {}
XLoot.Stack = lib
local L = XLoot.L
local print = print

-- ANCHOR element
do
	local backdrop = { bgFile = [[Interface\Tooltips\UI-Tooltip-Background]] }

	local function OnDragStart(self)
		self:StartMoving()
	end
	
	local function OnDragStop(self)
		self:StopMovingOrSizing()
		self.data.x = self:GetLeft()
		self.data.y = self:GetTop()
	end
	
	local function Close_OnClick(self)
		self.parent:Hide()
	end
	
	local function OnClick(self, ...)
		if self.OnClick then
			self:OnClick(...)
		end
	end

	local function Show(self)
		self:SetClampedToScreen(true)
		self:Position()
		self.data.visible = true
		self:_Show()
	end
	
	local function Hide(self)
		self:SetClampedToScreen(false)
		if self.data.direction == 'up' then
			self:Position(self.data.x, self.data.y - 20)
		elseif self.data.direction then
			self:Position(self.data.x, self.data.y + 20)
		end
		self:GetTop() -- Force reflow
		self:GetBottom()
		self.data.visible = false
		self:_Hide()
	end

	local function Position(self, x, y)
		self:ClearAllPoints()
		self:SetPoint('TOPLEFT', UIParent, 'BOTTOMLEFT', x or self.data.x, y or self.data.y)
		self:SetHeight(20)
		-- self:SetWidth(self.label:GetStringWidth() + 100)
		self:SetWidth(175)
	end

	local function AnchorChild(self, child, to)
		local d = self.data.direction
		if to then
			local a, b, x, y = 'BOTTOMLEFT', 'TOPLEFT', 0, 2
			if d == 'down' then
				a, b, x, y = 'TOPLEFT', 'BOTTOMLEFT', 0, -2
			elseif d == 'left' then
				a, b, x, y = 'RIGHT', 'LEFT', 2, 0
			elseif d == 'right' then
				a, b, x, y = 'LEFT', 'RIGHT', -2, 0
			end
			child:SetPoint(a, to, b, x, y)
		else
			local a, b = 'BOTTOMLEFT', 'TOPLEFT'
			if d == 'down' then
				a, b = 'TOPLEFT', 'BOTTOMLEFT'
			elseif d == 'left' then
				a, b = 'TOPRIGHT', 'BOTTOMRIGHT'
			end
			child:SetPoint(a, self, b)
		end
		if self.data and self.data.scale then
			child:SetScale(child.scale_mod and self.data.scale * child.scale_mod or self.data.scale)
		elseif child.scale_mod then
			child:SetScale(child.scale_mod)
		end
	end

	function UpdateSVData(self, svdata)
		if svdata then
			if self.data == svdata then
				local mod = self:GetScale() / svdata.scale
				svdata.x = svdata.x * mod
				svdata.y = svdata.y * mod
			end
			self.data = svdata
			self:SetScale(svdata.scale)
			self:Position()
			if not svdata.visible then
				self:Hide()
			end
		else
			self.data = {}
		end
	end

	function lib:CreateAnchor(text, svdata)
		local anchor = CreateFrame('Button', nil, UIParent)
		anchor:SetBackdrop(backdrop)
		anchor:SetBackdropColor(0, 0, 0, 0.7)
		anchor:SetMovable(true)
		anchor:SetClampedToScreen(true)
		anchor:RegisterForDrag('LeftButton')
		anchor:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
		anchor:SetScript('OnDragStart', OnDragStart)
		anchor:SetScript('OnDragStop', OnDragStop)
		anchor:SetScript('OnClick', OnClick)
		anchor:SetAlpha(0.8)
		anchor.Show, anchor._Show = Show, anchor.Show
		anchor.Hide, anchor._Hide = Hide, anchor.Hide
		anchor.Position = Position
		anchor.OnMove = OnMove
		anchor.OnToggle = OnToggle
		anchor.AnchorChild = AnchorChild
		anchor.UpdateSVData = UpdateSVData
		
		local close = CreateFrame('Button', nil, anchor, 'UIPanelCloseButton')
		close:SetScript('OnClick', Close_OnClick)
		close:SetPoint('RIGHT', 1, 0)
		close:SetHeight(20)
		close:SetWidth(20)
		close.parent = anchor
		anchor.close = close

		local label = anchor:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
		label:SetPoint('CENTER', -5, 0)
		label:SetJustifyH('MIDDLE')
		label:SetText(text)
		anchor.label = label
		
		anchor:SetHeight(20)
		anchor:SetWidth(label:GetStringWidth() + 100)

		anchor:UpdateSVData(svdata)
		
		return anchor
	end
end
-- END ANCHOR element

local function AnchorScale(self, scale)
	self:SetScale(scale)
	if self.children then
		for _, child in pairs(self.children) do
			child:SetScale(scale)
		end
	end
end

local table_insert = table.insert
local function AcquireChild(self)
	for _, f in ipairs(self.children) do
		if not f.active then
			return f
		end
	end
	local child = self:Factory()
	table_insert(self.children, child)
	return child, true
end

-- STATIC STACK
do
	local function Push(self)
		local child, new = AcquireChild(self)
		if new then
			local n = #self.children
			self:AnchorChild(child, n > 1 and children[n-1] or nil)
		end
		child:Show()
		child.active = true
		return child
	end

	local function Pop(self, child)
		child:Hide()
		child.active = false
		if child.Popped then
			child:Popped()
		end
	end

	local function Restack(self)
		for i,child in ipairs(self.children) do
			child:ClearAllPoints()
			self:AnchorChild(child, i == 1 and self or self.children[i-1])
		end
	end

	function lib:CreateStaticStack(factory, ...)
		local anchor = self:CreateAnchor(...)
		anchor.children = {}
		anchor.Factory = factory
		anchor.Push = Push
		anchor.Pop = Pop
		anchor.Scale = AnchorScale
		anchor.Restack = Restack
		return anchor
	end
end


