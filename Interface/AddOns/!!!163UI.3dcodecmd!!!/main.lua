local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ì e={
verbose=Ç,
info=Ç,
errro=Ó,
}
Ì É t(...)
Ê e.verbose Ò print("[verbose]",...)Æ
Æ
Ì É a(...)
Ê e.info Ò print("[verbose]",...)Æ
Æ
Ì É a(...)
Ê e.errro Ò print("[verbose]",...)Æ
Æ
É cmd3dcode_main_showlog(t,a)
Ê t==Í Ò t="verbose"Æ
Ê a==Í Ò a=Ó Æ
e[t]=a
Æ
Ê(LoggingChat())Ò
Ä
LoggingChat(1);
Æ
Ì e="3dcodecmd$Yin2"
Ì e="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
Ì e="3dcodecmd$Yang2"
Ì e="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yang()"
Ì É e(e,a,o)
Ê Î GetMacroBody(e)Ò
CreateMacro(e,"INV_MISC_QUESTIONMARK",a,Í)
t("create macro",e)
Ä
t("macro has already exists",e)
Æ
SetOverrideBindingMacro(ThreeDimensionsCode_Blackboard,Ó,o,e)
Æ
Ì i=0
Ì s=Ç
Ì e=GetNumAddOns()
Ì o=0
È e=1,GetNumAddOns()Ã
Ì a,a,a,t,a,a,a=GetAddOnInfo(e)
Ê t Á Î IsAddOnLoadOnDemand(e)Ò
o=o+1
Æ
Æ
Ì É n(o,a,e,t,i)
Ì e=CreateFrame("Frame",a,UIParent,e)
Ê t Ò
e:SetPoint("LEFT",t,"RIGHT",i,0)
Æ
e:SetFrameStrata("DIALOG")
e.t=e:CreateTexture()
e.t:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
e.t:SetAllPoints(e)
e.fontstring=e:CreateFontString()
e.fontstring:SetFontObject(GameFontNormalSmall)
e.fontstring:SetText(o)
e.fontstring:SetAllPoints(e)
e:Show()
Ê GetCVar("chatStyle")~="classic"Ò
e:SetAlpha(.35)
hooksecurefunc("ChatEdit_DeactivateChat",É(t)
e:SetAlpha(.35)
Æ)
hooksecurefunc("ChatEdit_ActivateChat",É(t)
e:SetAlpha(1)
Æ)
Æ
Ñ e
Æ
Ì É e(...)
Æ
É Toggle3DCodeCmdChatFrameBtnShown()
Ê Î Cmd3DCode_Emoticon_ChatFrameButton Ï Î Cmd3DCode_Screenshot_ChatFrameButton Ò
Ñ
Æ
Ì e=Ó
Ê U1DB Á U1DB.configs Ò
Ê U1DB.configs["!!!163ui!!!/displayScrshotEmoticonBtn"]=="_NIL"Ï U1DB.configs["!!!163ui!!!/displayScrshotEmoticonBtn"]==Ç Ò
e=Ç
Æ
Æ
Ê Î e Ò
Cmd3DCode_Emoticon_ChatFrameButton:Hide()
Cmd3DCode_Screenshot_ChatFrameButton:Hide()
È e=1,10 Ã
Ì a,o,i,n,t=_G["ChatFrame"..e.."EditBox"]:GetPoint()
_G["ChatFrame"..e.."EditBox"]:SetPoint(a,o,i,-5,t)
Æ
Ä
Cmd3DCode_Emoticon_ChatFrameButton:Show()
Cmd3DCode_Screenshot_ChatFrameButton:Show()
Ì e
È t=1,10 Ã
Ì a,i,n,o
e,a,i,n,o=_G["ChatFrame"..t.."EditBox"]:GetPoint()
_G["ChatFrame"..t.."EditBox"]:SetPoint(e,a,i,13,o)
Æ
Cmd3DCode_Emoticon_ChatFrameButton:SetWidth(32)
Cmd3DCode_Emoticon_ChatFrameButton:SetHeight(32)
Cmd3DCode_Screenshot_ChatFrameButton:SetWidth(32)
Cmd3DCode_Screenshot_ChatFrameButton:SetHeight(32)
Cmd3DCode_Emoticon_ChatFrameButton:ClearAllPoints()
Cmd3DCode_Emoticon_ChatFrameButton:SetPoint("RIGHT",ChatFrame1EditBox,"LEFT",8.4,0)
Cmd3DCode_Screenshot_ChatFrameButton:ClearAllPoints()
Cmd3DCode_Screenshot_ChatFrameButton:SetPoint("RIGHT",Cmd3DCode_Emoticon_ChatFrameButton,"LEFT",8,0)
Æ
Æ
Ì É d()
Ì e=n("è¡¨","Cmd3DCode_Emoticon_ChatFrameButton","Cmd3DCode_Emoticon_ChatFrameButtonTemplate")
Ì t=n("å›¾","Cmd3DCode_Screenshot_ChatFrameButton","Cmd3DCode_Screenshot_ChatFrameButtonTemplate",e,-6)
Toggle3DCodeCmdChatFrameBtnShown()
CoreUIEnableTooltip(e,"è‡ªå®šä¹‰è¡¨æƒ…","å¯¼å…¥ä½ çš„ä¸“å±žè¡¨æƒ…åŒ…")
CoreUIEnableTooltip(t,"æœ‰çˆ±æˆªå›¾","åœ¨æ¸¸æˆå†…æˆªå›¾å¹¶å‘é€åˆ°èŠå¤©é¢‘é“")
Ê dwChannelMuteButton Ò
SetOrHookScript(dwChannelMuteButton,"OnShow",Toggle3DCodeCmdChatFrameBtnShown)
SetOrHookScript(dwChannelMuteButton,"OnHide",Toggle3DCodeCmdChatFrameBtnShown)
Æ
Ê DWCChatTab18 Ò
SetOrHookScript(DWCChatTab18,"OnShow",Toggle3DCodeCmdChatFrameBtnShown)
SetOrHookScript(DWCChatTab18,"OnHide",Toggle3DCodeCmdChatFrameBtnShown)
Æ
Æ
Ì h=Ç
Ì a=Ç
Ì r=0
Ì l=time()
Ì e=CreateFrame("frame","3DCodeCmdInit",UIParent)
e:SetFrameStrata("TOOLTIP")
e:SetFrameLevel(128)
e:EnableKeyboard(Ó)
e:SetPropagateKeyboardInput(Ó);
e.PropagateKeyboardInput=Ó
e:SetScript("OnKeyDown",É(a,t,...)
Ê IsAltKeyDown()Á(t=="PAGEUP"Ï t=="PAGEDOWN")Ò
Ê t=="PAGEDOWN"Ò
ThreeDimensionsCode_Savepipe_Yin()
Å t=="PAGEUP"Ò
ThreeDimensionsCode_Savepipe_Yang()
Æ
Å IsControlKeyDown()Á t=="PRINTSCREEN"Ò
Cmd3DCode_Screenshot_Start()
Ä
Ê Î e.PropagateKeyboardInput Ò
a:SetPropagateKeyboardInput(Ó)
Æ
Ñ
Æ
e.PropagateKeyboardInput=Ç
a:SetPropagateKeyboardInput(Ç)
Ñ Ç
Æ)
Ì u={}
Ì É n()
a=Ó
r=time()
e:SetScript("OnEvent",null)
Ê Î s Ò
threeDimensionsCodeFrames_create()
s=Ó
t("åˆ›å»º threeDimensionsCodeFrames_create()")
Æ
d()
È e=1,GetNumBindings()Ã
Ì e={select(2,GetBinding(e))}
È t,e Ë pairs(e)Ã
u[e]=1
Æ
Æ
Æ
e:RegisterEvent("ADDON_LOADED")
e:SetScript("OnEvent",É(h,s,e)
Ê s=="ADDON_LOADED"Á e:sub(1,9)~="Blizzard_"Ò
i=i+1
Æ
t(s,e,e:sub(1,9),i,o)
Ê i>=o Á Î a Ò
n()
Æ
Æ)
e:SetScript("OnUpdate",É(o,o)
Ê h Ò
t("proccessed")
Ñ
Æ
Ê time()-l>=3 Á Î a Ò
t("ç­‰å¾…æ‰€æœ‰æ’ä»¶åŠ è½½å®Œæˆè¶…æ—¶")
n()
Æ
Ê Î a Ò
Ñ
Æ
Ê UnitAffectingCombat("player")Ò
t("in combat, wait over")
Ñ
Æ
Ê time()-r>=0 Ò
DeleteMacro("3dcodecmd$Yin")
DeleteMacro("3dcodecmd$Yin2")
DeleteMacro("3dcodecmd$Yang")
DeleteMacro("3dcodecmd$Yang2")
ThreeDimensionsCode_SignalLamp.desireWidth();
h=Ó
e:SetScript("OnUpdate",Í)
Æ
Æ)
É cmd3dcode_test()
bigdatasendtest()
Æ
É bigdatasendtest()
Ì e=GetTime()
Ì t=string.rep("1",GetScreenWidth()*3+12)
print('make string:',GetTime()-e,#t)
e=GetTime()
ThreeDimensionsCode_Send("hi",t);
print('make frames',GetTime()-e)
Æ
É ThreeDimensionsCode_IsFramesCreated()
Ñ s
Æ
É ThreeDimensionsCode_Tell_AllAddOnsLoaded()
Ñ n()
Æ]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()