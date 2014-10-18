-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local error = _G.error
local pairs = _G.pairs

-- Libraries
local table = _G.table

-----------------------------------------------------------------------
-- Library namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local MAJOR = "LibToast-1.0"

_G.assert(LibStub, MAJOR .. " requires LibStub")

local MINOR = 8 -- Should be manually increased
local lib, oldminor = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then
    return
end -- No upgrade needed

-----------------------------------------------------------------------
-- Migrations.
-----------------------------------------------------------------------
lib.templates = lib.templates or {}
lib.unique_templates = lib.unique_templates or {}
lib.active_toasts = lib.active_toasts or {}

lib.toast_heap = lib.toast_heap or {}
lib.button_heap = lib.button_heap or {}

lib.sink_icons = lib.sink_icons or {}
lib.sink_template = lib.sink_template or {} -- Cheating here, since users can only use strings.
lib.registered_sink = lib.registered_sink
lib.addon_names = lib.addon_names or {}
lib.addon_objects = lib.addon_objects or {}

-----------------------------------------------------------------------
-- Variables.
-----------------------------------------------------------------------
local current_toast
local internal_call
local calling_object

-----------------------------------------------------------------------
-- Constants.
-----------------------------------------------------------------------
local active_toasts = lib.active_toasts
local toast_heap = lib.toast_heap
local button_heap = lib.button_heap

local toast_proxy = {}

local METHOD_USAGE_FORMAT = MAJOR .. ":%s() - %s."

local DEFAULT_FADE_HOLD_TIME = 5
local DEFAULT_FADE_IN_TIME = 0.5
local DEFAULT_FADE_OUT_TIME = 1
local DEFAULT_TOAST_WIDTH = 250
local DEFAULT_TOAST_HEIGHT = 50
local DEFAULT_ICON_SIZE = 30

local DEFAULT_TOAST_BACKDROP = {
    bgFile = [[Interface\FriendsFrame\UI-Toast-Background]],
    edgeFile = [[Interface\FriendsFrame\UI-Toast-Border]],
    tile = true,
    tileSize = 12,
    edgeSize = 12,
    insets = {
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
    },
}

local DEFAULT_BACKGROUND_COLORS = {
    r = 0,
    g = 0,
    b = 0,
}

local DEFAULT_TITLE_COLORS = {
    r = 0.510,
    g = 0.773,
    b = 1,
}

local DEFAULT_TEXT_COLORS = {
    r = 0.486,
    g = 0.518,
    b = 0.541
}

local TOAST_BUTTONS = {
    primary_button = true,
    secondary_button = true,
    tertiary_button = true,
}
local TOAST_BUTTON_HEIGHT = 18

local SIBLING_ANCHORS = {
    TOPRIGHT = "BOTTOMRIGHT",
    TOPLEFT = "BOTTOMLEFT",
    BOTTOMRIGHT = "TOPRIGHT",
    BOTTOMLEFT = "TOPLEFT",
}

local OFFSET_X = {
    TOPRIGHT = -20,
    TOPLEFT = 20,
    BOTTOMRIGHT = -20,
    BOTTOMLEFT = 20,
}

local OFFSET_Y = {
    TOPRIGHT = -30,
    TOPLEFT = -30,
    BOTTOMRIGHT = 30,
    BOTTOMLEFT = 30,
}

local SIBLING_OFFSET_Y = {
    TOPRIGHT = -10,
    TOPLEFT = -10,
    BOTTOMRIGHT = 10,
    BOTTOMLEFT = 10,
}

local L_TOAST = "Toast"
local L_TOAST_DESC = "Shows messages in a toast window."

local LOCALE = _G.GetLocale()

if LOCALE == "esMX" or LOCALE == "esES" then
    L_TOAST = "Información emergente"
    L_TOAST_DESC = "Muestra mensajes de información en una ventana emergente"
elseif LOCALE == "frFR" then
    L_TOAST_DESC = "Montrer les messages dans une fenêtre \"toast\"."
elseif LOCALE == "deDE" then
    L_TOAST_DESC = "Zeigt Nachrichten in einem Toast-Fenster"
elseif LOCALE == "itIT" then
    -- Nothing yet.
elseif LOCALE == "koKR" then
    -- Nothing yet.
elseif LOCALE == "ptBR" then
    L_TOAST = "Brinde"
    L_TOAST_DESC = "Mostrar mensagems em uma janela externa"
elseif LOCALE == "ruRU" then
    L_TOAST = "Всплывающее"
    L_TOAST_DESC = "Показывать сообщения во всплывающем окне"
elseif LOCALE == "zhCN" then
    L_TOAST = "弹出窗口"
    L_TOAST_DESC = "在弹出窗口显示信息。"
elseif LOCALE == "zhTW" then
    L_TOAST = "彈出視窗"
    L_TOAST_DESC = "在彈出視窗顯示訊息。"
end

-----------------------------------------------------------------------
-- Settings functions.
-----------------------------------------------------------------------
local function ToastSpawnPoint()
    return _G.Toaster and _G.Toaster:SpawnPoint() or (_G.IsMacClient() and "TOPRIGHT" or "BOTTOMRIGHT")
end

local function ToastTitleColors(urgency)
    if _G.Toaster then
        return _G.Toaster:TitleColors(urgency)
    else
        return DEFAULT_TITLE_COLORS.r, DEFAULT_TITLE_COLORS.g, DEFAULT_TITLE_COLORS.b
    end
end

local function ToastTextColors(urgency)
    if _G.Toaster then
        return _G.Toaster:TextColors(urgency)
    else
        return DEFAULT_TEXT_COLORS.r, DEFAULT_TEXT_COLORS.g, DEFAULT_TEXT_COLORS.b
    end
end

local function ToastBackgroundColors(urgency)
    if _G.Toaster then
        return _G.Toaster:BackgroundColors(urgency)
    else
        return DEFAULT_BACKGROUND_COLORS.r, DEFAULT_BACKGROUND_COLORS.g, DEFAULT_BACKGROUND_COLORS.b
    end
end

local function ToastDuration()
    return _G.Toaster and _G.Toaster:Duration() or DEFAULT_FADE_HOLD_TIME
end

local function ToastOpacity()
    return _G.Toaster and _G.Toaster:Opacity() or 0.75
end

local function ToastHasFloatingIcon()
    return _G.Toaster and _G.Toaster:FloatingIcon()
end

local function ToastsAreSuppressed(source_addon)
    return _G.Toaster and (_G.Toaster:HideToasts() or _G.Toaster:HideToastsFromSource(source_addon))
end

local function ToastsAreMuted(source_addon)
    return _G.Toaster and (_G.Toaster:MuteToasts() or _G.Toaster:MuteToastsFromSource(source_addon))
end

-----------------------------------------------------------------------
-- Helper functions.
-----------------------------------------------------------------------
local function CallingObject()
    return calling_object
end

local function StringValue(input)
    local input_type = _G.type(input)

    if input_type == "function" then
        local output = input()

        if _G.type(output) ~= "string" or output == "" then
            return
        end
        return output
    elseif input_type == "string" then
        return input
    end
end

if not lib.templates[lib.sink_template] then
    lib.templates[lib.sink_template] = function(toast, ...)
        local calling_object = CallingObject()
        toast:SetTitle(StringValue(lib.addon_names[calling_object]))
        toast:SetText(...)
        toast:SetIconTexture(StringValue(lib.sink_icons[calling_object]))
    end
end

local function _positionToastIcon(toast)
    toast.icon:ClearAllPoints()

    if ToastHasFloatingIcon() then
        local lower_point = ToastSpawnPoint():lower()

        if lower_point:find("right") then
            toast.icon:SetPoint("TOPRIGHT", toast, "TOPLEFT", -5, -10)
        elseif lower_point:find("left") then
            toast.icon:SetPoint("TOPLEFT", toast, "TOPRIGHT", 5, -10)
        end
    else
        toast.icon:SetPoint("TOPLEFT", toast, "TOPLEFT", 10, -10)
    end
end

local function _reclaimButton(button)
    button:Hide()
    button:ClearAllPoints()
    button:SetParent(nil)
    button:SetText(nil)
    table.insert(button_heap, button)
end

local function _reclaimToast(toast)
    for button_name in pairs(TOAST_BUTTONS) do
        local button = toast[button_name]

        if button then
            toast[button_name] = nil
            _reclaimButton(button)
        end
    end
    toast.is_persistent = nil
    toast.template_name = nil
    toast.payload = nil
    toast.sound_file = nil
    toast:Hide()

    _G.UIFrameFadeRemoveFrame(toast)
    table.insert(toast_heap, toast)

    local remove_index
    for index = 1, #active_toasts do
        if active_toasts[index] == toast then
            remove_index = index
            break
        end
    end

    if remove_index then
        table.remove(active_toasts, remove_index):ClearAllPoints()
    end
    local spawn_point = ToastSpawnPoint()

    for index = 1, #active_toasts do
        local indexed_toast = active_toasts[index]
        indexed_toast:ClearAllPoints()
        _positionToastIcon(indexed_toast)

        if index == 1 then
            indexed_toast:SetPoint(spawn_point, _G.UIParent, spawn_point, OFFSET_X[spawn_point], OFFSET_Y[spawn_point])
        else
            indexed_toast:SetPoint(spawn_point, active_toasts[index - 1], SIBLING_ANCHORS[spawn_point], 0, SIBLING_OFFSET_Y[spawn_point])
        end
    end
end

local function _finishToastDisplay(toast)
    local fade_info = toast.fade_out_info
    fade_info.fadeTimer = 0
    fade_info.finishedFunc = _reclaimToast
    fade_info.finishedArg1 = toast

    _G.UIFrameFade(toast, fade_info)
end

local function _showDismissButton(frame, motion)
    frame.dismiss_button:Show()
end

local function _hideDismissButton(frame, motion)
    if not frame.dismiss_button:IsMouseOver() then
        frame.dismiss_button:Hide()
    end
end

local function _dismissToast(frame, button, down)
    _reclaimToast(frame:GetParent())
end

local function _acquireToast()
    local toast = table.remove(toast_heap)

    if not toast then
        toast = _G.CreateFrame("Button", nil, _G.UIParent)
        toast:SetFrameStrata("DIALOG")
        toast:Hide()

        local toast_icon = toast:CreateTexture(nil, "BORDER")

        toast_icon:SetSize(DEFAULT_ICON_SIZE, DEFAULT_ICON_SIZE)
        toast.icon = toast_icon

        local title = toast:CreateFontString(nil, "BORDER", "FriendsFont_Normal")
        title:SetJustifyH("LEFT")
        title:SetJustifyV("MIDDLE")
        title:SetWordWrap(true)
        title:SetPoint("TOPLEFT", toast, "TOPLEFT", 44, -10)
        title:SetPoint("RIGHT", toast, "RIGHT", -20, 10)
        toast.title = title

        local focus = _G.CreateFrame("Frame", nil, toast)
        focus:SetAllPoints(toast)
        focus:SetScript("OnEnter", _showDismissButton)
        focus:SetScript("OnLeave", _hideDismissButton)
        focus:SetScript("OnShow", _hideDismissButton)

        local dismiss_button = _G.CreateFrame("Button", nil, toast)
        dismiss_button:SetSize(18, 18)
        dismiss_button:SetPoint("TOPRIGHT", toast, "TOPRIGHT", -4, -4)
        dismiss_button:SetFrameStrata("DIALOG")
        dismiss_button:SetFrameLevel(toast:GetFrameLevel() + 2)
        dismiss_button:SetNormalTexture([[Interface\FriendsFrame\UI-Toast-CloseButton-Up]])
        dismiss_button:SetPushedTexture([[Interface\FriendsFrame\UI-Toast-CloseButton-Down]])
        dismiss_button:SetHighlightTexture([[Interface\FriendsFrame\UI-Toast-CloseButton-Highlight]])
        dismiss_button:Hide()
        dismiss_button:SetScript("OnClick", _dismissToast)

        focus.dismiss_button = dismiss_button

        local text = toast:CreateFontString(nil, "BORDER", "FriendsFont_Normal")
        text:SetJustifyH("LEFT")
        text:SetJustifyV("MIDDLE")
        text:SetWordWrap(true)
        text:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
        toast.text = text

        toast.fade_in_info = {
            timeToFade = DEFAULT_FADE_IN_TIME,
            startAlpha = 0,
            endAlpha = 1,
        }

        toast.fade_out_info = {
            timeToFade = DEFAULT_FADE_OUT_TIME,
            finishedFunc = _reclaimToast,
            finishedArg1 = toast,
            startAlpha = 1,
            endAlpha = 0,
        }
    end
    toast:SetSize(DEFAULT_TOAST_WIDTH, DEFAULT_TOAST_HEIGHT)
    toast:SetBackdrop(DEFAULT_TOAST_BACKDROP)

    if _G.Toaster then
        local icon_size = _G.Toaster:IconSize()
        toast.icon:SetSize(icon_size, icon_size)
    end
    return toast
end

-----------------------------------------------------------------------
-- Library methods.
-----------------------------------------------------------------------
function lib:Register(template_name, constructor, is_unique)
    local is_lib = (self == lib)

    if _G.type(template_name) ~= "string" or template_name == "" then
        error(METHOD_USAGE_FORMAT:format(is_lib and "Register" or "RegisterToast", "template_name must be a non-empty string"), 2)
    end

    if _G.type(constructor) ~= "function" then
        error(METHOD_USAGE_FORMAT:format(is_lib and "Register" or "RegisterToast", "constructor must be a function"), 2)
    end
    lib.templates[template_name] = constructor
    lib.unique_templates[template_name] = is_unique or nil
end

function lib:Spawn(template_name, ...)
    local is_lib = (self == lib)

    if not template_name or (not internal_call and (_G.type(template_name) ~= "string" or template_name == "")) then
        error(METHOD_USAGE_FORMAT:format(is_lib and "Spawn" or "SpawnToast", "template_name must be a non-empty string"), 2)
    end

    if not lib.templates[template_name] then
        error(METHOD_USAGE_FORMAT:format(is_lib and "Spawn" or "SpawnToast", ("\"%s\" does not match a registered template"):format(template_name)), 2)
    end
    local source_addon

    if self == lib then
        source_addon = _G.select(3, ([[\]]):split(_G.debugstack(2)))
    else
        source_addon = lib.addon_names[self] or _G.UNKNOWN
    end

    if ToastsAreSuppressed(source_addon) then
        return
    end

    if lib.unique_templates[template_name] then
        for index = 1, #active_toasts do
            if active_toasts[index].template_name == template_name then
                return
            end
        end
    end
    current_toast = _acquireToast()
    current_toast.template_name = template_name
    current_toast.source = source_addon

    -----------------------------------------------------------------------
    -- Reset defaults.
    -----------------------------------------------------------------------
    current_toast.title:SetText(nil)
    current_toast.text:SetText(nil)
    current_toast.icon:SetTexture(nil)
    current_toast.icon:SetTexCoord(0, 1, 0, 1)

    -----------------------------------------------------------------------
    -- Run constructor.
    -----------------------------------------------------------------------
    calling_object = self
    lib.templates[template_name](toast_proxy, ...)

    if not current_toast.title:GetText() and not current_toast.text:GetText() and not current_toast.icon:GetTexture() then
        _reclaimToast(current_toast)
        return
    end

    -----------------------------------------------------------------------
    -- Finalize layout.
    -----------------------------------------------------------------------
    local urgency = current_toast.urgency_level
    current_toast.title:SetTextColor(ToastTitleColors(urgency))
    current_toast.text:SetTextColor(ToastTextColors(urgency))

    local opacity = ToastOpacity()
    local r, g, b = ToastBackgroundColors(urgency)
    current_toast:SetBackdropColor(r, g, b, opacity)

    r, g, b = current_toast:GetBackdropBorderColor()
    current_toast:SetBackdropBorderColor(r, g, b, opacity)

    local fade_in_info = current_toast.fade_in_info
    fade_in_info.fadeTimer = 0
    fade_in_info.fadeHoldTime = current_toast.is_persistent and 0 or ToastDuration()

    if fade_in_info.fadeHoldTime > 0 then
        fade_in_info.finishedFunc = _finishToastDisplay
        fade_in_info.finishedArg1 = current_toast
    else
        fade_in_info.finishedFunc = nil
        fade_in_info.finishedArg1 = nil
    end
    _positionToastIcon(current_toast)

    if ToastHasFloatingIcon() or not current_toast.icon:GetTexture() then
        current_toast.title:SetPoint("TOPLEFT", current_toast, "TOPLEFT", 10, -10)
    else
        current_toast.title:SetPoint("TOPLEFT", current_toast, "TOPLEFT", current_toast.icon:GetWidth() + 15, -10)
    end

    if current_toast.title:GetText() then
        current_toast.title:SetWidth(current_toast:GetWidth() - current_toast.icon:GetWidth() - 20)
        current_toast.title:Show()
    else
        current_toast.title:Hide()
    end

    if current_toast.text:GetText() then
        current_toast.text:SetWidth(current_toast:GetWidth() - current_toast.icon:GetWidth() - 20)

        current_toast.text:Show()
    else
        current_toast.text:Hide()
    end
    local button_height = (current_toast.primary_button or current_toast.secondary_button or current_toast.tertiary_button) and TOAST_BUTTON_HEIGHT or 0
    current_toast:SetHeight(current_toast.text:GetStringHeight() + current_toast.title:GetStringHeight() + button_height + 25)

    -----------------------------------------------------------------------
    -- Anchor and spawn.
    -----------------------------------------------------------------------
    local spawn_point = ToastSpawnPoint()

    if #active_toasts > 0 then
        current_toast:SetPoint(spawn_point, active_toasts[#active_toasts], SIBLING_ANCHORS[spawn_point], 0, SIBLING_OFFSET_Y[spawn_point])
    else
        current_toast:SetPoint(spawn_point, _G.UIParent, spawn_point, OFFSET_X[spawn_point], OFFSET_Y[spawn_point])
    end
    active_toasts[#active_toasts + 1] = current_toast
    _G.UIFrameFade(current_toast, fade_in_info)

    if current_toast.sound_file and not ToastsAreMuted(source_addon) then
        _G.PlaySoundFile(current_toast.sound_file)
    end
end

function lib:DefineSink(display_name, texture_path)
    local is_lib = (self == lib)
    local path_type = _G.type(texture_path)
    local display_type = _G.type(display_name)

    if texture_path and (path_type ~= "function" and (path_type ~= "string" or texture_path == "")) then
        error(METHOD_USAGE_FORMAT:format(is_lib and "DefineSink" or "DefineSinkToast", "texture_path must be a non-empty string, a function that returns one, or nil"), 2)
    end
    local source_addon = _G.select(3, ([[\]]):split(_G.debugstack(2)))
    lib.addon_objects[display_name] = self

    if display_name and (display_type ~= "function" and (display_type ~= "string" or display_name == "")) then
        error(METHOD_USAGE_FORMAT:format(is_lib and "DefineSink" or "DefineSinkToast", "display_name must be a non-empty string, a function that returns one, or nil"), 2)
    end
    lib.sink_icons[self] = texture_path
    lib.addon_names[self] = display_name

    if not lib.registered_sink then
        local LibSink = LibStub("LibSink-2.0")

        if not LibSink then
            return
        end
        LibSink:RegisterSink("LibToast-1.0", L_TOAST, L_TOAST_DESC, function(source, text, ...)
            internal_call = true
            local func

            if source.SpawnToast then
                func = source.SpawnToast
            else
                source = lib
                func = lib.Spawn
            end
            func(source, lib.sink_template, text)
            internal_call = nil
        end)
        lib.registered_sink = true
    end
end

-----------------------------------------------------------------------
-- Proxy methods.
-----------------------------------------------------------------------
local TOAST_URGENCIES = {
    very_low = true,
    moderate = true,
    normal = true,
    high = true,
    emergency = true,
}

function toast_proxy:SetUrgencyLevel(urgency)
    urgency = urgency:gsub(" ", "_"):lower()

    if not TOAST_URGENCIES[urgency] then
        error(("\"%s\" is not a valid toast urgency level"):format(urgency), 2)
    end
    current_toast.urgency_level = urgency
end

function toast_proxy:UrgencyLevel()
    return current_toast.urgency_level
end

function toast_proxy:SetTitle(title)
    current_toast.title:SetText(title)
end

function toast_proxy:SetFormattedTitle(title, ...)
    current_toast.title:SetFormattedText(title, ...)
end

function toast_proxy:SetText(text)
    current_toast.text:SetText(text)
end

function toast_proxy:SetFormattedText(text, ...)
    current_toast.text:SetFormattedText(text, ...)
end

function toast_proxy:SetIconAtlas(...)
    current_toast.icon:SetAtlas(...)
end

function toast_proxy:SetIconTexture(texture)
    current_toast.icon:SetTexture(texture)
end

function toast_proxy:SetIconTexCoord(...)
    current_toast.icon:SetTexCoord(...)
end

local _initializedToastButton
do
    local BUTTON_NAME_FORMAT = "LibToast_Button%d"
    local button_count = 0

    local function _buttonCallbackHandler(button, mouse_button, is_down)
        button.handler(button.id, mouse_button, is_down, button.toast.payload)
        _reclaimToast(button.toast)
    end

    local function _acquireToastButton(toast)
        local button = table.remove(button_heap)

        if not button then
            button_count = button_count + 1

            button = _G.CreateFrame("Button", BUTTON_NAME_FORMAT:format(button_count), toast, "UIMenuButtonStretchTemplate")
            button:SetHeight(TOAST_BUTTON_HEIGHT)
            button:SetFrameStrata("DIALOG")
            button:SetScript("OnClick", _buttonCallbackHandler)

            local font_string = button:GetFontString()
            font_string:SetJustifyH("CENTER")
            font_string:SetJustifyV("CENTER")
        end
        button:SetParent(toast)
        button:SetFrameLevel(toast:GetFrameLevel() + 2)
        return button
    end

    function _initializedToastButton(button_id, label, handler)
        if not label or not handler then
            error("label and handler are required", 3)
            return
        end
        local button = current_toast[button_id]

        if not button then
            button = _acquireToastButton(current_toast)
            current_toast[button_id] = button
        end
        button.id = button_id:gsub("_button", "")
        button.handler = handler
        button.toast = current_toast

        button:Show()
        button:SetText(label)
        button:SetWidth(button:GetFontString():GetStringWidth() + 15)

        return button
    end
end -- do-block

function toast_proxy:SetPrimaryCallback(label, handler)
    local button = _initializedToastButton("primary_button", label, handler)
    button:SetPoint("BOTTOMLEFT", current_toast, "BOTTOMLEFT", 3, 4)
    button:SetPoint("BOTTOMRIGHT", current_toast, "BOTTOMRIGHT", -3, 4)

    current_toast:SetHeight(current_toast:GetHeight() + button:GetHeight() + 5)

    if button:GetWidth() > current_toast:GetWidth() then
        current_toast:SetWidth(button:GetWidth() + 5)
    end
end

function toast_proxy:SetSecondaryCallback(label, handler)
    if not current_toast.primary_button then
        error("primary button must be defined first", 2)
    end
    current_toast.primary_button:ClearAllPoints()
    current_toast.primary_button:SetPoint("BOTTOMLEFT", current_toast, "BOTTOMLEFT", 3, 4)

    local button = _initializedToastButton("secondary_button", label, handler)
    button:SetPoint("BOTTOMRIGHT", current_toast, "BOTTOMRIGHT", -3, 4)

    if button:GetWidth() + current_toast.primary_button:GetWidth() > current_toast:GetWidth() then
        current_toast:SetWidth(button:GetWidth() + current_toast.primary_button:GetWidth() + 5)
    end
end

function toast_proxy:SetTertiaryCallback(label, handler)
    if not current_toast.primary_button or not current_toast.secondary_button then
        error("primary and secondary buttons must be defined first", 2)
    end
    current_toast.secondary_button:ClearAllPoints()
    current_toast.secondary_button:SetPoint("LEFT", current_toast.primary_button, "RIGHT", 0, 0)

    local button = _initializedToastButton("tertiary_button", label, handler)
    button:SetPoint("LEFT", current_toast.secondary_button, "RIGHT", 0, 0)

    if button:GetWidth() + current_toast.primary_button:GetWidth() + current_toast.secondary_button:GetWidth() > current_toast:GetWidth() then
        current_toast:SetWidth(button:GetWidth() + current_toast.primary_button:GetWidth() + current_toast.secondary_button:GetWidth() + 5)
    end
end

function toast_proxy:SetPayload(...)
    current_toast.payload = { ... }
end

function toast_proxy:Payload()
    return _G.unpack(current_toast.payload)
end

function toast_proxy:MakePersistent()
    current_toast.is_persistent = true
end

function toast_proxy:SetSoundFile(file_path)
    current_toast.sound_file = file_path
end

-----------------------------------------------------------------------
-- Embed handling.
-----------------------------------------------------------------------
lib.embeds = lib.embeds or {}

local mixins = {
    "DefineSink",
    "Register",
    "Spawn",
}

function lib:Embed(target)
    lib.embeds[target] = true

    for index = 1, #mixins do
        local method = mixins[index]
        target[method .. "Toast"] = lib[method]
    end
    return target
end

for addon in pairs(lib.embeds) do
    lib:Embed(addon)
end
