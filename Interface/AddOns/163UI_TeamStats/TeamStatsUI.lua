local _, TS = ...
local L = TS.L
TS.FRAME_NAME = "TeamStatsFrame"
local names = {} --当前列表里的玩家名称
local sortType

local MIN_WIDTH = 400

local f = WW:Frame(TS.FRAME_NAME, UIParent, "ButtonFrameTemplate"):TOP(0, -40):Size(728,450):Hide():SetAlpha(0.95):SetMovable(true):SetToplevel(true)
f:SetResizable(true):SetMinResize(MIN_WIDTH,200):SetMaxResize(728,1000):SetClampedToScreen(true)
ButtonFrameTemplate_HidePortrait(f())
CoreUIMakeMovable(f())
table.insert(UISpecialFrames, TS.FRAME_NAME)

f.portrait:SetTexture("Interface\\FriendsFrame\\FriendsFrameScrollIcon");
f.TitleText:SetText(L["TitleText"])

TS.INNER_OFFSETY = -48 --滚动部分相对顶端的距离
TS.INSET_BORDER = {4,3,4,3} --边框是左上4 右下3，scrollbar是16，scroll偏3
TS.COLUMN_BUTTON_HEIGHT = 20

WW(f.Inset):TL(4, TS.INNER_OFFSETY):un() --inset是左上4,-60 右下-6，26


--状态文字,实现简单的...动画 todo: called by non UI.
local animateText = {
    [L["StatusGetting"]] = {},
    [L["StatusCannotGet"]] = {},
}
function TS:SetStatusText(text)
    for k,v in pairs(animateText) do
        if(k==text)then
            v.count=((v.count or 0)+1)%4
            if(v[v.count]) then
                text = v[v.count]
            else
                for i=1,v.count do text=text.."." end
                v[v.count]=text
            end
        end
    end
    f.status = f.status or f:CreateFontString(nil, "ARTWORK", "GameFontHighlight"):BL(8,8):un()
    f.status:SetText(text);
end

---选择副本的时候，显示正确的标题和需要的次数文本
function TS.SetTab(index)
    CoreUIKeepCorner(f, "TOPLEFT")
    f.tabIdx = index

    local tab = TS.TABS[index]

    for i=1, #f.headers do
        local header = f.headers[i]
        if i > TS.NUM_FIX_HEADERS then
            if i > #tab.bosses + TS.NUM_FIX_HEADERS then
                header:Hide()
            else
                header.id = tab.bosses[i-TS.NUM_FIX_HEADERS]
                header:Show()
                header:SetText(tab.idName[header.id])
            end
        else
            header:Show()
        end
    end

    local minWidth
    for i=1, #f.scroll.buttons do
        local btn = f.scroll.buttons[i]
        for j=1,#TS.cols do
            if j > TS.NUM_FIX_COLUMNS + #tab.bosses then
                btn.widgets[j]:Hide()
                btn.widgets[j].statId = nil
            else
                btn.widgets[j]:Show()
                minWidth = btn.widgets[j].right
                btn.widgets[j].statId = TS.mirror[TS.TABS[f.tabIdx].bosses[j-TS.NUM_FIX_COLUMNS]]
            end
        end
    end
    minWidth = minWidth and minWidth + 35
    f:SetMinResize(max(minWidth, MIN_WIDTH), select(2,f:GetMinResize()))
    f:SetMaxResize(max(minWidth, MIN_WIDTH), select(2,f:GetMaxResize()))
    f:SetWidth(max(minWidth, MIN_WIDTH))
    RunOnNextFrame(function() f.scroll.scrollChild:SetWidth(f.scroll:GetWidth()) end) --Point似乎是下一帧才更新的
    f.scroll.update()
end

function TS.CreateButtons(f)
    local btnScan = f:Button("$parentBtn1", "MagicButtonTemplate"):SetSize(80,22):SetText(L["BtnRescanText"])
    btnScan:SetScript("OnClick", function()
        for i=1, #names do
            local player = TS.db.players[names[i]]
            player.inspected = false
            player.gsGot = false
        end
        TS:UIUpdate()
        TS:StartCheckTimer(0.1)
    end)
    CoreUIEnableTooltip(btnScan(), L["BtnRescanTipTitle"], L["BtnRescanTip"])

    local btnLink = f:Button("$parentBtn2", "MagicButtonTemplate"):SetSize(80,22):SetText(L["BtnLinkText"])
    btnLink:SetScript("OnClick", function()
        local t = {}
        local realmName = GetRealmName()
        for i=1,#names do
            table.insert(t, EncodeURL(names[i]:gsub("%-"..realmName, "")))
        end
        f.linkCopyDialog:Show()
        f.linkCopyDialog.eb:SetText("http://product.game.163.com/wowteamstats/stat.jsp?r=".. EncodeURL(realmName).."&gs=1&i=icc25&n="..table.concat(t,","));
        f.linkCopyDialog.eb:HighlightText()
    end)
    CoreUIEnableTooltip(btnLink(),L["BtnLinkTipTitle"],L["BtnLinkTip"]);

    --信息广播
    --[网 易有爱：团员资料插件] TOC(25H) 副本击杀次数 (详情访问w.163.com)
    --打卡 死骑-恢复 GS(6212) 老一(7),老二(11),炮艇(22),小萨(10),烂肠(10),腐脸(10),教授(10),议会(10),女王(10),绿龙(10),冰龙(无),小阿(无),晶红龙(10)
    local annLine = {}
    StaticPopupDialogs["TEAMSTATS_ANN"] = {preferredIndex = 3,
        text = L["BtnAnnPopupText"],
        button1 = TEXT(YES),
        button2 = TEXT(CANCEL),
        OnAccept = function(self)
            local tab = TS.TABS[f.tabIdx]
            SendChatMessage("[网 易 有爱：团员资料插件] 副本："..tab.tab.." 击杀次数 (详情访问w.163.com)", self.data);
            for i=1,#names do
                table.wipe(annLine);
                local player = TS.db.players[names[i]]
                if player and player.selected then
                    tinsert(annLine, "[");
                    tinsert(annLine, player.name);
                    tinsert(annLine, "] ");
                    tinsert(annLine, L[player.class]);
                    local talent = player.inspected and (player.talentId==1 and player.talent1 or player.talent2)
                    tinsert(annLine, talent and "-"..talent:sub(1,6) or " 天赋未知")
                    tinsert(annLine, " ");
                    tinsert(annLine, player.gsGot and "GS("..player.gs..")" or "GS未知")
                    tinsert(annLine, "  ");
                    if(player.compared) then
                        local first=true
                        for j=1,#tab.bosses do
                            local statId = tab.bosses[j];
                            if(not first) then tinsert(annLine, ","); end
                            tinsert(annLine, tab.idName[statId].."("..player.stats[TS.mirror[statId]]..(first and "次)" or ")"));
                            first=false
                        end
                    else
                        tinsert(annLine, "-其他资料尚未得到-");
                    end
                    SendChatMessage(table.concat(annLine, ""), self.data);
                end
            end
        end,
        timeout = 0,
        hideOnEscape = 1,
        whileDead = 1,
        exclusive = 1,
    }
    local btnAnn = f:Button("$parentBtn3", "MagicButtonTemplate"):SetSize(80,22):SetText(L["BtnAnnText"])
    btnAnn:SetScript("OnClick", function(self)
        local count = 0
        for i=1,#names do
            local player = TS.db.players[names[i]]
            if player and player.selected then count=count+1 end
        end
        if(count==0) then message(L["BtnAnnNoSelect"]); return; end
        -- local channel = GetNumRaidMembers()>0 and "RAID" or GetNumPartyMembers()>0 and "PARTY" or "SAY";
        local channel = 'SAY'
        if(IsInGroup()) then
            if(IsInRaid()) then
                channel = 'RAID'
            else
                channel = 'PARTY'
            end
        end
        local channelName = channel=="RAID" and "团队" or channel=="PARTY" and "小队" or "说";
        StaticPopup_Show("TEAMSTATS_ANN", count, channelName, channel);
    end)
    CoreUIEnableTooltip(btnAnn(), L["BtnAnnTipTitle"], L["BtnAnnTip"]);

    CoreUIAnchor(f, "BOTTOMRIGHT", "BOTTOMRIGHT", 0, 0, "RIGHT", "LEFT", 0, 0, btnScan, btnAnn);
    btnScan:On("Load"):un()
    btnLink:On("Load"):un()
    btnAnn:On("Load"):un()

    local drop = f:Button('$parentDropdown', 'UIDropDownMenuTemplate', 'dropmenu'):TOPLEFT(-10, -22)

    local info = {}
    local function drop_select(f)
        TS.SetTab(f.value)
        UIDropDownMenu_SetSelectedValue(f.owner, f.value)
    end

    UIDropDownMenu_Initialize(drop(), function(frame, level)
        info.isNotRadio = true
        info.owner = frame
        info.func = drop_select

        for i, v in ipairs(TS.TABS) do
            info.text = v.tab
            info.value = i
            info.checked = nil
            UIDropDownMenu_AddButton(info)
        end
    end)
    UIDropDownMenu_SetSelectedValue(drop(), f().tabIdx or 1)

    local btnPrev = f:Button('$parentBtnPrev', nil, 'btnPrev')
    :SetSize(32, 32)
    :SetNormalTexture[[Interface\Buttons\UI-SpellbookIcon-PrevPage-Up]]
    :SetPushedTexture[[Interface\Buttons\UI-SpellbookIcon-PrevPage-Down]]
    :SetDisabledTexture[[Interface\Buttons\UI-SpellbookIcon-PrevPage-Disabled]]
    :SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]], "ADD")

    local btnNext = f:Button('$parentBtnNext', nil, 'btnNext')
    :SetSize(32, 32)
    :SetNormalTexture[[Interface\Buttons\UI-SpellbookIcon-NextPage-Up]]
    :SetPushedTexture[[Interface\Buttons\UI-SpellbookIcon-NextPage-Down]]
    :SetDisabledTexture[[Interface\Buttons\UI-SpellbookIcon-NextPage-Disabled]]
    :SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]], "ADD")

    btnNext.dir = 1
    btnPrev.dir = -1

    local dropbtn = drop()
    btnPrev():SetPoint('TOPLEFT', dropbtn, 'TOPRIGHT', 115, 2)
    btnNext():SetPoint('TOPLEFT', btnPrev(), 'TOPRIGHT', 0, 0)

    local on_click = function(btn)
        local min, max = 1, #TS.TABS
        local cur = f.tabIdx

        local next = cur + btn.dir
        if(next < min) then
            next = max
        elseif(next > max) then
            next = min
        end

        TS.SetTab(next)
        UIDropDownMenu_SetSelectedValue(dropbtn, next)
        UIDropDownMenu_SetText(dropbtn, TS.TABS[next].tab)
    end

    btnNext:SetScript('OnClick', on_click)
    btnPrev:SetScript('OnClick', on_click)

    --- 创建顶部按钮
    --for i=1, #TS.TABS do
    --    local btn = TplPanelButton(f, "$parentTAB"..i, 22):SetText(TS.TABS[i].tab):AutoWidth()
    --    btn.tabIdx = i
    --    if i==1 then
    --        btn:TOPLEFT(5,-25)
    --    else
    --        btn:LEFT("$parentTAB"..(i-1), "RIGHT", 5)
    --    end
    --    btn:SetScript("OnClick", function(self)
    --        CoreUIKeepCorner(f, "TOPLEFT")
    --        TS.SetTab(self.tabIdx)
    --    end)
    --    btn = btn:un()
    --end
end

--[[------------------------------------------------------------
创建列及标题按钮
---------------------------------------------------------------]]
local BossCountTextCreator = function(col,btn,idx)
    local text = btn:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"):SetWordWrap(false):Size(col.width,20)
    --btn:CreateTexture():SetTexture(1,1,1,0.5):TL(text):BR(text)
    return text
end
local BossCountTextUpdater = function(line, widget, idx, colIdx)
    local player = line.player
    local stats = player.stats
    local stats = stats and stats[widget.statId] or 0
    local r,g,b
    if not player.compared then
        stats,r,g,b = "?",0.5,0.5,0.5
    else
        if stats==0 then
            stats,r,g,b = "-",1,0.2,0.2
        elseif stats==1 then
            r,g,b = 1,0.5,0
        else
            r,g,b= 1,1,1
        end
    end
    widget:SetText(stats)
    widget:SetTextColor(r,g,b)
end

local sortFuncs = {
    [2] = function(a,b) local p1,p2=TS.db.players[a].name,TS.db.players[b].name; if f.scroll.currSort==2 then return p1<p2 else return p1>p2 end end,
    [3] = function(a,b)
        local p1,p2=TS.db.players[a],TS.db.players[b];
        if p1.class==p2.class then
            p1=p1.talentId==1 and p1.talent1 or p1.talent2 or ""
            p2=p2.talentId==1 and p2.talent1 or p2.talent2 or ""
            return p1<p2
        else
            return p1.class>p2.class
        end
    end,
    [4] = function(a,b) local p1,p2=TS.db.players[a].gs or 0,TS.db.players[b].gs or 0; if f.scroll.currSort==4 then return p1<p2 else return p1>p2 end end,
}

local function sortNames(self)
    local id = self.id
    if sortFuncs[id] then
        table.sort(names, sortFuncs[id])
        f.scroll.currSort = (f.scroll.currSort~=id and id or nil)
        f.scroll.update()
    end
end

function TS.SetupColumns(f)
    local targetBtnOnEnter = function(self) self.line:LockHighlight() end
    local targetBtnOnLeave = function(self) self.line:UnlockHighlight() end
    TS.cols = {
        {
            --复选框
            header = function(btn, col)
                local cb = WW(btn):CheckButton(nil, "UICheckButtonTemplate"):Size(24,24):BL(0,-3):un()
                CoreUIEnableTooltip(cb, "全选/取消全选", "选择玩家用于发布通告")
                cb:SetScript("OnClick", function(self)
                    local state = self:GetChecked();
                    for i=1,#names do
                        if TS.db.players[names[i]] then
                            TS.db.players[names[i]].selected = state;
                        end
                    end
                    f.scroll.update();
                end)
            end,
            headerSpan = 1,
            width = 20,
            offset = {1,-2}, --相对左侧的距离, 默认是{1,0}
            --初次创建时调用
            create = function(col,b,idx)
                TS.UIPlayerSelected = TS.UIPlayerSelected or function(self) self:GetParent().player.selected = self:GetChecked() end
                return b:CheckButton(nil, "UICheckButtonTemplate"):Size(col.width,20):SetScript("OnClick", TS.UIPlayerSelected);
            end,
            --布局发生变化时调用，比如SetTab，ReSize等
            layout = function(parent) end,
            --滚动更新时调用
            update = function(line, widget, idx, colIdx)
                widget:SetChecked(not not line.player.selected);
            end,
        },
        {
            header = L["HeaderPlayerName"],
            headerSpan = 1,
            width = 100,
            create = function(col,btn,idx) return btn:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"):SetJustifyH("CENTER"):Size(col.width, 24) end,
            update = function(line, widget, idx, colIdx)
                if(not InCombatLockdown())then
                    local target = line.target
                    if not target then
                        target = CreateFrame("Button", nil, UIParent, "SecureActionButtonTemplate")
                        target.line = line
                        target:SetAttribute("type", "macro")
                        target:SetFrameStrata("HIGH")
                        line.target = target
                        target:SetScript("OnEnter", targetBtnOnEnter)
                        target:SetScript("OnLeave", targetBtnOnLeave)
                    end
                    local target = line.target
                    target:ClearAllPoints()
                    target:SetParent(line)
                    target:SetPoint("TOPLEFT", line, "TOPLEFT", TS.cols[1].width+2, 0)
                    target:SetPoint("BOTTOMRIGHT", line, 0, 0)
                    if line.player.name then
                        target:SetAttribute("macrotext", "/target "..line.player.name)
                    end
                    target:Show();
                end
                CoreUISetTextWithClassColor(widget, line.player.name, line.player.class)
            end
        },
        {
            --职业
            width = 16,
            header = L["HeaderClass"],
            headerSpan = 2,
            offset = {3,-2},
            create = function(col,btn,idx) return btn:Texture(nil, "ARTWORK", "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"):Size(16, 16) end,
            update = function(line, widget, idx, colIdx) local icon=CLASS_ICON_TCOORDS[line.player.class] if icon then widget:SetTexCoord(unpack(icon)) end end,
        },
        {
            --天赋文字
            width = 45,
            create = function(col,btn,idx) return btn:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"):SetJustifyH("CENTER"):Size(col.width, 24) end,
            update = function(line, widget, idx, colIdx)
                local player = line.player
                local talent = player.talentId==1 and player.talent1 or player.talent2
                --widget:SetText(talent and talent:sub(1,6) or "无")
                CoreUISetTextWithClassColor(widget, talent and talent:sub(1,6) or (player.inspected and "无" or "?"), line.player.class)
                if not player.inspected then widget:SetTextColor(0.5,0.5,0.5,1) end
            end,
        },
        {
            header = L["HeaderGS"],
            headerSpan = 1,
            width = 54,
            tip = "身上当前装备的平均物品等级",
            create = function(col,btn,idx) return btn:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"):SetJustifyH("CENTER"):Size(col.width, 24) end,
            update = function(line, widget, idx, colIdx)
                local player = line.player
                widget:SetText(player.gs and format("%s%.1f", (player.bad and "|cffffd200*|r" or ""), player.gs) or "?")
                local r, b, g = U1GetInventoryLevelColor(player.gs)
                if not player.gsGot then widget:SetTextColor(0.5,0.5,0.5,1) else widget:SetTextColor(r,b,g) end
            end
        },
        {
            header = ITEM_MOD_RESILIENCE_RATING_SHORT,
            headerSpan = 1,
            width = 54,
            tip = "身上装备的韧性等级总和\n可用来区分PVP和PVE装备",
            create = function(col,btn,idx) return btn:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"):SetJustifyH("CENTER"):Size(col.width, 24) end,
            update = function(line, widget, idx, colIdx)
                local player = line.player
                widget:SetText(player.re or "?")
                if not player.gsGot or not player.re then widget:SetTextColor(0.5,0.5,0.5) else widget:SetTextColor(1,1,1) end
            end
        },
        {
            header = "珠宝附魔",
            headerSpan = 1,
            width = 100,
            tip = "已插宝石数/总宝石孔数 顶级宝石数/高级宝石数/其他宝石数\n \n已附魔装备数/总附魔装备数 缺失部位\n\n腰带打孔算一个附魔",
            create = function(col,btn,idx) return btn:CreateFontString(nil, "ARTWORK", "GameFontWhiteSmall"):SetJustifyH("CENTER"):Size(col.width, 30) end,
            update = function(line, widget, idx, colIdx)
                local player = line.player
                if (player.gem_info and player.total_enchant and player.has_enchant) then
                    widget:SetText(player.gem_info.."\n"..format((player.has_enchant == player.total_enchant and "%d" or "|cffff5555%d|r").."/%d |cffff5555%s|r", player.has_enchant, player.total_enchant, player.missing_enchant))
                else
                    widget:SetText("?")
                end
                if not player.gsGot then widget:SetTextColor(0.5,0.5,0.5) else widget:SetTextColor(1,1,1) end
            end
        },
    }

    TS.NUM_FIX_COLUMNS = #TS.cols

    --根据最大boss数量创建按钮
    local MAX_INFOS = 0 for _, v in next, TS.TABS do MAX_INFOS = max(MAX_INFOS, #v.bosses) end
    for i=1, MAX_INFOS do table.insert(TS.cols, { width = 52, header = true, create = BossCountTextCreator, update = BossCountTextUpdater, }) end
    local defaultOffset = {1,0} for i, col in ipairs(TS.cols) do if not col.offset then col.offset=defaultOffset end end

    --创建表头
    f.headers={}
    local tooltipFunc = function(self)
        local _,name = GetAchievementInfo(self.id)
        WW(GameTooltip):SetOwner(self):AddLine(self:GetText()):AddLine(name):Show():un()
    end
    local TAB_OFFSET = -1 --标签左侧距离上一个标签右侧的值
    local left = 2
    for i, col in ipairs(TS.cols) do
        --计算出固定的表头数
        if i>TS.NUM_FIX_COLUMNS and not TS.NUM_FIX_HEADERS then TS.NUM_FIX_HEADERS=#f.headers end

        if col.header then
            local id = #f.headers+1
            local btn = TplColumnButton(f, nil, TS.COLUMN_BUTTON_HEIGHT):SetScript("OnClick", sortNames):un()
            btn.id = id
            table.insert(f.headers, btn)
            --一个表头可以跨多个元素, 要计算其宽度
            local width = 0
            for j=1,col.headerSpan or 1 do
                local includeCol = TS.cols[i+j-1]
                width = width + includeCol.width + includeCol.offset[1]
                --includeCol.headerIdx = #f.cols
            end
            --todo: 这里需要考虑最左侧没有的情况
            WW(btn):BL("$parentInset","TL", left, 1-22):un()
            if type(col.header)=="string" then
                btn:SetText(col.header) --是字符串则设置上不动了
            elseif type(col.header)=="function" then
                col.header(btn, col)
            end
            btn.width = width - TAB_OFFSET --跨多个表头只减去一次

            btn:SetWidth(btn.width)

            if i > TS.NUM_FIX_COLUMNS then
                CoreUIEnableTooltip(btn, nil, tooltipFunc)
            elseif col.tip then
                CoreUIEnableTooltip(btn, type(col.header)=="string" and col.header or "说明", col.tip)
            end
        end
        left = left+col.offset[1]+col.width
    end
end

--[[------------------------------------------------------------
创建滚动区域
---------------------------------------------------------------]]
function TS.CreateScroll(f)
    local BUTTON_HEIGHT = 24 --滚动行的高度
    local SCROLLBAR_WIDTH = 16
    local SCROLLBAR_OFFX = 3

    local scroll = CoreUICreateHybridStep1(nil, f(), nil, nil, true)
    WW(scroll):Key("scroll"):TL("$parentInset", TS.INSET_BORDER[1], -TS.INSET_BORDER[3]-TS.COLUMN_BUTTON_HEIGHT):BR("$parentInset", -TS.INSET_BORDER[2]-SCROLLBAR_WIDTH-SCROLLBAR_OFFX, TS.INSET_BORDER[4]):un()
    scroll.scrollBar.doNotHide = true;

    scroll.creator = function(self, index, name)
        local button = WW:Button(name, self.scrollChild):SetHeight(BUTTON_HEIGHT):LEFT():RIGHT()
        :Texture(nil, "BACKGROUND", "Interface\\GuildFrame\\GuildFrame"):SetParentKey("stripe"):ALL():up()
        :Texture(nil, nil, "Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar"):ToTexture("Highlight", "ADD"):ALL():up()
        button:SetID(index)

        button.widgets = {}
        local left = 0
        for idx, col in ipairs(TS.cols) do
            left = left + col.offset[1]
            local widget = col:create(button, idx)
            --第一个的offset是相对边框左边的
            widget:LEFT(button, left, col.offset[2])
            left = left + col.width
            widget.right = left
            widget.index = idx
            button.widgets[idx] = widget:un()
        end

        return button:un()
    end

    scroll.getNumFunc = function() return #names end

    scroll.updateFunc = function(self, btn, id)
        --print("updateFunc")
        btn.player = TS.db.players[names[id]]
        for j=1, #TS.cols do
            local col = TS.cols[j]
            if col.update then
                col.update(btn, btn.widgets[j], id, j)
            end
        end
        if ( mod(id, 2) == 0 ) then
            btn.stripe:SetTexCoord(0.36230469, 0.38183594, 0.95898438, 0.99804688);
        else
            btn.stripe:SetTexCoord(0.51660156, 0.53613281, 0.88281250, 0.92187500);
        end
    end

    CoreUICreateHybridStep2(scroll, 0, 0, "TOPLEFT", "TOPLEFT", -1)
    f:SetScript("OnSizeChanged", CoreUICreateHybridButtonsOnSizeChanged)
end

function TS:UIUpdateNames()
    table.wipe(names)
    for name, _ in pairs(TS.names) do
        table.insert(names, name)
    end
    --table.sort(names, sortType)
    if f():IsVisible() then
        f.scroll.update()
    end
end

function TS:UIUpdate()
    if f():IsVisible() then
        f.scroll.update()
    else
        UICoreFrameFlash(LibDBIcon10_TeamStats.icon, 0.5 , 0.5, -1, 1, 0, 0)
    end
end

function TeamStatsUI_CreateMinimapButton()
    local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("163UI_TeamStats", {
        type = "launcher",
        label = "团队信息统计",
        icon = "Interface\\Icons\\Spell_Deathknight_UnholyPresence",
        iconCoords = {0.08, 0.92, 0.08, 0.92},
        OnClick = function(self, button) CoreUIShowOrHide(TeamStatsFrame, not TeamStatsFrame:IsVisible()) end,
    })
    U1DB.minimapPos = U1DB.minimapPos or 154
    LibStub("LibDBIcon-1.0"):Register("TeamStats", ldb, TeamStatsDB);
    CoreUIEnableTooltip(LibDBIcon10_TeamStats, L["MiniTipTitle"], L["MiniTip"]);
    TeamStatsUI_CreateMinimapButton = nil
end

function TeamStatsUI_CreateLinkCopyDialog(main)
    local dialog = main:Frame("$parentLinkCopyDialog", "BasicFrameTemplate", "linkCopyDialog"):CENTER():SetSize(300,80):SetFrameStrata("DIALOG"):Hide()
    dialog:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall"):SetText(L["CopyDialogTitleText"]):TL(10,-30);
    local dialogBox = dialog:EditBox(nil, "InputBoxTemplate", "eb"):BOTTOMLEFT(10,5):RIGHT(-10,0):SetHeight(20)
    dialogBox:SetScript("OnEscapePressed", function(self) self:GetParent():Hide() end)
    dialog.TitleText:SetText(L["BtnLinkText"])
end

function TeamStatsUI_CreateInfoDialog(main)
    local name;
    local d = CoreUICreateDialog(name,main,300,200):CENTER():Hide();
    d.title:SetText("友情提示");
    d.content = d:CreateFontString(nil,"ARTWORK","GameFontNormalSmall"):TL(20,-30):BR(-20,0):SetJustifyV("TOP"):SetJustifyH("LEFT"):un()
    d.content:SetText("　为了不影响正常游戏，插件每5秒最多获取一个玩家的成就数据，而且该玩家必须在视野范围内。不过我们提供了网页查询的方式，直接读取英雄榜。立即显示，无需等待！敬请点击下方的'网页查询'按钮。");
    local cb = TplCheckButton(d):Size(26):BL(20,15):un();
    cb.text:SetText("不再提示");
    cb.func = function(self)
        TS.db.noRemind = self:GetChecked();
    end
    cb.tooltipText="勾选此项将不再出现本提示"
    local close = d:Button(nil, "UIPanelButtonTemplate"):SetText("我知道了"):Size(80,26):BR(-20,15):un()
    close:SetScript("OnClick", function(self) self:GetParent():Hide() end);

    --屏蔽
    local mask = d:Frame("MASK"):EnableMouse(true):TL(f,0,0):BR(f,0,0):SetFrameLevel(0)
    mask:CreateTexture():SetTexture(0,0,0,0.5):TL():BR():up():un();

    main.infoDialog = d;
    return d;
end

function TeamStatsUI_INIT()
    --TeamStatsUI_CreateInfoDialog(f);
    TS.CreateButtons(f)
    TS.SetupColumns(f)
    TS.CreateScroll(f)
    TeamStatsUI_CreateLinkCopyDialog(f);
    --TeamStatsUI_CreateMinimapButton(); --must after var
    CoreUICreateResizeButton(f(),"BOTTOMRIGHT","BOTTOMRIGHT", 0, 0)
    CoreUIRegisterSlash("TeamStats", "/ts", "/teamstats", function() TeamStatsFrame:Show() end);

    TS.CreateButtons = nil
    TS.SetupColumns = nil
    TS.CreateScroll = nil
    TeamStatsUI_CreateInfoDialog = nil
    TeamStatsUI_CreateLinkCopyDialog = nil
    --TeamStatsUI_CreateMinimapButton = nil

    f:SetScript("OnShow", function(self)
        if(self.infoDialog and not TS.db.noRemind) then
            self.infoDialog:Show();
        end
        LibDBIcon10_TeamStats.icon.showWhenDone = 1
        UICoreFrameFlashStop(LibDBIcon10_TeamStats.icon)
        TS.SetTab(self.tabIdx or 1)
        self.scroll.update()
    end)

    local hideTargetButtons = function()
        if InCombatLockdown() then return end
        for _, line in next, f.scroll.buttons do
            if line.target then
                line.target:SetParent(nil)
                line.target:ClearAllPoints()
                line.target:Hide()
            end
        end
    end
    local ef = CoreOnEvent("PLAYER_REGEN_ENABLED", function() if f:IsVisible() then f.scroll.update() end end, true)
    CoreOnEvent("PLAYER_REGEN_DISABLED", hideTargetButtons, ef)
    f:SetScript("OnHide", hideTargetButtons)
end

TeamStatsUI_INIT()
