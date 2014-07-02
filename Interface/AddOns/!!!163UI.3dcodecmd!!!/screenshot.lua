local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� bit==� � bit32~=� �
bit=bit32
�
� o="!!!163UI.3dcodecmd!!!"
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
CoreUIEnableTooltip(ExternalPicturesThumbFrame_BtnSaveAs,"截图另存为")
CoreUIEnableTooltip(ExternalPicturesThumbFrame_BtnScrawl,"涂鸦")
CoreUIEnableTooltip(ExternalPicturesThumbFrame_BtnOpenInBrowser,"在浏览器中打开")
CoreUIEnableTooltip(ExternalPicturesThumbFrame_UrlFrame,"截图已经同步到网易服务器，点击复制网址")
� Cmd3DCode_UpdateViewFinderFrames()
� r=UIParent:GetWidth()
� d=UIParent:GetHeight()
� t,e,a,o=Cmd3DCode_ViewFinderFrame:GetRect()
� � t � � e � � a � � e �
�
�
� i=r-t-a
� s=d-e-o
� h=t+a
� n=e+o
Cmd3DCode_ShottingMaskFrame:SetWidth(r)
Cmd3DCode_ShottingMaskFrame:SetHeight(d)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetHeight(s)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,n)
Cmd3DCode_ShottingMaskFrameTOP:SetWidth(a)
Cmd3DCode_ShottingMaskFrameTOP:SetHeight(s)
Cmd3DCode_ShottingMaskFrameTOP:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",t,n)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetWidth(i)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetHeight(s)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",h,n)
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
Cmd3DCode_ViewFinderFrameDone:SetNormalTexture("Interface\\AddOns\\"..o.."\\Textures\\cupture.tga")
Cmd3DCode_ViewFinderFrameFullScreen:SetClampedToScreen(�)
Cmd3DCode_ViewFinderFrameFullScreen:SetNormalTexture("Interface\\AddOns\\"..o.."\\Textures\\fullscreen.tga")
Cmd3DCode_ViewFinderFrameCancel:SetClampedToScreen(�)
� Cmd3DCode_Screenshot_Start()
Cmd3DCode_ViewFinderFrame:SetWidth(400)
Cmd3DCode_ViewFinderFrame:SetHeight(300)
Cmd3DCode_ViewFinderFrame:SetPoint("CENTER",Cmd3DCode_ShottingMaskFrame,"CENTER",0,0)
Cmd3DCode_UpdateViewFinderFrames()
Cmd3DCode_ShottingMaskFrame:Show()
�
� t=ChatFrame1EditBox:CreateFontString()
t:SetFontObject(GameFontNormalSmall)
t:SetPoint("TOPLEFT")
t:SetPoint("BOTTOMRIGHT")
t:Hide()
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
ExternalPicturesThumbFrame.thumb=ExternalPicturesThumbFrame:CreateTexture(�,"BACKGROUND")
ExternalPicturesThumbFrame.thumb:SetPoint("BOTTOMLEFT",28,18)
ExternalPicturesThumbFrame_UrlFrame.text=ExternalPicturesThumbFrame_UrlFrame:CreateFontString(�,"OVERLAY","GameTooltipText")
ExternalPicturesThumbFrame_UrlFrame.text:SetPoint("BOTTOMLEFT")
ExternalPicturesThumbFrame_UrlFrame.text:SetText("Hello World!")
ExternalPicturesThumbFrame:SetPoint("CENTER")
� e=1
� ExternalPictures_FetchUnusedPicIdx()
idx=e
e=e+1
� e>2048 �
e=1
�
� idx
�
Cmd3DCode_Screenshot_CapturePictures={}
Cmd3DCode_Screenshot_ExternalPictures={}
� � h(t)
� e=ExternalPictures_FetchUnusedPicIdx()
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
Cmd3DCode_Screenshot_CapturePictures[e]=t
� t
�
� � m(t,a,i)
� e=ExternalPictures_FetchUnusedPicIdx()
� e={
texture="Interface\\AddOns\\"..o.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
downloaded=�,
idx=e,
picid=t,
channel=a,
from=i,
}
Cmd3DCode_Screenshot_ExternalPictures[t]=e
� e
�
� � i(a,t,e)
� o=t/e
� a=a.width/a.height
� a>o �
� t,t/a
�
� e*a,e
�
�
� Cmd3DCode_Screenshot_ExternalPicture_Thumb(n)
� e=Cmd3DCode_Screenshot_CapturePictures[n]
� � e �
�
�
� a,t=160,120
� e.loaded �
a,t=i(e,a,t)
ExternalPicturesThumbFrame.thumb:SetTexture(e.texture)
�
ExternalPicturesThumbFrame.thumb:SetTexture("Interface\\AddOns\\"..o.."\\Textures\\external-pic-loading.tga")
�
ExternalPicturesThumbFrame.thumb:SetWidth(a)
ExternalPicturesThumbFrame.thumb:SetHeight(t)
ExternalPicturesThumbFrame.thumb.picidx=n
� ExternalPicturesThumbFrame.thumb
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
� Cmd3DCode_Screenshot_TakePhoto(n)
Cmd3DCode_ShottingMaskFrame:Hide()
� d=UIParent:IsVisible()
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
ThreeDimensionsCode_Blackboard:Hide()
ThreeDimensionsCode_SignalLamp.hide()
� s=time()
TakeScreenshot()
� o=CreateFrame("FRAME")
o:RegisterEvent("SCREENSHOT_SUCCEEDED")
o:SetScript("OnEvent",�(l,i)
� i=="SCREENSHOT_SUCCEEDED"�
ThreeDimensionsCode_Blackboard:Show()
ThreeDimensionsCode_SignalLamp.show()
� e~="jpg"�
SetCVar("screenshotFormat",e)
�
� t � d �
UIParent:Show()
�
� h=h(s)
� o,i=GetPlayerMapPosition("player")
� d,e=UnitFactionGroup("player")
� e={
texture=h.texture,
delSrcPic=r,
meta={
time=s,
hideui=t,
fullscreen=n,
realm=GetRealmName(),
character=GetUnitName("player"),
zone=GetZoneText(),
subzone=GetSubZoneText(),
lng=o,
lat=i,
race=UnitRace("player"),
faction=e,
class=UnitClass("player"),
gender=UnitSex("player"),
level=UnitLevel("player"),
},
}
� � n �
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
print("|cFFCD853F 没有检测到有爱客户端，无法完成屏幕截图的裁切和传送，请启动有爱客户端继续。 |r")
�
� i=="SCREENSHOT_FAILED"�
ThreeDimensionsCode_Blackboard:Show()
ThreeDimensionsCode_SignalLamp.how()
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
UIDropDownMenu_Initialize(e,�(e,a)
� s=_G["DropDownList"..(a � 1)]
� e=1
�#Cmd3DCode_Screenshot_CapturePictures �
� i,o � pairs(Cmd3DCode_Screenshot_CapturePictures)�
� o.loaded � e<=25 �
� t=UIDropDownMenu_CreateInfo()
t.notCheckable=�
t.text=o.title
t.arg1=o
t.func=�(t,e)
� e.uploaded �
n(e.idx)
�
print("截图尚未上传到网易有爱服务器，请等待...")
�
�
UIDropDownMenu_AddButton(t,a)
� t=_G["DropDownList"..a.."Button"..e]
� t �
t.isExternalPic=�
t.externalPicIdx=i
t.externalPicItem=o
t.__scrshot_onenter=�(e,...)
� t=Cmd3DCode_Screenshot_ExternalPicture_Thumb(e.externalPicIdx)
� � t � � �
ExternalPicturesThumbFrame:SetPoint("BOTTOMLEFT",s,"BOTTOMRIGHT",10,0)
ExternalPicturesThumbFrame:Show()
� e.externalPicItem.picid �
� e="http://w.163.com/"..e.externalPicItem.picid
ExternalPicturesThumbFrame_UrlFrame.text:SetText(e)
ExternalPicturesThumbFrame_BtnOpenInBrowser.url=e
�
ExternalPicturesThumbFrame_UrlFrame.text:SetText("正在上传 ...")
�
ExternalPicturesThumbFrame_BtnScrawl.picidx=e.externalPicIdx
ExternalPicturesThumbFrame_BtnScrawl.picitem=e.externalPicItem
ExternalPicturesThumbFrame_BtnSaveAs.picidx=e.externalPicIdx
ExternalPicturesThumbFrame_BtnSaveAs.picitem=e.externalPicItem
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
ExternalPicturesThumbFrame_BtnScrawl:SetScript("OnClick",�(e)
� t=h(e.picitem.time)
t.title=e.picitem.title.."(涂鸦)"
� e={
addonName="!!!163UI.3dcodecmd!!!",
picidx=e.picidx,
newidx=t.idx,
picid=e.picitem.picid,
width=e.picitem.width,
height=e.picitem.height,
}
ThreeDimensionsCode_Send("scrawl",json_encode(e))
�)
DropDownList1:HookScript("OnHide",�(e)
ExternalPicturesThumbFrame:Hide()
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
� a="%[.+w%.163%.com%/(%w+).+%]"
� � h(e,t)
�
startpos,endpos,picid=string.find(e,a)
� startpos �
e=e:sub(0,startpos-1)
..(t(picid)�"")..e:sub(endpos+1)
�
� � startpos
� e
�
� � s(e,a,t)
� � e � �"xx"�
� a,t=i(e,a,t)
�"|Hviewpic:"..e.picid.."|h|TInterface\\AddOns\\"..o.."\\External\\Image\\"..e.idx..".tga:"..t..":"..a.."|t|h"
�
ThreeDimensionsCode_SafePipe_CmdHandles["ir"]=�(a,e)
� a,i,o=strsplit(",",e)
a=tonumber(a)
� e=Cmd3DCode_Screenshot_CapturePictures[a]
� � e �
print("Cmd3DCode_Screenshot_CapturePictures[picidx] not exits",a)
�
�
e.width=tonumber(i)� 0
e.height=tonumber(o)� 0
e.loaded=�
print("正在上传 "..e.title.." ...")
t:SetText("正在上传 "..e.title.." ...")
t:Show()
�
ThreeDimensionsCode_SafePipe_CmdHandles["iu"]=�(a,e)
� a,o=strsplit(",",e)
a=tonumber(a)
� e=Cmd3DCode_Screenshot_CapturePictures[a]
� � e �
�
�
t:Hide()
� o=="!"�
print(e.title,"上传失败")
�
�
print(e.title,"上传完成")
�
� t="http://w.163.com/"..o
Cmd3DCode_Screenshot_ExternalPictures[o]=e
e.uploaded=�
e.picid=o
n(a)
Cmd3DCode_Screenshot_CapturePictures_EmitUploded(a)
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
� � r(t,...)
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
t=t.."[ "..s(e,120,90).." ]"
� a=1,10 �
� _G["ChatFrame"..a.."Tab"]:IsVisible()�
� o,s,n,i
� e.from.msgtype=="CHANNEL"�
o=r(e.from.channel,GetChatWindowChannels(a))
� o �
� a=d(e.from.channel,GetChannelList())
s,n,i=GetMessageTypeColor("CHANNEL"..a)
t="["..e.from.channelString.."] "..t
�
�
o=r(e.from.msgtype,GetChatWindowMessages(a))
s,n,i=GetMessageTypeColor(e.from.msgtype)
�
� o �
_G["ChatFrame"..a]:AddMessage(t,s,n,i,e.from.guid)
�
�
�
�
� i=0
� � e(p,n,e,t,y,r,w,f,l,u,a,c,o,d,...)
e=h(e,�(e)
� n=="CHAT_MSG_WHISPER_INFORM"� t==GetUnitName("player",�).."-"..GetRealmName()�
� e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(e)
� e=s(e,120,90)
�"[ "..e.." ]"
�
� o>i �
i=o
� o={
author=t,
msgtype=n:sub(10),
channel=a,
channelString=r,
guid=d,
}
� a=m(e,a,o)
� time()-cmd3dcode_lastPingTime()>45 �
print("收到来自"..t.."的截图: w.163.com/"..e.." ,请启动有爱客户端显示此图")
�
ThreeDimensionsCode_Send("loadpic",a.texture..","..e)
�
�""
�
�)
�#e<1,e,t,y,r,w,f,l,u,a,c,o,d,...
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
� a=250
� � o(t,e)
� � t:IsShown()�
e.cachedText=�
�
�
a=math.max(t:GetWidth(),a)
� t=e:GetText()�""
� t==e.cachedText � � �
� t=h(t,�(e)
� e=Cmd3DCode_Screenshot_ExternalPictures[e]
� � e � �""�
� e.width<=0 � �""�
� s(e,100,75)
�)
�#t>0 �
e:SetText(t)
e.cachedText=t
e:SetWidth(math.min(e:GetStringWidth(),a-14))
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
� a=CreateFrame("Frame")
a.interval=o
a:SetScript("OnUpdate",�(e,t)
e.interval=e.interval-t
� e.interval<0 �
e.interval=o
i()
�
�)
a:Show()
� a="\[截图 [%d:\(涂鸦\)]+ (%d+)\]"
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
.."[发来游戏截图，在浏览器中输入网易官方网址查看：http://w.163.com/"..a.picid.." ]"
..e:sub(o+1)
�
� � t
ChatEdit_ChooseBoxForSend():SetText(e)
�)
hooksecurefunc("AutoCompleteEditBox_OnEscapePressed",�()
t:Hide()
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
t:SetWidth(a.width)
t:SetHeight(a.height)
e:Show()
�
}
� s=SetItemRef
� SetItemRef(e,t,i,a)
� n,h=strmatch(e,"^(.+):(.+)$")
� � o[n]�
s(e,t,i,a)
�
�
o[n](h,e,t,i,a)
�
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=Cmd3DCode_Screenshot_Start]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()