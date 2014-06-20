local base_char,keywords=191,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� bit==� � bit32~=� �
bit=bit32
�
� i=...
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
� i=t+a
� n=e+o
Cmd3DCode_ShottingMaskFrame:SetWidth(d)
Cmd3DCode_ShottingMaskFrame:SetHeight(r)
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
� o=ChatFrame1EditBox:CreateFontString()
o:SetFontObject(GameFontNormalSmall)
o:SetPoint("TOPLEFT")
o:SetPoint("BOTTOMRIGHT")
o:Hide()
� � n(e,t)
e=e*t
� a,e=math.modf(e,1)
e=e>=.5 � 1 � 0
�(a+e)/t
�
� � h(t)
� e=2;
�
� e>t �
� e;
�
e=bit.lshift(e,1);
� �
�
� e=1
Cmd3DCode_Screenshot_CapturePictures={}
Cmd3DCode_Screenshot_ExternalPictures={}
� a=UIParent:CreateTexture(�,"BACKGROUND")
a:SetPoint("CENTER",UIParent,"CENTER",0,0)
a:Show()
� � r(t)
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
� � u(a,o,t)
� t={
texture="Interface\\AddOns\\"..i.."\\External\\Image\\"..e..".tga",
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
� � s(e,t,a)
� o=t/a
� e=e.width/e.height
� e>o �
� t,t/e
�
� a*e,a
�
�
� Cmd3DCode_Screenshot_ExternalPicture_Texture(a,t)
� e=Cmd3DCode_Screenshot_ExternalPictures[a]
� � e �
print("picid",a,"无效")
�
�
� � t.pictexture �
t.pictexture=t:CreateTexture(�,"BACKGROUND")
�
print(e.width,">>",h(e.width))
print(e.height,">>",h(e.height))
t.pictexture:SetPoint("TOPLEFT")
t.pictexture:SetTexture(e.texture)
t.pictexture:SetWidth(e.width)
t.pictexture:SetHeight(e.height)
print(e.width,e.height,t.pictexture:GetWidth(),t.pictexture:GetHeight())
t.picid=a
� e
�
� Cmd3DCode_Screenshot_ExternalPicture_Thumb(n)
� e=Cmd3DCode_Screenshot_CapturePictures[n]
� � e �
�
�
� o,t=160,120
� e.loaded �
o,t=s(e,o,t)
a:SetTexture(e.texture)
�
a:SetTexture("Interface\\AddOns\\"..i.."\\Textures\\external-pic-loading.tga")
�
a:SetWidth(o)
a:SetHeight(t)
a.picidx=n
� a
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
� Cmd3DCode_Screenshot_TakePhoto(d)
Cmd3DCode_ShottingMaskFrame:Hide()
� s=UIParent:IsVisible()
� a=Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:GetChecked()
� l=Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()�"0"�"1"
� a �
print("隐藏UI")
UIParent:Hide()
�
� e=GetCVar("screenshotFormat")
� e~="jpg"�
SetCVar("screenshotFormat","jpg")
�
� i=time()
TakeScreenshot()
� t=CreateFrame("FRAME")
t:RegisterEvent("SCREENSHOT_SUCCEEDED")
t:SetScript("OnEvent",�(u,h)
� h=="SCREENSHOT_SUCCEEDED"�
� e~="jpg"�
SetCVar("screenshotFormat",e)
�
� a � s �
UIParent:Show()
�
� a=r(i)
� t=a.texture
..","..i
..","..l
..","..GetRealmName()
..","..GetUnitName("player")
� � d �
� a=UIParent:GetWidth()
� e=UIParent:GetHeight()
� h,i,s,o=Cmd3DCode_ViewFinderFrame:GetRect()
t=t..","..n(h/a,100)
..","..(1-n(i/e,100))-n(o/e,100)
..","..n(s/a,100)
..","..n(o/e,100)
�
ThreeDimensionsCode_Send("screenshot",t)
� time()-cmd3dcode_lastPingTime()>15 �
StaticPopup_Show("163UI-Screenshot:ClientNotFound")
�
print("正在上传 "..a.title.." ...")
o:SetText("正在上传 "..a.title.." ...")
o:Show()
�
�
t:SetScript("OnEvent",�)
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
� � n(t)
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
UIDropDownMenu_Initialize(e,�(e,t)
� o=_G["DropDownList"..(t � 1)]
�#Cmd3DCode_Screenshot_CapturePictures �
� a=1
� s,i � pairs(Cmd3DCode_Screenshot_CapturePictures)�
� a<=25 �
� e=UIDropDownMenu_CreateInfo()
e.notCheckable=�
e.text=i.title
e.arg1=i
e.func=�(t,e)
� e.uploaded �
n(e.idx)
�
print("截图尚未上传到网易有爱服务器，请等待...")
�
�
UIDropDownMenu_AddButton(e,t)
� e=_G["DropDownList"..t.."Button"..a]
� e �
e.isExternalPic=�
e.externalPicIdx=s
e.originOnEnter=e:GetScript("OnEnter")
e:SetScript("OnEnter",�(t,...)
� e=Cmd3DCode_Screenshot_ExternalPicture_Thumb(t.externalPicIdx)
� � e � � �
e:SetPoint("BOTTOMLEFT",o,"BOTTOMRIGHT",2,0)
e:Show()
� t.originOnEnter � t:originOnEnter(...)�
�)
e.originOnLeave=e:GetScript("OnLeave")
e:SetScript("OnLeave",�(e,...)
� t=Cmd3DCode_Screenshot_ExternalPicture_Thumb(e.externalPicIdx)
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
e.text="功能说明(?)"
e.notCheckable=�
e.hasOpacity=�
e.func=�()
Cmd3DCode_Screenshot_Help:Show()
�
UIDropDownMenu_AddButton(e,t)
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
� � h(e,t,a)
� � e � �"xx"�
� a,t=s(e,t,a)
�"|Hviewpic:"..e.picid.."|h|TInterface\\AddOns\\"..i.."\\External\\Image\\"..e.idx..".tga:"..t..":"..a.."|t|h"
�
ThreeDimensionsCode_SafePipe_CmdHandles["ir"]=�(t,e)
� t,a,o=strsplit(",",e)
t=tonumber(t)
� e=Cmd3DCode_Screenshot_CapturePictures[t]
� � e �
print("Cmd3DCode_Screenshot_CapturePictures[picidx] not exits",t)
�
�
e.width=tonumber(a)� 0
e.height=tonumber(o)� 0
e.loaded=�
�
ThreeDimensionsCode_SafePipe_CmdHandles["iu"]=�(t,e)
� e,a=strsplit(",",e)
e=tonumber(e)
� t="http://w.163.com/"..a
� t=Cmd3DCode_Screenshot_CapturePictures[e]
� � t �
�
�
Cmd3DCode_Screenshot_ExternalPictures[a]=t
t.uploaded=�
t.picid=a
print(t.title,"上传完成")
o:Hide()
n(e)
Cmd3DCode_Screenshot_CapturePictures_EmitUploded(e)
�
� � l(a,...)
� e=1,select("#",...),2 �
� t,e=select(e,...)
� a==e �
� t
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
� o,i,n,s
� e.from.msgtype=="CHANNEL"�
o=r(e.from.channel,GetChatWindowChannels(a))
� o �
� a=l(e.from.channel,GetChannelList())
i,n,s=GetMessageTypeColor("CHANNEL"..a)
t="["..e.from.channelString.."] "..t
�
�
o=r(e.from.msgtype,GetChatWindowMessages(a))
i,n,s=GetMessageTypeColor(e.from.msgtype)
�
� o �
_G["ChatFrame"..a]:AddMessage(t,i,n,s,e.from.guid)
�
�
�
�
� n=0
� � e(p,s,e,o,w,i,y,f,l,m,t,c,a,r)
e=d(e,�(e)
� s=="CHAT_MSG_WHISPER_INFORM"� o==GetUnitName("player",�).."-"..GetRealmName()�
� e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(e)
� e=h(e,120,90)
�"[ "..e.." ]"
�
� a>n �
n=a
� a={
author=o,
msgtype=s:sub(10),
channel=t,
channelString=i,
guid=r,
}
� t=u(e,t,a)
ThreeDimensionsCode_Send("loadpic",t.texture..","..e)
�
�""
�
�)
�#e<1,e,o,w,i,y,f,l,m,t,c,a,r
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
� e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(e)
� e � h(e,100,75)�""
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
� a=Cmd3DCode_Screenshot_CapturePictures[picidx]
� picidx � a � a.picid �
e=e:sub(0,t-1)
.."[发来了图片，在浏览器中输入网址查看：w.163.com/"..a.picid.."  (安装“网易有爱插件包”后可在游戏内显示)]"
..e:sub(o+1)
�
� � t
ChatEdit_ChooseBoxForSend():SetText(e)
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
� o={
viewpic=�(o,a,a,a,a,a)
� a=Cmd3DCode_Screenshot_ExternalPictures[o]
� � a �
print("picid",o,"无效")
�
�
t.texture:SetTexture(a.texture)
t.texture:SetWidth(a.width)
t.texture:SetHeight(a.height)
e:Show()
�
}
� s=SetItemRef
� SetItemRef(e,a,t,i)
� n,h=strmatch(e,"^(.+):(.+)$")
� � o[n]�
s(e,a,t,i)
�
�
o[n](h,e,a,t,i)
�
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=Cmd3DCode_Screenshot_Start]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()