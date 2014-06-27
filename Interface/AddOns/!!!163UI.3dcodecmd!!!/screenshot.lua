local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� bit==� � bit32~=� �
bit=bit32
�
� i="!!!163UI.3dcodecmd!!!"
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
� r=UIParent:GetWidth()
� d=UIParent:GetHeight()
� t,e,a,o=Cmd3DCode_ViewFinderFrame:GetRect()
� � t � � e � � a � � e �
�
�
� h=r-t-a
� s=d-e-o
� i=t+a
� n=e+o
Cmd3DCode_ShottingMaskFrame:SetWidth(r)
Cmd3DCode_ShottingMaskFrame:SetHeight(d)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetHeight(s)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,n)
Cmd3DCode_ShottingMaskFrameTOP:SetWidth(a)
Cmd3DCode_ShottingMaskFrameTOP:SetHeight(s)
Cmd3DCode_ShottingMaskFrameTOP:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",t,n)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetWidth(h)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetHeight(s)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",i,n)
Cmd3DCode_ShottingMaskFrameLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameLEFT:SetHeight(o)
Cmd3DCode_ShottingMaskFrameLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,e)
Cmd3DCode_ShottingMaskFrameRIGHT:SetWidth(h)
Cmd3DCode_ShottingMaskFrameRIGHT:SetHeight(o)
Cmd3DCode_ShottingMaskFrameRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",i,e)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,0)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetWidth(a)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",t,0)
Cmd3DCode_ShottingMaskFrameBOTTOMRIGHT:SetWidth(h)
Cmd3DCode_ShottingMaskFrameBOTTOMRIGHT:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOMRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",i,0)
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
Cmd3DCode_ViewFinderFrameDone:SetClampedToScreen(�)
Cmd3DCode_ViewFinderFrameDone:SetNormalTexture("Interface\\AddOns\\"..i.."\\Textures\\cupture.tga")
Cmd3DCode_ViewFinderFrameFullScreen:SetClampedToScreen(�)
Cmd3DCode_ViewFinderFrameFullScreen:SetNormalTexture("Interface\\AddOns\\"..i.."\\Textures\\fullscreen.tga")
Cmd3DCode_ViewFinderFrameCancel:SetClampedToScreen(�)
� Cmd3DCode_Screenshot_Start()
Cmd3DCode_ViewFinderFrame:SetWidth(400)
Cmd3DCode_ViewFinderFrame:SetHeight(300)
Cmd3DCode_ViewFinderFrame:SetPoint("CENTER",Cmd3DCode_ShottingMaskFrame,"CENTER",0,0)
Cmd3DCode_UpdateViewFinderFrames()
Cmd3DCode_ShottingMaskFrame:Show()
�
� a=ChatFrame1EditBox:CreateFontString()
a:SetFontObject(GameFontNormalSmall)
a:SetPoint("TOPLEFT")
a:SetPoint("BOTTOMRIGHT")
a:Hide()
� � n(e,t)
e=e*t
� a,e=math.modf(e,1)
e=e>=.5 � 1 � 0
�(a+e)/t
�
� � e(t)
� e=2;
�
� e>t �
� e;
�
e=bit.lshift(e,1);
� �
�
� o=UIParent:CreateTexture(�,"BACKGROUND")
� t=CreateFrame("FRAME")
t:SetScript("OnMouseDown",�(e)
� t=e.text:GetText()
� t:sub(1,17)=="http://w.163.com/"�
� e=ChatEdit_ChooseBoxForSend()
� � e:IsShown()� ChatFrame1EditBox:GetAlpha()<1 �
ChatEdit_ActivateChat(e)
�
e:SetText(t)
e:HighlightText()
�
�)
t:SetWidth(300)
t:SetHeight(10)
t.text=t:CreateFontString(�,"OVERLAY","GameTooltipText")
t.text:SetPoint("BOTTOMLEFT")
t.text:SetText("Hello World!")
� e=1
Cmd3DCode_Screenshot_CapturePictures={}
Cmd3DCode_Screenshot_ExternalPictures={}
� � l(t)
� t={
texture="Interface\\AddOns\\"..i.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
loaded=�,
uploaded=�,
idx=e,
time=t,
title=date("截图 %H:%M:%S",t),
}
Cmd3DCode_Screenshot_CapturePictures[e]=t
e=e+1
� e>512 �
e=1
�
� t
�
� � p(t,a,o)
� a={
texture="Interface\\AddOns\\"..i.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
downloaded=�,
idx=e,
picid=t,
channel=a,
from=o,
}
Cmd3DCode_Screenshot_ExternalPictures[t]=a
e=e+1
� e>512 �
e=1
�
� a
�
� � s(a,e,t)
� o=e/t
� a=a.width/a.height
� a>o �
� e,e/a
�
� t*a,t
�
�
� Cmd3DCode_Screenshot_ExternalPicture_Thumb(n)
� e=Cmd3DCode_Screenshot_CapturePictures[n]
� � e �
�
�
� t,a=160,120
� e.loaded �
t,a=s(e,t,a)
o:SetTexture(e.texture)
�
o:SetTexture("Interface\\AddOns\\"..i.."\\Textures\\external-pic-loading.tga")
�
o:SetWidth(t)
o:SetHeight(a)
o.picidx=n
� o
�
� Cmd3DCode_Screenshot_CapturePictures_FromPicId(t)
� a,e � pairs(Cmd3DCode_Screenshot_CapturePictures)�
� e.picid==t �
� e
�
�
�
� Cmd3DCode_Screenshot_CapturePictures_OnceUploded(e,t)
� � Cmd3DCode_Screenshot_CapturePictures[e]�
print("指定序列的图片不存在",e)
�
�
� e=Cmd3DCode_Screenshot_CapturePictures[e]
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
� Cmd3DCode_Screenshot_CapturePictures_EmitUploded(e)
� � Cmd3DCode_Screenshot_CapturePictures[e]�
�
�
� e=Cmd3DCode_Screenshot_CapturePictures[e]
� e.onceHandles �
� a,t � pairs(e.onceHandles)�
t(e)
�
e.onceHandles={}
�
�
� Cmd3DCode_Screenshot_TakePhoto(h)
Cmd3DCode_ShottingMaskFrame:Hide()
� r=UIParent:IsVisible()
� t=Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:GetChecked()� � � �
� d=Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()� � � �
� t �
print("隐藏UI")
UIParent:Hide()
�
� e=GetCVar("screenshotFormat")
� e~="jpg"�
SetCVar("screenshotFormat","jpg")
�
� s=time()
TakeScreenshot()
� i=CreateFrame("FRAME")
i:RegisterEvent("SCREENSHOT_SUCCEEDED")
i:SetScript("OnEvent",�(u,o)
� o=="SCREENSHOT_SUCCEEDED"�
� e~="jpg"�
SetCVar("screenshotFormat",e)
�
� t � r �
UIParent:Show()
�
� o=l(s)
� r,e=GetPlayerMapPosition("player")
� l,i=UnitFactionGroup("player")
� e={
texture=o.texture,
delSrcPic=d,
meta={
time=s,
hideui=t,
fullscreen=h,
realm=GetRealmName(),
character=GetUnitName("player"),
zone=GetZoneText(),
subzone=GetSubZoneText(),
lng=r,
lat=e,
race=UnitRace("player"),
faction=i,
class=UnitClass("player"),
gender=UnitSex("player"),
level=UnitLevel("player"),
},
}
� � h �
� a=UIParent:GetWidth()
� t=UIParent:GetHeight()
� i,h,s,o=Cmd3DCode_ViewFinderFrame:GetRect()
e.left=n(i/a,100)
e.top=(1-n(h/t,100))-n(o/t,100)
e.width=n(s/a,100)
e.height=n(o/t,100)
�
ThreeDimensionsCode_Send("screenshot",json_encode(e))
� time()-cmd3dcode_lastPingTime()>45 �
StaticPopup_Show("163UI-Screenshot:ClientNotFound")
�
print("正在上传 "..o.title.." ...")
a:SetText("正在上传 "..o.title.." ...")
a:Show()
�
�
i:SetScript("OnEvent",�)
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
� � h(t)
� a=Cmd3DCode_Screenshot_CapturePictures[t]
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
� t=Cmd3DCode_Screenshot_CapturePictures[t]
� � t �
�
�
� o,a=s(t,e:GetWidth(),e:GetHeight())
e:SetWidth(o)
e:SetHeight(a)
� a=e:CreateTexture(�,"BACKGROUND")
a:SetTexture(t.texture)
a:SetAllPoints(e)
�
Cmd3DCode_Screenshot_ChatFrameButton:SetParent(ChatFrame1EditBox)
Cmd3DCode_Screenshot_ChatFrameButton:Show()
Cmd3DCode_Screenshot_ChatFrameButton:SetPoint("LEFT",ChatFrame1EditBoxLanguage,"RIGHT",-8,0)
� e=CreateFrame("Button","Cmd3DCode_Screenshot_ChatFrameButton_MenuBtn",UIParent,"UIDropDownMenuTemplate")
e:Hide()
UIDropDownMenu_Initialize(e,�(e,a)
� n=_G["DropDownList"..(a � 1)]
� e=1
�#Cmd3DCode_Screenshot_CapturePictures �
� s,i � pairs(Cmd3DCode_Screenshot_CapturePictures)�
� e<=25 �
� o=UIDropDownMenu_CreateInfo()
o.notCheckable=�
o.text=i.title
o.arg1=i
o.func=�(t,e)
� e.uploaded �
h(e.idx)
�
print("截图尚未上传到网易有爱服务器，请等待...")
�
�
UIDropDownMenu_AddButton(o,a)
� a=_G["DropDownList"..a.."Button"..e]
� a �
a.isExternalPic=�
a.externalPicIdx=s
a.externalPicItem=i
a.__scrshot_onenter=�(e,...)
� a=Cmd3DCode_Screenshot_ExternalPicture_Thumb(e.externalPicIdx)
� � a � � �
a:SetPoint("BOTTOMLEFT",n,"BOTTOMRIGHT",2,15)
a:Show()
� e.externalPicItem.picid �
t.text:SetText("http://w.163.com/"..e.externalPicItem.picid)
ExternalPicturesThumb_BtnOpenInBrowser.url="http://w.163.com/"..e.externalPicItem.picid
ExternalPicturesThumb_BtnOpenInBrowser:Show()
ExternalPicturesThumb_BtnOpenInBrowser:SetPoint("BOTTOMLEFT",a,"BOTTOMRIGHT",1,20)
�
t.text:SetText("正在上传 ...")
�
t:SetPoint("BOTTOMLEFT",n,"BOTTOMRIGHT",2,0)
t:Show()
ExternalPicturesThumb_BtnScrawl.picidx=e.externalPicIdx
ExternalPicturesThumb_BtnScrawl.picid=e.externalPicItem.picid
ExternalPicturesThumb_BtnScrawl:SetPoint("BOTTOMLEFT",a,"BOTTOMRIGHT",1,-4)
ExternalPicturesThumb_BtnScrawl:Show()
�
�
e=e+1
�
�
�
� t=UIDropDownMenu_CreateInfo()
t.text="功能说明(?)"
t.notCheckable=�
t.hasOpacity=�
t.func=�()
Cmd3DCode_Screenshot_Help:Show()
�
UIDropDownMenu_AddButton(t,a)
e=e+1
� t=UIDropDownMenu_CreateInfo()
t.text="截屏发送"
t.func=Cmd3DCode_Screenshot_Start
t.notCheckable=�
t.tooltipTitle="截取屏幕"
t.tooltipText="截取屏幕发送到好友或聊天频道"
t.hasOpacity=�
UIDropDownMenu_AddButton(t,a)
� t=_G["DropDownList"..(a � 1).."Button"..e]
t.__scrshot_onenter=�(e,...)
GameTooltip:SetOwner(e,'ANCHOR_BOTTOMRIGHT')
GameTooltip:AddLine("快捷键：Ctrl+PrtScr")
GameTooltip:Show()
�
t.__scrshot_onleave=�(t,...)
GameTooltip:Hide()
�
e=e+1
�,"MENU")
DropDownList1:HookScript("OnHide",�(e)
o:Hide()
t:Hide()
ExternalPicturesThumb_BtnOpenInBrowser:Hide()
ExternalPicturesThumb_BtnScrawl:Hide()
� e=1,UIDROPDOWNMENU_MAXBUTTONS,1 �
button=_G["DropDownList"..(level � 1).."Button"..e]
� button � button.isExternalPic �
button.externalPicIdx=�
button.originOnEnter=�
button.originOnLeave=�
button.isExternalPic=�
button.__scrshot_onenter=�
button.__scrshot_onleave=�
�
�
�)
� e=1,UIDROPDOWNMENU_MAXBUTTONS,1 �
button=_G["DropDownList1Button"..e]
button:HookScript("OnEnter",�(e,...)
� e.__scrshot_onenter �
e:__scrshot_onenter(...)
�
�)
button:HookScript("OnLeave",�(e,...)
� e.__scrshot_onleave �
e:__scrshot_onleave(...)
�
�)
�
� t="%[.+w%.163%.com%/(%w+).+%]"
� � d(e,a)
�
startpos,endpos,picid=string.find(e,t)
� startpos �
e=e:sub(0,startpos-1)
..(a(picid)�"")..e:sub(endpos+1)
�
� � startpos
� e
�
� � n(e,a,t)
� � e � �"xx"�
� a,t=s(e,a,t)
�"|Hviewpic:"..e.picid.."|h|TInterface\\AddOns\\"..i.."\\External\\Image\\"..e.idx..".tga:"..t..":"..a.."|t|h"
�
ThreeDimensionsCode_SafePipe_CmdHandles["ir"]=�(t,e)
� t,o,a=strsplit(",",e)
t=tonumber(t)
� e=Cmd3DCode_Screenshot_CapturePictures[t]
� � e �
print("Cmd3DCode_Screenshot_CapturePictures[picidx] not exits",t)
�
�
e.width=tonumber(o)� 0
e.height=tonumber(a)� 0
e.loaded=�
�
ThreeDimensionsCode_SafePipe_CmdHandles["iu"]=�(t,e)
� t,o=strsplit(",",e)
t=tonumber(t)
� e=Cmd3DCode_Screenshot_CapturePictures[t]
� � e �
�
�
a:Hide()
� o=="!"�
print(e.title,"上传失败")
�
�
print(e.title,"上传完成")
�
� a="http://w.163.com/"..o
Cmd3DCode_Screenshot_ExternalPictures[o]=e
e.uploaded=�
e.picid=o
h(t)
Cmd3DCode_Screenshot_CapturePictures_EmitUploded(t)
�
� � r(a,...)
� e=1,select("#",...),2 �
� t,e=select(e,...)
� a==e �
� t
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
� e=Cmd3DCode_Screenshot_ExternalPictures[o]
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
� a,n,s,i
� e.from.msgtype=="CHANNEL"�
a=h(e.from.channel,GetChatWindowChannels(o))
� a �
� a=r(e.from.channel,GetChannelList())
n,s,i=GetMessageTypeColor("CHANNEL"..a)
t="["..e.from.channelString.."] "..t
�
�
a=h(e.from.msgtype,GetChatWindowMessages(o))
n,s,i=GetMessageTypeColor(e.from.msgtype)
�
� a �
_G["ChatFrame"..o]:AddMessage(t,n,s,i,e.from.guid)
�
�
�
�
� h=0
� � e(t,r,a,e,u,s,m,c,f,y,i,w,o,l,...)
a=d(a,�(t)
� r=="CHAT_MSG_WHISPER_INFORM"� e==GetUnitName("player",�).."-"..GetRealmName()�
� e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(t)
� e=n(e,120,90)
�"[ "..e.." ]"
�
� o>h �
h=o
� a={
author=e,
msgtype=r:sub(10),
channel=i,
channelString=s,
guid=l,
}
� a=p(t,i,a)
� time()-cmd3dcode_lastPingTime()>45 �
print("收到来自"..e.."的截图: w.163.com/"..t.." ,请启动有爱客户端显示此图")
�
ThreeDimensionsCode_Send("loadpic",a.texture..","..t)
�
�""
�
�)
�#a<1,a,e,u,s,m,c,f,y,i,w,o,l,...
�
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_DND",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER",e)
� t=250
� � o(a,e)
� � a:IsShown()�
e.cachedText=�
�
�
t=math.max(a:GetWidth(),t)
� a=e:GetText()�""
� a==e.cachedText � � �
� a=d(a,�(e)
� e=Cmd3DCode_Screenshot_ExternalPictures[e]
� � e � �""�
� e.width<=0 � �""�
� n(e,100,75)
�)
�#a>0 �
e:SetText(a)
e.cachedText=a
e:SetWidth(math.min(e:GetStringWidth(),t-14))
�
�
� � i()
� e=1,WorldFrame:GetNumChildren()�
� e=select(e,WorldFrame:GetChildren())
� t=e:GetBackdrop()
� t � t.bgFile=="Interface\\Tooltips\\ChatBubble-Background"�
� t=1,e:GetNumRegions()�
� t=select(t,e:GetRegions())
� t:GetObjectType()=="FontString"�
o(e,t)
�
�
�
�
�
� o=.15
� t=CreateFrame("Frame")
t.interval=o
t:SetScript("OnUpdate",�(e,t)
e.interval=e.interval-t
� e.interval<0 �
e.interval=o
i()
�
�)
t:Show()
� t="\[截图 [%d:]+ (%d+)\]"
hooksecurefunc("AutoCompleteEditBox_OnEnterPressed",�()
� e=ChatEdit_ChooseBoxForSend()
� � e:IsVisible()�
�
�
� e=e:GetText()
� a,o=1,picidx
�
a,o,picidx=string.find(e,t)
picidx=tonumber(picidx)
� t=Cmd3DCode_Screenshot_CapturePictures[picidx]
� picidx � t � t.picid �
e=e:sub(0,a-1)
.."[发来了图片，在浏览器中输入网址查看：w.163.com/"..t.picid.."  (安装“网易有爱插件包”后可在游戏内显示)]"
..e:sub(o+1)
�
� � a
ChatEdit_ChooseBoxForSend():SetText(e)
�)
hooksecurefunc("AutoCompleteEditBox_OnEscapePressed",�()
a:Hide()
�)
� e=CreateFrame("FRAME","Cmd3DCode_Screenshot_PicViewer",UIParent)
e:SetFrameStrata("TOOLTIP")
e:SetFrameLevel(120)
e:SetAllPoints(UIParent)
e:Hide()
e.bg=e:CreateTexture()
e.bg:SetTexture(.1,.1,.1,.7)
e.bg:SetAllPoints(e)
e:EnableKeyboard(�);
e:SetPropagateKeyboardInput(�);
e:SetScript("OnKeyDown",�(e,t,...)
� t=="ESCAPE"�
e:Hide()
e:SetPropagateKeyboardInput(�)
� �
�
e:SetPropagateKeyboardInput(�);
�)
e:SetScript("OnMouseDown",�(e)
e:Hide()
�)
� t=CreateFrame("FRAME","Cmd3DCode_Screenshot_PicViewerPhoto",e)
t:SetPoint("CENTER")
t:SetWidth(403)
t:SetHeight(300)
t.texture=t:CreateTexture(�,"BACKGROUND")
t.texture:SetAllPoints(t)
� a={
viewpic=�(o,a,a,a,a,a)
� a=Cmd3DCode_Screenshot_ExternalPictures[o]
� � a �
print("picid",o,"无效")
�
�
t.texture:SetTexture(a.texture)
t:SetWidth(a.width)
t:SetHeight(a.height)
e:Show()
�
}
� s=SetItemRef
� SetItemRef(e,i,n,o)
� t,h=strmatch(e,"^(.+):(.+)$")
� � a[t]�
s(e,i,n,o)
�
�
a[t](h,e,i,n,o)
�
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=Cmd3DCode_Screenshot_Start]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()