local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� bit==� � bit32~=� �
bit=bit32
�
� n="!!!163UI.3dcodecmd!!!"
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
� i=r-t-a
� n=d-e-o
� s=t+a
� h=e+o
Cmd3DCode_ShottingMaskFrame:SetWidth(r)
Cmd3DCode_ShottingMaskFrame:SetHeight(d)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetHeight(n)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,h)
Cmd3DCode_ShottingMaskFrameTOP:SetWidth(a)
Cmd3DCode_ShottingMaskFrameTOP:SetHeight(n)
Cmd3DCode_ShottingMaskFrameTOP:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",t,h)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetWidth(i)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetHeight(n)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",s,h)
Cmd3DCode_ShottingMaskFrameLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameLEFT:SetHeight(o)
Cmd3DCode_ShottingMaskFrameLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,e)
Cmd3DCode_ShottingMaskFrameRIGHT:SetWidth(i)
Cmd3DCode_ShottingMaskFrameRIGHT:SetHeight(o)
Cmd3DCode_ShottingMaskFrameRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",s,e)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,0)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetWidth(a)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",t,0)
Cmd3DCode_ShottingMaskFrameBOTTOMRIGHT:SetWidth(i)
Cmd3DCode_ShottingMaskFrameBOTTOMRIGHT:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOMRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",s,0)
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
Cmd3DCode_ViewFinderFrameDone:SetNormalTexture("Interface\\AddOns\\"..n.."\\Textures\\cupture.tga")
Cmd3DCode_ViewFinderFrameFullScreen:SetClampedToScreen(�)
Cmd3DCode_ViewFinderFrameFullScreen:SetNormalTexture("Interface\\AddOns\\"..n.."\\Textures\\fullscreen.tga")
Cmd3DCode_ViewFinderFrameCancel:SetClampedToScreen(�)
� Cmd3DCode_Screenshot_Start()
Cmd3DCode_ViewFinderFrame:SetWidth(400)
Cmd3DCode_ViewFinderFrame:SetHeight(300)
Cmd3DCode_ViewFinderFrame:SetPoint("CENTER",Cmd3DCode_ShottingMaskFrame,"CENTER",0,0)
Cmd3DCode_UpdateViewFinderFrames()
Cmd3DCode_ShottingMaskFrame:Show()
�
� o=ChatFrame1EditBox:CreateFontString()
o:SetFontObject(GameFontNormalSmall)
o:SetPoint("TOPLEFT")
o:SetPoint("BOTTOMRIGHT")
o:Hide()
� � a(e,t)
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
� i=UIParent:CreateTexture(�,"BACKGROUND")
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
� � d(t)
� t={
texture="Interface\\AddOns\\"..n.."\\External\\Image\\"..e..".tga",
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
� � u(a,o,t)
� t={
texture="Interface\\AddOns\\"..n.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
downloaded=�,
idx=e,
picid=a,
channel=o,
from=t,
}
Cmd3DCode_Screenshot_ExternalPictures[a]=t
e=e+1
� e>512 �
e=1
�
� t
�
� � s(e,a,t)
� o=a/t
� e=e.width/e.height
� e>o �
� a,a/e
�
� t*e,t
�
�
� Cmd3DCode_Screenshot_ExternalPicture_Thumb(o)
� e=Cmd3DCode_Screenshot_CapturePictures[o]
� � e �
�
�
� a,t=160,120
� e.loaded �
a,t=s(e,a,t)
i:SetTexture(e.texture)
�
i:SetTexture("Interface\\AddOns\\"..n.."\\Textures\\external-pic-loading.tga")
�
i:SetWidth(a)
i:SetHeight(t)
i.picidx=o
� i
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
� i=UIParent:IsVisible()
� t=Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:GetChecked()� � � �
� r=Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()� � � �
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
� n=CreateFrame("FRAME")
n:RegisterEvent("SCREENSHOT_SUCCEEDED")
n:SetScript("OnEvent",�(u,l)
� l=="SCREENSHOT_SUCCEEDED"�
� e~="jpg"�
SetCVar("screenshotFormat",e)
�
� t � i �
UIParent:Show()
�
� i=d(s)
� n,e=GetPlayerMapPosition("player")
� l,d=UnitFactionGroup("player")
� e={
texture=i.texture,
delSrcPic=r,
meta={
time=s,
hideui=t,
fullscreen=h,
realm=GetRealmName(),
character=GetUnitName("player"),
zone=GetZoneText(),
subzone=GetSubZoneText(),
lng=n,
lat=e,
race=UnitRace("player"),
faction=d,
class=UnitClass("player"),
gender=UnitSex("player"),
level=UnitLevel("player"),
},
}
� � h �
� i=UIParent:GetWidth()
� t=UIParent:GetHeight()
� n,s,h,o=Cmd3DCode_ViewFinderFrame:GetRect()
e.left=a(n/i,100)
e.top=(1-a(s/t,100))-a(o/t,100)
e.width=a(h/i,100)
e.height=a(o/t,100)
�
ThreeDimensionsCode_Send("screenshot",json_encode(e))
� time()-cmd3dcode_lastPingTime()>45 �
StaticPopup_Show("163UI-Screenshot:ClientNotFound")
�
print("正在上传 "..i.title.." ...")
o:SetText("正在上传 "..i.title.." ...")
o:Show()
�
�
n:SetScript("OnEvent",�)
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
� � r(t)
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
UIDropDownMenu_Initialize(e,�(e,o)
� n=_G["DropDownList"..(o � 1)]
� a=1
�#Cmd3DCode_Screenshot_CapturePictures �
� s,i � pairs(Cmd3DCode_Screenshot_CapturePictures)�
� a<=25 �
� e=UIDropDownMenu_CreateInfo()
e.notCheckable=�
e.text=i.title
e.arg1=i
e.func=�(t,e)
� e.uploaded �
r(e.idx)
�
print("截图尚未上传到网易有爱服务器，请等待...")
�
�
UIDropDownMenu_AddButton(e,o)
� e=_G["DropDownList"..o.."Button"..a]
� e �
e.isExternalPic=�
e.externalPicIdx=s
e.externalPicItem=i
e.originOnEnter=e:GetScript("OnEnter")
e:SetScript("OnEnter",�(e,...)
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
� e.originOnEnter � e:originOnEnter(...)�
�)
�
a=a+1
�
�
�
� e=UIDropDownMenu_CreateInfo()
e.text="功能说明(?)"
e.notCheckable=�
e.hasOpacity=�
e.func=�()
Cmd3DCode_Screenshot_Help:Show()
�
UIDropDownMenu_AddButton(e,o)
a=a+1
� e=UIDropDownMenu_CreateInfo()
e.text="截屏发送"
e.func=Cmd3DCode_Screenshot_Start
e.notCheckable=�
e.tooltipTitle="截取屏幕"
e.tooltipText="截取屏幕发送到好友或聊天频道"
e.hasOpacity=�
UIDropDownMenu_AddButton(e,o)
� e=_G["DropDownList"..(o � 1).."Button"..a]
e:SetScript("OnEnter",�(e,...)
GameTooltip:SetOwner(e,'ANCHOR_BOTTOMRIGHT')
GameTooltip:AddLine("快捷键：Ctrl+PrtScr")
GameTooltip:Show()
�)
e:SetScript("OnLeave",�(e,...)
GameTooltip:Hide()
�)
a=a+1
n:SetScript("OnHide",�(a)
i:Hide()
t:Hide()
ExternalPicturesThumb_BtnOpenInBrowser:Hide()
ExternalPicturesThumb_BtnScrawl:Hide()
� t=1,UIDROPDOWNMENU_MAXBUTTONS,1 �
e=_G["DropDownList"..(o � 1).."Button"..t]
� e � e.isExternalPic �
e:SetScript("OnEnter",e.originOnEnter)
e.externalPicIdx=�
e.originOnEnter=�
e.originOnLeave=�
e.isExternalPic=�
�
�
n:SetScript("OnHide",�)
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
� � h(e,t,a)
� � e � �"xx"�
� a,t=s(e,t,a)
�"|Hviewpic:"..e.picid.."|h|TInterface\\AddOns\\"..n.."\\External\\Image\\"..e.idx..".tga:"..t..":"..a.."|t|h"
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
� t,a=strsplit(",",e)
t=tonumber(t)
� e=Cmd3DCode_Screenshot_CapturePictures[t]
� � e �
�
�
o:Hide()
� a=="!"�
print(e.title,"上传失败")
�
�
print(e.title,"上传完成")
�
� o="http://w.163.com/"..a
Cmd3DCode_Screenshot_ExternalPictures[a]=e
e.uploaded=�
e.picid=a
r(t)
Cmd3DCode_Screenshot_CapturePictures_EmitUploded(t)
�
� � l(e,...)
� t=1,select("#",...),2 �
� a,t=select(t,...)
� e==t �
� a
�
�
� �
�
� � r(t,...)
� e=1,select("#",...)�
� select(e,...)==t �
� e
�
�
� �
�
� � i(e)
� t=GetRealmName()
� a=#e-(#t+1)
� e:sub(a+2)==t �
� e:sub(1,a)
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
t=t.."[ "..h(e,120,90).." ]"
� a=1,10 �
� _G["ChatFrame"..a.."Tab"]:IsVisible()�
� o,n,s,i
� e.from.msgtype=="CHANNEL"�
o=r(e.from.channel,GetChatWindowChannels(a))
� o �
� a=l(e.from.channel,GetChannelList())
n,s,i=GetMessageTypeColor("CHANNEL"..a)
t="["..e.from.channelString.."] "..t
�
�
o=r(e.from.msgtype,GetChatWindowMessages(a))
n,s,i=GetMessageTypeColor(e.from.msgtype)
�
� o �
_G["ChatFrame"..a]:AddMessage(t,n,s,i,e.from.guid)
�
�
�
�
� i=0
� � e(p,s,e,t,y,r,f,w,m,c,a,l,o,n)
e=d(e,�(e)
� s=="CHAT_MSG_WHISPER_INFORM"� t==GetUnitName("player",�).."-"..GetRealmName()�
� e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(e)
� e=h(e,120,90)
�"[ "..e.." ]"
�
� o>i �
i=o
� o={
author=t,
msgtype=s:sub(10),
channel=a,
channelString=r,
guid=n,
}
� a=u(e,a,o)
� time()-cmd3dcode_lastPingTime()>45 �
print("收到来自"..t.."的截图: w.163.com/"..e.." ,请启动有爱客户端显示此图")
�
ThreeDimensionsCode_Send("loadpic",a.texture..","..e)
�
�""
�
�)
�#e<1,e,t,y,r,f,w,m,c,a,l,o,n
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
� t=d(t,�(e)
� e=Cmd3DCode_Screenshot_ExternalPictures[e]
� � e � �""�
� e.width<=0 � �""�
� h(e,100,75)
�)
�#t>0 �
e:SetText(t)
e.cachedText=t
e:SetWidth(math.min(e:GetStringWidth(),a-14))
�
�
� � n()
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
n()
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
o:Hide()
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
� SetItemRef(e,t,o,a)
� n,h=strmatch(e,"^(.+):(.+)$")
� � i[n]�
s(e,t,o,a)
�
�
i[n](h,e,t,o,a)
�
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=Cmd3DCode_Screenshot_Start]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()