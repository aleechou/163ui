local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ê bit==Í Á bit32~=Í Ò
bit=bit32
Æ
Ì t="!!!163UI.3dcodecmd!!!"
Ì a
Cmd3DCode_ShottingMaskFrame.texture_screenshot=Cmd3DCode_ShottingMaskFrame:CreateTexture()
Cmd3DCode_ShottingMaskFrame.texture_screenshot:SetAllPoints(Cmd3DCode_ShottingMaskFrame)
Cmd3DCode_ShottingMaskFrame.texture_screenshot:Hide()
Cmd3DCode_ShottingMaskFrame:HookScript("OnHide",É()
Cmd3DCode_ShottingMaskFrame.texture_screenshot:Hide()
Ê Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic.orivalue~=Í Ò
Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:SetChecked(Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic.orivalue)
Æ
Æ)
Ì o=CreateFrame("FRAME")
o:RegisterEvent("SCREENSHOT_SUCCEEDED")
o:RegisterEvent("SCREENSHOT_FAILED")
o:RegisterEvent("VARIABLES_LOADED")
o:SetScript("OnEvent",É(o,e)
Ê e=="SCREENSHOT_SUCCEEDED"Ï e=="SCREENSHOT_FAILED"Ò
Ê o.onScreenshotFinished Ò
o:onScreenshotFinished(e)
Ä
Ê e=="SCREENSHOT_SUCCEEDED"Ò
Ê a.screenshot.attachPrtScr==Ç Ò
Ñ
Æ
Ì e={
meta={time=time()},
texture="Interface\\AddOns\\"..t.."\\External\\Image\\"..ExternalPictures_FetchUnusedPicIdx()..".tga",
}
ThreeDimensionsCode_Send("screenshot-load",json_encode(e))
Æ
Æ
Å e=="VARIABLES_LOADED"Ò
Ê Î Cmd3DCode_Settings Ò Cmd3DCode_Settings={}Æ
a=Cmd3DCode_Settings
Ê Î a.screenshot Ò a.screenshot={}Æ
Cmd3DCode_ViewFinderFrame_ChkBtn_AttachPrtScr:SetChecked(a.screenshot.attachPrtScr~=Ç)
Æ
Æ)
ThreeDimensionsCode_SafePipe_CmdHandles["screenshot/screen-ready"]=É(t,e)
Ì t,e,a,a=strsplit(",",e)
Cmd3DCode_Screenshot_Start(tonumber(e),t)
Æ
Cmd3DCode_ShottingMaskFrame:SetPoint("TOPLEFT",0,0)
Cmd3DCode_ShottingMaskFrame:SetFrameStrata("TOOLTIP")
Cmd3DCode_ShottingMaskFrame:SetFrameLevel(125)
Cmd3DCode_ShottingMaskFrame:SetWidth(UIParent:GetWidth())
Cmd3DCode_ShottingMaskFrame:SetHeight(UIParent:GetHeight())
Ì É e(t)
Ì t=_G["Cmd3DCode_ShottingMaskFrame"..t]
t.texture=t:CreateTexture(Í,"BACKGROUND")
t.texture:SetTexture(.1,.1,.1,.5)
t.texture:SetAllPoints(t)
Ñ t
Æ
e("TOPLEFT")
e("TOP")
e("TOPRIGHT")
e("LEFT")
e("RIGHT")
e("BOTTOMLEFT")
e("BOTTOM")
e("BOTTOMRIGHT")
CoreUIEnableTooltip(ExternalPicturesThumbFrame_BtnSaveAs,"æˆªå›¾å¦å­˜ä¸º")
CoreUIEnableTooltip(ExternalPicturesThumbFrame_BtnScrawl,"æ¶‚é¸¦")
CoreUIEnableTooltip(ExternalPicturesThumbFrame_BtnOpenInBrowser,"åœ¨æµè§ˆå™¨ä¸­æ‰“å¼€")
CoreUIEnableTooltip(ExternalPicturesThumbFrame_UrlFrame,"æˆªå›¾å·²ç»åŒæ­¥åˆ°ç½‘æ˜“æœåŠ¡å™¨ï¼Œç‚¹å‡»å¤åˆ¶ç½‘å€")
É Cmd3DCode_UpdateViewFinderFrames()
Ì d=UIParent:GetWidth()
Ì r=UIParent:GetHeight()
Ì t,e,a,o=Cmd3DCode_ViewFinderFrame:GetRect()
Ê Î t Ï Î e Ï Î a Ï Î e Ò
Ñ
Æ
Ì h=d-t-a
Ì i=r-e-o
Ì n=t+a
Ì s=e+o
Cmd3DCode_ShottingMaskFrame:SetWidth(d)
Cmd3DCode_ShottingMaskFrame:SetHeight(r)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetWidth(t)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetHeight(i)
Cmd3DCode_ShottingMaskFrameTOPLEFT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",0,s)
Cmd3DCode_ShottingMaskFrameTOP:SetWidth(a)
Cmd3DCode_ShottingMaskFrameTOP:SetHeight(i)
Cmd3DCode_ShottingMaskFrameTOP:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",t,s)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetWidth(h)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetHeight(i)
Cmd3DCode_ShottingMaskFrameTOPRIGHT:SetPoint("BOTTOMLEFT",Cmd3DCode_ShottingMaskFrame,"BOTTOMLEFT",n,s)
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
Æ
Cmd3DCode_ViewFinderFrame:SetPoint("CENTER",Cmd3DCode_ShottingMaskFrame,"CENTER",0,0)
Cmd3DCode_ViewFinderFrame:SetBackdrop({
edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
edgeSize=10,
insets={left=0,right=0,top=0,bottom=0}
});
Cmd3DCode_ViewFinderFrame:SetBackdropBorderColor(1,1,1)
Cmd3DCode_ViewFinderFrame:RegisterForDrag("LeftButton","RightButton");
Cmd3DCode_ViewFinderFrame:EnableMouse(Ó)
Cmd3DCode_ViewFinderFrame:SetMovable(Ó)
Cmd3DCode_ViewFinderFrame:SetResizable(Ó)
Cmd3DCode_ViewFinderFrame:SetClampedToScreen(Ó)
Cmd3DCode_ViewFinderFrameDone:SetClampedToScreen(Ó)
Cmd3DCode_ViewFinderFrameDone:SetNormalTexture("Interface\\AddOns\\"..t.."\\Textures\\cupture.tga")
Cmd3DCode_ViewFinderFrameFullScreen:SetClampedToScreen(Ó)
Cmd3DCode_ViewFinderFrameFullScreen:SetNormalTexture("Interface\\AddOns\\"..t.."\\Textures\\fullscreen.tga")
Cmd3DCode_ViewFinderFrameCancel:SetClampedToScreen(Ó)
É Cmd3DCode_Screenshot_Start(e,a)
Cmd3DCode_ViewFinderFrame:SetWidth(400)
Cmd3DCode_ViewFinderFrame:SetHeight(300)
Cmd3DCode_ViewFinderFrame:SetPoint("CENTER",Cmd3DCode_ShottingMaskFrame,"CENTER",0,0)
Cmd3DCode_UpdateViewFinderFrames()
Cmd3DCode_ShottingMaskFrame:Show()
Ê e Ò
Cmd3DCode_ShottingMaskFrame.shottime=e
Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic.orivalue=Î Î Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()
Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:SetChecked(Ó)
Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:Hide()
Ì e="Interface\\AddOns\\"..t.."\\External\\Image\\"..a..".tga"
Cmd3DCode_ShottingMaskFrame.texture_screenshot:SetTexture(e)
Cmd3DCode_ShottingMaskFrame.texture_screenshot:Show()
Ä
Cmd3DCode_ShottingMaskFrame.shottime=Í
Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:Show()
Cmd3DCode_ShottingMaskFrame.texture_screenshot:Hide()
Æ
Æ
Ì a=ChatFrame1EditBox:CreateFontString()
a:SetFontObject(GameFontNormalSmall)
a:SetPoint("TOPLEFT")
a:SetPoint("BOTTOMRIGHT")
a:Hide()
Ì É i(e,t)
e=e*t
Ì a,e=math.modf(e,1)
e=e>=.5 Á 1 Ï 0
Ñ(a+e)/t
Æ
Ì É e(t)
Ì e=2;
Ğ
Ê e>t Ò
Ñ e;
Æ
e=bit.lshift(e,1);
Ô Ç
Æ
ExternalPicturesThumbFrame.background=ExternalPicturesThumbFrame:CreateTexture(Í,"BACKGROUND")
ExternalPicturesThumbFrame.background:SetTexture(.2,.2,.2,.7)
ExternalPicturesThumbFrame.background:SetAllPoints(ExternalPicturesThumbFrame)
ExternalPicturesThumbFrame.thumb=ExternalPicturesThumbFrame:CreateTexture()
ExternalPicturesThumbFrame.thumb:SetPoint("BOTTOMLEFT",34,22)
ExternalPicturesThumbFrame_UrlFrame.text=ExternalPicturesThumbFrame_UrlFrame:CreateFontString(Í,"OVERLAY","GameTooltipText")
ExternalPicturesThumbFrame_UrlFrame.text:SetPoint("BOTTOMLEFT")
ExternalPicturesThumbFrame_UrlFrame.text:SetText("Hello World!")
ExternalPicturesThumbFrame:SetPoint("CENTER")
Ì e=1
É ExternalPictures_FetchUnusedPicIdx()
idx=e
e=e+1
Ê e>2048 Ò
e=1
print("åŠ è½½å¤–éƒ¨è¾¾åˆ°ä¸Šé™ï¼Œä½ éœ€è¦é‡è½½ç•Œé¢æ¸…ç†å·²åŠ è½½å›¾ç‰‡åç»§ç»­")
Æ
Ñ idx
Æ
Cmd3DCode_Screenshot_CapturePictures={}
Cmd3DCode_Screenshot_ExternalPictures={}
Ì É n(a)
Ì e=ExternalPictures_FetchUnusedPicIdx()
Ì t={
texture="Interface\\AddOns\\"..t.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
loaded=Ç,
uploaded=Ç,
idx=e,
time=a,
title=date("æˆªå›¾ %H:%M:%S",a),
}
Cmd3DCode_Screenshot_CapturePictures[e]=t
Ñ t
Æ
Ì É w(e,o,i)
Ì a=ExternalPictures_FetchUnusedPicIdx()
Ì t={
texture="Interface\\AddOns\\"..t.."\\External\\Image\\"..a..".tga",
width=0,
height=0,
downloaded=Ç,
idx=a,
picid=e,
channel=o,
from=i,
}
Cmd3DCode_Screenshot_ExternalPictures[e]=t
Ñ t
Æ
É calExternalPictureSize(e,a,t)
Ê e.width<=a Á e.height<=t Ò
Ñ e.width,e.height
Æ
Ì o=a/t
Ì e=e.width/e.height
Ê e>o Ò
Ñ a,a/e
Ä
Ñ t*e,t
Æ
Æ
É Cmd3DCode_Screenshot_ExternalPicture_Thumb(i)
Ì e=Cmd3DCode_Screenshot_CapturePictures[i]
Ê Î e Ò
Ñ
Æ
Ì a,o=160,120
Ê e.loaded Ò
a,o=calExternalPictureSize(e,a,o)
ExternalPicturesThumbFrame.thumb:SetTexture(e.texture)
Ä
ExternalPicturesThumbFrame.thumb:SetTexture("Interface\\AddOns\\"..t.."\\Textures\\external-pic-loading.tga")
Æ
ExternalPicturesThumbFrame.thumb:SetWidth(a)
ExternalPicturesThumbFrame.thumb:SetHeight(o)
ExternalPicturesThumbFrame.thumb.picidx=i
Ñ ExternalPicturesThumbFrame.thumb
Æ
É Cmd3DCode_Screenshot_CapturePictures_FromPicId(t)
È a,e Ë pairs(Cmd3DCode_Screenshot_CapturePictures)Ã
Ê e.picid==t Ò
Ñ e
Æ
Æ
Ê Cmd3DCode_CustomEmoticonsDB Á Cmd3DCode_CustomEmoticonsDB.emoticons Ò
Ì e=Cmd3DCode_CustomEmoticonsDB.emoticons[t]
Ê e Ò
Ñ e
Æ
Æ
Æ
É Cmd3DCode_Screenshot_ExternalPictures_FromPicId(e)
Ê Cmd3DCode_Screenshot_ExternalPictures[e]Ò
Ñ Cmd3DCode_Screenshot_ExternalPictures[e]
Æ
Ê Cmd3DCode_CustomEmoticonsDB Á Cmd3DCode_CustomEmoticonsDB.emoticons Ò
Ì e=Cmd3DCode_CustomEmoticonsDB.emoticons[e]
Ê e Ò
Ñ e
Æ
Æ
Æ
É Cmd3DCode_Screenshot_CapturePictures_OnceUploded(e,t)
Ê Î Cmd3DCode_Screenshot_CapturePictures[e]Ò
print("æŒ‡å®šåºåˆ—çš„å›¾ç‰‡ä¸å­˜åœ¨",e)
Ñ
Æ
Ì e=Cmd3DCode_Screenshot_CapturePictures[e]
Ê e.picid Ò
t(e)
Ä
Ê Î e.onceHandles Ò
e.onceHandles={}
Æ
table.insert(e.onceHandles,t)
Æ
Æ
É Cmd3DCode_Screenshot_CapturePictures_EmitUploded(e)
Ê Î Cmd3DCode_Screenshot_CapturePictures[e]Ò
Ñ
Æ
Ì e=Cmd3DCode_Screenshot_CapturePictures[e]
Ê e.onceHandles Ò
È a,t Ë pairs(e.onceHandles)Ã
t(e)
Æ
e.onceHandles={}
Æ
Æ
É Cmd3DCode_Screenshot_TakePhoto(t)
Ì r=UIParent:IsVisible()
Ì a=Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:GetChecked()Á Ó Ï Ç
Ì h=Î Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()
Ì e=Cmd3DCode_ShottingMaskFrame.shottime Á Cmd3DCode_ShottingMaskFrame.shottime Ï time()
Cmd3DCode_ShottingMaskFrame:Hide()
Ì É s()
Ì r=n(e)
Ì o,s=GetPlayerMapPosition("player")
Ì d,n=UnitFactionGroup("player")
Ì e={
texture=r.texture,
delSrcPic=h,
meta={
time=e,
hideui=a,
fullscreen=t,
realm=GetRealmName(),
character=GetUnitName("player"),
zone=GetZoneText(),
subzone=GetSubZoneText(),
lng=o,
lat=s,
race=UnitRace("player"),
faction=n,
class=UnitClass("player"),
gender=UnitSex("player"),
level=UnitLevel("player"),
},
}
Ê Î t Ò
Ì o=UIParent:GetWidth()
Ì t=UIParent:GetHeight()
Ì n,s,h,a=Cmd3DCode_ViewFinderFrame:GetRect()
e.left=i(n/o,100)
e.top=(1-i(s/t,100))-i(a/t,100)
e.width=i(h/o,100)
e.height=i(a/t,100)
Æ
ThreeDimensionsCode_Send("screenshot",json_encode(e))
Ê time()-cmd3dcode_lastPingTime()>45 Ò
print("|cFFCD853F æ²¡æœ‰æ£€æµ‹åˆ°æœ‰çˆ±å®¢æˆ·ç«¯ï¼Œæ— æ³•å®Œæˆå±å¹•æˆªå›¾çš„è£åˆ‡å’Œä¼ é€ï¼Œè¯·å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯ç»§ç»­ã€‚ |r")
Æ
Æ
Ê Cmd3DCode_ShottingMaskFrame.shottime Ò
s()
Ä
Ê a Ò
UIParent:Hide()
Æ
Ì e=GetCVar("screenshotFormat")
Ê e~="jpg"Ò
SetCVar("screenshotFormat","jpg")
Æ
ThreeDimensionsCode_Blackboard:Hide()
ThreeDimensionsCode_SignalLamp.hide()
o.onScreenshotFinished=É(i,t)
o.onScreenshotFinished=Í
Ê t=="SCREENSHOT_SUCCEEDED"Ò
ThreeDimensionsCode_Blackboard:Show()
ThreeDimensionsCode_SignalLamp.show()
Ê e~="jpg"Ò
SetCVar("screenshotFormat",e)
Æ
Ê a Á r Ò
UIParent:Show()
Æ
s()
Å t=="SCREENSHOT_FAILED"Ò
ThreeDimensionsCode_Blackboard:Show()
ThreeDimensionsCode_SignalLamp.how()
Æ
Æ
TakeScreenshot()
Æ
Æ
StaticPopupDialogs["163UI-Screenshot:ClientNotFound"]={
text="æ²¡æœ‰æ£€æµ‹åˆ°æœ‰çˆ±å®¢æˆ·ç«¯ï¼Œæ— æ³•å®Œæˆå±å¹•æˆªå›¾çš„è£åˆ‡å’Œä¼ é€ï¼Œè¯·å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯ã€‚",
button1="å…³é—­",
timeout=0,
whileDead=Ó,
hideOnEscape=Ó,
preferredIndex=3,
}
Ì É i(t)
Ì a=Cmd3DCode_Screenshot_CapturePictures[t]
Ê Î a Ò
print("æœªèƒ½æ‰¾åˆ°åºå·ä¸º",t,"çš„æˆªå›¾")
Ñ
Æ
Ì e=ChatEdit_ChooseBoxForSend()
Ê Î e:IsShown()Ï ChatFrame1EditBox:GetAlpha()<1 Ò
ChatEdit_ActivateChat(e)
Æ
e:SetText("["..a.title.." "..t.."]")
Æ
É Cmd3DCode_Screenshot_ShowExternalPic(e,t)
Ì t=Cmd3DCode_Screenshot_CapturePictures[t]
Ê Î t Ò
Ñ
Æ
Ì o,a=calExternalPictureSize(t,e:GetWidth(),e:GetHeight())
e:SetWidth(o)
e:SetHeight(a)
Ì a=e:CreateTexture(Í,"BACKGROUND")
a:SetTexture(t.texture)
a:SetAllPoints(e)
Æ
Ì e=CreateFrame("Button","Cmd3DCode_Screenshot_ChatFrameButton_MenuBtn",UIParent,"UIDropDownMenuTemplate")
e:Hide()
UIDropDownMenu_Initialize(e,É(e,a)
Ì s=_G["DropDownList"..(a Ï 1)]
Ì e=1
Ê#Cmd3DCode_Screenshot_CapturePictures Ò
È n,o Ë pairs(Cmd3DCode_Screenshot_CapturePictures)Ã
Ê o.loaded Á e<=25 Ò
Ì t=UIDropDownMenu_CreateInfo()
t.notCheckable=Ó
t.text=o.title
t.arg1=o
t.func=É(t,e)
Ê e.uploaded Ò
i(e.idx)
Ä
print("æˆªå›¾å°šæœªä¸Šä¼ åˆ°ç½‘æ˜“æœ‰çˆ±æœåŠ¡å™¨ï¼Œè¯·ç­‰å¾…...")
Æ
Æ
UIDropDownMenu_AddButton(t,a)
Ì t=_G["DropDownList"..a.."Button"..e]
Ê t Ò
t.isExternalPic=Ó
t.externalPicIdx=n
t.externalPicItem=o
t.__scrshot_onenter=É(e,...)
Ì t=Cmd3DCode_Screenshot_ExternalPicture_Thumb(e.externalPicIdx)
Ê Î t Ò Ñ Æ
ExternalPicturesThumbFrame:SetPoint("BOTTOMLEFT",s,"BOTTOMRIGHT",10,0)
ExternalPicturesThumbFrame:Show()
Ê e.externalPicItem.picid Ò
Ì e="http://w.163.com/"..e.externalPicItem.picid
ExternalPicturesThumbFrame_UrlFrame.text:SetText(e)
ExternalPicturesThumbFrame_BtnOpenInBrowser.url=e
Ä
ExternalPicturesThumbFrame_UrlFrame.text:SetText("æ­£åœ¨ä¸Šä¼  ...")
Æ
ExternalPicturesThumbFrame_BtnScrawl.picidx=e.externalPicIdx
ExternalPicturesThumbFrame_BtnScrawl.picitem=e.externalPicItem
ExternalPicturesThumbFrame_BtnSaveAs.picidx=e.externalPicIdx
ExternalPicturesThumbFrame_BtnSaveAs.picitem=e.externalPicItem
Æ
Æ
e=e+1
Æ
Æ
Æ
Ì t=UIDropDownMenu_CreateInfo()
t.text="åŠŸèƒ½è¯´æ˜(?)"
t.notCheckable=Ó
t.hasOpacity=Ó
t.func=É()
Cmd3DCode_Screenshot_Help:Show()
Æ
UIDropDownMenu_AddButton(t,a)
e=e+1
Ì t=UIDropDownMenu_CreateInfo()
t.text="æˆªå±å‘é€"
t.func=É()Cmd3DCode_Screenshot_Start()Æ
t.notCheckable=Ó
t.tooltipTitle="æˆªå–å±å¹•"
t.tooltipText="æˆªå–å±å¹•å‘é€åˆ°å¥½å‹æˆ–èŠå¤©é¢‘é“"
t.hasOpacity=Ó
UIDropDownMenu_AddButton(t,a)
Ì t=_G["DropDownList"..(a Ï 1).."Button"..e]
t.__scrshot_onenter=É(e,...)
GameTooltip:SetOwner(e,'ANCHOR_BOTTOMRIGHT')
GameTooltip:AddLine("å¿«æ·é”®ï¼šCtrl+PrtScr")
GameTooltip:Show()
Æ
t.__scrshot_onleave=É(t,...)
GameTooltip:Hide()
Æ
e=e+1
Æ,"MENU")
ExternalPicturesThumbFrame_BtnScrawl:SetScript("OnClick",É(e)
Ì t=n(e.picitem.time)
t.title=e.picitem.title.."(æ¶‚é¸¦)"
Ì e={
addonName="!!!163UI.3dcodecmd!!!",
picidx=e.picidx,
newidx=t.idx,
picid=e.picitem.picid,
width=e.picitem.width,
height=e.picitem.height,
}
ThreeDimensionsCode_Send("scrawl",json_encode(e))
Æ)
DropDownList1:HookScript("OnHide",É(e)
ExternalPicturesThumbFrame:Hide()
È e=1,UIDROPDOWNMENU_MAXBUTTONS,1 Ã
button=_G["DropDownList"..(level Ï 1).."Button"..e]
Ê button Á button.isExternalPic Ò
button.externalPicIdx=Í
button.originOnEnter=Í
button.originOnLeave=Í
button.isExternalPic=Í
button.__scrshot_onenter=Í
button.__scrshot_onleave=Í
Æ
Æ
Æ)
È e=1,UIDROPDOWNMENU_MAXBUTTONS,1 Ã
button=_G["DropDownList1Button"..e]
button:HookScript("OnEnter",É(e,...)
Ê e.__scrshot_onenter Ò
e:__scrshot_onenter(...)
Æ
Æ)
button:HookScript("OnLeave",É(e,...)
Ê e.__scrshot_onleave Ò
e:__scrshot_onleave(...)
Æ
Æ)
Æ
Ì n="%[.+w%.163%.com%/(%w+).+%]"
Ì É r(e,t)
Ğ
startpos,endpos,picid=string.find(e,n)
Ê startpos Ò
e=e:sub(0,startpos-1)
..(t(picid)Ï"")..e:sub(endpos+1)
Æ
Ô Î startpos
Ñ e
Æ
Ì É h(e,a,i)
Ê Î e Ò Ñ"unkown picture"Æ
Ì o=e.texture Ï"Interface\\AddOns\\"..t.."\\External\\Image\\"..e.idx..".tga"
Ì t,a=calExternalPictureSize(e,a,i)
Ê e.type=="emoticon"Ò
Ñ"|T"..o..":"..a..":"..t.."|t"
Ä
Ñ"|Hviewpic:"..e.picid.."|h|T"..o..":"..a..":"..t.."|t|h"
Æ
Æ
ThreeDimensionsCode_SafePipe_CmdHandles["screenshot/ready"]=É(t,e)
Ì t,i,o=strsplit(",",e)
t=tonumber(t)
Ì e=Cmd3DCode_Screenshot_CapturePictures[t]
Ê Î e Ò
print("Cmd3DCode_Screenshot_CapturePictures[picidx] not exits",t)
Ñ
Æ
e.width=tonumber(i)Ï 0
e.height=tonumber(o)Ï 0
e.loaded=Ó
print("æ­£åœ¨ä¸Šä¼  "..e.title.." ...")
a:SetText("æ­£åœ¨ä¸Šä¼  "..e.title.." ...")
a:Show()
Æ
ThreeDimensionsCode_SafePipe_CmdHandles["screenshot/uploaded"]=É(t,e)
Ì t,o=strsplit(",",e)
t=tonumber(t)
Ì e=Cmd3DCode_Screenshot_CapturePictures[t]
Ê Î e Ò
Ñ
Æ
a:Hide()
Ê o=="!"Ò
print(e.title,"ä¸Šä¼ å¤±è´¥")
Ñ
Ä
print(e.title,"ä¸Šä¼ å®Œæˆ")
Æ
Ì a="http://w.163.com/"..o
Cmd3DCode_Screenshot_ExternalPictures[o]=e
e.uploaded=Ó
e.picid=o
i(t)
Cmd3DCode_Screenshot_CapturePictures_EmitUploded(t)
Æ
Ì É l(t,...)
È e=1,select("#",...),2 Ã
Ì e,a=select(e,...)
Ê t==a Ò
Ñ e
Æ
Æ
Ñ Í
Æ
Ì É d(t,...)
È e=1,select("#",...)Ã
Ê select(e,...)==t Ò
Ñ e
Æ
Æ
Ñ Ç
Æ
Ì É i(e)
Ì t=GetRealmName()
Ì a=#e-(#t+1)
Ê e:sub(a+2)==t Ò
Ñ e:sub(1,a)
Ä
Ñ e
Æ
Æ
ThreeDimensionsCode_SafePipe_CmdHandles["screenshot/downloaded"]=É(t,e)
Ì o,a,t=strsplit(",",e)
Ê(a=="0"Á t=="0")Ï(a==""Á t=="")Ò
print("å¤–éƒ¨å›¾ç‰‡ä¸‹è½½å¤±è´¥ï¼Œå¯èƒ½æ˜¯ç½‘ç»œåŸå› é€ æˆ")
Æ
Ì e=Cmd3DCode_Screenshot_ExternalPictures[o]
Ê Î e Ò
print("æœªèƒ½æ‰¾åˆ°IDä¸º",o,"çš„æˆªå›¾")
Ñ
Æ
e.downloaded=Ó
e.width=tonumber(a)
e.height=tonumber(t)
Ì t="|Hplayer:"..e.from.author.."|h["..i(e.from.author).."]|h: å‘æ¥äº†å›¾ç‰‡ "
t=t.."[ "..h(e,80,60).." ]"
È a=1,10 Ã
Ê _G["ChatFrame"..a.."Tab"]:IsVisible()Ò
Ì o,n,i,s
Ê e.from.msgtype=="CHANNEL"Ò
o=d(e.from.channel,GetChatWindowChannels(a))
Ê o Ò
Ì a=l(e.from.channel,GetChannelList())
n,i,s=GetMessageTypeColor("CHANNEL"..a)
t="["..e.from.channelString.."] "..t
Æ
Ä
o=d(e.from.msgtype,GetChatWindowMessages(a))
n,i,s=GetMessageTypeColor(e.from.msgtype)
Æ
Ê o Ò
_G["ChatFrame"..a]:AddMessage(t,n,i,s,e.from.guid)
Æ
Æ
Æ
Æ
Ì n=0
Ì É e(t,s,a,e,f,d,c,u,m,y,o,p,i,l,...)
a=r(a,É(t)
Ê s=="CHAT_MSG_WHISPER_INFORM"Ï e==GetUnitName("player",Ç).."-"..GetRealmName()Ò
Ì e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(t)
Ì e=h(e,80,60)
Ñ"[ "..e.." ]"
Ä
Ê i>n Ò
n=i
Ì a={
author=e,
msgtype=s:sub(10),
channel=o,
channelString=d,
guid=l,
}
Ì a=w(t,o,a)
Ê time()-cmd3dcode_lastPingTime()>45 Ò
print("æ”¶åˆ°æ¥è‡ª"..e.."çš„æˆªå›¾: w.163.com/"..t.." ,è¯·å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯æ˜¾ç¤ºæ­¤å›¾")
Æ
ThreeDimensionsCode_Send("loadpic",a.texture..","..t)
Æ
Ñ""
Æ
Æ)
Ñ#a<1,a,e,f,d,c,u,m,y,o,p,i,l,...
Æ
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
Ì i=250
Ì É n(t,e)
Ê Î t:IsShown()Ò
e.cachedText=Í
Ñ
Æ
i=math.max(t:GetWidth(),i)
Ì t=e:GetText()Ï""
Ê t==e.cachedText Ò Ñ Æ
Ì t=r(t,É(e)
Ì e=Cmd3DCode_Screenshot_ExternalPictures_FromPicId(e)
Ê Î e Ò Ñ""Æ
Ê e.width<=0 Ò Ñ""Æ
Ñ h(e,100,75)
Æ)
Ê#t>0 Ò
e:SetText(t)
e.cachedText=t
e:SetWidth(math.min(e:GetStringWidth(),i-14))
Æ
Æ
Ì É i()
È e=1,WorldFrame:GetNumChildren()Ã
Ì e=select(e,WorldFrame:GetChildren())
Ì t=e:GetBackdrop()
Ê t Á t.bgFile=="Interface\\Tooltips\\ChatBubble-Background"Ò
È t=1,e:GetNumRegions()Ã
Ì t=select(t,e:GetRegions())
Ê t:GetObjectType()=="FontString"Ò
n(e,t)
Æ
Æ
Æ
Æ
Æ
Ì t=.3
Ì e=t
o:SetScript("OnUpdate",É(o,a)
e=e-a
Ê e<0 Ò
e=t
i()
Æ
Æ)
Ì o="%[æˆªå›¾ [%d:%(æ¶‚é¸¦%)]+ (%d+)%]"
Ì i="%[è¡¨æƒ… ([0-9a-zA-Z]+)%]"
hooksecurefunc("AutoCompleteEditBox_OnEnterPressed",É()
Ì e=ChatEdit_ChooseBoxForSend()
Ê Î e:IsVisible()Ò
Ñ
Æ
Ì e=e:GetText()
Ì t,a=1,picidx
Ğ
t,a,picidx=string.find(e,o)
picidx=tonumber(picidx)
Ì o=Cmd3DCode_Screenshot_CapturePictures[picidx]
Ê picidx Á o Á o.picid Ò
e=e:sub(1,t-1)
.."[å‘æ¥äº†æ¸¸æˆæˆªå›¾ï¼Œåœ¨æµè§ˆå™¨ä¸­è¾“å…¥ç½‘æ˜“å®˜æ–¹ç½‘å€æŸ¥çœ‹ï¼šhttp://w.163.com/"..o.picid.." ]"
..e:sub(a+1)
Æ
Ô Î t
Ğ
t,a,picid=string.find(e,i)
Ê picid Ò
e=e:sub(1,t-1)
.."[å‘æ¥äº†è¡¨æƒ…å›¾ç‰‡ï¼Œåœ¨æµè§ˆå™¨ä¸­è¾“å…¥ç½‘æ˜“å®˜æ–¹ç½‘å€æŸ¥çœ‹ï¼šhttp://w.163.com/"..picid.." ]"
..e:sub(a+1)
Æ
Ô Î t
ChatEdit_ChooseBoxForSend():SetText(e)
Æ)
hooksecurefunc("AutoCompleteEditBox_OnEscapePressed",É()
a:Hide()
Æ)
Ì e=CreateFrame("FRAME","Cmd3DCode_Screenshot_PicViewer",UIParent)
e:SetFrameStrata("TOOLTIP")
e:SetFrameLevel(120)
e:SetAllPoints(UIParent)
e:Hide()
e.bg=e:CreateTexture()
e.bg:SetTexture(.1,.1,.1,.7)
e.bg:SetAllPoints(e)
e:EnableKeyboard(Ó);
e:SetPropagateKeyboardInput(Ó);
e:SetScript("OnKeyDown",É(e,t,...)
Ê t=="ESCAPE"Ò
e:Hide()
e:SetPropagateKeyboardInput(Ç)
Ñ Ç
Æ
e:SetPropagateKeyboardInput(Ó);
Æ)
e:SetScript("OnMouseDown",É(e)
e:Hide()
Æ)
Ì t=CreateFrame("FRAME","Cmd3DCode_Screenshot_PicViewerPhoto",e)
t:SetPoint("CENTER")
t:SetWidth(403)
t:SetHeight(300)
t.texture=t:CreateTexture(Í,"BACKGROUND")
t.texture:SetAllPoints(t)
Ì a={
viewpic=É(o,a,a,a,a,a)
Ì a=Cmd3DCode_Screenshot_ExternalPictures[o]
Ê Î a Ò
print("picid",o,"æ— æ•ˆ")
Ñ
Æ
t.texture:SetTexture(a.texture)
t:SetWidth(a.width)
t:SetHeight(a.height)
e:Show()
Æ
}
Ì s=SetItemRef
É SetItemRef(e,n,o,i)
Ì t,h=strmatch(e,"^(.+):(.+)$")
Ê Î a[t]Ò
s(e,n,o,i)
Ñ
Æ
a[t](h,e,n,o,i)
Æ
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=É()Cmd3DCode_Screenshot_Start()Æ]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()