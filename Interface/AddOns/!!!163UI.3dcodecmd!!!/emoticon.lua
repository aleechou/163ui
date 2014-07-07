local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� h="!!!163UI.3dcodecmd!!!"
� t=1,10 �
� e=CreateFrame("Frame","Cmd3DCode_Emoticon_ChatFrameButton"..t,_G["ChatFrame"..t.."EditBox"],"Cmd3DCode_Emoticon_ChatFrameButtonTemplate")
e:SetPoint("LEFT","Cmd3DCode_Screenshot_ChatFrameButton"..t,"RIGHT",-8,0)
� a=e:CreateTexture()
a:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
a:SetAllPoints(e)
� a=e:CreateFontString()
a:SetFontObject(GameFontNormalSmall)
a:SetText("表")
a:SetAllPoints(e)
e:Show()
_G["ChatFrame"..t.."EditBox"].btnemoticon=e
�
hooksecurefunc("ChatEdit_DeactivateChat",�(e)
� e.btnemoticon �
e.btnemoticon:Hide()
�
�)
hooksecurefunc("ChatEdit_ActivateChat",�(e)
� e.btnemoticon �
e.btnemoticon:Show()
�
�)
� i=Cmd3DCode_CustomEmoticonsDB
� � i � i={}�
� � i.emoticons � i.emoticons={}�
� e=6
� t=3
� n=8
� s=8
� d=14
� r=35
� � a(o,t)
� a="Cmd3DCode_Emoticon_Thumb"..o
� � _G[a]� � t �
� t=CreateFrame("Frame",a,Cmd3DCode_EmoticonFrame,"Cmd3DCode_Emoticon_PictureTemplate")
� a=o%e*(s+t:GetWidth())+d
� e=-floor(o/e)*(n+t:GetHeight())-r
t:SetPoint("TOPLEFT",a,e)
t.texture=_G[t:GetName().."_Texture"]
t.checkbutton=_G[t:GetName().."_ChkBtn"]
�
� _G[a]
�
� Cmd3DCode_Emoticon_ShowPage(n)
� e=0,t*e-1 �
� e=a(e,�)
� e �
e.checkbutton:SetChecked(�)
e:Hide()
�
�
� d=(n-1)*t*e
� r=n*t*e-1
� o=0
� s=0
� i,e � pairs(i.emoticons)�
� � e.type �
e.texture="Interface\\AddOns\\"..h.."\\External\\Emoticons\\"..e.filename
e.picid=i
e.type="emoticon"
�
� o>=d � o<=r �
� t=a(s)
� o,a=calExternalPictureSize(e,64,64)
t.texture:SetTexture(e.texture)
t.texture:SetWidth(o)
t.texture:SetHeight(a)
t.picid=i
t:Show()
s=s+1
�
o=o+1
�
� e=ceil(o/(t*e))
� e<1 � e=1 �
Cmd3DCode_EmoticonFrame_TxtPageNum.pagenum=n
Cmd3DCode_EmoticonFrame_TxtPageNum.totalpages=e
Cmd3DCode_EmoticonFrame_TxtPageNum:SetText(n.."/"..e)
�
Cmd3DCode_Emoticon_ShowPage(1)
Cmd3DCode_EmoticonFrame_BtnAllCheck:SetScript("OnClick",�()
� e=0,t*e-1 �
� e=a(e,�)
� e � e:IsVisible()�
e.checkbutton:SetChecked(�)
�
�
�)
Cmd3DCode_EmoticonFrame_BtnAllRevert:SetScript("OnClick",�()
� e=0,t*e-1 �
� e=a(e,�)
� e � e:IsVisible()�
e.checkbutton:SetChecked(� e.checkbutton:GetChecked())
�
�
�)
Cmd3DCode_EmoticonFrame_BtnRemove:SetScript("OnClick",�()
� o={}
� e=0,t*e-1 �
� e=a(e)
� e.checkbutton:GetChecked()�
tinsert(o,e.picid)
�
�
�#o<1 �
�
�
StaticPopup_Show("163UI-Emoticon:RemoveConfirm")
.data={
addonName=h,
piclst=o,
}
�)
StaticPopupDialogs["163UI-Emoticon:RemoveConfirm"]={
text="确定要删除选中的表情图片吗？",
button1="删除",
button2="取消",
whileDead=�,
hideOnEscape=�,
preferredIndex=3,
OnAccept=�(t,e)
ThreeDimensionsCode_Send("emoticon/remove",json_encode(e))
Cmd3DCode_CheckoutClientAndPrompt()
�,
}
ThreeDimensionsCode_SafePipe_CmdHandles["emoticon/start-upload"]=�(t,e)
� t,e=strsplit(",",e)
print("正在上传表情图片",(t+1).."/"..e,"...")
�
ThreeDimensionsCode_SafePipe_CmdHandles["emoticon/upload-error"]=�()
print("表情图片上传遇到错误")
�
StaticPopupDialogs["163UI-Emoticon:ImportDone"]={
text="表情图片已经导入到WOW中，需要重载界面(Reload UI)后生效",
button1="立即重载界面",
button2="稍后再说",
whileDead=�,
hideOnEscape=�,
preferredIndex=3,
OnAccept=ReloadUI,
}
ThreeDimensionsCode_SafePipe_CmdHandles["emoticon/changed"]=�(t,e)
� e=tonumber(e)
� e==0 �
�
� e>0 �
StaticPopupDialogs["163UI-Emoticon:ImportDone"].text="表情图片已经导入到WOW中，需要重载界面(Reload UI)后生效"
�
StaticPopupDialogs["163UI-Emoticon:ImportDone"].text="表情图片已经从WOW中删除，需要重载界面(Reload UI)后生效"
�
StaticPopup_Show("163UI-Emoticon:ImportDone")
�
ThreeDimensionsCode_SafePipe_CmdHandles["emoticon/not-start/another-working"]=�()
print("另一个表情导入任务正在进行中，请等待完成")
�
]===], '@../!!!163UI.3dcodecmd!!!/emoticon.lua'))()