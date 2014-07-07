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
� n=r-t-a
� i=d-e-o
� h=t+a
� s=e+o
Cmd3DCode_ShottingMaskFrame:SetWidth(r)
Cmd3DCode_ShottingMaskFrame:SetHeight(d)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetHeight(i)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,s)
Cmd3DCode_ShottingMaskFrameTOP:SetWidth(a)
Cmd3DCode_ShottingMaskFrameTOP:SetHeight(i)
Cmd3DCode_ShottingMaskFrameTOP:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",t,s)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetWidth(n)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetHeight(i)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",h,s)
Cmd3DCode_ShottingMaskFrameLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameLEFT:SetHeight(o)
Cmd3DCode_ShottingMaskFrameLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,e)
Cmd3DCode_ShottingMaskFrameRIGHT:SetWidth(n)
Cmd3DCode_ShottingMaskFrameRIGHT:SetHeight(o)
Cmd3DCode_ShottingMaskFrameRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",h,e)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOMLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,0)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetWidth(a)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetHeight(e)
Cmd3DCode_ShottingMaskFrameBOTTOM:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",t,0)
Cmd3DCode_ShottingMaskFrameBOTTOMRIGHT:SetWidth(n)
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
� � s(t)
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
� � p(e,i,a)
� t=ExternalPictures_FetchUnusedPicIdx()
� t={
texture="Interface\\AddOns\\"..o.."\\External\\Image\\"..t..".tga",
width=0,
height=0,
downloaded=�,
idx=t,
picid=e,
channel=i,
from=a,
}
Cmd3DCode_Screenshot_ExternalPictures[e]=t
� t
�
� calExternalPictureSize(e,a,t)
� e.width<=a � e.height<=t �
� e.width,e.height
�
� o=a/t
� e=e.width/e.height
� e>o �
� a,a/e
�
� t*e,t
�
�
� Cmd3DCode_Screenshot_ExternalPicture_Thumb(i)
� e=Cmd3DCode_Screenshot_CapturePictures[i]
� � e �
�
�
� a,t=160,120
� e.loaded �
a,t=calExternalPictureSize(e,a,t)
ExternalPicturesThumbFrame.thumb:SetTexture(e.texture)
�
ExternalPicturesThumbFrame.thumb:SetTexture("Interface\\AddOns\\"..o.."\\Textures\\external-pic-loading.tga")
�
ExternalPicturesThumbFrame.thumb:SetWidth(a)
ExternalPicturesThumbFrame.thumb:SetHeight(t)
ExternalPicturesThumbFrame.thumb.picidx=i
� ExternalPicturesThumbFrame.thumb
�
� Cmd3DCode_Screenshot_CapturePictures_FromPicId(t)
� a,e � pairs(Cmd3DCode_Screenshot_CapturePictures)�
� e.picid==t �
� e
�
�
� Cmd3DCode_CustomEmoticonsDB � Cmd3DCode_CustomEmoticonsDB.emoticons �
� e=Cmd3DCode_CustomEmoticonsDB.emoticons[t]
� e �
� e
�
�
�
� Cmd3DCode_Screenshot_ExternalPictures_FromPicId(e)
� Cmd3DCode_Screenshot_ExternalPictures[e]�
� Cmd3DCode_Screenshot_ExternalPictures[e]
�
� Cmd3DCode_CustomEmoticonsDB � Cmd3DCode_CustomEmoticonsDB.emoticons �
� e=Cmd3DCode_CustomEmoticonsDB.emoticons[e]
� e �
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
� r=UIParent:IsVisible()
� e=Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:GetChecked()� � � �
� d=Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()� � � �
� e �
print("隐藏UI")
UIParent:Hide()
�
� t=GetCVar("screenshotFormat")
� t~="jpg"�
SetCVar("screenshotFormat","jpg")
�
ThreeDimensionsCode_Blackboard:Hide()
ThreeDimensionsCode_SignalLamp.hide()
� i=time()
TakeScreenshot()
� o=CreateFrame("FRAME")
o:RegisterEvent("SCREENSHOT_SUCCEEDED")
o:SetScript("OnEvent",�(l,h)
� h=="SCREENSHOT_SUCCEEDED"�
ThreeDimensionsCode_Blackboard:Show()
ThreeDimensionsCode_SignalLamp.show()
� t~="jpg"�
SetCVar("screenshotFormat",t)
�
� e � r �
UIParent:Show()
�
� h=s(i)
� s,o=GetPlayerMapPosition("player")
� r,t=UnitFactionGroup("player")
� e={
texture=h.texture,
delSrcPic=d,
meta={
time=i,
hideui=e,
fullscreen=n,
realm=GetRealmName(),
character=GetUnitName("player"),
zone=GetZoneText(),
subzone=GetSubZoneText(),
lng=s,
lat=o,
race=UnitRace("player"),
faction=t,
class=UnitClass("player"),
gender=UnitSex("player"),
level=UnitLevel("player"),
},
}
� � n �
� o=UIParent:GetWidth()
� t=UIParent:GetHeight()
� n,s,h,i=Cmd3DCode_ViewFinderFrame:GetRect()
e.left=a(n/o,100)
e.top=(1-a(s/t,100))-a(i/t,100)
e.width=a(h/o,100)
e.height=a(i/t,100)
�
ThreeDimensionsCode_Send("screenshot",json_encode(e))
� time()-cmd3dcode_lastPingTime()>45 �
print("|cFFCD853F 没有检测到有爱客户端，无法完成屏幕截图的裁切和传送，请启动有爱客户端继续。 |r")
�
� h=="SCREENSHOT_FAILED"�
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
� � i(t)
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
� a,o=calExternalPictureSize(t,e:GetWidth(),e:GetHeight())
e:SetWidth(a)
e:SetHeight(o)
� a=e:CreateTexture(�,"BACKGROUND")
a:SetTexture(t.texture)
a:SetAllPoints(e)
�
� t=1,10 �
� e=CreateFrame("Frame","Cmd3DCode_Screenshot_ChatFrameButton"..t,_G["ChatFrame"..t.."EditBox"],"Cmd3DCode_Screenshot_ChatFrameButtonTemplate")
e:SetPoint("LEFT","ChatFrame"..t.."EditBoxLanguage","RIGHT",-8,0)
� a=e:CreateTexture()
a:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
a:SetAllPoints(e)
� a=e:CreateFontString()
a:SetFontObject(GameFontNormalSmall)
a:SetText("图")
a:SetAllPoints(e)
e:Show()
_G["ChatFrame"..t.."EditBox"].btnscreenshot=e
�
hooksecurefunc("ChatEdit_DeactivateChat",�(e)
� e.btnscreenshot �
e.btnscreenshot:Hide()
�
�)
hooksecurefunc("ChatEdit_ActivateChat",�(e)
� e.btnscreenshot �
e.btnscreenshot:Show()
�
�)
� e=CreateFrame("Button","Cmd3DCode_Screenshot_ChatFrameButton_MenuBtn",UIParent,"UIDropDownMenuTemplate")
e:Hide()
UIDropDownMenu_Initialize(e,�(e,a)
� s=_G["DropDownList"..(a � 1)]
� e=1
�#Cmd3DCode_Screenshot_CapturePictures �
� n,o � pairs(Cmd3DCode_Screenshot_CapturePictures)�
� o.loaded � e<=25 �
� t=UIDropDownMenu_CreateInfo()
t.notCheckable=�
t.text=o.title
t.arg1=o
t.func=�(t,e)
� e.uploaded �
i(e.idx)
�
print("截图尚未上传到网易有爱服务器，请等待...")
�
�
UIDropDownMenu_AddButton(t,a)
� t=_G["DropDownList"..a.."Button"..e]
� t �
t.isExternalPic=�
t.externalPicIdx=n
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
� t=s(e.picitem.time)
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
� � r(e,t)
�
startpos,endpos,picid=string.find(e,a)
� startpos �
e=e:sub(0,startpos-1)
..(t(picid)�"")..e:sub(endpos+1)
�
� � startpos
� e
�
� � h(e,a,i)
� � e � �"unkown picture"�
� t=e.texture �"Interface\\AddOns\\"..o.."\\External\\Image\\"..e.idx..".tga"
� a,o=calExternalPictureSize(e,a,i)
� e.type=="emoticon"�
�"|T"..t..":"..o..":"..a.."|t"
�
�"|Hviewpic:"..e.picid.."|h|T"..t..":"..o..":"..a.."|t|h"
�
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
i(a)
Cmd3DCode_Screenshot_CapturePictures_EmitUploded(a)
�
� � l(e,...)
� t=1,select("#",...),2 �
� t,a=select(t,...)
� e==a �
� t
�
�
� �
�
� � d(t,...)
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
t=t.."[ "..h(e,80,60).." ]"
� o=1,10 �
� _G["ChatFrame"..o.."Tab"]:IsVisible()�
� a,n,i,s
� e.from.msgtype=="CHANNEL"�
a=d(e.from.channel,GetChatWindowChannels(o))
� a �
� a=l(e.from.channel,GetChannelList())
n,i,s=GetMessageTypeColor("CHANNEL"..a)
t="["..e.from.channelString.."] "..t
�
�
a=d(e.from.msgtype,GetChatWindowMessages(o))
n,i,s=GetMessageTypeColor(e.from.msgtype)
�
� a �
_G["ChatFrame"..o]:AddMessage(t,n,i,s,e.from.guid)
�
�
�
�
� l=0
� � e(e,n,t,a,u,d,y,w,m,f,o,c,i,s,...)
t=r(t,�(e)
� n=="CHAT_MSG_WHISPER_INFORM"� a==GetUnitName("player",�).."-"..GetRealmName()�
� e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(e)
� e=h(e,80,60)
�"[ "..e.." ]"
�
� i>l �
l=i
� t={
author=a,
msgtype=n:sub(10),
channel=o,
channelString=d,
guid=s,
}
� t=p(e,o,t)
� time()-cmd3dcode_lastPingTime()>45 �
print("收到来自"..a.."的截图: w.163.com/"..e.." ,请启动有爱客户端显示此图")
�
ThreeDimensionsCode_Send("loadpic",t.texture..","..e)
�
�""
�
�)
�#t<1,t,a,u,d,y,w,m,f,o,c,i,s,...
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
� t=r(t,�(e)
� e=Cmd3DCode_Screenshot_ExternalPictures_FromPicId(e)
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
� o="%[截图 [%d:%(涂鸦%)]+ (%d+)%]"
� i="%[表情 ([0-9a-zA-Z]+)%]"
hooksecurefunc("AutoCompleteEditBox_OnEnterPressed",�()
� e=ChatEdit_ChooseBoxForSend()
� � e:IsVisible()�
�
�
� e=e:GetText()
� t,a=1,picidx
�
t,a,picidx=string.find(e,o)
picidx=tonumber(picidx)
� o=Cmd3DCode_Screenshot_CapturePictures[picidx]
� picidx � o � o.picid �
e=e:sub(1,t-1)
.."[发来了游戏截图，在浏览器中输入网易官方网址查看：http://w.163.com/"..o.picid.." ]"
..e:sub(a+1)
�
� � t
�
t,a,picid=string.find(e,i)
� picid �
e=e:sub(1,t-1)
.."[发来了表情图片，在浏览器中输入网易官方网址查看：http://w.163.com/"..picid.." ]"
..e:sub(a+1)
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
� n={
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
� SetItemRef(e,i,o,a)
� t,h=strmatch(e,"^(.+):(.+)$")
� � n[t]�
s(e,i,o,a)
�
�
n[t](h,e,i,o,a)
�
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=Cmd3DCode_Screenshot_Start]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()