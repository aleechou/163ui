
----------------------------------
-- Helpers
----------------------------------

local function CallForStyleUpdate()
	for name, theme in pairs(TidyPlatesThemeList) do
		if theme.OnApplyThemeCustomization then theme:OnApplyThemeCustomization() end
	end
end

local function GetPanelValues(panel, targetTable)
	local index
	for index in pairs(targetTable) do
		if panel[index] then
			targetTable[index] = panel[index]:GetValue()
	--for index, widget in pairs(panel) do
		--if widget.GetValue then
			--targetTable[index] = widget:GetValue()

		end
	end
end

local function SetPanelValues(panel, sourceTable)
	for index, value in pairs(sourceTable) do
		if panel[index] then
			panel[index]:SetValue(value)
		end
	end
end

local function GetSavedVariables(targetTable, cloneTable)
	local i, v
	for i, v in pairs(targetTable) do
		if cloneTable[i] ~= nil then
			targetTable[i] = cloneTable[i]
		end
	end
end

local function ListToTable( ... )
	local t = {}
	local index, line
	for index = 1, select("#", ...) do
		line = select(index, ...)
		if line ~= "" then t[index] = line end
	end
	return t
end

local function ConvertStringToTable(source, target )
	local temp = ListToTable(strsplit("\n", source))
	target = wipe(target)

	for index = 1, #source do
		local str = temp[index]
		if str then target[str] = true end
	end
end


local function ConvertDebuffListTable(source, target, order)
	local temp = ListToTable(strsplit("\n", source))
	target = wipe(target)
	if order then order = wipe(order) end

	for index = 1, #temp do
		local str = temp[index]
		local item
		local prefix, suffix

		if str then
			prefix, suffix = select(3, string.find( str, "(%w+)[%s%p]*(.*)"))
			if prefix then
				if TidyPlatesHubPrefixList[prefix] then
					item = suffix
					-- CONVERT
					target[item] = TidyPlatesHubPrefixList[prefix]
				else -- If no prefix is listed, assume 1
					if suffix and suffix ~= "" then item = prefix.." "..suffix
					else item = prefix end
					-- CONVERT
					target[item] = 1
				end
				if order then order[item] = index end
			end
		end
	end

end

local function AddHubFunction(functionTable, menuTable, functionPointer, functionDescription, functionKey )
	if functionTable then
		functionTable[functionKey or (#functionTable+1)] = functionPointer
	end

	if menuTable then
		menuTable[#menuTable+1] = { text = functionDescription, value = functionKey }
	end
end

TidyPlatesHubHelpers = {}
TidyPlatesHubHelpers.CallForStyleUpdate = CallForStyleUpdate
TidyPlatesHubHelpers.GetPanelValues = GetPanelValues
TidyPlatesHubHelpers.SetPanelValues = SetPanelValues
TidyPlatesHubHelpers.GetSavedVariables = GetSavedVariables
TidyPlatesHubHelpers.ListToTable = ListToTable
TidyPlatesHubHelpers.ConvertStringToTable = ConvertStringToTable
TidyPlatesHubHelpers.ConvertDebuffListTable = ConvertDebuffListTable
TidyPlatesHubHelpers.AddHubFunction = AddHubFunction

--[[
local CallForStyleUpdate = TidyPlatesHubHelpers.CallForStyleUpdate
local GetPanelValues = TidyPlatesHubHelpers.GetPanelValues
local SetPanelValues = TidyPlatesHubHelpers.SetPanelValues
local GetSavedVariables = TidyPlatesHubHelpers.GetSavedVariables
local ListToTable = TidyPlatesHubHelpers.ListToTable
local ConvertStringToTable = TidyPlatesHubHelpers.ConvertStringToTable
local ConvertDebuffListTable = TidyPlatesHubHelpers.ConvertDebuffListTable
--]]



local function fromCSV (s)
  s = s .. ','        -- ending comma
  local t = {}        -- table to collect fields
  local fieldstart = 1
  repeat
    -- next field is quoted? (start with `"'?)
    if string.find(s, '^"', fieldstart) then
      local a, c
      local i  = fieldstart
      repeat
        -- find closing quote
        a, i, c = string.find(s, '"("?)', i+1)
      until c ~= '"'    -- quote not followed by quote?
      if not i then error('unmatched "') end
      local f = string.sub(s, fieldstart+1, i-1)
      table.insert(t, (string.gsub(f, '""', '"')))
      fieldstart = string.find(s, ',', i) + 1
    else                -- unquoted; find next comma
      local nexti = string.find(s, ',', fieldstart)
      table.insert(t, string.sub(s, fieldstart, nexti-1))
      fieldstart = nexti + 1
    end
  until fieldstart > string.len(s)
  return t
end
--[[
local function EvaluateExpression(expression)
	print(expression)
	-- /eval oh blah, dee, oh , blah ,do
	local t = fromCSV(expression)
	for i,v in pairs(t) do
		print(i,v)
	end

end


SLASH_EVAL1 = '/eval'
SlashCmdList['EVAL'] = EvaluateExpression
--]]









