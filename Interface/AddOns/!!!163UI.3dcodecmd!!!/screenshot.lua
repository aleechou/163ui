local base_char,keywords=191,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[É bit==Ì À bit32~=Ì Ñ
bit=bit32
Å
Ë i="!!!163UI.3dcodecmd!!!"
Cmd3DCode_ShottingMaskFrame:SetPoint("TOPLEFT",0,0)
Cmd3DCode_ShottingMaskFrame:SetFrameStrata("TOOLTIP")
Cmd3DCode_ShottingMaskFrame:SetFrameLevel(125)
Cmd3DCode_ShottingMaskFrame:SetWidth(UIParent:GetWidth())
Cmd3DCode_ShottingMaskFrame:SetHeight(UIParent:GetHeight())
Ë È e(t)
Ë t=_G["Cmd3DCode_ShottingMaskFrame"..t]
t.texture=t:CreateTexture(Ì,"BACKGROUND")
t.texture:SetTexture(.1,.1,.1,.5)
t.texture:SetAllPoints(t)
Ğ t
Å
e("TOPLEFT")
e("TOP")
e("TOPRIGHT")
e("LEFT")
e("RIGHT")
e("BOTTOMLEFT")
e("BOTTOM")
e("BOTTOMRIGHT")
È Cmd3DCode_UpdateViewFinderFrames()
Ë d=UIParent:GetWidth()
Ë r=UIParent:GetHeight()
Ë t,e,a,o=Cmd3DCode_ViewFinderFrame:GetRect()
É Í t Î Í e Î Í a Î Í e Ñ
Ğ
Å
Ë i=d-t-a
Ë n=r-e-o
Ë h=t+a
Ë s=e+o
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
Å
Cmd3DCode_ViewFinderFrame:SetPoint("CENTER",Cmd3DCode_ShottingMaskFrame,"CENTER",0,0)
Cmd3DCode_ViewFinderFrame:SetBackdrop({
edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
edgeSize=10,
insets={left=0,right=0,top=0,bottom=0}
});
Cmd3DCode_ViewFinderFrame:SetBackdropBorderColor(1,1,1)
Cmd3DCode_ViewFinderFrame:RegisterForDrag("LeftButton","RightButton");
Cmd3DCode_ViewFinderFrame:EnableMouse(Ò)
Cmd3DCode_ViewFinderFrame:SetMovable(Ò)
Cmd3DCode_ViewFinderFrame:SetResizable(Ò)
Cmd3DCode_ViewFinderFrame:SetClampedToScreen(Ò)
Cmd3DCode_ViewFinderFrameDone:SetClampedToScreen(Ò)
Cmd3DCode_ViewFinderFrameDone:SetNormalTexture("Interface\\AddOns\\"..i.."\\Textures\\cupture.tga")
Cmd3DCode_ViewFinderFrameFullScreen:SetClampedToScreen(Ò)
Cmd3DCode_ViewFinderFrameFullScreen:SetNormalTexture("Interface\\AddOns\\"..i.."\\Textures\\fullscreen.tga")
Cmd3DCode_ViewFinderFrameCancel:SetClampedToScreen(Ò)
È Cmd3DCode_Screenshot_Start()
Cmd3DCode_ViewFinderFrame:SetWidth(400)
Cmd3DCode_ViewFinderFrame:SetHeight(300)
Cmd3DCode_ViewFinderFrame:SetPoint("CENTER",Cmd3DCode_ShottingMaskFrame,"CENTER",0,0)
Cmd3DCode_UpdateViewFinderFrames()
Cmd3DCode_ShottingMaskFrame:Show()
Å
Ë a=ChatFrame1EditBox:CreateFontString()
a:SetFontObject(GameFontNormalSmall)
a:SetPoint("TOPLEFT")
a:SetPoint("BOTTOMRIGHT")
a:Hide()
Ë È n(e,t)
e=e*t
Ë a,e=math.modf(e,1)
e=e>=.5 À 1 Î 0
Ğ(a+e)/t
Å
Ë È e(t)
Ë e=2;
Ï
É e>t Ñ
Ğ e;
Å
e=bit.lshift(e,1);
Ó Æ
Å
Ë o=UIParent:CreateTexture(Ì,"BACKGROUND")
Ë t=CreateFrame("FRAME")
t:SetScript("OnMouseDown",È(e)
Ë t=e.text:GetText()
É t:sub(1,17)=="http://w.163.com/"Ñ
Ë e=ChatEdit_ChooseBoxForSend()
É Í e:IsShown()Î ChatFrame1EditBox:GetAlpha()<1 Ñ
ChatEdit_ActivateChat(e)
Å
e:SetText(t)
e:HighlightText()
Å
Å)
t:SetWidth(300)
t:SetHeight(10)
t.text=t:CreateFontString(Ì,"OVERLAY","GameTooltipText")
t.text:SetPoint("BOTTOMLEFT")
t.text:SetText("Hello World!")
Ë e=1
Cmd3DCode_Screenshot_CapturePictures={}
Cmd3DCode_Screenshot_ExternalPictures={}
Ë È l(t)
Ë t={
texture="Interface\\AddOns\\"..i.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
loaded=Æ,
uploaded=Æ,
idx=e,
time=t,
title=date("æˆªå›¾ %H:%M:%S",t),
}
Cmd3DCode_Screenshot_CapturePictures[e]=t
e=e+1
É e>512 Ñ
e=1
Å
Ğ t
Å
Ë È p(t,o,a)
Ë a={
texture="Interface\\AddOns\\"..i.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
downloaded=Æ,
idx=e,
picid=t,
channel=o,
from=a,
}
Cmd3DCode_Screenshot_ExternalPictures[t]=a
e=e+1
É e>512 Ñ
e=1
Å
Ğ a
Å
Ë È s(t,a,e)
Ë o=a/e
Ë t=t.width/t.height
É t>o Ñ
Ğ a,a/t
Ã
Ğ e*t,e
Å
Å
È Cmd3DCode_Screenshot_ExternalPicture_Thumb(n)
Ë e=Cmd3DCode_Screenshot_CapturePictures[n]
É Í e Ñ
Ğ
Å
Ë a,t=160,120
É e.loaded Ñ
a,t=s(e,a,t)
o:SetTexture(e.texture)
Ã
o:SetTexture("Interface\\AddOns\\"..i.."\\Textures\\external-pic-loading.tga")
Å
o:SetWidth(a)
o:SetHeight(t)
o.picidx=n
Ğ o
Å
È Cmd3DCode_Screenshot_CapturePictures_FromPicId(t)
Ç a,e Ê pairs(Cmd3DCode_Screenshot_CapturePictures)Â
É e.picid==t Ñ
Ğ e
Å
Å
Å
È Cmd3DCode_Screenshot_CapturePictures_OnceUploded(e,t)
É Í Cmd3DCode_Screenshot_CapturePictures[e]Ñ
print("æŒ‡å®šåºåˆ—çš„å›¾ç‰‡ä¸å­˜åœ¨",e)
Ğ
Å
Ë e=Cmd3DCode_Screenshot_CapturePictures[e]
print(e.picid)
É e.picid Ñ
t(e)
Ã
É Í e.onceHandles Ñ
e.onceHandles={}
Å
table.insert(e.onceHandles,t)
Å
Å
È Cmd3DCode_Screenshot_CapturePictures_EmitUploded(e)
É Í Cmd3DCode_Screenshot_CapturePictures[e]Ñ
Ğ
Å
Ë e=Cmd3DCode_Screenshot_CapturePictures[e]
É e.onceHandles Ñ
Ç a,t Ê pairs(e.onceHandles)Â
t(e)
Å
e.onceHandles={}
Å
Å
È Cmd3DCode_Screenshot_TakePhoto(i)
Cmd3DCode_ShottingMaskFrame:Hide()
Ë d=UIParent:IsVisible()
Ë e=Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:GetChecked()À Ò Î Æ
Ë r=Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()À Ò Î Æ
É e Ñ
print("éšè—UI")
UIParent:Hide()
Å
Ë t=GetCVar("screenshotFormat")
É t~="jpg"Ñ
SetCVar("screenshotFormat","jpg")
Å
Ë s=time()
TakeScreenshot()
Ë o=CreateFrame("FRAME")
o:RegisterEvent("SCREENSHOT_SUCCEEDED")
o:SetScript("OnEvent",È(u,h)
É h=="SCREENSHOT_SUCCEEDED"Ñ
É t~="jpg"Ñ
SetCVar("screenshotFormat",t)
Å
É e À d Ñ
UIParent:Show()
Å
Ë t=l(s)
Ë o,h=GetPlayerMapPosition("player")
Ë l,d=UnitFactionGroup("player")
Ë e={
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
É Í i Ñ
Ë o=UIParent:GetWidth()
Ë t=UIParent:GetHeight()
Ë s,i,h,a=Cmd3DCode_ViewFinderFrame:GetRect()
e.left=n(s/o,100)
e.top=(1-n(i/t,100))-n(a/t,100)
e.width=n(h/o,100)
e.height=n(a/t,100)
Å
ThreeDimensionsCode_Send("screenshot",json_encode(e))
É time()-cmd3dcode_lastPingTime()>45 Ñ
StaticPopup_Show("163UI-Screenshot:ClientNotFound")
Ã
print("æ­£åœ¨ä¸Šä¼  "..t.title.." ...")
a:SetText("æ­£åœ¨ä¸Šä¼  "..t.title.." ...")
a:Show()
Å
Å
o:SetScript("OnEvent",Ì)
Å)
Å
StaticPopupDialogs["163UI-Screenshot:ClientNotFound"]={
text="æ²¡æœ‰æ£€æµ‹åˆ°æœ‰çˆ±å®¢æˆ·ç«¯ï¼Œæ— æ³•å®Œæˆå±å¹•æˆªå›¾çš„è£åˆ‡å’Œä¼ é€ï¼Œè¯·å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯ã€‚",
button1="å…³é—­",
timeout=0,
whileDead=Ò,
hideOnEscape=Ò,
preferredIndex=3,
}
Ë È h(e)
Ë a=Cmd3DCode_Screenshot_CapturePictures[e]
É Í a Ñ
print("æœªèƒ½æ‰¾åˆ°åºå·ä¸º",e,"çš„æˆªå›¾")
Ğ
Å
Ë t=ChatEdit_ChooseBoxForSend()
É Í t:IsShown()Î ChatFrame1EditBox:GetAlpha()<1 Ñ
ChatEdit_ActivateChat(t)
Å
t:SetText("["..a.title.." "..e.."]")
Å
È Cmd3DCode_Screenshot_ShowExternalPic(e,t)
Ë t=Cmd3DCode_Screenshot_CapturePictures[t]
É Í t Ñ
Ğ
Å
Ë a,o=s(t,e:GetWidth(),e:GetHeight())
e:SetWidth(a)
e:SetHeight(o)
Ë a=e:CreateTexture(Ì,"BACKGROUND")
a:SetTexture(t.texture)
a:SetAllPoints(e)
Å
Cmd3DCode_Screenshot_ChatFrameButton:SetParent(ChatFrame1EditBox)
Cmd3DCode_Screenshot_ChatFrameButton:Show()
Cmd3DCode_Screenshot_ChatFrameButton:SetPoint("LEFT",ChatFrame1EditBoxLanguage,"RIGHT",-8,0)
Ë e=CreateFrame("Button","Cmd3DCode_Screenshot_ChatFrameButton_MenuBtn",UIParent,"UIDropDownMenuTemplate")
e:Hide()
UIDropDownMenu_Initialize(e,È(e,a)
Ë i=_G["DropDownList"..(a Î 1)]
É#Cmd3DCode_Screenshot_CapturePictures Ñ
Ë o=1
Ç s,n Ê pairs(Cmd3DCode_Screenshot_CapturePictures)Â
É o<=25 Ñ
Ë e=UIDropDownMenu_CreateInfo()
e.notCheckable=Ò
e.text=n.title
e.arg1=n
e.func=È(t,e)
É e.uploaded Ñ
h(e.idx)
Ã
print("æˆªå›¾å°šæœªä¸Šä¼ åˆ°ç½‘æ˜“æœ‰çˆ±æœåŠ¡å™¨ï¼Œè¯·ç­‰å¾…...")
Å
Å
UIDropDownMenu_AddButton(e,a)
Ë e=_G["DropDownList"..a.."Button"..o]
É e Ñ
e.isExternalPic=Ò
e.externalPicIdx=s
e.externalPicItem=n
e.originOnEnter=e:GetScript("OnEnter")
e:SetScript("OnEnter",È(e,...)
Ë a=Cmd3DCode_Screenshot_ExternalPicture_Thumb(e.externalPicIdx)
É Í a Ñ Ğ Å
a:SetPoint("BOTTOMLEFT",i,"BOTTOMRIGHT",2,15)
a:Show()
É e.externalPicItem.picid Ñ
t.text:SetText("http://w.163.com/"..e.externalPicItem.picid)
ExternalPicturesThumb_BtnOpenInBrowser.url="http://w.163.com/"..e.externalPicItem.picid
ExternalPicturesThumb_BtnOpenInBrowser:Show()
ExternalPicturesThumb_BtnOpenInBrowser:SetPoint("BOTTOMLEFT",a,"BOTTOMRIGHT",1,20)
Ã
t.text:SetText("æ­£åœ¨ä¸Šä¼  ...")
Å
t:SetPoint("BOTTOMLEFT",i,"BOTTOMRIGHT",2,0)
t:Show()
ExternalPicturesThumb_BtnScrawl.picidx=e.externalPicIdx
ExternalPicturesThumb_BtnScrawl.picid=e.externalPicItem.picid
ExternalPicturesThumb_BtnScrawl:SetPoint("BOTTOMLEFT",a,"BOTTOMRIGHT",1,-4)
ExternalPicturesThumb_BtnScrawl:Show()
É e.originOnEnter Ñ e:originOnEnter(...)Å
Å)
Å
Å
o=o+1
Å
Å
Ë e=UIDropDownMenu_CreateInfo()
e.text="åŠŸèƒ½è¯´æ˜(?)"
e.notCheckable=Ò
e.hasOpacity=Ò
e.func=È()
Cmd3DCode_Screenshot_Help:Show()
Å
UIDropDownMenu_AddButton(e,a)
Ë e=UIDropDownMenu_CreateInfo()
e.text="æˆªå±å‘é€"
e.func=Cmd3DCode_Screenshot_Start
e.notCheckable=Ò
e.tooltipTitle="æˆªå–å±å¹•"
e.tooltipText="æˆªå–å±å¹•å‘é€åˆ°å¥½å‹æˆ–èŠå¤©é¢‘é“"
e.hasOpacity=Ò
UIDropDownMenu_AddButton(e,a)
i:SetScript("OnHide",È(e)
o:Hide()
t:Hide()
ExternalPicturesThumb_BtnOpenInBrowser:Hide()
ExternalPicturesThumb_BtnScrawl:Hide()
Ç e=1,UIDROPDOWNMENU_MAXBUTTONS,1 Â
button=_G["DropDownList"..(a Î 1).."Button"..e]
É button À button.isExternalPic Ñ
button:SetScript("OnEnter",button.originOnEnter)
button.externalPicIdx=Ì
button.originOnEnter=Ì
button.originOnLeave=Ì
button.isExternalPic=Ì
Å
Å
i:SetScript("OnHide",Ì)
Å)
Å,"MENU")
Ë o="%[.+w%.163%.com%/(%w+).+%]"
Ë È r(e,t)
Ï
startpos,endpos,picid=string.find(e,o)
É startpos Ñ
e=e:sub(0,startpos-1)
..(t(picid)Î"")..e:sub(endpos+1)
Å
Ó Í startpos
Ğ e
Å
Ë È n(e,t,a)
É Í e Ñ Ğ"xx"Å
Ë a,t=s(e,t,a)
Ğ"|Hviewpic:"..e.picid.."|h|TInterface\\AddOns\\"..i.."\\External\\Image\\"..e.idx..".tga:"..t..":"..a.."|t|h"
Å
ThreeDimensionsCode_SafePipe_CmdHandles["ir"]=È(t,e)
Ë t,o,a=strsplit(",",e)
t=tonumber(t)
Ë e=Cmd3DCode_Screenshot_CapturePictures[t]
É Í e Ñ
print("Cmd3DCode_Screenshot_CapturePictures[picidx] not exits",t)
Ğ
Å
e.width=tonumber(o)Î 0
e.height=tonumber(a)Î 0
e.loaded=Ò
Å
ThreeDimensionsCode_SafePipe_CmdHandles["iu"]=È(t,e)
Ë t,o=strsplit(",",e)
t=tonumber(t)
Ë e=Cmd3DCode_Screenshot_CapturePictures[t]
É Í e Ñ
Ğ
Å
a:Hide()
É o=="!"Ñ
print(e.title,"ä¸Šä¼ å¤±è´¥")
Ğ
Ã
print(e.title,"ä¸Šä¼ å®Œæˆ")
Å
Ë a="http://w.163.com/"..o
Cmd3DCode_Screenshot_ExternalPictures[o]=e
e.uploaded=Ò
e.picid=o
h(t)
Cmd3DCode_Screenshot_CapturePictures_EmitUploded(t)
Å
Ë È d(a,...)
Ç e=1,select("#",...),2 Â
Ë e,t=select(e,...)
É a==t Ñ
Ğ e
Å
Å
Ğ Ì
Å
Ë È h(t,...)
Ç e=1,select("#",...)Â
É select(e,...)==t Ñ
Ğ e
Å
Å
Ğ Æ
Å
Ë È i(e)
Ë a=GetRealmName()
Ë t=#e-(#a+1)
É e:sub(t+2)==a Ñ
Ğ e:sub(1,t)
Ã
Ğ e
Å
Å
ThreeDimensionsCode_SafePipe_CmdHandles["id"]=È(t,e)
Ë o,a,t=strsplit(",",e)
É(a=="0"À t=="0")Î(a==""À t=="")Ñ
print("å¤–éƒ¨å›¾ç‰‡ä¸‹è½½å¤±è´¥ï¼Œå¯èƒ½æ˜¯ç½‘ç»œåŸå› é€ æˆ")
Å
Ë e=Cmd3DCode_Screenshot_ExternalPictures[o]
É Í e Ñ
print("æœªèƒ½æ‰¾åˆ°IDä¸º",o,"çš„æˆªå›¾")
Ğ
Å
e.downloaded=Ò
e.width=tonumber(a)
e.height=tonumber(t)
Ë t="|Hplayer:"..e.from.author.."|h["..i(e.from.author).."]|h: å‘æ¥äº†å›¾ç‰‡ "
t=t.."[ "..n(e,120,90).." ]"
Ç o=1,10 Â
É _G["ChatFrame"..o.."Tab"]:IsVisible()Ñ
Ë a,i,s,n
É e.from.msgtype=="CHANNEL"Ñ
a=h(e.from.channel,GetChatWindowChannels(o))
É a Ñ
Ë a=d(e.from.channel,GetChannelList())
i,s,n=GetMessageTypeColor("CHANNEL"..a)
t="["..e.from.channelString.."] "..t
Å
Ã
a=h(e.from.msgtype,GetChatWindowMessages(o))
i,s,n=GetMessageTypeColor(e.from.msgtype)
Å
É a Ñ
_G["ChatFrame"..o]:AddMessage(t,i,s,n,e.from.guid)
Å
Å
Å
Å
Ë l=0
Ë È e(e,h,t,a,u,d,m,c,w,f,i,y,o,s)
t=r(t,È(e)
É h=="CHAT_MSG_WHISPER_INFORM"Î a==GetUnitName("player",Æ).."-"..GetRealmName()Ñ
Ë e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(e)
Ë e=n(e,120,90)
Ğ"[ "..e.." ]"
Ã
É o>l Ñ
l=o
Ë t={
author=a,
msgtype=h:sub(10),
channel=i,
channelString=d,
guid=s,
}
Ë t=p(e,i,t)
É time()-cmd3dcode_lastPingTime()>45 Ñ
print("æ”¶åˆ°æ¥è‡ª"..a.."çš„æˆªå›¾: w.163.com/"..e.." ,è¯·å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯æ˜¾ç¤ºæ­¤å›¾")
Å
ThreeDimensionsCode_Send("loadpic",t.texture..","..e)
Å
Ğ""
Å
Å)
Ğ#t<1,t,a,u,d,m,c,w,f,i,y,o,s
Å
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
Ë o=250
Ë È s(t,e)
É Í t:IsShown()Ñ
e.cachedText=Ì
Ğ
Å
o=math.max(t:GetWidth(),o)
Ë t=e:GetText()Î""
É t==e.cachedText Ñ Ğ Å
Ë t=r(t,È(e)
Ë e=Cmd3DCode_Screenshot_ExternalPictures[e]
É Í e Ñ Ğ""Å
É e.width<=0 Ñ Ğ""Å
Ğ n(e,100,75)
Å)
É#t>0 Ñ
e:SetText(t)
e.cachedText=t
e:SetWidth(math.min(e:GetStringWidth(),o-14))
Å
Å
Ë È i()
Ç e=1,WorldFrame:GetNumChildren()Â
Ë e=select(e,WorldFrame:GetChildren())
Ë t=e:GetBackdrop()
É t À t.bgFile=="Interface\\Tooltips\\ChatBubble-Background"Ñ
Ç t=1,e:GetNumRegions()Â
Ë t=select(t,e:GetRegions())
É t:GetObjectType()=="FontString"Ñ
s(e,t)
Å
Å
Å
Å
Å
Ë o=.15
Ë t=CreateFrame("Frame")
t.interval=o
t:SetScript("OnUpdate",È(e,t)
e.interval=e.interval-t
É e.interval<0 Ñ
e.interval=o
i()
Å
Å)
t:Show()
Ë i="\[æˆªå›¾ [%d:]+ (%d+)\]"
hooksecurefunc("AutoCompleteEditBox_OnEnterPressed",È()
Ë e=ChatEdit_ChooseBoxForSend()
É Í e:IsVisible()Ñ
Ğ
Å
Ë e=e:GetText()
Ë t,o=1,picidx
Ï
t,o,picidx=string.find(e,i)
picidx=tonumber(picidx)
Ë a=Cmd3DCode_Screenshot_CapturePictures[picidx]
É picidx À a À a.picid Ñ
e=e:sub(0,t-1)
.."[å‘æ¥äº†å›¾ç‰‡ï¼Œåœ¨æµè§ˆå™¨ä¸­è¾“å…¥ç½‘å€æŸ¥çœ‹ï¼šw.163.com/"..a.picid.."  (å®‰è£…â€œç½‘æ˜“æœ‰çˆ±æ’ä»¶åŒ…â€åå¯åœ¨æ¸¸æˆå†…æ˜¾ç¤º)]"
..e:sub(o+1)
Å
Ó Í t
ChatEdit_ChooseBoxForSend():SetText(e)
Å)
hooksecurefunc("AutoCompleteEditBox_OnEscapePressed",È()
a:Hide()
Å)
Ë e=CreateFrame("FRAME","Cmd3DCode_Screenshot_PicViewer",UIParent)
e:SetFrameStrata("TOOLTIP")
e:SetFrameLevel(120)
e:SetAllPoints(UIParent)
e:Hide()
e.bg=e:CreateTexture()
e.bg:SetTexture(.1,.1,.1,.7)
e.bg:SetAllPoints(e)
e:EnableKeyboard(Ò);
e:SetPropagateKeyboardInput(Ò);
e:SetScript("OnKeyDown",È(e,t,...)
É t=="ESCAPE"Ñ
e:Hide()
e:SetPropagateKeyboardInput(Æ)
Ğ Æ
Å
e:SetPropagateKeyboardInput(Ò);
Å)
e:SetScript("OnMouseDown",È(e)
e:Hide()
Å)
Ë t=CreateFrame("FRAME","Cmd3DCode_Screenshot_PicViewerPhoto",e)
t:SetPoint("CENTER")
t:SetWidth(403)
t:SetHeight(300)
t.texture=t:CreateTexture(Ì,"BACKGROUND")
t.texture:SetAllPoints(t)
Ë i={
viewpic=È(o,a,a,a,a,a)
Ë a=Cmd3DCode_Screenshot_ExternalPictures[o]
É Í a Ñ
print("picid",o,"æ— æ•ˆ")
Ğ
Å
t.texture:SetTexture(a.texture)
t:SetWidth(a.width)
t:SetHeight(a.height)
e:Show()
Å
}
Ë s=SetItemRef
È SetItemRef(e,o,n,t)
Ë a,h=strmatch(e,"^(.+):(.+)$")
É Í i[a]Ñ
s(e,o,n,t)
Ğ
Å
i[a](h,e,o,n,t)
Å
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=Cmd3DCode_Screenshot_Start]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()