local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local Type,Version,Ancestor="AlarMinimapButton",4,nil
local pp=print
local me, ns = ...
--[===[@debug@
LibStub("AlarLoader-3.0"):loadingList(__FILE__,me)
--@end-debug@]===]
if (LibDebug) then LibDebug() end
local function debug(...)
--[===[@debug@
	--print(...)
--@end-debug@]===]
end
local print=pp
local toc=select(4,GetBuildInfo())
--[[ Standard prologue end --]]
local _G=_G
local AWG=LibStub("AlarWidgets-3.0")
local AceGUI=AWG.AceGUI
local InjectStandardMethods=AWG.InjectStandardMethods
--[[ Mimimap Button Widget
		Methods
		:SetImage(texture,texcoords...)
		:SetClamped(boolean)
		:GetClamped()
		:SetLocked(boolean)
		:GetLocked()
		:Status(boolean)
		:SetBorderColor(r,g,b)
		:SetStatusTable(table)
		Events
		OnClick
		OnEnter
		OnLeave
--]]
do
		local mx={}
			-- called to set an external table to store status in
		function mx:SetStatusTable(status)
		assert(type(status) == "table")
		self.status = status
		self:ApplyStatus()
		end
		function mx.buttonOnEnter(this)
				local self=this.obj
				self:Fire("OnEnter",this)
		end
		function mx.buttonOnClick(this,button)
				local self=this.obj
				self:Fire("OnClick",this,button)
				if (button == 'LeftButton') then self:Fire("OnLeftClick",this) end
				if (button == 'RightButton') then self:Fire("OnRightClick",this) end
		end
		function mx.buttonOnLeave(this)
				local self=this.obj
				self:Fire("OnLeave",this)
		end
		function mx.buttonOnDragStop(this)
				local obj=this.obj
			local status=obj.status or obj.localstatus
			obj.dragger:Hide()
			this:UnlockHighlight()
			this:StopMovingOrSizing();
			if (not status.clamped) then mx.Move(this) end
			pp('button',obj.button)
			pp('frame',obj.frame)
			pp('dragger',obj.dragger)
			pp('this',this)
			mx.Reposition(this)
				pp("dragstop",status.position,this,status.x,status.y)

		end
		function mx.buttonOnDragStart(this)
				local status=this.obj.status or this.obj.localstatus
				pp("dragstart",status.x,status.y)
				this:LockHighlight()
				if (status.clamped) then
						pp("Clamped")
						this.obj.dragger:Show()
				else
						pp("Unclamped")
						this:StartMoving()
				end
		end
		function mx.Reposition(this)
			local status=this.obj.status or this.obj.localstatus
			local position=status.position or -90
			local x=status.x or 0
			local y=status.y or 0
			if (status.clamped) then
						pp ("x,y from position",position,x,y)
						x=-16-(80*cos(position))
						y=(80*sin(position))+16
				end
				this.obj.frame:ClearAllPoints()
				this.obj.button:ClearAllPoints()
				this.obj.frame:SetPoint("TOPLEFT","Minimap","CENTER" ,x,y)
				this.obj.button:SetPoint("CENTER",this.obj.frame,"CENTER")
				status.x=x
				status.y=y
			status.position=position
		end
		function mx.Move(this,noreposition)
				local xpos,ypos = GetCursorPosition()
			local status=this.obj.status or this.obj.localstatus
				local xmin,ymin = Minimap:GetLeft(), Minimap:GetTop()
				if (status.clamped) then
						local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()
						xpos = xmin-xpos/UIParent:GetScale()+70
						ypos = ypos/UIParent:GetScale()-ymin-70
						status.position=math.deg(math.atan2(ypos,xpos))
						mx.Reposition(this)
				else
						xpos = xpos/UIParent:GetScale()-xmin - 80
						ypos = ypos/UIParent:GetScale()-ymin + 80
						status.x=xpos
						status.y=ypos
				end
		end
		function mx.Lock(self)
				local status=self.status or self.localstatus
				if (status.locked) then
						self.button:RegisterForDrag(nil)
				else
						self.button:RegisterForDrag("leftbutton")
				end
		end
		function mx.Clamp(self)
				local status=self.status or self.localstatus
				self.frame:ClearAllPoints()
				self.frame:SetParent(Minimap)
				if (status.clamped) then
						pp("Clamp","Clamping")
						self.dragger:SetScript("OnUpdate",function(this) mx.Move(this,false) end)
				else
						pp("Clamp","UnClamping")
						self.dragger:SetScript("OnUpdate",nil)
				end
				mx.Reposition(self.button)
		end
		function mx.SetClamped(self,lock)
				pp("SetClamped",lock)
			local status = self.status or self.localstatus
			local old=status.clamped
			status.clamped=lock
			mx.Clamp(self)
			return old
		end
		function mx.GetClamped(self)
			local status = self.status or self.localstatus
			return status.clamped
		end


	function mx.SetImage(self, path, ...)
		local image = self.image
		image:SetTexture(path)

		if image:GetTexture() then
			self.imageshown = true
			local n = select('#', ...)
			if n == 4 or n == 8 then
				image:SetTexCoord(...)
			end
		else
			self.imageshown = nil
		end
	end

	function mx.ApplyStatus(self)
		local status = self.status or self.localstatus
		local frame = self.frame
			pp("Applystatus",x,y,position)
		mx.Clamp(self)
		mx.Lock(self)
	end

	function mx.Acquire(self)
		self.frame:SetParent(Minimap)
		self.frame:SetFrameStrata("LOW")
		--self:ApplyStatus()
	end

		function mx.SetBorderColor(self,r,g,b)
				self.border:SetVertexColor(r,g,b)
		end
		function mx.Status(self,on)
				if (on) then
						mx.SetBorderColor(self,0.2,0.9,0.2)
				else
						mx.SetBorderColor(self,0.9,0.2,0.2)
				end
		end

	function mx._Constructor()
		local frame = CreateFrame("Frame",nil,UIParent)
		local self = {}
		self.localstatus={}
		InjectStandardMethods(self)
		self.type = Type
		self.frame=frame
		self.frame.obj=self
		self.Acquire = mx.Acquire
		self.SetBorderColor = mx.SetBorderCOlor
		self.SetImage = mx.SetImage
		self.Status = mx.Status
		self.ApplyStatus = mx.ApplyStatus
		self.SetClamped = mx.SetClamped
		self.GetClamped = mx.GetClamped
		self.SetStatusTable= mx.SetStatusTable
		frame:SetWidth(32)
		frame:SetHeight(32)
		frame:SetClampedToScreen(1)
		local button=CreateFrame("Button",nil,frame)
		button.obj=self
		self.button=button
		local t=button:CreateTexture()
		t:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
				t:SetBlendMode("ADD")
				t:SetAllPoints(button)
		button:SetHighlightTexture(t)
		button:SetHeight(33)
		button:SetWidth(33)
		button:SetMovable(true)
		button:EnableMouse(true)
		button:SetPoint("TOPLEFT",Minimap,"CENTER",0,0)
		button:RegisterForClicks("LeftButtonUp","RightButtonUp")
		button:SetScript("OnEnter",mx.buttonOnEnter)
		button:SetScript("OnLeave",mx.buttonOnLeave)
		button:SetScript("OnDragStart",mx.buttonOnDragStart)
		button:SetScript("OnDragStop",mx.buttonOnDragStop)
		--button:SetScript("OnMouseUp",mx.buttonOnDragStop)
		button:SetScript("OnClick",mx.buttonOnClick)
		t=button:CreateTexture(nil,"BORDER")
		t:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
		t:SetHeight(20)
		t:SetWidth(20)
		t:SetPoint("CENTER",-2,1)
		self.image=t
		t=button:CreateTexture("NIL","OVERLAY")
		t:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
		t:SetHeight(52)
		t:SetWidth(53)
		t:SetPoint("TOPLEFT")
		self.border=t
		local dragger=CreateFrame("Frame",nil,frame)
		dragger:EnableMouse(true)
		dragger:SetMovable(true)
		dragger:SetScript("OnDragStop",mx.buttonOnDragStart)
		dragger:Hide()
		dragger.obj=self
		self.dragger=dragger
		AceGUI:RegisterAsWidget(self)
		pp("Minimap constructor done")
		return self
	end
	AceGUI:RegisterWidgetType(Type,mx._Constructor,Version)
	AWG.widgets[Type]=Version
end


