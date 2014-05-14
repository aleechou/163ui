local base_char,keywords=152,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[¢ bit==¥ ™ bit32~=¥ ª
bitfunc=bit32
œ
bitfunc=bit
ž
¤ e={
verbose=Ÿ,
info=Ÿ,
errro=«,
}
¤ ¡ m(...)
¢ e.verbose ª print("[verbose]",...)ž
ž
¤ ¡ c(...)
¢ e.info ª print("[verbose]",...)ž
ž
¤ ¡ t(...)
¢ e.errro ª print("[verbose]",...)ž
ž
¡ cmd3dcode_pipe_showlog(t,a)
¢ t==¥ ª t="verbose"ž
¢ a==¥ ª a=« ž
e[t]=a
ž
¤ w=3
¤ e=""
¤ l=-1
¤ u=-1
¤ a=-1
¤ t=0
¤ i=0
¤ n=0
¤ s=0
¤ d=0
¤ h=0
¤ ¡ f()
n=0
s=0
ž
¤ ¡ r()
e=""
l=-1
u=-1
a=-1
t=0
i=0
h=0
d=0
f()
ž
r()
¤ ¡ y(o)
m("receive",(i+1).."/"..t,"byte",o,string.char(o))
¢ l<0 ª
l=o
©
 u<0 ª
u=o
a=l
t=u
c("cmd id",a,"data len",t)
¢ t<1 ª
r()
ž
©
ž
e=e..string.char(o)
i=i+1
¢ i>=t ª
¤ t=e:find(":")
¢ t ª
¤ o=e:sub(1,t-1)
¢ ThreeDimensionsCode_SafePipe_CmdHandles[o]ª
ThreeDimensionsCode_SafePipe_CmdHandles[o](a,e:sub(t+1))
ž
ž
c("receive over, time",GetTime()-d,"cmd id",a)
c(e)
r()
©
ž
ž
¤ ¡ a(t)
¤ e=GetTime()
¢ h==0 ª
d=e
m("first bit come in")
œ
¢ e-h>w ª
m("safe pipe è¶…æ—¶å…³é—­")
r()
d=e
ž
ž
h=e
¢ t>0 ª
n=bitfunc.bor(n,bitfunc.lshift(t,7-s))
ž
s=s+1
¢ s>=8 ª
y(n)
f(n)
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