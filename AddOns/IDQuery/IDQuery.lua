------------------------------------------------------------
-- IDQuery.lua
--
-- Abin
-- 2010/8/27
------------------------------------------------------------

local GetSpellInfo = GetSpellInfo
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local GetAchievementInfo = GetAchievementInfo
local GetAchievementLink = GetAchievementLink
local HandleModifiedItemClick = HandleModifiedItemClick
local select = select
local gsub = gsub
local strtrim = strtrim
local strfind = strfind
local strlower = strlower
local pcall = pcall

-------------------------------------------------
-- Query data definition
-------------------------------------------------

local QUERY_DATA = {

	item = {
		ID_MAX = 79000, --78498 for WOW 4.3 --54806 for WOW 3.35

        step = 790,

		nameFunc = GetItemInfo,

		displayFunc = function(id)
			local name, _, quality, _, _, _, _, _, _, icon = GetItemInfo(id)
			local r, g, b = GetItemQualityColor(quality)
			return name, icon, r, g, b
		end,

		linkFunc = function(id) return select(2, GetItemInfo(id)) end,
	},

	spell = {
		ID_MAX = 150000, --111962 for WOW 4.3 --80864 for WOW 3.35

		nameFunc = GetSpellInfo,

		displayFunc = function(id)
			local name, level, icon = GetSpellInfo(id)
			if name and level and level ~= "" then
				name = name.." |cff808080("..level..")|r"
			end
			return name, icon, 113 / 255, 213 / 255, 1
		end,

		linkFunc = function(id)
			local name = GetSpellInfo(id)
			if name then
				return "|cff71d5ff|Hspell:"..id.."|h["..name.."]|h|r"
			end
		end,
	},

	achievement = {
		ID_MAX = 6500, --6185 for WOW4.3 --4824 for WOW 3.35

		nameFunc = function(id)
            local status, _, name = pcall(GetAchievementInfo, id)
            return status and name
        end,

		displayFunc = function(id)
			local _, name, _, _, _, _, _, _, _, icon = GetAchievementInfo(id)
			return name, icon, 1, 1, 0
		end,

		linkFunc = GetAchievementLink,
	},
}

local L = IDQUERY_LOCALE
local isSearching, searchData, searchText, searchProgress, count, searchTimer, searchedAllOnce --searchedAllOnce 是用来标记第一次搜索的，可以重新搜索
local searchType = "item"

-------------------------------------------------
-- Main frame
-------------------------------------------------

local frame = UICreateInterfaceOptionPage("IDQueryOptionPage", "物品法术查询", L["desc"], nil, UIParent)
IDQFrame = frame
frame:SetDialogStyle("TOOLTIP", 1)
frame:SetSize(400, 430)
frame:SetPoint("CENTER")
frame:SetClampedToScreen(true)
frame:SetClampRectInsets(300, -300, -300, 300)

-------------------------------------------------
-- "Type" selection
-------------------------------------------------

local typeGroup = frame:CreateSingleSelectionGroup(TYPE..":", 50)
frame:AnchorToTopLeft(typeGroup, 0, -10)
local itemCheck = typeGroup:AddButton(ITEMS, "item")
itemCheck:ClearAllPoints()
itemCheck:SetPoint("LEFT", typeGroup, "LEFT", 50, 0)
typeGroup:AddButton(SPELLS, "spell")
typeGroup:AddButton(ACHIEVEMENTS, "achievement")
typeGroup.OnCheckInit = function(self, value) return value == "item" end
typeGroup.OnSelectionChanged = function(self, value) searchType = value end

-------------------------------------------------
-- "Name" editbox
-------------------------------------------------

local nameEdit = frame:CreateEditBox(NAME..":", 50)
nameEdit:SetWidth(200)
nameEdit.text:ClearAllPoints()
nameEdit.text:SetPoint("TOPLEFT", typeGroup, "BOTTOMLEFT", 0, -16)
nameEdit:ClearAllPoints()
nameEdit:SetPoint("LEFT", nameEdit.text, "LEFT", 50, 0)

-------------------------------------------------
-- Search button
-------------------------------------------------

local queryButton = frame:CreatePressButton(SEARCH)
queryButton:SetWidth(90)
queryButton:SetHeight(24)
queryButton:SetPoint("LEFT", nameEdit, "RIGHT", 5, 0)
CoreUIEnableTooltip(queryButton, "注意", "第一次搜索物品需要建立物品缓存，会非常慢，但请耐心等待搜索完毕，新缓存的物品可能搜索不到，请再搜索一次，以后就好了。\n\n另外搜索物品会给网络和服务器带来较大压力，而且游戏会卡顿，可能导致掉线。")

-------------------------------------------------
-- Status text
-------------------------------------------------

local statusText = frame:CreateFontString(frame:GetName().."StatusText", "ARTWORK", "GameFontHighlightLeft")
statusText:SetPoint("TOPLEFT", nameEdit.text, "BOTTOMLEFT", 6, -20)
statusText:SetText(format(L["records"], 0))

-------------------------------------------------
-- Results list
-------------------------------------------------

local panel = frame:CreatePanel()
panel:SetPoint("TOPLEFT", 16, -164)
panel:SetPoint("TOPRIGHT", -16, -164)
panel:SetHeight(250)

local list = UICreateVirtualScrollList(frame:GetName().."RecordsList", panel, 12)
list:SetPoint("TOPLEFT", 4, -5)
list:SetPoint("BOTTOMRIGHT", -4, 4)

-- List handler "OnButtonCreated", initialize list buttons
function list:OnButtonCreated(button)
	button:SetHeight(20)
	button.idText = button:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	button.idText:SetPoint("LEFT", 5, 0)
	button.idText:SetWidth(50)

	button.icon = button:CreateTexture(nil, "ARTWORK")
	button.icon:SetPoint("LEFT", button.idText, "RIGHT", 5, 0)
	button.icon:SetWidth(18)
	button.icon:SetHeight(18)

	button.nameText = button:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
	button.nameText:SetPoint("LEFT", button.icon, "RIGHT", 5, 0)
	button.nameText:SetPoint("RIGHT", -5, 0)
end

-- List handler "OnButtonClick"
function list:OnButtonClick(button, id, flag, down)
	if searchData then
		local link = searchData.linkFunc(id)
		if link then
			HandleModifiedItemClick(link)
        end
        if DEBUG_MODE and IsControlKeyDown() then
            dump({QUERY_DATA[searchType].nameFunc(id)})
        end
	end
end

-- List handler "OnButtonUpdate", update list button data
function list:OnButtonUpdate(button, id)
	if searchData then
		button.idText:SetText(id)
		local name, icon, r, g, b = searchData.displayFunc(id)
		button.nameText:SetText(name)
		button.icon:SetTexture(icon)
		button.nameText:SetTextColor(r, g, b)
	end
end

-- List handler "OnButtonTooltip"
function list:OnButtonTooltip(button, id)
	if searchData then
		local link = searchData.linkFunc(id)
		if link then
			pcall(GameTooltip.SetHyperlink, GameTooltip, link)
		end
	end
end

local function StopSearch(flag)
    if isSearching then
        isSearching = nil;
        CoreCancelTimer(searchTimer);
        searchTimer = nil;
        if flag == -2 then
            searchProgress = nil --用来再次搜索的
            statusText:SetText(L["too many"])
            nameEdit:SetFocus()
        elseif flag == -1 then
            statusText:SetText(format(L["stop records"], searchProgress*100/QUERY_DATA[searchType].ID_MAX, count))
        else
            searchProgress = nil
            searchedAllOnce = true
            statusText:SetText(format(L["records"], count))
        end
        queryButton:SetText(SEARCH)
        collectgarbage("collect")
    end
end

local function searchStep(text)
    local data = QUERY_DATA[searchType]
    local func = data.nameFunc
    local limit = data.ID_MAX
    local step = data.step or limit
    for i = searchProgress+1, min(searchProgress+step, limit) do
        local name = func(i)
        if name and strfind(strlower(name), text) then
            count = count + 1
            if count < 500 then
                list:InsertData(i)
            else
                StopSearch(-2)
                return
            end
        end
    end
    searchProgress = searchProgress + step
    if searchProgress >= limit then
        StopSearch()
    else
        statusText:SetText(L["searching"].." "..format("%d%%", searchProgress*100/limit))
    end
end

local function StartSearch()
	if isSearching then
		return
    end

	local data = QUERY_DATA[searchType]
	if not data then
		return
	end

	local text = gsub(strlower(strtrim(nameEdit:GetText())), "*", ".-")
	if text == searchText and data == searchData and not searchProgress and searchedAllOnce then
		return -- No changes, don't need to search again
	end

	list:Clear()
	nameEdit:ClearFocus()

	if text == "" or not pcall(strfind, "", text) then
		statusText:SetText(L["invalid text"])
		nameEdit:SetFocus()
		return -- Invalid text
	end

	-- Start searching
	isSearching = 1
	searchData = data
	searchText = text
	statusText:SetText(L["searching"])

	local func = data.nameFunc
	local limit = data.ID_MAX
	local i, name = tonumber(text)

    count = 0
	if i then
		-- Direct ID
		if func(i) then
			count = count + 1
			list:InsertData(i)
        end
        StopSearch()
	else
		-- Name
        searchProgress = 0
        queryButton:SetText(L["stop"])
        searchTimer = CoreScheduleTimer(true, 0.1, searchStep, text)
    end
end

queryButton:SetScript("OnClick", function()
    if isSearching then
        StopSearch(-1)
    else
        StartSearch()
    end
end)
nameEdit:SetScript("OnEnterPressed", StartSearch)

-------------------------------------------------
-- Slash handler
-------------------------------------------------

SLASH_IDQUERY1 = "/idq"
SLASH_IDQUERY2 = "/idquery"
SlashCmdList["IDQUERY"] = function() frame:Toggle() end
