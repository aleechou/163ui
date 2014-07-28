local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� bit==� � bit32~=� �
bit=bit32
�
� t="!!!163UI.3dcodecmd!!!"
� e
Cmd3DCode_ShottingMaskFrame.texture_screenshot=Cmd3DCode_ShottingMaskFrame:CreateTexture()
Cmd3DCode_ShottingMaskFrame.texture_screenshot:SetAllPoints(Cmd3DCode_ShottingMaskFrame)
Cmd3DCode_ShottingMaskFrame.texture_screenshot:Hide()
Cmd3DCode_ShottingMaskFrame:HookScript("OnHide",�()
Cmd3DCode_ShottingMaskFrame.texture_screenshot:Hide()
� Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic.orivalue~=� �
Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:SetChecked(Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic.orivalue)
�
�)
� a=CreateFrame("FRAME")
a:RegisterEvent("SCREENSHOT_SUCCEEDED")
a:RegisterEvent("SCREENSHOT_FAILED")
a:RegisterEvent("VARIABLES_LOADED")
a:SetScript("OnEvent",�(o,a)
� a=="SCREENSHOT_SUCCEEDED"� a=="SCREENSHOT_FAILED"�
� o.onScreenshotFinished �
o:onScreenshotFinished(a)
�
� a=="SCREENSHOT_SUCCEEDED"�
� e.screenshot.attachPrtScr==� �
�
�
� e={
meta={time=time()},
texture="Interface\\AddOns\\"..t.."\\External\\Image\\"..ExternalPictures_FetchUnusedPicIdx()..".tga",
}
ThreeDimensionsCode_Send("screenshot-load",json_encode(e))
�
�
� a=="VARIABLES_LOADED"�
� � Cmd3DCode_Settings � Cmd3DCode_Settings={}�
e=Cmd3DCode_Settings
� � e.screenshot � e.screenshot={}�
Cmd3DCode_ViewFinderFrame_ChkBtn_AttachPrtScr:SetChecked(e.screenshot.attachPrtScr~=�)
�
�)
ThreeDimensionsCode_SafePipe_CmdHandles["screenshot/screen-ready"]=�(t,e)
� e,t,a,a=strsplit(",",e)
Cmd3DCode_Screenshot_Start(tonumber(t),e)
�
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
� � l(e,s)
� a,t,e,o=e:GetRect()
� i=a+e
� n=t+o
� o,e,h,s=s:GetRect()
� h=o+h
� s=e+s
� i=i<h � i � h
� a=a>o � a � o
� a>=i �
� �
�
� o=n<s � n � s
� e=t>e � t � e
� e>=o �
� �
�
� a,o,i-a,o-e
�
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
� h=r-t-a
� s=d-e-o
� n=t+a
� i=e+o
Cmd3DCode_ShottingMaskFrame:SetWidth(r)
Cmd3DCode_ShottingMaskFrame:SetHeight(d)
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
� e,e,o,a=ChatFrame1:GetRect()
� i,i,e,t=l(Cmd3DCode_ViewFinderFrame,ChatFrame1)
� e �(o*a)/5<e*t �
Cmd3DCode_ViewFinderFrame_ChkBtn_Public:SetChecked(�)
�
Cmd3DCode_ViewFinderFrame_ChkBtn_Public:SetChecked(�)
�
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
Cmd3DCode_ViewFinderFrameDone:SetNormalTexture("Interface\\AddOns\\"..t.."\\Textures\\cupture.tga")
Cmd3DCode_ViewFinderFrameFullScreen:SetClampedToScreen(�)
Cmd3DCode_ViewFinderFrameFullScreen:SetNormalTexture("Interface\\AddOns\\"..t.."\\Textures\\fullscreen.tga")
Cmd3DCode_ViewFinderFrameCancel:SetClampedToScreen(�)
� Cmd3DCode_Screenshot_Start(e,a)
Cmd3DCode_ViewFinderFrame:SetWidth(400)
Cmd3DCode_ViewFinderFrame:SetHeight(300)
Cmd3DCode_ViewFinderFrame:SetPoint("CENTER",Cmd3DCode_ShottingMaskFrame,"CENTER",0,0)
Cmd3DCode_UpdateViewFinderFrames()
Cmd3DCode_ShottingMaskFrame:Show()
� e �
Cmd3DCode_ShottingMaskFrame.shottime=e
Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic.orivalue=� � Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()
Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:SetChecked(�)
Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:Hide()
� e="Interface\\AddOns\\"..t.."\\External\\Image\\"..a..".tga"
Cmd3DCode_ShottingMaskFrame.texture_screenshot:SetTexture(e)
Cmd3DCode_ShottingMaskFrame.texture_screenshot:Show()
�
Cmd3DCode_ShottingMaskFrame.shottime=�
Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:Show()
Cmd3DCode_ShottingMaskFrame.texture_screenshot:Hide()
�
�
� e=1,10 �
� e=_G["ChatFrame"..e.."EditBox"]
e.frmPicUploading=e:CreateFontString()
e.frmPicUploading:SetFontObject(GameFontNormalSmall)
e.frmPicUploading:SetPoint("TOPLEFT")
e.frmPicUploading:SetPoint("BOTTOMRIGHT")
e.frmPicUploading:Hide()
�
� � o(e,t)
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
ExternalPicturesThumbFrame.background=ExternalPicturesThumbFrame:CreateTexture(�,"BACKGROUND")
ExternalPicturesThumbFrame.background:SetTexture(.2,.2,.2,.7)
ExternalPicturesThumbFrame.background:SetAllPoints(ExternalPicturesThumbFrame)
ExternalPicturesThumbFrame.thumb=ExternalPicturesThumbFrame:CreateTexture()
ExternalPicturesThumbFrame.thumb:SetPoint("BOTTOMLEFT",34,22)
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
print("加载外部达到上限，你需要重载界面清理已加载图片后继续")
�
� idx
�
Cmd3DCode_Screenshot_CapturePictures={}
Cmd3DCode_Screenshot_ExternalPictures={}
� � s(a)
� e=ExternalPictures_FetchUnusedPicIdx()
� t={
texture="Interface\\AddOns\\"..t.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
loaded=�,
uploaded=�,
idx=e,
time=a,
title=date("截图 %H:%M:%S",a),
}
Cmd3DCode_Screenshot_CapturePictures[e]=t
� t
�
� � u(a,o,i)
� e=ExternalPictures_FetchUnusedPicIdx()
� e={
texture="Interface\\AddOns\\"..t.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
downloaded=�,
idx=e,
picid=a,
channel=o,
from=i,
}
Cmd3DCode_Screenshot_ExternalPictures[a]=e
� e
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
� o,a=160,120
� e.loaded �
o,a=calExternalPictureSize(e,o,a)
ExternalPicturesThumbFrame.thumb:SetTexture(e.texture)
�
ExternalPicturesThumbFrame.thumb:SetTexture("Interface\\AddOns\\"..t.."\\Textures\\external-pic-loading.tga")
�
ExternalPicturesThumbFrame.thumb:SetWidth(o)
ExternalPicturesThumbFrame.thumb:SetHeight(a)
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
� Cmd3DCode_Screenshot_TakePhoto(t)
� r=UIParent:IsVisible()
� i=Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:GetChecked()� � � �
� d=� Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()
� e=Cmd3DCode_ShottingMaskFrame.shottime � Cmd3DCode_ShottingMaskFrame.shottime � time()
Cmd3DCode_ShottingMaskFrame:Hide()
� � n()
� s=s(e)
� n,a=GetPlayerMapPosition("player")
� r,h=UnitFactionGroup("player")
� e={
texture=s.texture,
delSrcPic=d,
meta={
time=e,
hideui=i,
public=Cmd3DCode_ViewFinderFrame_ChkBtn_Public:GetChecked()� � � �,
fullscreen=t,
realm=GetRealmName(),
character=GetUnitName("player"),
zone=GetZoneText(),
subzone=GetSubZoneText(),
lng=n,
lat=a,
race=UnitRace("player"),
faction=h,
class=UnitClass("player"),
gender=UnitSex("player"),
level=UnitLevel("player"),
},
}
� � t �
� a=UIParent:GetWidth()
� t=UIParent:GetHeight()
� s,h,n,i=Cmd3DCode_ViewFinderFrame:GetRect()
e.left=o(s/a,100)
e.top=(1-o(h/t,100))-o(i/t,100)
e.width=o(n/a,100)
e.height=o(i/t,100)
�
ThreeDimensionsCode_Send("screenshot",json_encode(e))
� time()-cmd3dcode_lastPingTime()>45 �
print("|cFFCD853F 没有检测到有爱客户端，无法完成屏幕截图的裁切和传送，请启动有爱客户端继续。 |r")
�
�
� Cmd3DCode_ShottingMaskFrame.shottime �
n()
�
� i �
UIParent:Hide()
�
� e=GetCVar("screenshotFormat")
� e~="jpg"�
SetCVar("screenshotFormat","jpg")
�
ThreeDimensionsCode_Blackboard:Hide()
ThreeDimensionsCode_SignalLamp.hide()
a.onScreenshotFinished=�(o,t)
a.onScreenshotFinished=�
� t=="SCREENSHOT_SUCCEEDED"�
ThreeDimensionsCode_Blackboard:Show()
ThreeDimensionsCode_SignalLamp.show()
� e~="jpg"�
SetCVar("screenshotFormat",e)
�
� i � r �
UIParent:Show()
�
n()
� t=="SCREENSHOT_FAILED"�
ThreeDimensionsCode_Blackboard:Show()
ThreeDimensionsCode_SignalLamp.how()
�
�
TakeScreenshot()
�
�
StaticPopupDialogs["163UI-Screenshot:ClientNotFound"]={
text="没有检测到有爱客户端，无法完成屏幕截图的裁切和传送，请启动有爱客户端。",
button1="关闭",
timeout=0,
whileDead=�,
hideOnEscape=�,
preferredIndex=3,
}
� � i(e)
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
� a,o=calExternalPictureSize(t,e:GetWidth(),e:GetHeight())
e:SetWidth(a)
e:SetHeight(o)
� a=e:CreateTexture(�,"BACKGROUND")
a:SetTexture(t.texture)
a:SetAllPoints(e)
�
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
t.func=�()Cmd3DCode_Screenshot_Start()�
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
� o="%[.+w%.163%.com%/(%w+).+%]"
� � h(e,t)
�
startpos,endpos,picid=string.find(e,o)
� startpos �
e=e:sub(0,startpos-1)
..(t(picid)�"")..e:sub(endpos+1)
�
� � startpos
� e
�
� � n(e,a,i)
� � e � �"unkown picture"�
� o=e.texture �"Interface\\AddOns\\"..t.."\\External\\Image\\"..e.idx..".tga"
� a,t=calExternalPictureSize(e,a,i)
� e.type=="emoticon"�
�"|T"..o..":"..t..":"..a.."|t"
�
�"|Hviewpic:"..e.picid.."|h|T"..o..":"..t..":"..a.."|t|h"
�
�
ThreeDimensionsCode_SafePipe_CmdHandles["screenshot/ready"]=�(t,e)
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
� t=1,10 �
� _G["ChatFrame"..t.."Tab"]:IsVisible()�
_G["ChatFrame"..t]:AddMessage("正在上传 "..e.title.." ...")
� t=_G["ChatFrame"..t.."EditBox"]
t.frmPicUploading:SetText("正在上传 "..e.title.." ...")
t.frmPicUploading:Show()
�
�
�
ThreeDimensionsCode_SafePipe_CmdHandles["screenshot/uploaded"]=�(t,e)
� t,a=strsplit(",",e)
t=tonumber(t)
� e=Cmd3DCode_Screenshot_CapturePictures[t]
� � e �
�
�
� e=1,10 �
� _G["ChatFrame"..e.."Tab"]:IsVisible()�
_G["ChatFrame"..e.."EditBox"].frmPicUploading:Hide()
�
�
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
i(t)
Cmd3DCode_Screenshot_CapturePictures_EmitUploded(t)
�
� � d(t,...)
� e=1,select("#",...),2 �
� e,a=select(e,...)
� t==a �
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
ThreeDimensionsCode_SafePipe_CmdHandles["screenshot/downloaded"]=�(t,e)
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
t=t.."[ "..n(e,80,60).." ]"
� o=1,10 �
� _G["ChatFrame"..o.."Tab"]:IsVisible()�
� a,s,i,n
� e.from.msgtype=="CHANNEL"�
a=r(e.from.channel,GetChatWindowChannels(o))
� a �
� a=d(e.from.channel,GetChannelList())
s,i,n=GetMessageTypeColor("CHANNEL"..a)
t="["..e.from.channelString.."] "..t
�
�
a=r(e.from.msgtype,GetChatWindowMessages(o))
s,i,n=GetMessageTypeColor(e.from.msgtype)
�
� a �
_G["ChatFrame"..o]:AddMessage(t,s,i,n,e.from.guid)
�
�
�
�
� r=0
� � e(t,s,a,e,f,l,m,p,y,w,i,c,o,d,...)
a=h(a,�(t)
� s=="CHAT_MSG_WHISPER_INFORM"� e==GetUnitName("player",�).."-"..GetRealmName()�
� e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(t)
� e=n(e,80,60)
�"[ "..e.." ]"
�
� o>r �
r=o
� a={
author=e,
msgtype=s:sub(10),
channel=i,
channelString=l,
guid=d,
}
� a=u(t,i,a)
� time()-cmd3dcode_lastPingTime()>45 �
print("收到来自"..e.."的截图: w.163.com/"..t.." ,请启动有爱客户端显示此图")
�
ThreeDimensionsCode_Send("loadpic",a.texture..","..t)
�
�""
�
�)
�#a<1,a,e,f,l,m,p,y,w,i,c,o,d,...
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
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER",e)
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
� a=h(a,�(e)
� e=Cmd3DCode_Screenshot_ExternalPictures_FromPicId(e)
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
� t=.3
� e=t
a:SetScript("OnUpdate",�(o,a)
e=e-a
� e<0 �
e=t
i()
�
�)
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
� e=1,10 �
� _G["ChatFrame"..e.."Tab"]:IsVisible()�
_G["ChatFrame"..e.."EditBox"].frmPicUploading:Hide()
�
�
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
� SetItemRef(e,o,n,i)
� t,h=strmatch(e,"^(.+):(.+)$")
� � a[t]�
s(e,o,n,i)
�
�
a[t](h,e,o,n,i)
�
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=�()Cmd3DCode_Screenshot_Start()�]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()