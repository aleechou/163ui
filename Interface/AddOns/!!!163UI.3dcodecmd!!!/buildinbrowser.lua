local base_char,keywords=191,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[SLASH_URL1="/url"
SlashCmdList["URL"]=�(e,t)
�#e<1 �
e="http://www.baidu.com/"
�
Cmd3DCode_CheckoutClientAndPrompt("没有检测到有爱客户端，无法启动有爱内置浏览器")
ThreeDimensionsCode_Send("innerbrowser",e)
�
SLASH_BAIDU1="/baidu"
SLASH_BAIDU2="/百度"
SlashCmdList["BAIDU"]=�(e,t)
Cmd3DCode_CheckoutClientAndPrompt("没有检测到有爱客户端，无法启动有爱内置浏览器")
ThreeDimensionsCode_Send("innerbrowser","http://www.baidu.com/#wd="..e)
�
hooksecurefunc("AutoCompleteEditBox_OnEnterPressed",�()
� e=ChatEdit_ChooseBoxForSend()
� � e:IsVisible()�
�
�
� e=e:GetText()
�)
SLASH_OPEN1="/open"
SlashCmdList["OPEN"]=�(e,t)
Cmd3DCode_CheckoutClientAndPrompt("没有检测到有爱客户端，无法启动有爱内置浏览器")
ThreeDimensionsCode_Send("openurl",e)
�
� e=CreateFrame("Button","BaiduQuest",QuestLogControlPanel,"UIPanelButtonTemplate")
e:SetWidth(100)
e:SetHeight(21)
e:SetText("百度一下")
e:SetPoint("LEFT",QuestLogFrameTrackButton,"RIGHT")
e:SetScript("OnClick",�()
� e=GetQuestLogSelection()
� e<1 �
�
�
Cmd3DCode_CheckoutClientAndPrompt("没有检测到有爱客户端，无法启动有爱内置浏览器")
� e=GetQuestLogTitle(e)
ThreeDimensionsCode_Send("innerbrowser","http://www.baidu.com/#wd=wow任务+"..e)
�)
� e=CreateFrame("Button","BaiduItem",ItemRefTooltip,"UIPanelButtonTemplate")
e:SetText("百度一下")
e:SetWidth(100)
e:SetPoint("BOTTOMRIGHT",ItemRefTooltip,"BOTTOMRIGHT",-10,8)
hooksecurefunc(ItemRefTooltip,"SetHyperlink",�(e)
e:SetHeight(e:GetHeight()+26)
�)
hooksecurefunc(ItemRefTooltip,"Show",�(e)
e:SetHeight(e:GetHeight()+26)
�)
� � o(t)
� t,e � pairs({t:GetRegions()})�
� e:GetObjectType()=="FontString"�
� e:GetText()
�
�
�
e:SetScript("OnClick",�(e)
� e=ItemRefTooltip:GetItem()
� a=""
� e �
a="物品"
�
� t=o(ItemRefTooltip)
� t �
e=t:match("^|T.+|t (.+)$")� t
�
�
Cmd3DCode_CheckoutClientAndPrompt("没有检测到有爱客户端，无法启动有爱内置浏览器")
ThreeDimensionsCode_Send("innerbrowser","http://www.baidu.com/#wd=wow"..a.."+"..e)
�)
hooksecurefunc(GameTooltip,"SetHyperlink",�(e)
e:AddLine("")
e:AddLine("点击链接，可在游戏内置浏览器中")
e:AddLine("打开百度搜索相应内容")
e:AddLine("")
e:Show()
�);
]===], '@../!!!163UI.3dcodecmd!!!/buildinbrowser.lua'))()