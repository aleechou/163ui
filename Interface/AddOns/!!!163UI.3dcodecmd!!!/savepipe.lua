local base_char,keywords=152,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[’ bit==₯  bit32~=₯ ͺ
bitfunc=bit32

bitfunc=bit

€ e={
verbose=,
info=,
errro=«,
}
€ ‘ m(...)
’ e.verbose ͺ print("[verbose]",...)

€ ‘ c(...)
’ e.info ͺ print("[verbose]",...)

€ ‘ t(...)
’ e.errro ͺ print("[verbose]",...)

‘ cmd3dcode_pipe_showlog(t,a)
’ t==₯ ͺ t="verbose"
’ a==₯ ͺ a=« 
e[t]=a

€ w=3
€ e=""
€ l=-1
€ u=-1
€ a=-1
€ t=0
€ i=0
€ n=0
€ s=0
€ d=0
€ h=0
€ ‘ f()
n=0
s=0

€ ‘ r()
e=""
l=-1
u=-1
a=-1
t=0
i=0
h=0
d=0
f()

r()
€ ‘ y(o)
m("receive",(i+1).."/"..t,"byte",o,string.char(o))
’ l<0 ͺ
l=o
©
 u<0 ͺ
u=o
a=l
t=u
c("cmd id",a,"data len",t)
’ t<1 ͺ
r()

©

e=e..string.char(o)
i=i+1
’ i>=t ͺ
€ t=e:find(":")
’ t ͺ
€ o=e:sub(1,t-1)
’ ThreeDimensionsCode_SafePipe_CmdHandles[o]ͺ
ThreeDimensionsCode_SafePipe_CmdHandles[o](a,e:sub(t+1))


c("receive over, time",GetTime()-d,"cmd id",a)
c(e)
r()
©


€ ‘ a(t)
€ e=GetTime()
’ h==0 ͺ
d=e
m("first bit come in")

’ e-h>w ͺ
m("safe pipe θΆζΆε³ι­")
r()
d=e


h=e
’ t>0 ͺ
n=bitfunc.bor(n,bitfunc.lshift(t,7-s))

s=s+1
’ s>=8 ͺ
y(n)
f(n)


‘ ThreeDimensionsCode_Savepipe_Yin()
a(0)

‘ ThreeDimensionsCode_Savepipe_Yang()
a(1)

ThreeDimensionsCode_SafePipe_CmdHandles={
newsize=‘(t,e)
€ t=e:find("x")
’ t ͺ
€ e=e:sub(1,t-1)
e=tonumber(e)
’ e ͺ
’ ThreeDimensionsCode_Blackboard ͺ
ThreeDimensionsCode_Blackboard.setReadScreenWidth(e)



,
script=‘(t,e)
loadstring(e)()

}
]===], '@../!!!163UI.3dcodecmd!!!/savepipe.lua'))()