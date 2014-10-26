U1_CHAT_WORLD_CHANNEL = "大脚世界频道";
U1RegisterAddon("163UI_Chat", {
    title = "聊天增强",
    defaultEnable = 1,
    desc = "和聊天框相关的小插件，提供聊天框缩放、鼠标滚轮增强、TAB切换频道、点击时间标记复制文本等功能，详情参见设置页面。` `此外还整合了'自动查询密语详情'及'智能切换声望条'的功能。",

    tags = { TAG_CHAT, TAG_DEV },

    --icon = [[Interface\Icons\Achievement_WorldEvent_ChildrensWeek]],
    author = "|cffcd1a1c[网易原创]|r",
    icon = [[Interface\Icons\Spell_Holy_HolyGuidance]],
    ------- Options --------
    {
        var="worldchannel",
        default = 1,
        text="加入世界频道",
        callback = function(cfg, v, loading)
            if v then
                JoinChannelByName(U1_CHAT_WORLD_CHANNEL)
            else
                LeaveChannelByName(U1_CHAT_WORLD_CHANNEL)
            end
        end,
    },

    {
        var="wwm",
        default = 1,
        text="自动查询密我的人是谁",
        callback = function(cfg, v, loading)
            WhoWhisperedMeCmds(v and "ON" or "OFF");
        end,
        {
            text="列出密我的所有人",
            tip="说明`可以点击回复哦`命令行：/wwm",
            callback = function() WhoWhisperedMeCmds("stats") end,
        }
    },
    {
        var = "whispersticky",
        default = false,
        type = "checkbox",
        text = "保持上次密语对象",
        tip = "说明`按回车时显示的是最近一次密语的人，容易密错人，请注意哦。",
        callback = function(cfg, v, loading)
            ChatTypeInfo["WHISPER"].sticky = v and 1 or 0;
            ChatTypeInfo["BN_WHISPER"].sticky = v and 1 or 0;
            if not v then
                WithAllChatFrame(function(cf)
                    local ctype = cf.editBox:GetAttribute("chatType")
                    if ctype=="WHISPER" or ctype=="BN_WHISPER" then
                        cf.editBox:SetAttribute("chatType", "SAY")
                    end
                    local stype = cf.editBox:GetAttribute("stickyType")
                    if stype=="WHISPER" or stype=="BN_WHISPER" then
                        cf.editBox:SetAttribute("stickyType", "SAY")
                    end
                end)
            end
        end,
    },
    {
        var = "resize2",
        default = 1,
        type = "checkbox",
        text = "启用左上角缩放按钮",
        callback = function(cfg, v, loading)
            if v then
                WithAllChatFrame(function(chatFrame) if(chatFrame.resizeButton:IsVisible()) then chatFrame.resizeButton2:Show() end end)
            else
                WithAllChatFrame(function(chatFrame) chatFrame.resizeButton2:Hide() end)
            end
            togglehook(nil, "U1Chat_ChatFrameResizeOnShow", noop, not v);
        end,
    },
    {
        var = "wheel",
        default = 1,
        type = "checkbox",
        text = "启用鼠标滚轮增强功能",
        tip = "说明`启用本功能后，按住ctrl然后滚动鼠标滚轮可以一次翻一页，按住shift然后滚动则可以翻到第一行或最末行。",
        callback = function(cfg, v, loading)
            togglehook(nil, "U1Chat_ChatFrame_OnMouseWheel", noop, not v);
        end,
    },
    {
        var = "editontop",
        default = false,
        type = "checkbox",
        text = "输入框位于窗口顶部",
        callback = function(cfg, v, loading)

            local offset = U1CfgFindChild(cfg, "offset")
            offset = U1LoadDBValue(offset) or 0
            
            for i=1, 10 do
                local editBox = _G["ChatFrame"..i.."EditBox"]
                local _, rel, _, x = editBox:GetPoint()
                if editBox then

                    if v then
                        editBox:ClearAllPoints()
                        editBox:SetPoint("BOTTOMLEFT", rel, "TOPLEFT", x, 20+offset)
                        editBox:SetPoint("BOTTOMRIGHT", rel, "TOPRIGHT", x, 20+offset)

                    elseif not loading then
                        editBox:ClearAllPoints()
                        editBox:SetPoint("TOPLEFT", rel, "BOTTOMLEFT", x, -2)
                        editBox:SetPoint("TOPRIGHT", rel, "BOTTOMRIGHT", x, -2)
                    end
                end
            end

            if v then
                -- 如果聊天窗口在顶部，挪开密语按钮
                if WhisperPopTipFrame and WhisperPopTipFrame:IsVisible() then
                    local p,r,rp,x,y = WhisperPopTipFrame:GetPoint()
                    if p=="BOTTOM" and r==FriendsMicroButton and y<30 and x<300 then
                        WhisperPopTipFrame:SetPoint("BOTTOM",FriendsMicroButton,"TOP",x,24)
                    end
                end
            end
        end,
        {
            var = "offset",
            default = 10,
            type= "spin",
            range = {-100, 100, 10},
            text = "位置偏移量",
            tip = "说明`向上为正，向下为负数，默认0是在聊天标签上沿。",
            callback = function(cfg, v, loading)
                if not loading then U1CfgCallBack(cfg._parent, nil, loading); end
            end,
        }
    },
    {
        var = "format",
        default = "%H:%M:%S",
        type = "drop",
        text = "聊天信息时间标签格式",
        tip = "说明`虽然暴雪也提供了同样的功能，但它没有颜色区分。而且可以点击我们添加的时间标签复制这一行聊天文本。",
        options = {"无", nil, "分:秒", "%M:%S", "时:分", "%H:%M", "时分秒", "%H:%M:%S"},
        cols = 2,
        callback = function(cfg, v, loading)
            if v then
                local old = GetCVar("showTimestamps");
                if old ~= "none" then U1DB.showTimestamps = old end
                SetCVar("showTimestamps", "none");
            else
                if U1DB.showTimestamps then
                    SetCVar("showTimestamps", U1DB.showTimestamps)
                    U1DB.showTimestamps = nil;
                end
            end
            if(v == '无' or v == '') then
                U1Chat_TimeStampFormat = nil
            else
                U1Chat_TimeStampFormat = v
            end
        end,
    },
    {
        var = "maxLines",
        default = 0,
        type = "spin",
        range = {0, 5000, 500,},
        text = "设置聊天框的记录行数",
        tip = "温馨提示`设置为0则使用默认值。`因为设置记录行数会清除当前信息, 所以修改将在下次进入游戏时生效。` `不过可用插件功能清除当前窗口信息立即生效。",
        cols = 4,
        getvalue = function() return CoreGetParaParam("Gamma", 17, 4) end,
        callback = function(cfg, v, loading)
            CoreSetParaParam("Gamma", v, 17, 4);
        end,
    },
    {
        type="button",
        id="clean",
        text="清除当前窗口",
        tip="温馨提示`请先点一下要清除窗口的标签，然后再点击此按钮",
        callback = function(cfg, v, loading)
            if SELECTED_CHAT_FRAME then
                StaticPopup_Show("163UI_CHAT_CLEAR", _G[SELECTED_CHAT_FRAME:GetName().."Tab"]:GetText());
            else
                U1Message("请先点击标签选择一个聊天框");
            end
        end,
    },
    {
        var="customtab",
        default = 1,
        text="启用TAB智能切换对话模式",
        tip="说明`按TAB键可以在说/公会/小队/团队/战场等对话模式下切换，小提示：按住SHIFT再按TAB可以向前翻。",
        callback = function(cfg, v, loading)
            togglehook(nil, "ChatEdit_CustomTabPressed_Inner", noop, not v);
        end,
        {
            var="tabchannel",
            text="是否在通用频道之间切换",
            tip="说明`循环时包含'综合','交易'等通用频道。",
        },
    },
    {
        var = 'chatColorNamesByClass',
        default = false,
        text = "聊天框名字使用职业颜色",
        tip = '说明`选中后将自动启用所有频道和玩家信息的[使用职业颜色]选项, 关闭时不会自动禁用这些选项',
        callback = function(cfg, v, loading)
            U1_Chat_EnableChatColorNamesByClassGroup(v)
        end,
    },
});
