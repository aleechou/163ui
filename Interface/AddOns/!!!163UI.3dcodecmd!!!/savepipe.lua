local base_char,keywords=152,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[¢ bit==¥ ™ bit32~=¥ ª
bitfunc=bit32
œ
bitfunc=bit
ž
¤ ¡ u(...)
ž
¤ ¡ c(...)
ž
¤ ¡ e(...)
print("[ERROR]",...)
ž
¤ w=3
¤ e=""
¤ r=-1
¤ s=-1
¤ n=-1
¤ t=0
¤ a=0
¤ i=0
¤ o=0
¤ h=0
¤ l=0
¤ ¡ m()
i=0
o=0
ž
¤ ¡ d()
e=""
r=-1
s=-1
n=-1
t=0
a=0
l=0
h=0
m()
ž
d()
¤ ¡ f(o)
u("receive",(a+1).."/"..t,"byte",o,string.char(o))
¢ r<0 ª
r=o
©
 s<0 ª
s=o
n=r
t=s
c("cmd id",n,"data len",t)
¢ t<1 ª
d()
ž
©
ž
e=e..string.char(o)
a=a+1
¢ a>=t ª
¤ t=e:find(":")
¢ t ª
¤ a=e:sub(1,t-1)
¢ ThreeDimensionsCode_SafePipe_CmdHandles[a]ª
ThreeDimensionsCode_SafePipe_CmdHandles[a](n,e:sub(t+1))
ž
ž
c("receive over, time",GetTime()-h,"cmd id",n)
c(e)
d()
©
ž
ž
¤ ¡ a(t)
¤ e=GetTime()
¢ l==0 ª
h=e
u("first bit come in")
œ
¢ e-l>w ª
u("safe pipe è¶…æ—¶å…³é—­")
d()
h=e
ž
ž
l=e
¢ t>0 ª
i=bitfunc.bor(i,bitfunc.lshift(t,7-o))
ž
o=o+1
¢ o>=8 ª
f(i)
m(i)
ž
ž
¡ ThreeDimensionsCode_Savepipe_Yin()
a(0)
ž
¡ ThreeDimensionsCode_Savepipe_Yang()
a(1)
ž
ThreeDimensionsCode_SafePipe_CmdHandles={
newsize=¡(t,e)
¤ t=e:find("x")
¢ t ª
¤ e=e:sub(1,t-1)
e=tonumber(e)
¢ e ª
¢ ThreeDimensionsCode_Blackboard ª
ThreeDimensionsCode_Blackboard.setReadScreenWidth(e)
ž
ž
ž
ž,
script=¡(t,e)
loadstring(e)()
ž
}
]===], '@../!!!163UI.3dcodecmd!!!/savepipe.lua'))()