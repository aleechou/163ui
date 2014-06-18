local base_char,keywords=191,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� o=...
Cmd3DCode_ShottingMaskFrame:SetPoint("TOPLEFT",0,0)
Cmd3DCode_ShottingMaskFrame:SetFrameStrata("TOOLTIP")
Cmd3DCode_ShottingMaskFrame:SetFrameLevel(125)
Cmd3DCode_ShottingMaskFrame:SetWidth(UIParent:GetWidth())
Cmd3DCode_ShottingMaskFrame:SetHeight(UIParent:GetHeight())
� � e(t)
� t=_G["Cmd3DCode_ShottingMaskFrame"..t]
t.texture=t:CreateTexture(�,"BACKGROUND")
t.texture:SetTexture(.1,.1,.1,.5)
t.texture:SetAllPoints(t)
� t
�
e("TOPLEFT")
e("TOP")
e("TOPRIGHT")
e("LEFT")
e("RIGHT")
e("BOTTOMLEFT")
e("BOTTOM")
e("BOTTOMRIGHT")
� Cmd3DCode_UpdateViewFinderFrames()
� d=UIParent:GetWidth()
� r=UIParent:GetHeight()
� t,e,a,o=Cmd3DCode_ViewFinderFrame:GetRect()
� � t � � e � � a � � e �
�
�
� h=d-t-a
� s=r-e-o
� n=t+a
� i=e+o
Cmd3DCode_ShottingMaskFrame:SetWidth(d)
Cmd3DCode_ShottingMaskFrame:SetHeight(r)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetHeight(s)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,i)
Cmd3DCode_ShottingMaskFrameTOP:SetWidth(a)
Cmd3DCode_ShottingMaskFrameTOP:SetHeight(s)
Cmd3DCode_ShottingMaskFrameTOP:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",t,i)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetWidth(h)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetHeight(s)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",n,i)
Cmd3DCode_ShottingMaskFrameLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameLEFT:SetHeight(o)
Cmd3DCode_ShottingMaskFrameLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,e)
Cmd3DCode_ShottingMaskFrameRIGHT:SetWidth(h)
Cmd3DCode_ShottingMaskFrameRIGHT:SetHeight(o)
Cmd3DCode_ShottingMaskFrameRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",n,e)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,0)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetWidth(a)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",t,0)
Cmd3DCode_ShottingMaskFrameBOTTOMRIGHT:SetWidth(h)
Cmd3DCode_ShottingMaskFrameBOTTOMRIGHT:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOMRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",n,0)
�
Cmd3DCode_ViewFinderFrame:SetPoint("CENTER",Cmd3DCode_ShottingMaskFrame,"CENTER",0,0)
Cmd3DCode_ViewFinderFrame:SetBackdrop({
edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
edgeSize=10,
insets={left=0,right=0,top=0,bottom=0}
});
Cmd3DCode_ViewFinderFrame:SetBackdropBorderColor(1,1,1)
Cmd3DCode_ViewFinderFrame:RegisterForDrag("LeftButton","RightButton");
Cmd3DCode_ViewFinderFrame:EnableMouse(�)
Cmd3DCode_ViewFinderFrame:SetMovable(�)
Cmd3DCode_ViewFinderFrame:SetResizable(�)
Cmd3DCode_ViewFinderFrame:SetClampedToScreen(�)
� Cmd3DCode_Screenshot_Start()
Cmd3DCode_ViewFinderFrame:SetWidth(400)
Cmd3DCode_ViewFinderFrame:SetHeight(300)
Cmd3DCode_ViewFinderFrame:SetPoint("CENTER",Cmd3DCode_ShottingMaskFrame,"CENTER",0,0)
Cmd3DCode_UpdateViewFinderFrames()
Cmd3DCode_ShottingMaskFrame:Show()
�
� � a(e,t)
e=e*t
� a,e=math.modf(e,1)
e=e>=.5 � 1 � 0
�(a+e)/t
�
� e=1
Cmd3DCode_Screenshot_ExternalPictures={}
Cmd3DCode_Screenshot_ExternalPicture_Receives={}
� t=UIParent:CreateTexture(�,"BACKGROUND")
t:SetPoint("CENTER",UIParent,"CENTER",0,0)
t:Show()
� � h(t)
� t={
texture="Interface\\AddOns\\"..o.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
loaded=�,
uploaded=�,
idx=e,
time=t,
title=date("截图 %H:%M:%S",t),
}
Cmd3DCode_Screenshot_ExternalPictures[e]=t
e=e+1
� e>512 �
e=1
�
� t
�
� � c(t,i,a)
� a={
texture="Interface\\AddOns\\"..o.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
downloaded=�,
idx=e,
picid=t,
channel=i,
from=a,
}
Cmd3DCode_Screenshot_ExternalPicture_Receives[t]=a
e=e+1
� e>512 �
e=1
�
� a
�
� � i(t,a,e)
� o=a/e
� t=t.width/t.height
� t>o �
� a,a/t
�
� e*t,e
�
�
� Cmd3DCode_Screenshot_ExternalPictures_Thumb(s)
� e=Cmd3DCode_Screenshot_ExternalPictures[s]
� � e �
�
�
� a,n=160,120
� e.loaded �
a,n=i(e,a,n)
t:SetTexture(e.texture)
�
t:SetTexture("Interface\\AddOns\\"..o.."\\Textures\\external-pic-loading.tga")
�
t:SetWidth(a)
t:SetHeight(n)
t.picidx=s
� t
�
� Cmd3DCode_Screenshot_ExternalPictures_FromPicId(t)
� a,e � pairs(Cmd3DCode_Screenshot_ExternalPictures)�
� e.picid==t �
� e
�
�
�
� Cmd3DCode_Screenshot_ExternalPictures_OnceUploded(e,t)
� � Cmd3DCode_Screenshot_ExternalPictures[e]�
print("指定序列的图片不存在",e)
�
�
� e=Cmd3DCode_Screenshot_ExternalPictures[e]
print(e.picid)
� e.picid �
t(e)
�
� � e.onceHandles �
e.onceHandles={}
�
table.insert(e.onceHandles,t)
�
�
� Cmd3DCode_Screenshot_ExternalPictures_EmitUploded(e)
� � Cmd3DCode_Screenshot_ExternalPictures[e]�
�
�
� e=Cmd3DCode_Screenshot_ExternalPictures[e]
� e.onceHandles �
� a,t � pairs(e.onceHandles)�
t(e)
�
e.onceHandles={}
�
�
� Cmd3DCode_Screenshot_TakePhoto(r)
Cmd3DCode_ShottingMaskFrame:Hide()
� d=UIParent:IsVisible()
� i=Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:GetChecked()
� s=Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()�"0"�"1"
� i �
print("隐藏UI")
UIParent:Hide()
�
� e=GetCVar("screenshotFormat")
� e~="jpg"�
SetCVar("screenshotFormat","jpg")
�
� t=time()
TakeScreenshot()
� o=CreateFrame("FRAME")
o:RegisterEvent("SCREENSHOT_SUCCEEDED")
o:SetScript("OnEvent",�(l,n)
� n=="SCREENSHOT_SUCCEEDED"�
� e~="jpg"�
SetCVar("screenshotFormat",e)
�
� i � d �
UIParent:Show()
�
� o=h(t)
� t=o.texture
..","..t
..","..s
..","..GetRealmName()
..","..GetUnitName("player")
� � r �
� o=UIParent:GetWidth()
� e=UIParent:GetHeight()
� h,n,s,i=Cmd3DCode_ViewFinderFrame:GetRect()
t=t..","..a(h/o,100)
..","..(1-a(n/e,100))-a(i/e,100)
..","..a(s/o,100)
..","..a(i/e,100)
�
ThreeDimensionsCode_Send("screenshot",t)
� time()-cmd3dcode_lastPingTime()>15 �
StaticPopup_Show("163UI-Screenshot:ClientNotFound")
�
print("正在上传 "..o.title.." ...")
�
�
o:SetScript("OnEvent",�)
�)
�
StaticPopupDialogs["163UI-Screenshot:ClientNotFound"]={
text="没有检测到有爱客户端，无法完成屏幕截图的裁切和传送，请启动有爱客户端。",
button1="关闭",
timeout=0,
whileDead=�,
hideOnEscape=�,
preferredIndex=3,
}
� � s(t)
� a=Cmd3DCode_Screenshot_ExternalPictures[t]
� � a �
print("未能找到序号为",t,"的截图")
�
�
� e=ChatEdit_ChooseBoxForSend()
� � e:IsShown()� ChatFrame1EditBox:GetAlpha()<1 �
ChatEdit_ActivateChat(e)
�
e:SetText("["..a.title.." "..t.."]")
�
� Cmd3DCode_Screenshot_ShowExternalPic(e,t)
� t=Cmd3DCode_Screenshot_ExternalPictures[t]
� � t �
�
�
� a,o=i(t,e:GetWidth(),e:GetHeight())
e:SetWidth(a)
e:SetHeight(o)
� a=e:CreateTexture(�,"BACKGROUND")
a:SetTexture(t.texture)
a:SetAllPoints(e)
�
Cmd3DCode_Screenshot_ChatFrameButton:SetParent(ChatFrame1EditBox)
Cmd3DCode_Screenshot_ChatFrameButton:Show()
Cmd3DCode_Screenshot_ChatFrameButton:SetPoint("LEFT",ChatFrame1EditBoxLanguage,"RIGHT",-8,0)
� e=CreateFrame("Button","Cmd3DCode_Screenshot_ChatFrameButton_MenuBtn",UIParent,"UIDropDownMenuTemplate")
e:Hide()
UIDropDownMenu_Initialize(e,�(e,t)
� o=_G["DropDownList"..(t � 1)]
�#Cmd3DCode_Screenshot_ExternalPictures �
� a=1
� n,i � pairs(Cmd3DCode_Screenshot_ExternalPictures)�
� a<=25 �
� e=UIDropDownMenu_CreateInfo()
e.notCheckable=�
e.text=i.title
e.arg1=i
e.func=�(t,e)
� e.uploaded �
s(e.idx)
�
print("截图尚未上传到网易有爱服务器，请等待...")
�
�
UIDropDownMenu_AddButton(e,t)
� e=_G["DropDownList"..t.."Button"..a]
� e �
e.isExternalPic=�
e.externalPicIdx=n
e.originOnEnter=e:GetScript("OnEnter")
e:SetScript("OnEnter",�(t,...)
� e=Cmd3DCode_Screenshot_ExternalPictures_Thumb(t.externalPicIdx)
� � e � � �
e:SetPoint("BOTTOMLEFT",o,"BOTTOMRIGHT",2,0)
e:Show()
� t.originOnEnter � t:originOnEnter(...)�
�)
e.originOnLeave=e:GetScript("OnLeave")
e:SetScript("OnLeave",�(e,...)
� t=Cmd3DCode_Screenshot_ExternalPictures_Thumb(e.externalPicIdx)
� � t � � �
t:Hide()
� e.originOnLeave � e:originOnLeave(...)�
�)
�
�
a=a+1
�
�
� e=UIDropDownMenu_CreateInfo()
e.text="截屏发送"
e.func=Cmd3DCode_Screenshot_Start
e.notCheckable=�
e.tooltipTitle="截取屏幕"
e.tooltipText="截取屏幕发送到好友或聊天频道"
e.hasOpacity=�
UIDropDownMenu_AddButton(e,t)
o:SetScript("OnHide",�(e)
� e=1,UIDROPDOWNMENU_MAXBUTTONS,1 �
button=_G["DropDownList"..(t � 1).."Button"..e]
� button � button.isExternalPic �
button:SetScript("OnEnter",button.originOnEnter)
button:SetScript("OnLeave",button.originOnLeave)
button.externalPicIdx=�
button.originOnEnter=�
button.originOnLeave=�
button.isExternalPic=�
�
�
o:SetScript("OnHide",�)
�)
�,"MENU")
� a="%[.+w%.163%.com%/(%w+).+%]"
� � d(e,t)
�
startpos,endpos,picid=string.find(e,a)
� startpos �
e=e:sub(0,startpos-1)
..(t(picid)�"")..e:sub(endpos+1)
�
� � startpos
� e
�
� � n(e,a,t)
� � e � �"xx"�
� t,a=i(e,a,t)
�"|Hextpic:"..e.picid.."|h|TInterface\\AddOns\\"..o.."\\External\\Image\\"..e.idx..".tga:"..a..":"..t.."|t|h"
�
ThreeDimensionsCode_SafePipe_CmdHandles["ir"]=�(t,e)
� e,o,a=strsplit(",",e)
e=tonumber(e)
� t=Cmd3DCode_Screenshot_ExternalPictures[e]
� � t �
print("Cmd3DCode_Screenshot_ExternalPictures[picidx] not exits",e)
�
�
t.width=tonumber(o)� 0
t.height=tonumber(a)� 0
t.loaded=�
�
ThreeDimensionsCode_SafePipe_CmdHandles["iu"]=�(t,e)
� e,a=strsplit(",",e)
e=tonumber(e)
� t="http://w.163.com/"..a
� t=Cmd3DCode_Screenshot_ExternalPictures[e]
� � t �
�
�
t.uploaded=�
t.picid=a
print(t.title,"上传完成")
s(e)
Cmd3DCode_Screenshot_ExternalPictures_EmitUploded(e)
�
� � r(t,...)
� e=1,select("#",...),2 �
� e,a=select(e,...)
� t==a �
� e
�
�
� �
�
� � h(t,...)
� e=1,select("#",...)�
� select(e,...)==t �
� e
�
�
� �
�
� � i(e)
� a=GetRealmName()
� t=#e-(#a+1)
� e:sub(t+2)==a �
� e:sub(1,t)
�
� e
�
�
ThreeDimensionsCode_SafePipe_CmdHandles["id"]=�(t,e)
� o,t,a=strsplit(",",e)
�(t=="0"� a=="0")�(t==""� a=="")�
print("外部图片下载失败，可能是网络原因造成")
�
� e=Cmd3DCode_Screenshot_ExternalPicture_Receives[o]
� � e �
print("未能找到ID为",o,"的截图")
�
�
e.downloaded=�
e.width=tonumber(t)
e.height=tonumber(a)
� t="|Hplayer:"..e.from.author.."|h["..i(e.from.author).."]|h: 发来了图片 "
t=t.."[ "..n(e,120,90).." ]"
� o=1,10 �
� _G["ChatFrame"..o.."Tab"]:IsVisible()�
� a,i,s,n
� e.from.msgtype=="CHANNEL"�
a=h(e.from.channel,GetChatWindowChannels(o))
� a �
� a=r(e.from.channel,GetChannelList())
i,s,n=GetMessageTypeColor("CHANNEL"..a)
t="["..e.from.channelString.."] "..t
�
�
a=h(e.from.msgtype,GetChatWindowMessages(o))
i,s,n=GetMessageTypeColor(e.from.msgtype)
�
� a �
_G["ChatFrame"..o]:AddMessage(t,i,s,n,e.from.guid)
�
�
�
�
� s=0
� � e(p,r,e,t,w,h,y,f,m,u,a,l,o,i)
e=d(e,�(e)
� r=="CHAT_MSG_WHISPER_INFORM"� t==GetUnitName("player",�).."-"..GetRealmName()�
� e=Cmd3DCode_Screenshot_ExternalPictures_FromPicId(e)
� e=n(e,120,90)
�"[ "..e.." ]"
�
� o>s �
s=o
� t={
author=t,
msgtype=r:sub(10),
channel=a,
channelString=h,
guid=i,
}
� t=c(e,a,t)
ThreeDimensionsCode_Send("loadpic",t.texture..","..e)
�
�""
�
�)
�#e<1,e,t,w,h,y,f,m,u,a,l,o,i
�
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_DND",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER",e)
� a=250
� � i(t,e)
� � t:IsShown()�
e.cachedText=�
�
�
a=math.max(t:GetWidth(),a)
� t=e:GetText()�""
� t==e.cachedText � � �
t=d(t,�(e)
� e=Cmd3DCode_Screenshot_ExternalPictures_FromPicId(e)
� e � n(e,100,75)�""
�)
e:SetText(t)
e.cachedText=t
e:SetWidth(math.min(e:GetStringWidth(),a-14))
�
� � o()
� e=1,WorldFrame:GetNumChildren()�
� e=select(e,WorldFrame:GetChildren())
� t=e:GetBackdrop()
� t � t.bgFile=="Interface\\Tooltips\\ChatBubble-Background"�
� t=1,e:GetNumRegions()�
� t=select(t,e:GetRegions())
� t:GetObjectType()=="FontString"�
i(e,t)
�
�
�
�
�
� a=.15
� t=CreateFrame("Frame")
t.interval=a
t:SetScript("OnUpdate",�(e,t)
e.interval=e.interval-t
� e.interval<0 �
e.interval=a
o()
�
�)
t:Show()
� a="\[截图 [%d:]+ (%d+)\]"
hooksecurefunc("AutoCompleteEditBox_OnEnterPressed",�()
� e=ChatEdit_ChooseBoxForSend()
� � e:IsVisible()�
�
�
� e=e:GetText()
� t,o=1,picidx
�
t,o,picidx=string.find(e,a)
picidx=tonumber(picidx)
� a=Cmd3DCode_Screenshot_ExternalPictures[picidx]
� picidx � a � a.picid �
e=e:sub(0,t-1)
.."[发来了图片，在浏览器中输入网址查看：w.163.com/"..a.picid.."  (安装“网易有爱插件包”后可在游戏内显示)]"
..e:sub(o+1)
�
� � t
ChatEdit_ChooseBoxForSend():SetText(e)
�)
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=Cmd3DCode_Screenshot_Start
� myfuncxxxx()
print("in myfuncxxxx()")
�
� a=SetItemRef
� SetItemRef(e,n,i,o)
� t=strmatch(e,"^extpic:(.+)")
� t �
print("图片id：",t)
�
a(e,n,i,o)
�
�
]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()