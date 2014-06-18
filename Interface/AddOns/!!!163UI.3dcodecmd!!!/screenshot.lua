local base_char,keywords=191,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ë o=...
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
Ë n=t+a
Ë i=e+o
Cmd3DCode_ShottingMaskFrame:SetWidth(d)
Cmd3DCode_ShottingMaskFrame:SetHeight(r)
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
È Cmd3DCode_Screenshot_Start()
Cmd3DCode_ViewFinderFrame:SetWidth(400)
Cmd3DCode_ViewFinderFrame:SetHeight(300)
Cmd3DCode_ViewFinderFrame:SetPoint("CENTER",Cmd3DCode_ShottingMaskFrame,"CENTER",0,0)
Cmd3DCode_UpdateViewFinderFrames()
Cmd3DCode_ShottingMaskFrame:Show()
Å
Ë È a(e,t)
e=e*t
Ë a,e=math.modf(e,1)
e=e>=.5 À 1 Î 0
Ğ(a+e)/t
Å
Ë e=1
Cmd3DCode_Screenshot_ExternalPictures={}
Cmd3DCode_Screenshot_ExternalPicture_Receives={}
Ë t=UIParent:CreateTexture(Ì,"BACKGROUND")
t:SetPoint("CENTER",UIParent,"CENTER",0,0)
t:Show()
Ë È h(t)
Ë t={
texture="Interface\\AddOns\\"..o.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
loaded=Æ,
uploaded=Æ,
idx=e,
time=t,
title=date("æˆªå›¾ %H:%M:%S",t),
}
Cmd3DCode_Screenshot_ExternalPictures[e]=t
e=e+1
É e>512 Ñ
e=1
Å
Ğ t
Å
Ë È c(t,i,a)
Ë a={
texture="Interface\\AddOns\\"..o.."\\External\\Image\\"..e..".tga",
width=0,
height=0,
downloaded=Æ,
idx=e,
picid=t,
channel=i,
from=a,
}
Cmd3DCode_Screenshot_ExternalPicture_Receives[t]=a
e=e+1
É e>512 Ñ
e=1
Å
Ğ a
Å
Ë È i(t,a,e)
Ë o=a/e
Ë t=t.width/t.height
É t>o Ñ
Ğ a,a/t
Ã
Ğ e*t,e
Å
Å
È Cmd3DCode_Screenshot_ExternalPictures_Thumb(s)
Ë e=Cmd3DCode_Screenshot_ExternalPictures[s]
É Í e Ñ
Ğ
Å
Ë a,n=160,120
É e.loaded Ñ
a,n=i(e,a,n)
t:SetTexture(e.texture)
Ã
t:SetTexture("Interface\\AddOns\\"..o.."\\Textures\\external-pic-loading.tga")
Å
t:SetWidth(a)
t:SetHeight(n)
t.picidx=s
Ğ t
Å
È Cmd3DCode_Screenshot_ExternalPictures_FromPicId(t)
Ç a,e Ê pairs(Cmd3DCode_Screenshot_ExternalPictures)Â
É e.picid==t Ñ
Ğ e
Å
Å
Å
È Cmd3DCode_Screenshot_ExternalPictures_OnceUploded(e,t)
É Í Cmd3DCode_Screenshot_ExternalPictures[e]Ñ
print("æŒ‡å®šåºåˆ—çš„å›¾ç‰‡ä¸å­˜åœ¨",e)
Ğ
Å
Ë e=Cmd3DCode_Screenshot_ExternalPictures[e]
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
È Cmd3DCode_Screenshot_ExternalPictures_EmitUploded(e)
É Í Cmd3DCode_Screenshot_ExternalPictures[e]Ñ
Ğ
Å
Ë e=Cmd3DCode_Screenshot_ExternalPictures[e]
É e.onceHandles Ñ
Ç a,t Ê pairs(e.onceHandles)Â
t(e)
Å
e.onceHandles={}
Å
Å
È Cmd3DCode_Screenshot_TakePhoto(r)
Cmd3DCode_ShottingMaskFrame:Hide()
Ë d=UIParent:IsVisible()
Ë i=Cmd3DCode_ViewFinderFrame_ChkBtn_HideUI:GetChecked()
Ë s=Cmd3DCode_ViewFinderFrame_ChkBtn_SaveSrcPic:GetChecked()À"0"Î"1"
É i Ñ
print("éšè—UI")
UIParent:Hide()
Å
Ë e=GetCVar("screenshotFormat")
É e~="jpg"Ñ
SetCVar("screenshotFormat","jpg")
Å
Ë t=time()
TakeScreenshot()
Ë o=CreateFrame("FRAME")
o:RegisterEvent("SCREENSHOT_SUCCEEDED")
o:SetScript("OnEvent",È(l,n)
É n=="SCREENSHOT_SUCCEEDED"Ñ
É e~="jpg"Ñ
SetCVar("screenshotFormat",e)
Å
É i À d Ñ
UIParent:Show()
Å
Ë o=h(t)
Ë t=o.texture
..","..t
..","..s
..","..GetRealmName()
..","..GetUnitName("player")
É Í r Ñ
Ë o=UIParent:GetWidth()
Ë e=UIParent:GetHeight()
Ë h,n,s,i=Cmd3DCode_ViewFinderFrame:GetRect()
t=t..","..a(h/o,100)
..","..(1-a(n/e,100))-a(i/e,100)
..","..a(s/o,100)
..","..a(i/e,100)
Å
ThreeDimensionsCode_Send("screenshot",t)
É time()-cmd3dcode_lastPingTime()>15 Ñ
StaticPopup_Show("163UI-Screenshot:ClientNotFound")
Ã
print("æ­£åœ¨ä¸Šä¼  "..o.title.." ...")
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
Ë È s(t)
Ë a=Cmd3DCode_Screenshot_ExternalPictures[t]
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
Ë t=Cmd3DCode_Screenshot_ExternalPictures[t]
É Í t Ñ
Ğ
Å
Ë a,o=i(t,e:GetWidth(),e:GetHeight())
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
É#Cmd3DCode_Screenshot_ExternalPictures Ñ
Ë a=1
Ç n,i Ê pairs(Cmd3DCode_Screenshot_ExternalPictures)Â
É a<=25 Ñ
Ë e=UIDropDownMenu_CreateInfo()
e.notCheckable=Ò
e.text=i.title
e.arg1=i
e.func=È(t,e)
É e.uploaded Ñ
s(e.idx)
Ã
print("æˆªå›¾å°šæœªä¸Šä¼ åˆ°ç½‘æ˜“æœ‰çˆ±æœåŠ¡å™¨ï¼Œè¯·ç­‰å¾…...")
Å
Å
UIDropDownMenu_AddButton(e,t)
Ë e=_G["DropDownList"..t.."Button"..a]
É e Ñ
e.isExternalPic=Ò
e.externalPicIdx=n
e.originOnEnter=e:GetScript("OnEnter")
e:SetScript("OnEnter",È(t,...)
Ë e=Cmd3DCode_Screenshot_ExternalPictures_Thumb(t.externalPicIdx)
É Í e Ñ Ğ Å
e:SetPoint("BOTTOMLEFT",o,"BOTTOMRIGHT",2,0)
e:Show()
É t.originOnEnter Ñ t:originOnEnter(...)Å
Å)
e.originOnLeave=e:GetScript("OnLeave")
e:SetScript("OnLeave",È(e,...)
Ë t=Cmd3DCode_Screenshot_ExternalPictures_Thumb(e.externalPicIdx)
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
Ë È n(e,a,t)
É Í e Ñ Ğ"xx"Å
Ë t,a=i(e,a,t)
Ğ"|Hextpic:"..e.picid.."|h|TInterface\\AddOns\\"..o.."\\External\\Image\\"..e.idx..".tga:"..a..":"..t.."|t|h"
Å
ThreeDimensionsCode_SafePipe_CmdHandles["ir"]=È(t,e)
Ë e,o,a=strsplit(",",e)
e=tonumber(e)
Ë t=Cmd3DCode_Screenshot_ExternalPictures[e]
É Í t Ñ
print("Cmd3DCode_Screenshot_ExternalPictures[picidx] not exits",e)
Ğ
Å
t.width=tonumber(o)Î 0
t.height=tonumber(a)Î 0
t.loaded=Ò
Å
ThreeDimensionsCode_SafePipe_CmdHandles["iu"]=È(t,e)
Ë e,a=strsplit(",",e)
e=tonumber(e)
Ë t="http://w.163.com/"..a
Ë t=Cmd3DCode_Screenshot_ExternalPictures[e]
É Í t Ñ
Ğ
Å
t.uploaded=Ò
t.picid=a
print(t.title,"ä¸Šä¼ å®Œæˆ")
s(e)
Cmd3DCode_Screenshot_ExternalPictures_EmitUploded(e)
Å
Ë È r(t,...)
Ç e=1,select("#",...),2 Â
Ë e,a=select(e,...)
É t==a Ñ
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
Ë o,t,a=strsplit(",",e)
É(t=="0"À a=="0")Î(t==""À a=="")Ñ
print("å¤–éƒ¨å›¾ç‰‡ä¸‹è½½å¤±è´¥ï¼Œå¯èƒ½æ˜¯ç½‘ç»œåŸå› é€ æˆ")
Å
Ë e=Cmd3DCode_Screenshot_ExternalPicture_Receives[o]
É Í e Ñ
print("æœªèƒ½æ‰¾åˆ°IDä¸º",o,"çš„æˆªå›¾")
Ğ
Å
e.downloaded=Ò
e.width=tonumber(t)
e.height=tonumber(a)
Ë t="|Hplayer:"..e.from.author.."|h["..i(e.from.author).."]|h: å‘æ¥äº†å›¾ç‰‡ "
t=t.."[ "..n(e,120,90).." ]"
Ç o=1,10 Â
É _G["ChatFrame"..o.."Tab"]:IsVisible()Ñ
Ë a,i,s,n
É e.from.msgtype=="CHANNEL"Ñ
a=h(e.from.channel,GetChatWindowChannels(o))
É a Ñ
Ë a=r(e.from.channel,GetChannelList())
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
Ë s=0
Ë È e(p,r,e,t,w,h,y,f,m,u,a,l,o,i)
e=d(e,È(e)
É r=="CHAT_MSG_WHISPER_INFORM"Î t==GetUnitName("player",Æ).."-"..GetRealmName()Ñ
Ë e=Cmd3DCode_Screenshot_ExternalPictures_FromPicId(e)
Ë e=n(e,120,90)
Ğ"[ "..e.." ]"
Ã
É o>s Ñ
s=o
Ë t={
author=t,
msgtype=r:sub(10),
channel=a,
channelString=h,
guid=i,
}
Ë t=c(e,a,t)
ThreeDimensionsCode_Send("loadpic",t.texture..","..e)
Å
Ğ""
Å
Å)
Ğ#e<1,e,t,w,h,y,f,m,u,a,l,o,i
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
Ë e=Cmd3DCode_Screenshot_ExternalPictures_FromPicId(e)
Ğ e À n(e,100,75)Î""
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
Ë a=Cmd3DCode_Screenshot_ExternalPictures[picidx]
É picidx À a À a.picid Ñ
e=e:sub(0,t-1)
.."[å‘æ¥äº†å›¾ç‰‡ï¼Œåœ¨æµè§ˆå™¨ä¸­è¾“å…¥ç½‘å€æŸ¥çœ‹ï¼šw.163.com/"..a.picid.."  (å®‰è£…â€œç½‘æ˜“æœ‰çˆ±æ’ä»¶åŒ…â€åå¯åœ¨æ¸¸æˆå†…æ˜¾ç¤º)]"
..e:sub(o+1)
Å
Ó Í t
ChatEdit_ChooseBoxForSend():SetText(e)
Å)
SLASH_3DCODECMDSCREENSHOT1="/ss"
SlashCmdList["3DCODECMDSCREENSHOT"]=Cmd3DCode_Screenshot_Start
È myfuncxxxx()
print("in myfuncxxxx()")
Å
Ë a=SetItemRef
È SetItemRef(e,n,i,o)
Ë t=strmatch(e,"^extpic:(.+)")
É t Ñ
print("å›¾ç‰‡idï¼š",t)
Ã
a(e,n,i,o)
Å
Å
]===], '@../!!!163UI.3dcodecmd!!!/screenshot.lua'))()