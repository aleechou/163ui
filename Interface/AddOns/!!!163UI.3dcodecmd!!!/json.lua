local base_char,keywords=128,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[å e=_G
print("xxxx")
å c
å m
å f
å s
å d
å l
å o
å r
å u
å n
å h
å i
â h(t)
ä t==ç í
ë"null"
Ü
å a=e.type(t)
ä a=='string'í
ë'"'..r(t)..'"'
Ü
ä a=='number'è a=='boolean'í
ë e.tostring(t)
Ü
ä a=='boolean'í
ë t Å'true'è'false'
Ü
ä a=='table'í
å a={}
å o,i=u(t)
ä o í
à e=1,i É
table.insert(a,h(t[e]))
Ü
Ñ
à e,t ã e.pairs(t)É
ä n(e)Å n(t)í
table.insert(a,'"'..r(e)..'":'..h(t))
Ü
Ü
Ü
ä o í
ë'['..table.concat(a,',')..']'
Ñ
ë'{'..table.concat(a,',')..'}'
Ü
Ü
ä a=='function'Å t==null í
ë'null'
Ü
e.assert(á,'encode attempt to encode unsupported type '..a..':'..e.tostring(t))
Ü
â i(a,t)
t=t Å t è 1
t=o(a,t)
e.assert(t<=string.len(a),'Unterminated JSON encoded object found at position in ['..a..']')
å e=string.sub(a,t,t)
ä e=='{'í
ë d(a,t)
Ü
ä e=='['í
ë c(a,t)
Ü
ä string.find("+-0123456789.e",e,1,ì)í
ë s(a,t)
Ü
ä e==[["]]è e==[[']]í
ë l(a,t)
Ü
ä string.sub(a,t,t+1)=='/*'í
ë i(a,m(a,t))
Ü
ë f(a,t)
Ü
â null()
ë null
Ü
â c(a,t)
å h={}
å n=string.len(a)
e.assert(string.sub(a,t,t)=='[','decode_scanArray called but array does not start at position '..t..' in string:\n'..a)
t=t+1
ê
t=o(a,t)
e.assert(t<=n,'JSON String ended unexpectedly scanning array.')
å s=string.sub(a,t,t)
ä(s==']')í
ë h,t+1
Ü
ä(s==',')í
t=o(a,t+1)
Ü
e.assert(t<=n,'JSON String ended unexpectedly scanning array.')
object,t=i(a,t)
table.insert(h,object)
î á
Ü
â m(a,t)
e.assert(string.sub(a,t,t+1)=='/*',"decode_scanComment called but comment does not start at position "..t)
å a=string.find(a,'*/',t+2)
e.assert(a~=ç,"Unterminated comment in string at "..t)
ë a+2
Ü
â f(o,t)
å i={["true"]=ì,["false"]=á,["null"]=ç}
å a={"true","false","null"}
à n,a ã e.pairs(a)É
ä string.sub(o,t,t+string.len(a)-1)==a í
ë i[a],t+string.len(a)
Ü
Ü
e.assert(ç,'Failed to scan constant from string '..o..' at starting position '..t)
Ü
â s(a,o)
å t=o+1
å n=string.len(a)
å i="+-0123456789.e"
ï(string.find(i,string.sub(a,t,t),1,ì)
Å t<=n
)É
t=t+1
Ü
å i='return '..string.sub(a,o,t-1)
å a=e.loadstring(i)
e.assert(a,'Failed to scan number [ '..i..'] in JSON string at position '..o..' : '..t)
ë a(),t
Ü
â d(a,t)
å r={}
å s=string.len(a)
å n,d
e.assert(string.sub(a,t,t)=='{','decode_scanObject called but object does not start at position '..t..' in string:\n'..a)
t=t+1
ê
t=o(a,t)
e.assert(t<=s,'JSON string ended unexpectedly while scanning object.')
å h=string.sub(a,t,t)
ä(h=='}')í
ë r,t+1
Ü
ä(h==',')í
t=o(a,t+1)
Ü
e.assert(t<=s,'JSON string ended unexpectedly scanning object.')
n,t=i(a,t)
e.assert(t<=s,'JSON string ended unexpectedly searching for value of key '..n)
t=o(a,t)
e.assert(t<=s,'JSON string ended unexpectedly searching for value of key '..n)
e.assert(string.sub(a,t,t)==':','JSON object key-value assignment mal-formed at '..t)
t=o(a,t+1)
e.assert(t<=s,'JSON string ended unexpectedly searching for value of key '..n)
d,t=i(a,t)
r[n]=d
î á
Ü
â l(o,a)
e.assert(a,'decode_scanString(..) called without start position')
å i=string.sub(o,a,a)
e.assert(i==[[']]è i==[["]],'decode_scanString called for a non-string')
å n=á
å t=a+1
å s=á
å h=string.len(o)
ê
å a=string.sub(o,t,t)
ä é n í
ä a==[[\]]í
n=ì
Ñ
s=a==i
Ü
Ñ
n=á
Ü
t=t+1
e.assert(t<=h+1,"String decoding failed: unterminated string at position "..t)
î s
å i='return '..string.sub(o,a,t-1)
å o=e.loadstring(i)
e.assert(o,'Failed to load string [ '..i..'] in JSON4Lua.decode_scanString at position '..a..' : '..t)
ë o(),t
Ü
â o(t,e)
å o=" \n\r\t"
å a=string.len(t)
ï(string.find(o,string.sub(t,e,e),1,ì)Å e<=a)É
e=e+1
Ü
ë e
Ü
â r(e)
e=string.gsub(e,'\\','\\\\')
e=string.gsub(e,'"','\\"')
e=string.gsub(e,"'","\\'")
e=string.gsub(e,'\n','\\n')
e=string.gsub(e,'\t','\\t')
ë e
Ü
â u(i)
å a=0
à t,o ã e.pairs(i)É
ä(e.type(t)=='number'Å math.floor(t)==t Å 1<=t)í
ä(é n(o))í ë á Ü
a=math.max(a,t)
Ñ
ä(t=='n')í
ä o~=table.getn(i)í ë á Ü
Ñ
ä n(o)í ë á Ü
Ü
Ü
Ü
ë ì,a
Ü
â n(t)
å e=e.type(t)
ë(e=='string'è e=='boolean'è e=='number'è e=='nil'è e=='table')è(e=='function'Å t==null)
Ü
json_encode=h
json_decode=i]===], '@../!!!163UI.3dcodecmd!!!/json.lua'))()