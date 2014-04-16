﻿-- --------------------
-- TellMeWhen
-- Originally by Nephthys of Hyjal <lieandswell@yahoo.com>

-- Other contributions by:
--		Sweetmms of Blackrock, Oozebull of Twisting Nether, Oodyboo of Mug'thol,
--		Banjankri of Blackrock, Predeter of Proudmoore, Xenyr of Aszune

-- Currently maintained by
-- Cybeloras of Aerie Peak/Detheroc/Mal'Ganis
-- --------------------


if not TMW then return end

local TMW = TMW
local L = TMW.L
local print = TMW.print
	

local isMoving = nil
local function stopMoving(group)
	group:StopMovingOrSizing()
	
	isMoving = nil
	
	local GroupModule_GroupPosition = group:GetModuleOrModuleChild("GroupModule_GroupPosition")
	GroupModule_GroupPosition:UpdatePositionAfterMovement()
	
	group:Setup()
	
	TMW.IE:NotifyChanges()
end

	
local Module = TMW:NewClass("IconModule_GroupMover", "IconModule"){

	METHOD_EXTENSIONS = {
		OnImplementIntoIcon = function(self)
			local icon = self.icon
			local group = icon.group
			
			local GroupModule_GroupPosition = group:GetModuleOrModuleChild("GroupModule_GroupPosition")
			
			if not GroupModule_GroupPosition then
				error("Implementing IconModule_GroupMover (or a derivative) requies that GroupModule_GroupPosition (or a derivative) be already implemented.")
			end
		end,
	},
	
	OnNewInstance_GroupMover = function(self, icon)
		icon:RegisterForDrag("LeftButton", "RightButton")
	end,
}

Module:SetScriptHandler("OnDragStart", function(Module, icon, button)
	if button == "LeftButton" then
		local group = icon:GetParent()
		if not TMW.Locked and not group.Locked then
			group:StartMoving()
			isMoving = group
		end
	end
end)

Module:SetScriptHandler("OnDragStop", function(Module, icon)
	if isMoving then
		stopMoving(isMoving)
	end
end)


-- Sometimes, if a group/icon does some things to itself while moving
-- (Hiding/Showing seems to trigger this), OnDragStop won't fire when it should.
-- Having these here makes sure that the user doesn't get a group permanantly stuck to their cursor.
	
WorldFrame:HookScript("OnMouseDown", function(WorldFrame, button)
	if isMoving then
		stopMoving(isMoving)
	end
end)

TMW:RegisterCallback("TMW_GROUP_HIDE_PRE", function(event, group)
	if isMoving == group then
		stopMoving(isMoving)
	end
end)

TMW:RegisterCallback("TMW_LOCK_TOGGLED", function(event, Locked)
	if Locked and isMoving then
		stopMoving(isMoving)
	end
end)
	
Module:SetScriptHandler("OnMouseUp", function(Module, icon, button)
	if not TMW.Locked then
		if isMoving then
			stopMoving(isMoving)
		end
	end
end)




TMW.IconDragger:RegisterIconDragHandler(330,	-- Anchor
	function(IconDragger, info)
		local name, desc

		local srcname = TMW:GetGroupName(IconDragger.srcicon.group:GetID(), IconDragger.srcicon.group:GetID())

		if IconDragger.desticon and IconDragger.srcicon.group:GetID() ~= IconDragger.desticon.group:GetID() then
			local destname = L["fGROUP"]:format(TMW:GetGroupName(IconDragger.desticon.group:GetID(), IconDragger.desticon.group:GetID(), 1))
			name = L["ICONMENU_ANCHORTO"]:format(destname)
			desc = L["ICONMENU_ANCHORTO_DESC"]:format(srcname, destname, destname, srcname)

		elseif IconDragger.destFrame and IconDragger.destFrame:GetName() then
			if IconDragger.destFrame == WorldFrame and IconDragger.srcicon.group.Point.relativeTo ~= "UIParent" then
			
				
				local currentFrameName = IconDragger.srcicon.group.Point.relativeTo
				
				local groupID = currentFrameName:match("^TellMeWhen_Group(%d+)")
				local iconID = currentFrameName:match("^TellMeWhen_Group%d+_Icon(%d+)")
				
				if iconID and groupID then
					currentFrameName = L["GROUPICON"]:format(TMW:GetGroupName(groupID, groupID, 1), iconID)
				elseif groupID then
					currentFrameName = TMW:GetGroupName(groupID, groupID)
				end
				
				name = L["ICONMENU_ANCHORTO_UIPARENT"]
				desc = L["ICONMENU_ANCHORTO_UIPARENT_DESC"]:format(srcname, currentFrameName)

			elseif IconDragger.destFrame ~= WorldFrame then
				local destname = IconDragger.destFrame:GetName()
				name = L["ICONMENU_ANCHORTO"]:format(destname)
				desc = L["ICONMENU_ANCHORTO_DESC"]:format(srcname, destname, destname, srcname)
			end
		end

		if name then
			info.text = name
			info.tooltipTitle = name
			info.tooltipText = desc
			return true
		end
	end,
	function(IconDragger)
		if IconDragger.desticon then
			-- we are anchoring to another TMW group, so dont operate on the same group.
			if IconDragger.desticon.group == IconDragger.srcicon.group then
				return
			end

			-- set the setting
			IconDragger.srcicon.group.Point.relativeTo = IconDragger.desticon.group:GetName()
		else
			local name = IconDragger.destFrame:GetName()
			-- we are anchoring to some other frame entirely.
			if IconDragger.destFrame == WorldFrame then
				-- If it was dragged to WorldFrame then reset the anchor to UIParent (the text in the dropdown is custom for this circumstance)
				name = "UIParent"
			elseif IconDragger.destFrame == IconDragger.srcicon.group then
				-- this should never ever ever ever ever ever ever ever ever happen.
				return
			elseif not IconDragger.destFrame:GetName() then
				-- make sure it actually has a name
				return
			end

			-- set the setting
			IconDragger.srcicon.group.Point.relativeTo = name
		end

		-- do adjustments and positioning
		-- i cheat. we didnt really stop moving anything, but i'm going to hijack this function anyway.
		stopMoving(IconDragger.srcicon.group)
	end
)