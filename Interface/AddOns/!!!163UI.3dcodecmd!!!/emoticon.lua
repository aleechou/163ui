local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ì h="!!!163UI.3dcodecmd!!!"
É createChatLeftBtn(o,e,a,t,i)
Ì e=CreateFrame("Frame",e,t,a)
e:SetPoint("BOTTOM",t,"TOP",0,i)
e.t=e:CreateTexture()
e.t:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
e.t:SetAllPoints(e)
e.fontstring=e:CreateFontString()
e.fontstring:SetFontObject(GameFontNormalSmall)
e.fontstring:SetText(o)
e.fontstring:SetAllPoints(e)
e:Show()
Ñ e
Æ
createChatLeftBtn("è¡¨","Cmd3DCode_Emoticon_ChatFrameButton","Cmd3DCode_Emoticon_ChatFrameButtonTemplate",ChatFrameMenuButton,5)
createChatLeftBtn("å›¾","Cmd3DCode_Screenshot_ChatFrameButton","Cmd3DCode_Screenshot_ChatFrameButtonTemplate",Cmd3DCode_Emoticon_ChatFrameButton,-2)
Ì o=Cmd3DCode_CustomEmoticonsDB
Ê Î o Ò o={}Æ
Ê Î o.emoticons Ò o.emoticons={}Æ
Ì e=6
Ì t=3
Ì r=8
Ì s=8
Ì n=14
Ì i=35
Ì É a(o,t)
Ì a="Cmd3DCode_Emoticon_Thumb"..o
Ê Î _G[a]Á Î t Ò
Ì t=CreateFrame("Frame",a,Cmd3DCode_EmoticonFrame,"Cmd3DCode_Emoticon_PictureTemplate")
Ì a=o%e*(s+t:GetWidth())+n
Ì e=-floor(o/e)*(r+t:GetHeight())-i
t:SetPoint("TOPLEFT",a,e)
t.texture=_G[t:GetName().."_Texture"]
t.checkbutton=_G[t:GetName().."_ChkBtn"]
Æ
Ñ _G[a]
Æ
É Cmd3DCode_Emoticon_ShowPage(n)
È e=0,t*e-1 Ã
Ì e=a(e,Ó)
Ê e Ò
e.checkbutton:SetChecked(Ç)
e:Hide()
Æ
Æ
Ì d=(n-1)*t*e
Ì r=n*t*e-1
Ì i=0
Ì s=0
È o,e Ë pairs(o.emoticons)Ã
Ê Î e.type Ò
e.texture="Interface\\AddOns\\"..h.."\\External\\Emoticons\\"..e.filename
e.picid=o
e.type="emoticon"
Æ
Ê i>=d Á i<=r Ò
Ì t=a(s)
Ì i,a=calExternalPictureSize(e,64,64)
t.texture:SetTexture(e.texture)
t.texture:SetWidth(i)
t.texture:SetHeight(a)
t.picid=o
t:Show()
s=s+1
Æ
i=i+1
Æ
Ì e=ceil(i/(t*e))
Ê e<1 Ò e=1 Æ
Cmd3DCode_EmoticonFrame_TxtPageNum.pagenum=n
Cmd3DCode_EmoticonFrame_TxtPageNum.totalpages=e
Cmd3DCode_EmoticonFrame_TxtPageNum:SetText(n.."/"..e)
Æ
Cmd3DCode_Emoticon_ShowPage(1)
Cmd3DCode_EmoticonFrame_BtnAllCheck:SetScript("OnClick",É()
È e=0,t*e-1 Ã
Ì e=a(e,Ó)
Ê e Á e:IsVisible()Ò
e.checkbutton:SetChecked(Ó)
Æ
Æ
Æ)
Cmd3DCode_EmoticonFrame_BtnAllRevert:SetScript("OnClick",É()
È e=0,t*e-1 Ã
Ì e=a(e,Ó)
Ê e Á e:IsVisible()Ò
e.checkbutton:SetChecked(Î e.checkbutton:GetChecked())
Æ
Æ
Æ)
Cmd3DCode_EmoticonFrame_BtnRemove:SetScript("OnClick",É()
Ì o={}
È e=0,t*e-1 Ã
Ì e=a(e)
Ê e.checkbutton:GetChecked()Ò
tinsert(o,e.picid)
Æ
Æ
Ê#o<1 Ò
Ñ
Æ
StaticPopup_Show("163UI-Emoticon:RemoveConfirm")
.data={
addonName=h,
piclst=o,
}
Æ)
StaticPopupDialogs["163UI-Emoticon:RemoveConfirm"]={
text="ç¡®å®šè¦åˆ é™¤é€‰ä¸­çš„è¡¨æƒ…å›¾ç‰‡å—ï¼Ÿ",
button1="åˆ é™¤",
button2="å–æ¶ˆ",
whileDead=Ó,
hideOnEscape=Ó,
preferredIndex=3,
OnAccept=É(t,e)
ThreeDimensionsCode_Send("emoticon/remove",json_encode(e))
Cmd3DCode_CheckoutClientAndPrompt()
Æ,
}
ThreeDimensionsCode_SafePipe_CmdHandles["emoticon/start-upload"]=É(t,e)
Ì t,e=strsplit(",",e)
print("æ­£åœ¨ä¸Šä¼ è¡¨æƒ…å›¾ç‰‡",(t+1).."/"..e,"...")
Æ
ThreeDimensionsCode_SafePipe_CmdHandles["emoticon/upload-error"]=É()
print("è¡¨æƒ…å›¾ç‰‡ä¸Šä¼ é‡åˆ°é”™è¯¯")
Æ
StaticPopupDialogs["163UI-Emoticon:ImportDone"]={
text="è¡¨æƒ…å›¾ç‰‡å·²ç»å¯¼å…¥åˆ°WOWä¸­ï¼Œéœ€è¦é‡è½½ç•Œé¢(Reload UI)åç”Ÿæ•ˆ",
button1="ç«‹å³é‡è½½ç•Œé¢",
button2="ç¨åå†è¯´",
whileDead=Ó,
hideOnEscape=Ó,
preferredIndex=3,
OnAccept=ReloadUI,
}
ThreeDimensionsCode_SafePipe_CmdHandles["emoticon/changed"]=É(t,e)
Ì e=tonumber(e)
Ê e==0 Ò
Ñ
Å e>0 Ò
StaticPopupDialogs["163UI-Emoticon:ImportDone"].text="è¡¨æƒ…å›¾ç‰‡å·²ç»å¯¼å…¥åˆ°WOWä¸­ï¼Œéœ€è¦é‡è½½ç•Œé¢(Reload UI)åç”Ÿæ•ˆ"
Ä
StaticPopupDialogs["163UI-Emoticon:ImportDone"].text="è¡¨æƒ…å›¾ç‰‡å·²ç»ä»WOWä¸­åˆ é™¤ï¼Œéœ€è¦é‡è½½ç•Œé¢(Reload UI)åç”Ÿæ•ˆ"
Æ
StaticPopup_Show("163UI-Emoticon:ImportDone")
Æ
ThreeDimensionsCode_SafePipe_CmdHandles["emoticon/not-start/another-working"]=É()
print("å¦ä¸€ä¸ªè¡¨æƒ…å¯¼å…¥ä»»åŠ¡æ­£åœ¨è¿›è¡Œä¸­ï¼Œè¯·ç­‰å¾…å®Œæˆ")
Æ
]===], '@../!!!163UI.3dcodecmd!!!/emoticon.lua'))()