local base_char,keywords=152,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[¢ bit==¥ ™ bit32~=¥ ª
bitfunc=bit32
œ
bitfunc=bit
ž
¤ ¡ c(...)
ž
¤ ¡ u(...)
print("[info]",...)
ž
¤ ¡ e(...)
print("[ERROR]",...)
ž
¤ f=3
¤ e=""
¤ d=-1
¤ r=-1
¤ l=-1
¤ t=0
¤ i=0
¤ o=0
¤ a=0
¤ h=0
¤ n=0
¤ ¡ m()
o=0
a=0
ž
¤ ¡ s()
e=""
d=-1
r=-1
l=-1
t=0
i=0
n=0
h=0
m()
ž
s()
¤ ¡ w(a)
c("receive",(i+1).."/"..t,"byte",a,string.char(a))
¢ d<0 ª
d=a
©
 r<0 ª
r=a
l=d
t=r
u("cmd id",l,"data len",t)
¢ t<1 ª
s()
ž
©
ž
e=e..string.char(a)
i=i+1
¢ i>=t ª
¤ t=e:find(":")
¢ t ª
¤ a=e:sub(1,t-1)
¢ ThreeDimensionsCode_SafePipe_CmdHandles[a]ª
ThreeDimensionsCode_SafePipe_CmdHandles[a](e:sub(t+1))
ž
ž
u("receive over, time",GetTime()-h,"cmd id",l)
u(e)
s()
©
ž
ž
¤ ¡ i(t)
¤ e=GetTime()
¢ n==0 ª
h=e
c("first bit come in")
œ
¢ e-n>f ª
c("safe pipe è¶…æ—¶å…³é—­")
s()
h=e
ž
ž
n=e
¢ t>0 ª
o=bitfunc.bor(o,bitfunc.lshift(t,7-a))
ž
a=a+1
¢ a>=8 ª
w(o)
m(o)
ž
ž
¡ ThreeDimensionsCode_Savepipe_Yin()
i(0)
ž
¡ ThreeDimensionsCode_Savepipe_Yang()
i(1)
ž
ThreeDimensionsCode_SafePipe_CmdHandles={
newsize=¡(t)
¤ e=t:find("x")
¢ e ª
¤ e=t:sub(1,e-1)
e=tonumber(e)
¢ e ª
threeDimensionsCodePad.setReadScreenWidth(e)
ž
ž
ž
}
]===], '@../!!!163UI.3dcodecmd!!!/savepipe.lua'))()