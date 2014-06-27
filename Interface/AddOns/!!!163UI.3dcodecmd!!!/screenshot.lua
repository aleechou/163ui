local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ê bit==Í Á bit32~=Í Ò
bit=bit32
Æ
Ì i="!!!163UI.3dcodecmd!!!"
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
É Cmd3DCode_UpdateViewFinderFrames()
Ì r=UIParent:GetWidth()
Ì d=UIParent:GetHeight()
Ì t,e,a,o=Cmd3DCode_ViewFinderFrame:GetRect()
Ê Î t Ï Î e Ï Î a Ï Î e Ò
Ñ
Æ
Ì h=r-t-a
Ì s=d-e-o
Ì i=t+a
Ì n=e+o
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
Cmd3DCode_ViewFinderFrameDone:SetNormalTexture("Interface\\AddOns\\"..i.."\\Textures\\cupture.tga")
Cmd3DCode_ViewFinderFrameFullScreen:SetClampedToScreen(Ó)
Cmd3DCode_ViewFinderFrameFullScreen:SetNormalTexture("Interface\\AddOns\\"..i.."\\Textures\\fullscreen.tga")
Cmd3DCode_ViewFinderFrameCancel:SetClampedToScreen(Ó)
É Cmd3DCode_Screenshot_Start()
Cmd3DCode_ViewFinderFrame:SetWidth(400)
Cmd3DCode_ViewFinderFrame:SetHeight(300)
Cmd3DCode_ViewFinderFrame:SetPoint("CENTER",Cmd3DCode_ShottingMaskFrame,"CENTER",0,0)
Cmd3DCode_UpdateViewFinderFrames()
Cmd3DCode_ShottingMaskFrame:Show()
Æ
Ì a=ChatFrame1EditBox:CreateFontString()
a:SetFontObject(GameFontNormalSmall)
a:SetPoint("TOPLEFT")
a:SetPoint("BOTTOMRIGHT")
a:Hide()
Ì É n(e,t)
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
Ì o=UIParent:CreateTexture(Í,"BACKGROUND")
Ì t=CreateFrame("FRAME")
t:SetScript("OnMouseDown",É(e)
Ì t=e.text:GetText()
Ê t:sub(1,17)=="http://w.163.com/"Ò
Ì e=ChatEdit_ChooseBoxForSend()
Ê Î e:IsShown()Ï ChatFrame1EditBox:GetAlpha()<1 Ò
ChatEdit_ActivateChat(e)
Æ
e:SetText(t)
e:HighlightText()
Æ
Æ)
t:SetWidth(300)
t:SetHeight(10)
t.text=t:CreateFontString(Í,"OVERLAY","GameTooltipText")
t.text:SetPoint("BOTTOMLEFT")
t.text:SetText("Hello World!")
Ì e=1
Cmd3DCode_Screenshot_CapturePictures={}
Cmd3DCode_Screenshot_ExternalPictures={}
Ì É l(t)
Ì t={
texture="Interface\\AddOns\\"..i.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
loaded=Ç,
uploaded=Ç,
idx=e,
time=t,
title=date("æˆªå›¾ %H:%M:%S",t),
}
Cmd3DCode_Screenshot_CapturePictures[e]=t
e=e+1
Ê e>512 Ò
e=1
Æ
Ñ t
Æ
Ì É p(t,a,o)
Ì a={
texture="Interface\\AddOns\\"..i.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
downloaded=Ç,
idx=e,
picid=t,
channel=a,
from=o,
}
Cmd3DCode_Screenshot_ExternalPictures[t]=a
e=e+1
Ê e>512 Ò
e=1
Æ
Ñ a
Æ
Ì É s(a,e,t)
Ì o=e/t
Ì a=a.width/a.height
Ê a>o Ò
Ñ e,e/a
Ä
Ñ t*a,t
Æ
Æ
É Cmd3DCode_Screenshot_ExternalPicture_Thumb(n)
Ì e=Cmd3DCode_Screenshot_CapturePictures[n]
Ê Î e Ò
Ñ
Æ
Ì t,a=160,120
Ê e.loaded Ò
t,a=s(e,t,a)
o:SetTexture(e.texture)
Ä
o:SetTexture("Interface\\AddOns\\"..i.."\\Textures\\external-pic-loading.tga")
Æ
o:SetWidth(t)
o:SetHeight(a)
o.picidx=n
Ñ o
Æ
É Cmd3DCode_Screenshot_CapturePictures_FromPicId(t)
È a,e Ë pairs(Cmd3DCode_Screenshot_CapturePictures)Ã
Ê e.picid==t Ò
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
print(e.picid)
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
É Cmd3DCode_Screenshot_TakePhoto(h)
Cmd3DCode_ShottingMaskFrame:Hide()
Ì r=UIParent:IsVisible()
Ì t=Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:GetChecked()Á Ó Ï Ç
Ì d=Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()Á Ó Ï Ç
Ê t Ò
print("éšè—UI")
UIParent:Hide()
Æ
Ì e=GetCVar("screenshotFormat")
Ê e~="jpg"Ò
SetCVar("screenshotFormat","jpg")
Æ
Ì s=time()
TakeScreenshot()
Ì i=CreateFrame("FRAME")
i:RegisterEvent("SCREENSHOT_SUCCEEDED")
i:SetScript("OnEvent",É(u,o)
Ê o=="SCREENSHOT_SUCCEEDED"Ò
Ê e~="jpg"Ò
SetCVar("screenshotFormat",e)
Æ
Ê t Á r Ò
UIParent:Show()
Æ
Ì o=l(s)
Ì r,e=GetPlayerMapPosition("player")
Ì l,i=UnitFactionGroup("player")
Ì e={
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
Ê Î h Ò
Ì a=UIParent:GetWidth()
Ì t=UIParent:GetHeight()
Ì i,h,s,o=Cmd3DCode_ViewFinderFrame:GetRect()
e.left=n(i/a,100)
e.top=(1-n(h/t,100))-n(o/t,100)
e.width=n(s/a,100)
e.height=n(o/t,100)
Æ
ThreeDimensionsCode_Send("screenshot",json_encode(e))
Ê time()-cmd3dcode_lastPingTime()>45 Ò
StaticPopup_Show("163UI-Screenshot:ClientNotFound")
Ä
print("æ­£åœ¨ä¸Šä¼  "..o.title.." ...")
a:SetText("æ­£åœ¨ä¸Šä¼  "..o.title.." ...")
a:Show()
Æ
Æ
i:SetScript("OnEvent",Í)
Æ)
Æ
StaticPopupDialogs["163UI-Screenshot:ClientNotFound"]={
text="æ²¡æœ‰æ£€æµ‹åˆ°æœ‰çˆ±å®¢æˆ·ç«¯ï¼Œæ— æ³•å®Œæˆå±å¹•æˆªå›¾çš„è£åˆ‡å’Œä¼ é€ï¼Œè¯·å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯ã€‚",
button1="å…³é—­",
timeout=0,
whileDead=Ó,
hideOnEscape=Ó,
preferredIndex=3,
}
Ì É h(t)
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
Ì o,a=s(t,e:GetWidth(),e:GetHeight())
e:SetWidth(o)
e:SetHeight(a)
Ì a=e:CreateTexture(Í,"BACKGROUND")
a:SetTexture(t.texture)
a:SetAllPoints(e)
Æ
Cmd3DCode_Screenshot_ChatFrameButton:SetParent(ChatFrame1EditBox)
Cmd3DCode_Screenshot_ChatFrameButton:Show()
Cmd3DCode_Screenshot_ChatFrameButton:SetPoint("LEFT",ChatFrame1EditBoxLanguage,"RIGHT",-8,0)
Ì e=CreateFrame("Button","Cmd3DCode_Screenshot_ChatFrameButton_MenuBtn",UIParent,"UIDropDownMenuTemplate")
e:Hide()
UIDropDownMenu_Initialize(e,É(e,a)
Ì n=_G["DropDownList"..(a Ï 1)]
Ì e=1
Ê#Cmd3DCode_Screenshot_CapturePictures Ò
È s,i Ë pairs(Cmd3DCode_Screenshot_CapturePictures)Ã
Ê e<=25 Ò
Ì o=UIDropDownMenu_CreateInfo()
o.notCheckable=Ó
o.text=i.title
o.arg1=i
o.func=É(t,e)
Ê e.uploaded Ò
h(e.idx)
Ä
print("æˆªå›¾å°šæœªä¸Šä¼ åˆ°ç½‘æ˜“æœ‰çˆ±æœåŠ¡å™¨ï¼Œè¯·ç­‰å¾…...")
Æ
Æ
UIDropDownMenu_AddButton(o,a)
Ì a=_G["DropDownList"..a.."Button"..e]
Ê a Ò
a.isExternalPic=Ó
a.externalPicIdx=s
a.externalPicItem=i
a.__scrshot_onenter=É(e,...)
Ì a=Cmd3DCode_Screenshot_ExternalPicture_Thumb(e.externalPicIdx)
Ê Î a Ò Ñ Æ
a:SetPoint("BOTTOMLEFT",n,"BOTTOMRIGHT",2,15)
a:Show()
Ê e.externalPicItem.picid Ò
t.text:SetText("http://w.163.com/"..e.externalPicItem.picid)
ExternalPicturesThumb_BtnOpenInBrowser.url="http://w.163.com/"..e.externalPicItem.picid
ExternalPicturesThumb_BtnOpenInBrowser:Show()
ExternalPicturesThumb_BtnOpenInBrowser:SetPoint("BOTTOMLEFT",a,"BOTTOMRIGHT",1,20)
Ä
t.text:SetText("æ­£åœ¨ä¸Šä¼  ...")
Æ
t:SetPoint("BOTTOMLEFT",n,"BOTTOMRIGHT",2,0)
t:Show()
ExternalPicturesThumb_BtnScrawl.picidx=e.externalPicIdx
ExternalPicturesThumb_BtnScrawl.picid=e.externalPicItem.picid
ExternalPicturesThumb_BtnScrawl:SetPoint("BOTTOMLEFT",a,"BOTTOMRIGHT",1,-4)
ExternalPicturesThumb_BtnScrawl:Show()
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
t.func=Cmd3DCode_Screenshot_Start
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
DropDownList1:HookScript("OnHide",É(e)
o:Hide()
t:Hide()
ExternalPicturesThumb_BtnOpenInBrowser:Hide()
ExternalPicturesThumb_BtnScrawl:Hide()
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
Ì t="%[.+w%.163%.com%/(%w+).+%]"
Ì É d(e,a)
Ğ
startpos,endpos,picid=string.find(e,t)
Ê startpos Ò
e=e:sub(0,startpos-1)
..(a(picid)Ï"")..e:sub(endpos+1)
Æ
Ô Î startpos
Ñ e
Æ
Ì É n(e,a,t)
Ê Î e Ò Ñ"xx"Æ
Ì a,t=s(e,a,t)
Ñ"|Hviewpic:"..e.picid.."|h|TInterface\\AddOns\\"..i.."\\External\\Image\\"..e.idx..".tga:"..t..":"..a.."|t|h"
Æ
ThreeDimensionsCode_SafePipe_CmdHandles["ir"]=É(t,e)
Ì t,o,a=strsplit(",",e)
t=tonumber(t)
Ì e=Cmd3DCode_Screenshot_CapturePictures[t]
Ê Î e Ò
print("Cmd3DCode_Screenshot_CapturePictures[picidx] not exits",t)
Ñ
Æ
e.width=tonumber(o)Ï 0
e.height=tonumber(a)Ï 0
e.loaded=Ó
Æ
ThreeDimensionsCode_SafePipe_CmdHandles["iu"]=É(t,e)
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
h(t)
Cmd3DCode_Screenshot_CapturePictures_EmitUploded(t)
Æ
Ì É r(a,...)
È e=1,select("#",...),2 Ã
Ì t,e=select(e,...)
Ê a==e Ò
Ñ t
Æ
Æ
Ñ Í
Æ
Ì É h(t,...)
È e=1,select("#",...)Ã
Ê select(e,...)==t Ò
Ñ e
Æ
Æ
Ñ Ç
Æ
Ì É i(e)
Ì a=GetRealmName()
Ì t=#e-(#a+1)
Ê e:sub(t+2)==a Ò
Ñ e:sub(1,t)
Ä
Ñ e
Æ
Æ
ThreeDimensionsCode_SafePipe_CmdHandles["id"]=É(t,e)
Ì o,t,a=strsplit(",",e)
Ê(t=="0"Á a=="0")Ï(t==""Á a=="")Ò
print("å¤–éƒ¨å›¾ç‰‡ä¸‹è½½å¤±è´¥ï¼Œå¯èƒ½æ˜¯ç½‘ç»œåŸå› é€ æˆ")
Æ
Ì e=Cmd3DCode_Screenshot_ExternalPictures[o]
Ê Î e Ò
print("æœªèƒ½æ‰¾åˆ°IDä¸º",o,"çš„æˆªå›¾")
Ñ
Æ
e.downloaded=Ó
e.width=tonumber(t)
e.height=tonumber(a)
Ì t="|Hplayer:"..e.from.author.."|h["..i(e.from.author).."]|h: å‘æ¥äº†å›¾ç‰‡ "
t=t.."[ "..n(e,120,90).." ]"
È o=1,10 Ã
Ê _G["ChatFrame"..o.."Tab"]:IsVisible()Ò
Ì a,n,s,i
Ê e.from.msgtype=="CHANNEL"Ò
a=h(e.from.channel,GetChatWindowChannels(o))
Ê a Ò
Ì a=r(e.from.channel,GetChannelList())
n,s,i=GetMessageTypeColor("CHANNEL"..a)
t="["..e.from.channelString.."] "..t
Æ
Ä
a=h(e.from.msgtype,GetChatWindowMessages(o))
n,s,i=GetMessageTypeColor(e.from.msgtype)
Æ
Ê a Ò
_G["ChatFrame"..o]:AddMessage(t,n,s,i,e.from.guid)
Æ
Æ
Æ
Æ
Ì h=0
Ì É e(t,r,a,e,u,s,m,c,f,y,i,w,o,l,...)
a=d(a,É(t)
Ê r=="CHAT_MSG_WHISPER_INFORM"Ï e==GetUnitName("player",Ç).."-"..GetRealmName()Ò
Ì e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(t)
Ì e=n(e,120,90)
Ñ"[ "..e.." ]"
Ä
Ê o>h Ò
h=o
Ì a={
author=e,
msgtype=r:sub(10),
channel=i,
channelString=s,
guid=l,
}
Ì a=p(t,i,a)
Ê time()-cmd3dcode_lastPingTime()>45 Ò
print("æ”¶åˆ°æ¥è‡ª"..e.."çš„æˆªå›¾: w.163.com/"..t.." ,è¯·å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯æ˜¾ç¤ºæ­¤å›¾")
Æ
ThreeDimensionsCode_Send("loadpic",a.texture..","..t)
Æ
Ñ""
Æ
Æ)
Ñ#a<1,a,e,u,s,m,c,f,y,i,w,o,l,...
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
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_DND",e)
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER",e)
Ì t=250
Ì É o(a,e)
Ê Î a:IsShown()Ò
e.cachedText=Í
Ñ
Æ
t=math.max(a:GetWidth(),t)
Ì a=e:GetText()Ï""
Ê a==e.cachedText Ò Ñ Æ
Ì a=d(a,É(e)
Ì e=Cmd3DCode_Screenshot_ExternalPictures[e]
Ê Î e Ò Ñ""Æ
Ê e.width<=0 Ò Ñ""Æ
Ñ n(e,100,75)
Æ)
Ê#a>0 Ò
e:SetText(a)
e.cachedText=a
e:SetWidth(math.min(e:GetStringWidth(),t-14))
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
o(e,t)
Æ
Æ
Æ
Æ
Æ
Ì o=.15
Ì t=CreateFrame("Frame")
t.interval=o
t:SetScript("OnUpdate",É(e,t)
e.interval=e.interval-t
Ê e.interval<0 Ò
e.interval=o
i()
Æ
Æ)
t:Show()
Ì t="\[æˆªå›¾ [%d:]+ (%d+)\]"
hooksecurefunc("AutoCompleteEditBox_OnEnterPressed",É()
Ì e=ChatEdit_ChooseBoxForSend()
Ê Î e:IsVisible()Ò
Ñ
Æ
Ì e=e:GetText()
Ì a,o=1,picidx
Ğ
a,o,picidx=string.find(e,t)
picidx=tonumber(picidx)
Ì t=Cmd3DCode_Screenshot_CapturePictures[picidx]
Ê picidx Á t Á t.picid Ò
e=e:sub(0,a-1)
.."[å‘æ¥äº†å›¾ç‰‡ï¼Œåœ¨æµè§ˆå™¨ä¸­è¾“å…¥ç½‘å€æŸ¥çœ‹ï¼šw.163.com/"..t.picid.."  (å®‰è£…â€œç½‘æ˜“æœ‰çˆ±æ’ä»¶åŒ…â€åå¯åœ¨æ¸¸æˆå†…æ˜¾ç¤º)]"
..e:sub(o+1)
Æ
Ô Î a
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
É SetItemRef(e,i,n,o)
Ì t,h=strmatch(e,"^(.+):(.+)$")
Ê Î a[t]Ò
s(e,i,n,o)
Ñ
Æ
a[t](h,e,i,n,o)
Æ
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=Cmd3DCode_Screenshot_Start]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()