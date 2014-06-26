local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ê bit==Í Á bit32~=Í Ò
bit=bit32
Æ
Ì n="!!!163UI.3dcodecmd!!!"
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
Ì i=r-t-a
Ì n=d-e-o
Ì s=t+a
Ì h=e+o
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
Cmd3DCode_ViewFinderFrameDone:SetNormalTexture("Interface\\AddOns\\"..n.."\\Textures\\cupture.tga")
Cmd3DCode_ViewFinderFrameFullScreen:SetClampedToScreen(Ó)
Cmd3DCode_ViewFinderFrameFullScreen:SetNormalTexture("Interface\\AddOns\\"..n.."\\Textures\\fullscreen.tga")
Cmd3DCode_ViewFinderFrameCancel:SetClampedToScreen(Ó)
É Cmd3DCode_Screenshot_Start()
Cmd3DCode_ViewFinderFrame:SetWidth(400)
Cmd3DCode_ViewFinderFrame:SetHeight(300)
Cmd3DCode_ViewFinderFrame:SetPoint("CENTER",Cmd3DCode_ShottingMaskFrame,"CENTER",0,0)
Cmd3DCode_UpdateViewFinderFrames()
Cmd3DCode_ShottingMaskFrame:Show()
Æ
Ì o=ChatFrame1EditBox:CreateFontString()
o:SetFontObject(GameFontNormalSmall)
o:SetPoint("TOPLEFT")
o:SetPoint("BOTTOMRIGHT")
o:Hide()
Ì É a(e,t)
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
Ì i=UIParent:CreateTexture(Í,"BACKGROUND")
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
Ì É d(t)
Ì t={
texture="Interface\\AddOns\\"..n.."\\External\\Image\\"..e..".tga",
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
Ì É u(a,o,t)
Ì t={
texture="Interface\\AddOns\\"..n.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
downloaded=Ç,
idx=e,
picid=a,
channel=o,
from=t,
}
Cmd3DCode_Screenshot_ExternalPictures[a]=t
e=e+1
Ê e>512 Ò
e=1
Æ
Ñ t
Æ
Ì É s(e,a,t)
Ì o=a/t
Ì e=e.width/e.height
Ê e>o Ò
Ñ a,a/e
Ä
Ñ t*e,t
Æ
Æ
É Cmd3DCode_Screenshot_ExternalPicture_Thumb(o)
Ì e=Cmd3DCode_Screenshot_CapturePictures[o]
Ê Î e Ò
Ñ
Æ
Ì a,t=160,120
Ê e.loaded Ò
a,t=s(e,a,t)
i:SetTexture(e.texture)
Ä
i:SetTexture("Interface\\AddOns\\"..n.."\\Textures\\external-pic-loading.tga")
Æ
i:SetWidth(a)
i:SetHeight(t)
i.picidx=o
Ñ i
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
Ì i=UIParent:IsVisible()
Ì t=Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:GetChecked()Á Ó Ï Ç
Ì r=Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()Á Ó Ï Ç
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
Ì n=CreateFrame("FRAME")
n:RegisterEvent("SCREENSHOT_SUCCEEDED")
n:SetScript("OnEvent",É(u,l)
Ê l=="SCREENSHOT_SUCCEEDED"Ò
Ê e~="jpg"Ò
SetCVar("screenshotFormat",e)
Æ
Ê t Á i Ò
UIParent:Show()
Æ
Ì i=d(s)
Ì n,e=GetPlayerMapPosition("player")
Ì l,d=UnitFactionGroup("player")
Ì e={
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
Ê Î h Ò
Ì i=UIParent:GetWidth()
Ì t=UIParent:GetHeight()
Ì n,s,h,o=Cmd3DCode_ViewFinderFrame:GetRect()
e.left=a(n/i,100)
e.top=(1-a(s/t,100))-a(o/t,100)
e.width=a(h/i,100)
e.height=a(o/t,100)
Æ
ThreeDimensionsCode_Send("screenshot",json_encode(e))
Ê time()-cmd3dcode_lastPingTime()>45 Ò
StaticPopup_Show("163UI-Screenshot:ClientNotFound")
Ä
print("æ­£åœ¨ä¸Šä¼  "..i.title.." ...")
o:SetText("æ­£åœ¨ä¸Šä¼  "..i.title.." ...")
o:Show()
Æ
Æ
n:SetScript("OnEvent",Í)
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
Ì É r(t)
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
Ì a,o=s(t,e:GetWidth(),e:GetHeight())
e:SetWidth(a)
e:SetHeight(o)
Ì a=e:CreateTexture(Í,"BACKGROUND")
a:SetTexture(t.texture)
a:SetAllPoints(e)
Æ
Cmd3DCode_Screenshot_ChatFrameButton:SetParent(ChatFrame1EditBox)
Cmd3DCode_Screenshot_ChatFrameButton:Show()
Cmd3DCode_Screenshot_ChatFrameButton:SetPoint("LEFT",ChatFrame1EditBoxLanguage,"RIGHT",-8,0)
Ì e=CreateFrame("Button","Cmd3DCode_Screenshot_ChatFrameButton_MenuBtn",UIParent,"UIDropDownMenuTemplate")
e:Hide()
UIDropDownMenu_Initialize(e,É(e,o)
Ì n=_G["DropDownList"..(o Ï 1)]
Ì a=1
Ê#Cmd3DCode_Screenshot_CapturePictures Ò
È s,i Ë pairs(Cmd3DCode_Screenshot_CapturePictures)Ã
Ê a<=25 Ò
Ì e=UIDropDownMenu_CreateInfo()
e.notCheckable=Ó
e.text=i.title
e.arg1=i
e.func=É(t,e)
Ê e.uploaded Ò
r(e.idx)
Ä
print("æˆªå›¾å°šæœªä¸Šä¼ åˆ°ç½‘æ˜“æœ‰çˆ±æœåŠ¡å™¨ï¼Œè¯·ç­‰å¾…...")
Æ
Æ
UIDropDownMenu_AddButton(e,o)
Ì e=_G["DropDownList"..o.."Button"..a]
Ê e Ò
e.isExternalPic=Ó
e.externalPicIdx=s
e.externalPicItem=i
e.originOnEnter=e:GetScript("OnEnter")
e:SetScript("OnEnter",É(e,...)
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
Ê e.originOnEnter Ò e:originOnEnter(...)Æ
Æ)
Æ
a=a+1
Æ
Æ
Æ
Ì e=UIDropDownMenu_CreateInfo()
e.text="åŠŸèƒ½è¯´æ˜(?)"
e.notCheckable=Ó
e.hasOpacity=Ó
e.func=É()
Cmd3DCode_Screenshot_Help:Show()
Æ
UIDropDownMenu_AddButton(e,o)
a=a+1
Ì e=UIDropDownMenu_CreateInfo()
e.text="æˆªå±å‘é€"
e.func=Cmd3DCode_Screenshot_Start
e.notCheckable=Ó
e.tooltipTitle="æˆªå–å±å¹•"
e.tooltipText="æˆªå–å±å¹•å‘é€åˆ°å¥½å‹æˆ–èŠå¤©é¢‘é“"
e.hasOpacity=Ó
UIDropDownMenu_AddButton(e,o)
Ì e=_G["DropDownList"..(o Ï 1).."Button"..a]
e:SetScript("OnEnter",É(e,...)
GameTooltip:SetOwner(e,'ANCHOR_BOTTOMRIGHT')
GameTooltip:AddLine("å¿«æ·é”®ï¼šCtrl+PrtScr")
GameTooltip:Show()
Æ)
e:SetScript("OnLeave",É(e,...)
GameTooltip:Hide()
Æ)
a=a+1
n:SetScript("OnHide",É(a)
i:Hide()
t:Hide()
ExternalPicturesThumb_BtnOpenInBrowser:Hide()
ExternalPicturesThumb_BtnScrawl:Hide()
È t=1,UIDROPDOWNMENU_MAXBUTTONS,1 Ã
e=_G["DropDownList"..(o Ï 1).."Button"..t]
Ê e Á e.isExternalPic Ò
e:SetScript("OnEnter",e.originOnEnter)
e.externalPicIdx=Í
e.originOnEnter=Í
e.originOnLeave=Í
e.isExternalPic=Í
Æ
Æ
n:SetScript("OnHide",Í)
Æ)
Æ,"MENU")
Ì a="%[.+w%.163%.com%/(%w+).+%]"
Ì É d(e,t)
Ğ
startpos,endpos,picid=string.find(e,a)
Ê startpos Ò
e=e:sub(0,startpos-1)
..(t(picid)Ï"")..e:sub(endpos+1)
Æ
Ô Î startpos
Ñ e
Æ
Ì É h(e,t,a)
Ê Î e Ò Ñ"xx"Æ
Ì a,t=s(e,t,a)
Ñ"|Hviewpic:"..e.picid.."|h|TInterface\\AddOns\\"..n.."\\External\\Image\\"..e.idx..".tga:"..t..":"..a.."|t|h"
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
Ì t,a=strsplit(",",e)
t=tonumber(t)
Ì e=Cmd3DCode_Screenshot_CapturePictures[t]
Ê Î e Ò
Ñ
Æ
o:Hide()
Ê a=="!"Ò
print(e.title,"ä¸Šä¼ å¤±è´¥")
Ñ
Ä
print(e.title,"ä¸Šä¼ å®Œæˆ")
Æ
Ì o="http://w.163.com/"..a
Cmd3DCode_Screenshot_ExternalPictures[a]=e
e.uploaded=Ó
e.picid=a
r(t)
Cmd3DCode_Screenshot_CapturePictures_EmitUploded(t)
Æ
Ì É l(e,...)
È t=1,select("#",...),2 Ã
Ì a,t=select(t,...)
Ê e==t Ò
Ñ a
Æ
Æ
Ñ Í
Æ
Ì É r(t,...)
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
t=t.."[ "..h(e,120,90).." ]"
È a=1,10 Ã
Ê _G["ChatFrame"..a.."Tab"]:IsVisible()Ò
Ì o,n,s,i
Ê e.from.msgtype=="CHANNEL"Ò
o=r(e.from.channel,GetChatWindowChannels(a))
Ê o Ò
Ì a=l(e.from.channel,GetChannelList())
n,s,i=GetMessageTypeColor("CHANNEL"..a)
t="["..e.from.channelString.."] "..t
Æ
Ä
o=r(e.from.msgtype,GetChatWindowMessages(a))
n,s,i=GetMessageTypeColor(e.from.msgtype)
Æ
Ê o Ò
_G["ChatFrame"..a]:AddMessage(t,n,s,i,e.from.guid)
Æ
Æ
Æ
Æ
Ì i=0
Ì É e(p,s,e,t,y,r,f,w,m,c,a,l,o,n)
e=d(e,É(e)
Ê s=="CHAT_MSG_WHISPER_INFORM"Ï t==GetUnitName("player",Ç).."-"..GetRealmName()Ò
Ì e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(e)
Ì e=h(e,120,90)
Ñ"[ "..e.." ]"
Ä
Ê o>i Ò
i=o
Ì o={
author=t,
msgtype=s:sub(10),
channel=a,
channelString=r,
guid=n,
}
Ì a=u(e,a,o)
Ê time()-cmd3dcode_lastPingTime()>45 Ò
print("æ”¶åˆ°æ¥è‡ª"..t.."çš„æˆªå›¾: w.163.com/"..e.." ,è¯·å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯æ˜¾ç¤ºæ­¤å›¾")
Æ
ThreeDimensionsCode_Send("loadpic",a.texture..","..e)
Æ
Ñ""
Æ
Æ)
Ñ#e<1,e,t,y,r,f,w,m,c,a,l,o,n
Æ
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
Ì a=250
Ì É i(t,e)
Ê Î t:IsShown()Ò
e.cachedText=Í
Ñ
Æ
a=math.max(t:GetWidth(),a)
Ì t=e:GetText()Ï""
Ê t==e.cachedText Ò Ñ Æ
Ì t=d(t,É(e)
Ì e=Cmd3DCode_Screenshot_ExternalPictures[e]
Ê Î e Ò Ñ""Æ
Ê e.width<=0 Ò Ñ""Æ
Ñ h(e,100,75)
Æ)
Ê#t>0 Ò
e:SetText(t)
e.cachedText=t
e:SetWidth(math.min(e:GetStringWidth(),a-14))
Æ
Æ
Ì É n()
È e=1,WorldFrame:GetNumChildren()Ã
Ì e=select(e,WorldFrame:GetChildren())
Ì t=e:GetBackdrop()
Ê t Á t.bgFile=="Interface\\Tooltips\\ChatBubble-Background"Ò
È t=1,e:GetNumRegions()Ã
Ì t=select(t,e:GetRegions())
Ê t:GetObjectType()=="FontString"Ò
i(e,t)
Æ
Æ
Æ
Æ
Æ
Ì a=.15
Ì t=CreateFrame("Frame")
t.interval=a
t:SetScript("OnUpdate",É(e,t)
e.interval=e.interval-t
Ê e.interval<0 Ò
e.interval=a
n()
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
o:Hide()
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
Ì i={
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
É SetItemRef(e,t,o,a)
Ì n,h=strmatch(e,"^(.+):(.+)$")
Ê Î i[n]Ò
s(e,t,o,a)
Ñ
Æ
i[n](h,e,t,o,a)
Æ
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=Cmd3DCode_Screenshot_Start]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()