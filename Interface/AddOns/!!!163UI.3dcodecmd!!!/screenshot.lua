local base_char,keywords=191,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[É bit==Ì À bit32~=Ì Ñ
bit=bit32
Å
Ë i=...
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
Ë h=d-t-a
Ë s=r-e-o
Ë i=t+a
Ë n=e+o
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
Ë o=ChatFrame1EditBox:CreateFontString()
o:SetFontObject(GameFontNormalSmall)
o:SetPoint("TOPLEFT")
o:SetPoint("BOTTOMRIGHT")
o:Hide()
Ë È n(e,t)
e=e*t
Ë a,e=math.modf(e,1)
e=e>=.5 À 1 Î 0
Ğ(a+e)/t
Å
Ë È h(t)
Ë e=2;
Ï
É e>t Ñ
Ğ e;
Å
e=bit.lshift(e,1);
Ó Æ
Å
Ë e=1
Cmd3DCode_Screenshot_CapturePictures={}
Cmd3DCode_Screenshot_ExternalPictures={}
Ë a=UIParent:CreateTexture(Ì,"BACKGROUND")
a:SetPoint("CENTER",UIParent,"CENTER",0,0)
a:Show()
Ë È r(t)
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
Ë È u(a,o,t)
Ë t={
texture="Interface\\AddOns\\"..i.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
downloaded=Æ,
idx=e,
picid=a,
channel=o,
from=t,
}
Cmd3DCode_Screenshot_ExternalPictures[a]=t
e=e+1
É e>512 Ñ
e=1
Å
Ğ t
Å
Ë È s(e,t,a)
Ë o=t/a
Ë e=e.width/e.height
É e>o Ñ
Ğ t,t/e
Ã
Ğ a*e,a
Å
Å
È Cmd3DCode_Screenshot_ExternalPicture_Texture(a,t)
Ë e=Cmd3DCode_Screenshot_ExternalPictures[a]
É Í e Ñ
print("picid",a,"æ— æ•ˆ")
Ğ
Å
É Í t.pictexture Ñ
t.pictexture=t:CreateTexture(Ì,"BACKGROUND")
Å
print(e.width,">>",h(e.width))
print(e.height,">>",h(e.height))
t.pictexture:SetPoint("TOPLEFT")
t.pictexture:SetTexture(e.texture)
t.pictexture:SetWidth(e.width)
t.pictexture:SetHeight(e.height)
print(e.width,e.height,t.pictexture:GetWidth(),t.pictexture:GetHeight())
t.picid=a
Ğ e
Å
È Cmd3DCode_Screenshot_ExternalPicture_Thumb(n)
Ë e=Cmd3DCode_Screenshot_CapturePictures[n]
É Í e Ñ
Ğ
Å
Ë o,t=160,120
É e.loaded Ñ
o,t=s(e,o,t)
a:SetTexture(e.texture)
Ã
a:SetTexture("Interface\\AddOns\\"..i.."\\Textures\\external-pic-loading.tga")
Å
a:SetWidth(o)
a:SetHeight(t)
a.picidx=n
Ğ a
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
È Cmd3DCode_Screenshot_TakePhoto(d)
Cmd3DCode_ShottingMaskFrame:Hide()
Ë s=UIParent:IsVisible()
Ë a=Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:GetChecked()
Ë l=Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()À"0"Î"1"
É a Ñ
print("éšè—UI")
UIParent:Hide()
Å
Ë e=GetCVar("screenshotFormat")
É e~="jpg"Ñ
SetCVar("screenshotFormat","jpg")
Å
Ë i=time()
TakeScreenshot()
Ë t=CreateFrame("FRAME")
t:RegisterEvent("SCREENSHOT_SUCCEEDED")
t:SetScript("OnEvent",È(u,h)
É h=="SCREENSHOT_SUCCEEDED"Ñ
É e~="jpg"Ñ
SetCVar("screenshotFormat",e)
Å
É a À s Ñ
UIParent:Show()
Å
Ë a=r(i)
Ë t=a.texture
..","..i
..","..l
..","..GetRealmName()
..","..GetUnitName("player")
É Í d Ñ
Ë a=UIParent:GetWidth()
Ë e=UIParent:GetHeight()
Ë h,i,s,o=Cmd3DCode_ViewFinderFrame:GetRect()
t=t..","..n(h/a,100)
..","..(1-n(i/e,100))-n(o/e,100)
..","..n(s/a,100)
..","..n(o/e,100)
Å
ThreeDimensionsCode_Send("screenshot",t)
É time()-cmd3dcode_lastPingTime()>15 Ñ
StaticPopup_Show("163UI-Screenshot:ClientNotFound")
Ã
print("æ­£åœ¨ä¸Šä¼  "..a.title.." ...")
o:SetText("æ­£åœ¨ä¸Šä¼  "..a.title.." ...")
o:Show()
Å
Å
t:SetScript("OnEvent",Ì)
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
Ë È n(t)
Ë a=Cmd3DCode_Screenshot_CapturePictures[t]
É Í a Ñ
print("æœªèƒ½æ‰¾åˆ°åºå·ä¸º",t,"çš„æˆªå›¾")
Ğ
Å
Ë e=ChatEdit_ChooseBoxForSend()
É Í e:IsShown()Î ChatFrame1EditBox:GetAlpha()<1 Ñ
ChatEdit_ActivateChat(e)
Å
e:SetText("["..a.title.." "..t.."]")
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
UIDropDownMenu_Initialize(e,È(e,t)
Ë o=_G["DropDownList"..(t Î 1)]
É#Cmd3DCode_Screenshot_CapturePictures Ñ
Ë a=1
Ç s,i Ê pairs(Cmd3DCode_Screenshot_CapturePictures)Â
É a<=25 Ñ
Ë e=UIDropDownMenu_CreateInfo()
e.notCheckable=Ò
e.text=i.title
e.arg1=i
e.func=È(t,e)
É e.uploaded Ñ
n(e.idx)
Ã
print("æˆªå›¾å°šæœªä¸Šä¼ åˆ°ç½‘æ˜“æœ‰çˆ±æœåŠ¡å™¨ï¼Œè¯·ç­‰å¾…...")
Å
Å
UIDropDownMenu_AddButton(e,t)
Ë e=_G["DropDownList"..t.."Button"..a]
É e Ñ
e.isExternalPic=Ò
e.externalPicIdx=s
e.originOnEnter=e:GetScript("OnEnter")
e:SetScript("OnEnter",È(t,...)
Ë e=Cmd3DCode_Screenshot_ExternalPicture_Thumb(t.externalPicIdx)
É Í e Ñ Ğ Å
e:SetPoint("BOTTOMLEFT",o,"BOTTOMRIGHT",2,0)
e:Show()
É t.originOnEnter Ñ t:originOnEnter(...)Å
Å)
e.originOnLeave=e:GetScript("OnLeave")
e:SetScript("OnLeave",È(e,...)
Ë t=Cmd3DCode_Screenshot_ExternalPicture_Thumb(e.externalPicIdx)
É Í t Ñ Ğ Å
t:Hide()
É e.originOnLeave Ñ e:originOnLeave(...)Å
Å)
Å
Å
a=a+1
Å
Å
Ë e=UIDropDownMenu_CreateInfo()
e.text="åŠŸèƒ½è¯´æ˜(?)"
e.notCheckable=Ò
e.hasOpacity=Ò
e.func=È()
Cmd3DCode_Screenshot_Help:Show()
Å
UIDropDownMenu_AddButton(e,t)
Ë e=UIDropDownMenu_CreateInfo()
e.text="æˆªå±å‘é€"
e.func=Cmd3DCode_Screenshot_Start
e.notCheckable=Ò
e.tooltipTitle="æˆªå–å±å¹•"
e.tooltipText="æˆªå–å±å¹•å‘é€åˆ°å¥½å‹æˆ–èŠå¤©é¢‘é“"
e.hasOpacity=Ò
UIDropDownMenu_AddButton(e,t)
o:SetScript("OnHide",È(e)
Ç e=1,UIDROPDOWNMENU_MAXBUTTONS,1 Â
button=_G["DropDownList"..(t Î 1).."Button"..e]
É button À button.isExternalPic Ñ
button:SetScript("OnEnter",button.originOnEnter)
button:SetScript("OnLeave",button.originOnLeave)
button.externalPicIdx=Ì
button.originOnEnter=Ì
button.originOnLeave=Ì
button.isExternalPic=Ì
Å
Å
o:SetScript("OnHide",Ì)
Å)
Å,"MENU")
Ë a="%[.+w%.163%.com%/(%w+).+%]"
Ë È d(e,t)
Ï
startpos,endpos,picid=string.find(e,a)
É startpos Ñ
e=e:sub(0,startpos-1)
..(t(picid)Î"")..e:sub(endpos+1)
Å
Ó Í startpos
Ğ e
Å
Ë È h(e,t,a)
É Í e Ñ Ğ"xx"Å
Ë a,t=s(e,t,a)
Ğ"|Hviewpic:"..e.picid.."|h|TInterface\\AddOns\\"..i.."\\External\\Image\\"..e.idx..".tga:"..t..":"..a.."|t|h"
Å
ThreeDimensionsCode_SafePipe_CmdHandles["ir"]=È(t,e)
Ë t,a,o=strsplit(",",e)
t=tonumber(t)
Ë e=Cmd3DCode_Screenshot_CapturePictures[t]
É Í e Ñ
print("Cmd3DCode_Screenshot_CapturePictures[picidx] not exits",t)
Ğ
Å
e.width=tonumber(a)Î 0
e.height=tonumber(o)Î 0
e.loaded=Ò
Å
ThreeDimensionsCode_SafePipe_CmdHandles["iu"]=È(t,e)
Ë e,a=strsplit(",",e)
e=tonumber(e)
Ë t="http://w.163.com/"..a
Ë t=Cmd3DCode_Screenshot_CapturePictures[e]
É Í t Ñ
Ğ
Å
Cmd3DCode_Screenshot_ExternalPictures[a]=t
t.uploaded=Ò
t.picid=a
print(t.title,"ä¸Šä¼ å®Œæˆ")
o:Hide()
n(e)
Cmd3DCode_Screenshot_CapturePictures_EmitUploded(e)
Å
Ë È l(a,...)
Ç e=1,select("#",...),2 Â
Ë t,e=select(e,...)
É a==e Ñ
Ğ t
Å
Å
Ğ Ì
Å
Ë È r(t,...)
Ç e=1,select("#",...)Â
É select(e,...)==t Ñ
Ğ e
Å
Å
Ğ Æ
Å
Ë È i(e)
Ë t=GetRealmName()
Ë a=#e-(#t+1)
É e:sub(a+2)==t Ñ
Ğ e:sub(1,a)
Ã
Ğ e
Å
Å
ThreeDimensionsCode_SafePipe_CmdHandles["id"]=È(t,e)
Ë o,t,a=strsplit(",",e)
É(t=="0"À a=="0")Î(t==""À a=="")Ñ
print("å¤–éƒ¨å›¾ç‰‡ä¸‹è½½å¤±è´¥ï¼Œå¯èƒ½æ˜¯ç½‘ç»œåŸå› é€ æˆ")
Å
Ë e=Cmd3DCode_Screenshot_ExternalPictures[o]
É Í e Ñ
print("æœªèƒ½æ‰¾åˆ°IDä¸º",o,"çš„æˆªå›¾")
Ğ
Å
e.downloaded=Ò
e.width=tonumber(t)
e.height=tonumber(a)
Ë t="|Hplayer:"..e.from.author.."|h["..i(e.from.author).."]|h: å‘æ¥äº†å›¾ç‰‡ "
t=t.."[ "..h(e,120,90).." ]"
Ç a=1,10 Â
É _G["ChatFrame"..a.."Tab"]:IsVisible()Ñ
Ë o,i,n,s
É e.from.msgtype=="CHANNEL"Ñ
o=r(e.from.channel,GetChatWindowChannels(a))
É o Ñ
Ë a=l(e.from.channel,GetChannelList())
i,n,s=GetMessageTypeColor("CHANNEL"..a)
t="["..e.from.channelString.."] "..t
Å
Ã
o=r(e.from.msgtype,GetChatWindowMessages(a))
i,n,s=GetMessageTypeColor(e.from.msgtype)
Å
É o Ñ
_G["ChatFrame"..a]:AddMessage(t,i,n,s,e.from.guid)
Å
Å
Å
Å
Ë n=0
Ë È e(p,s,e,o,w,i,y,f,l,m,t,c,a,r)
e=d(e,È(e)
É s=="CHAT_MSG_WHISPER_INFORM"Î o==GetUnitName("player",Æ).."-"..GetRealmName()Ñ
Ë e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(e)
Ë e=h(e,120,90)
Ğ"[ "..e.." ]"
Ã
É a>n Ñ
n=a
Ë a={
author=o,
msgtype=s:sub(10),
channel=t,
channelString=i,
guid=r,
}
Ë t=u(e,t,a)
ThreeDimensionsCode_Send("loadpic",t.texture..","..e)
Å
Ğ""
Å
Å)
Ğ#e<1,e,o,w,i,y,f,l,m,t,c,a,r
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
Ë a=250
Ë È i(t,e)
É Í t:IsShown()Ñ
e.cachedText=Ì
Ğ
Å
a=math.max(t:GetWidth(),a)
Ë t=e:GetText()Î""
É t==e.cachedText Ñ Ğ Å
t=d(t,È(e)
Ë e=Cmd3DCode_Screenshot_CapturePictures_FromPicId(e)
Ğ e À h(e,100,75)Î""
Å)
e:SetText(t)
e.cachedText=t
e:SetWidth(math.min(e:GetStringWidth(),a-14))
Å
Ë È o()
Ç e=1,WorldFrame:GetNumChildren()Â
Ë e=select(e,WorldFrame:GetChildren())
Ë t=e:GetBackdrop()
É t À t.bgFile=="Interface\\Tooltips\\ChatBubble-Background"Ñ
Ç t=1,e:GetNumRegions()Â
Ë t=select(t,e:GetRegions())
É t:GetObjectType()=="FontString"Ñ
i(e,t)
Å
Å
Å
Å
Å
Ë a=.15
Ë t=CreateFrame("Frame")
t.interval=a
t:SetScript("OnUpdate",È(e,t)
e.interval=e.interval-t
É e.interval<0 Ñ
e.interval=a
o()
Å
Å)
t:Show()
Ë a="\[æˆªå›¾ [%d:]+ (%d+)\]"
hooksecurefunc("AutoCompleteEditBox_OnEnterPressed",È()
Ë e=ChatEdit_ChooseBoxForSend()
É Í e:IsVisible()Ñ
Ğ
Å
Ë e=e:GetText()
Ë t,o=1,picidx
Ï
t,o,picidx=string.find(e,a)
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
Ë o={
viewpic=È(o,a,a,a,a,a)
Ë a=Cmd3DCode_Screenshot_ExternalPictures[o]
É Í a Ñ
print("picid",o,"æ— æ•ˆ")
Ğ
Å
t.texture:SetTexture(a.texture)
t.texture:SetWidth(a.width)
t.texture:SetHeight(a.height)
e:Show()
Å
}
Ë s=SetItemRef
È SetItemRef(e,a,t,i)
Ë n,h=strmatch(e,"^(.+):(.+)$")
É Í o[n]Ñ
s(e,a,t,i)
Ğ
Å
o[n](h,e,a,t,i)
Å
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=Cmd3DCode_Screenshot_Start]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()