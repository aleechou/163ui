local base_char,keywords=161,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[´ bit==Æ ¢ bit32~=Æ ≥
bit=bit32
ß
≠ i=-1
≠ ™ o(...)
ß
≠ ™ t(...)
ß
≠ n=GetScreenWidth()
≠ e=10
™ threeDimensionsCodeFrames_create()
ThreeDimensionsCode_Blackboard=CreateFrame("frame","ThreeDimensionsCode",Æ)
ThreeDimensionsCode_Blackboard:SetPoint("TOPLEFT",0,0)
ThreeDimensionsCode_Blackboard:SetWidth(n)
ThreeDimensionsCode_Blackboard:SetHeight(e)
ThreeDimensionsCode_Blackboard:SetFrameStrata("FULLSCREEN_DIALOG")
ThreeDimensionsCode_Blackboard:SetFrameLevel(128)
ThreeDimensionsCode_Blackboard:Show()
o("mode:",GetScreenWidth()*UIParent:GetEffectiveScale(),GetScreenHeight()*UIParent:GetEffectiveScale())
ThreeDimensionsCode_Blackboard.setReadScreenWidth=™(e)
i=e
ThreeDimensionsCode_Blackboard:SetScale((GetScreenWidth()*UIParent:GetEffectiveScale())/i)
ThreeDimensionsCode_SignalLamp.keepAlive()
t("new width:",(GetScreenWidth()*UIParent:GetEffectiveScale()),"/",i)
ß
≠ a={
keepAlive={
20/255,
14/255,
63/255,
1
},
desireWidth={
198/255,
210/255,
11/255,
1
},
receiving={
198/255,
31/255,
112/255,
1
},
}
≠ ™ o(e,t)
≠ e=CreateFrame("frame",e,Æ)
e:SetWidth(2)
e:SetHeight(2)
e:SetPoint(t,0,0)
e.texture=e:CreateTexture(Æ,"BACKGROUND")
≤ e
ß
≠ t=o("ThreeDimensionsCode_SignalLampA","BOTTOMLEFT")
≠ e=o("ThreeDimensionsCode_SignalLampB","BOTTOMRIGHT")
t:SetFrameLevel(128)
e:SetFrameLevel(128)
ThreeDimensionsCode_SignalLamp={
keepAlive=™()
´ i<0 ≥
ThreeDimensionsCode_SignalLamp.desireWidth()
•
t.texture:SetTexture(unpack(a.keepAlive))
t.texture:SetAllPoints(t)
e.texture:SetTexture(unpack(a.keepAlive))
e.texture:SetAllPoints(e)
ß
ß,
desireWidth=™()
t.texture:SetTexture(unpack(a.desireWidth))
t.texture:SetAllPoints(t)
e.texture:SetTexture(unpack(a.desireWidth))
e.texture:SetAllPoints(e)
ß,
receiving=™()
t.texture:SetTexture(unpack(a.receiving))
t.texture:SetAllPoints(t)
e.texture:SetTexture(unpack(a.receiving))
e.texture:SetAllPoints(e)
ß,
}
ß
≠ s=bit.bor(bit.lshift(255,8),255)
≠ t=0;
≠ a=math.random(0,1e3)
o("commandID",a)
≠ i={}
™ i:new()
≠ e={}
setmetatable(e,{__index=self})
≤ e
ß
™ i:pushchar(e)
self:pushbyte(string.byte(e))
ß
™ i:pushbyte(e)
table.insert(self,e)
´#self>=3 ≥
self:flush();
ß
ß
™ i:flush()
≠ e;
≠ a={ThreeDimensionsCode_Blackboard:GetChildren()}
´#a<=t ≥
e=CreateFrame("frame","ThreeDimensionsCode_Pixel",ThreeDimensionsCode_Blackboard)
e:SetWidth(1)
e:SetHeight(1)
≠ a=t%n
≠ t=floor(t/n)
e:SetPoint("TOPLEFT",a,t)
e:Show()
e.texture=e:CreateTexture(Æ,"BACKGROUND")
•
e=a[t+1];
ß
e.texture:SetTexture(self:color(1),self:color(2),self:color(3),1)
e.texture:SetAllPoints(e)
t=t+1
≠ ™ e(e)
≤ e ¢ string.char(e)∞""
ß
o("chars:",e(self[1]),e(self[2]),e(self[3]))
o("bytes:",self[1],self[2],self[3])
o("colors:",self:color(1),self:color(2),self:color(3))
© e,t ¨ pairs(self)§
self[e]=Æ
ß
ß
™ i:color(e)
´ self[e]==Æ ≥
≤ 0
•
≤ self[e]/255
ß
ß
™ send(n)
t=0;
n=string.sub(n,1,s)
≠ e=i:new()
≠ t=#n
≠ s=bit.band(t,255)
≠ i=bit.rshift(t,8)
o("the data length",t)
e:pushbyte(bit.rshift(a,8))
e:pushchar("1")
e:pushbyte(bit.band(a,255))
e:pushbyte(s)
e:pushchar("9")
e:pushbyte(i)
© t=1,#n §
≠ t=string.sub(n,t,t)
e:pushchar(t)
ß
e:pushchar("8")
e:pushchar("2")
e:flush()
a=a+1
´ a>65535 ≥
a=0
ß
ß
ThreeDimensionsCode_Send=™(e,t)
send(e..":"..t)
ß
SLASH_3DCODECMD1="/cmd3d"
SlashCmdList["3DCODECMD"]=™(t)
≠ e=t:find(":")
print(e)
´ e==Æ ≥
print("Ê†ºÂºèÊó†ÊïàÔºõ <cmd>:<args>")
≤;
ß
≠ a=t:sub(1,e-1)
≠ e=t:sub(e+1)
ThreeDimensionsCode_Send(a,e)
ß
SLASH_URL1="/url"
SlashCmdList["URL"]=™(e,t)
ThreeDimensionsCode_Send("innerbrowser",e)
ß
SLASH_OPEN1="/open"
SlashCmdList["OPEN"]=™(e,t)
ThreeDimensionsCode_Send("openurl",e)
ß
]===], '@../!!!163UI.3dcodecmd!!!/threeDimensionsCode.lua'))()