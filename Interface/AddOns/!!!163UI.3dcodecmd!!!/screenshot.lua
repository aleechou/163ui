local base_char,keywords=191,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
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
� d=UIParent:GetWidth()
� r=UIParent:GetHeight()
� t,e,a,o=Cmd3DCode_ViewFinderFrame:GetRect()
� � t � � e � � a � � e �
�
�
� i=d-t-a
� n=r-e-o
� h=t+a
� s=e+o
Cmd3DCode_ShottingMaskFrame:SetWidth(d)
Cmd3DCode_ShottingMaskFrame:SetHeight(r)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetHeight(n)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,s)
Cmd3DCode_ShottingMaskFrameTOP:SetWidth(a)
Cmd3DCode_ShottingMaskFrameTOP:SetHeight(n)
Cmd3DCode_ShottingMaskFrameTOP:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",t,s)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetWidth(i)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetHeight(n)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",h,s)
Cmd3DCode_ShottingMaskFrameLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameLEFT:SetHeight(o)
Cmd3DCode_ShottingMaskFrameLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,e)
Cmd3DCode_ShottingMaskFrameRIGHT:SetWidth(i)
Cmd3DCode_ShottingMaskFrameRIGHT:SetHeight(o)
Cmd3DCode_ShottingMaskFrameRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",h,e)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,0)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetWidth(a)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",t,0)
Cmd3DCode_ShottingMaskFrameBOTTOMRIGHT:SetWidth(i)
Cmd3DCode_ShottingMaskFrameBOTTOMRIGHT:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOMRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",h,0)
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
� � p(t,o,a)
� a={
texture="Interface\\AddOns\\"..i.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
downloaded=�,
idx=e,
picid=t,
channel=o,
from=a,
}
Cmd3DCode_Screenshot_ExternalPictures[t]=a
e=e+1
� e>512 �
e=1
�
� a
�
� � s(t,a,e)
� o=a/e
� t=t.width/t.height
� t>o �
� a,a/t
�
� e*t,e
�
�
� Cmd3DCode_Screenshot_ExternalPicture_Thumb(n)
� e=Cmd3DCode_Screenshot_CapturePictures[n]
� � e �
�
�
� a,t=160,120
� e.loaded �
a,t=s(e,a,t)
o:SetTexture(e.texture)
�
o:SetTexture("Interface\\AddOns\\"..i.."\\Textures\\external-pic-loading.tga")
�
o:SetWidth(a)
o:SetHeight(t)
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
� Cmd3DCode_Screenshot_TakePhoto(i)
Cmd3DCode_ShottingMaskFrame:Hide()
� d=UIParent:IsVisible()
� e=Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:GetChecked()� � � �
� r=Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()� � � �
� e �
print("隐藏UI")
UIParent:Hide()
�
� t=GetCVar("screenshotFormat")
� t~="jpg"�
SetCVar("screenshotFormat","jpg")
�
� s=time()
TakeScreenshot()
� o=CreateFrame("FRAME")
o:RegisterEvent("SCREENSHOT_SUCCEEDED")
o:SetScript("OnEvent",�(u,h)
� h=="SCREENSHOT_SUCCEEDED"�
� t~="jpg"�
SetCVar("screenshotFormat",t)
�
� e � d �
UIParent:Show()
�
� t=l(s)
� o,h=GetPlayerMapPosition("player")
� l,d=UnitFactionGroup("player")
� e={
texture=t.texture,
delSrcPic=r,
meta={
time=s,
hideui=e,
fullscreen=i,
realm=GetRealmName(),
character=GetUnitName("player"),
zone=GetZoneText(),
subzone=GetSubZoneText(),
lng=o,
lat=h,
race=UnitRace("player"),
faction=d,
class=UnitClass("player"),
gender=UnitSex("player"),
level=UnitLevel("player"),
},
}
� � i �
� o=UIParent:GetWidth()
� t=UIParent:GetHeight()
� s,i,h,a=Cmd3DCode_ViewFinderFrame:GetRect()
e.left=n(s/o,100)
e.top=(1-n(i/t,100))-n(a/t,100)
e.width=n(h/o,100)
e.height=n(a/t,100)
�
ThreeDimensionsCode_Send("screenshot",json_encode(e))
� time()-cmd3dcode_lastPingTime()>45 �
StaticPopup_Show("163UI-Screenshot:ClientNotFound")
�
print("正在上传 "..t.title.." ...")
a:SetText("正在上传 "..t.title.." ...")
a:Show()
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
� � h(e)
� a=Cmd3DCode_Screenshot_CapturePictures[e]
� � a �
print("未能找到序号为",e,"的截图")
�
�
� t=ChatEdit_ChooseBoxForSend()
� � t:IsShown()� ChatFrame1EditBox:GetAlpha()<1 �
ChatEdit_ActivateChat(t)
�
t:SetText("["..a.title.." "..e.."]")
�
� Cmd3DCode_Screenshot_ShowExternalPic(e,t)
� t=Cmd3DCode_Screenshot_CapturePictures[t]
� � t �
�
�
� a,o=s(t,e:GetWidth(),e:GetHeight())
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
UIDropDownMenu_Initialize(e,�(e,a)
� i=_G["DropDownList"..(a � 1)]
�#Cmd3DCode_Screenshot_CapturePictures �
� o=1
� s,n � pairs(Cmd3DCode_Screenshot_CapturePictures)�
� o<=25 �
� e=UIDropDownMenu_CreateInfo()
e.notCheckable=�
e.text=n.title
e.arg1=n
e.func=�(t,e)
� e.uploaded �
h(e.idx)
�
print("截图尚未上传到网易有爱服务器，请等待...")
�
�
UIDropDownMenu_AddButton(e,a)
� e=_G["DropDownList"..a.."Button"..o]
� e �
e.isExternalPic=�
e.externalPicIdx=s
e.externalPicItem=n
e.originOnEnter=e:GetScript("OnEnter")
e:SetScript("OnEnter",�(e,...)
� a=Cmd3DCode_Screenshot_ExternalPicture_Thumb(e.externalPicIdx)
� � a � � �
a:SetPoint("BOTTOMLEFT",i,"BOTTOMRIGHT",2,15)
a:Show()
� e.externalPicItem.picid �
t.text:SetText("http://w.163.com/"..e.externalPicItem.picid)
ExternalPicturesThumb_BtnOpenInBrowser.url="http://w.163.com/"..e.externalPicItem.picid
ExternalPicturesThumb_BtnOpenInBrowser:Show()
ExternalPicturesThumb_BtnOpenInBrowser:SetPoint("BOTTOMLEFT",a,"BOTTOMRIGHT",1,20)
�
t.text:SetText("正在上传 ...")
�
t:SetPoint("BOTTOMLEFT",i,"BOTTOMRIGHT",2,0)
t:Show()
ExternalPicturesThumb_BtnScrawl.picidx=e.externalPicIdx
ExternalPicturesThumb_BtnScrawl.picid=e.externalPicItem.picid
ExternalPicturesThumb_BtnScrawl:SetPoint("BOTTOMLEFT",a,"BOTTOMRIGHT",1,-4)
ExternalPicturesThumb_BtnScrawl:Show()
� e.originOnEnter � e:originOnEnter(...)�
�)
�
�
o=o+1
�
�
� e=UIDropDownMenu_CreateInfo()
e.text="功能说明(?)"
e.notCheckable=�
e.hasOpacity=�
e.func=�()
Cmd3DCode_Screenshot_Help:Show()
�
UIDropDownMenu_AddButton(e,a)
� e=UIDropDownMenu_CreateInfo()
e.text="截屏发送"
e.func=Cmd3DCode_Screenshot_Start
e.notCheckable=�
e.tooltipTitle="截取屏幕"
e.tooltipText="截取屏幕发送到好友或聊天频道"
e.hasOpacity=�
UIDropDownMenu_AddButton(e,a)
i:SetScript("OnHide",�(e)
o:Hide()
t:Hide()
ExternalPicturesThumb_BtnOpenInBrowser:Hide()
ExternalPicturesThumb_BtnScrawl:Hide()
� e=1,UIDROPDOWNMENU_MAXBUTTONS,1 �
button=_G["DropDownList"..(a � 1).."Button"..e]
� button � button.isExternalPic �
button:SetScript("OnEnter",button.originOnEnter)
button.externalPicIdx=�
button.originOnEnter=�
button.originOnLeave=�
button.isExternalPic=�
�
�
i:SetScript("OnHide",�)
�)
�,"MENU")
� o="%[.+w%.163%.com%/(%w+).+%]"
� � r(e,t)
�
startpos,endpos,picid=string.find(e,o)
� startpos �
e=e:sub(0,startpos-1)
..(t(picid)�"")..e:sub(endpos+1)
�
� � startpos
� e
�
� � n(e,t,a)
� � e � �"xx"�
� a,t=s(e,t,a)
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
� � d(a,...)
� e=1,select("#",...),2 �
� e,t=select(e,...)
� a==t �
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
� o,a,t=strsplit(",",e)
�(a=="0"� t=="0")�(a==""� t=="")�
print("外部图片下载失败，可能是网络原因造成")
�
� e=Cmd3DCode_Screenshot_ExternalPictures[o]
� � e �
print("未能找到ID为",o,"的截图")
�
�
e.downloaded=�
e.width=tonumber(a)
e.height=tonumber(t)
� t="|Hplayer:"..e.from.author.."|h["..i(e.from.author).."]|h: 发来了图片 "
t=t.."[ "..n(e,120,90).." ]"
� o=1,10 �
� _G["ChatFrame"..o.."Tab"]:IsVisible()�
� a,i,s,n
� e.from.msgtype=="CHANNEL"�
a=h(e.from.channel,GetChatWindowChannels(o))
� a �
� a=d(e.from.channel,GetChannelList())
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
� l=0
� � e(e,h,t,a,u,d,m,c,w,f,i,y,o,s)
t=r(t,�(e)
� h=="CHAT_MSG_WHISPER_INFORM"� a==GetUnitName("player",�).."-"..GetRealmName()�
� e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(e)
� e=n(e,120,90)
�"[ "..e.." ]"
�
� o>l �
l=o
� t={
author=a,
msgtype=h:sub(10),
channel=i,
channelString=d,
guid=s,
}
� t=p(e,i,t)
� time()-cmd3dcode_lastPingTime()>45 �
print("收到来自"..a.."的截图: w.163.com/"..e.." ,请启动有爱客户端显示此图")
�
ThreeDimensionsCode_Send("loadpic",t.texture..","..e)
�
�""
�
�)
�#t<1,t,a,u,d,m,c,w,f,i,y,o,s
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
� o=250
� � s(t,e)
� � t:IsShown()�
e.cachedText=�
�
�
o=math.max(t:GetWidth(),o)
� t=e:GetText()�""
� t==e.cachedText � � �
� t=r(t,�(e)
� e=Cmd3DCode_Screenshot_ExternalPictures[e]
� � e � �""�
� e.width<=0 � �""�
� n(e,100,75)
�)
�#t>0 �
e:SetText(t)
e.cachedText=t
e:SetWidth(math.min(e:GetStringWidth(),o-14))
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
s(e,t)
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
� i="\[截图 [%d:]+ (%d+)\]"
hooksecurefunc("AutoCompleteEditBox_OnEnterPressed",�()
� e=ChatEdit_ChooseBoxForSend()
� � e:IsVisible()�
�
�
� e=e:GetText()
� t,o=1,picidx
�
t,o,picidx=string.find(e,i)
picidx=tonumber(picidx)
� a=Cmd3DCode_Screenshot_CapturePictures[picidx]
� picidx � a � a.picid �
e=e:sub(0,t-1)
.."[发来了图片，在浏览器中输入网址查看：w.163.com/"..a.picid.."  (安装“网易有爱插件包”后可在游戏内显示)]"
..e:sub(o+1)
�
� � t
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
� i={
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
� SetItemRef(e,o,n,t)
� a,h=strmatch(e,"^(.+):(.+)$")
� � i[a]�
s(e,o,n,t)
�
�
i[a](h,e,o,n,t)
�
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=Cmd3DCode_Screenshot_Start]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()