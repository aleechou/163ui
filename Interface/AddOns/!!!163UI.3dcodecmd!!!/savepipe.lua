local base_char,keywords=152,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� bit==� � bit32~=� �
bitfunc=bit32
�
bitfunc=bit
�
� e={
verbose=�,
info=�,
errro=�,
}
� � u(...)
� e.verbose � print("[verbose]",...)�
�
� � c(...)
� e.info � print("[verbose]",...)�
�
� � t(...)
� e.errro � print("[verbose]",...)�
�
� cmd3dcode_pipe_showlog(a,t)
� a==� � a="verbose"�
� t==� � t=� �
e[a]=t
�
� f=3
� e=""
� l=-1
� d=-1
� i=-1
� t=0
� n=0
� o=0
� a=0
� s=0
� r=0
� � m()
o=0
a=0
�
� � h()
e=""
l=-1
d=-1
i=-1
t=0
n=0
r=0
s=0
m()
�
h()
� � w(a)
u("receive",(n+1).."/"..t,"byte",a,string.char(a))
� l<0 �
l=a
�
� d<0 �
d=a
i=l
t=d
c("cmd id",i,"data len",t)
� t<1 �
h()
�
�
�
e=e..string.char(a)
n=n+1
� n>=t �
� t=string.byte(e:sub(1,1))
� t=ThreeDimensionsCode_SafePipe_CmdHandles[t]
� a
� t �
a=e:sub(2)
t=ThreeDimensionsCode_SafePipe_CmdHandles[t]
�
� o=e:find(":")
� o �
� i=e:sub(1,o-1)
a=e:sub(o+1)
t=ThreeDimensionsCode_SafePipe_CmdHandles[i]
�
�
� t �
t(i,a)
�
c("receive over, time",GetTime()-s,"cmd id",i)
c(e)
h()
�
�
�
� � i(t)
� e=GetTime()
� r==0 �
s=e
u("first bit come in")
�
� e-r>f �
u("safe pipe 超时关闭")
h()
s=e
�
�
r=e
� t>0 �
o=bitfunc.bor(o,bitfunc.lshift(t,7-a))
�
a=a+1
� a>=8 �
w(o)
m(o)
�
�
� ThreeDimensionsCode_Savepipe_Yin()
i(0)
�
� ThreeDimensionsCode_Savepipe_Yang()
i(1)
�
ThreeDimensionsCode_SafePipe_CmdHandles={
"newsize",
"script",
"ping",
"screenshot/ready",
"screenshot/uploaded",
"screenshot/downloaded",
"screenshot/screen-ready",
"xx",
"xx",
"emoticon/start-upload",
"emoticon/upload-error",
"emoticon/changed",
"emoticon/not-start/another-working",
newsize=�(e,t)
� e=t:find("x")
� e �
� e=t:sub(1,e-1)
e=tonumber(e)
� e �
� ThreeDimensionsCode_Blackboard �
ThreeDimensionsCode_Blackboard.setReadScreenWidth(e)
�
�
�
�,
script=�(t,e)
loadstring(e)()
�,
}
]===], '@../!!!163UI.3dcodecmd!!!/savepipe.lua'))()