local base_char,keywords=128,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� e=_G
� c
� m
� f
� s
� d
� l
� o
� r
� u
� n
� h
� i
� h(t)
� t==� �
�"null"
�
� a=e.type(t)
� a=='string'�
�'"'..r(t)..'"'
�
� a=='number'� a=='boolean'�
� e.tostring(t)
�
� a=='boolean'�
� t �'true'�'false'
�
� a=='table'�
� a={}
� o,i=u(t)
� o �
� e=1,i �
table.insert(a,h(t[e]))
�
�
� e,t � e.pairs(t)�
� n(e)� n(t)�
table.insert(a,'"'..r(e)..'":'..h(t))
�
�
�
� o �
�'['..table.concat(a,',')..']'
�
�'{'..table.concat(a,',')..'}'
�
�
� a=='function'� t==null �
�'null'
�
e.assert(�,'encode attempt to encode unsupported type '..a..':'..e.tostring(t))
�
� i(a,t)
t=t � t � 1
t=o(a,t)
e.assert(t<=string.len(a),'Unterminated JSON encoded object found at position in ['..a..']')
� e=string.sub(a,t,t)
� e=='{'�
� d(a,t)
�
� e=='['�
� c(a,t)
�
� string.find("+-0123456789.e",e,1,�)�
� s(a,t)
�
� e==[["]]� e==[[']]�
� l(a,t)
�
� string.sub(a,t,t+1)=='/*'�
� i(a,m(a,t))
�
� f(a,t)
�
� null()
� null
�
� c(a,t)
� h={}
� n=string.len(a)
e.assert(string.sub(a,t,t)=='[','decode_scanArray called but array does not start at position '..t..' in string:\n'..a)
t=t+1
�
t=o(a,t)
e.assert(t<=n,'JSON String ended unexpectedly scanning array.')
� s=string.sub(a,t,t)
�(s==']')�
� h,t+1
�
�(s==',')�
t=o(a,t+1)
�
e.assert(t<=n,'JSON String ended unexpectedly scanning array.')
object,t=i(a,t)
table.insert(h,object)
� �
�
� m(a,t)
e.assert(string.sub(a,t,t+1)=='/*',"decode_scanComment called but comment does not start at position "..t)
� a=string.find(a,'*/',t+2)
e.assert(a~=�,"Unterminated comment in string at "..t)
� a+2
�
� f(o,t)
� i={["true"]=�,["false"]=�,["null"]=�}
� a={"true","false","null"}
� n,a � e.pairs(a)�
� string.sub(o,t,t+string.len(a)-1)==a �
� i[a],t+string.len(a)
�
�
e.assert(�,'Failed to scan constant from string '..o..' at starting position '..t)
�
� s(a,o)
� t=o+1
� n=string.len(a)
� i="+-0123456789.e"
�(string.find(i,string.sub(a,t,t),1,�)
� t<=n
)�
t=t+1
�
� i='return '..string.sub(a,o,t-1)
� a=e.loadstring(i)
e.assert(a,'Failed to scan number [ '..i..'] in JSON string at position '..o..' : '..t)
� a(),t
�
� d(a,t)
� r={}
� s=string.len(a)
� n,d
e.assert(string.sub(a,t,t)=='{','decode_scanObject called but object does not start at position '..t..' in string:\n'..a)
t=t+1
�
t=o(a,t)
e.assert(t<=s,'JSON string ended unexpectedly while scanning object.')
� h=string.sub(a,t,t)
�(h=='}')�
� r,t+1
�
�(h==',')�
t=o(a,t+1)
�
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
� �
�
� l(o,a)
e.assert(a,'decode_scanString(..) called without start position')
� i=string.sub(o,a,a)
e.assert(i==[[']]� i==[["]],'decode_scanString called for a non-string')
� n=�
� t=a+1
� s=�
� h=string.len(o)
�
� a=string.sub(o,t,t)
� � n �
� a==[[\]]�
n=�
�
s=a==i
�
�
n=�
�
t=t+1
e.assert(t<=h+1,"String decoding failed: unterminated string at position "..t)
� s
� i='return '..string.sub(o,a,t-1)
� o=e.loadstring(i)
e.assert(o,'Failed to load string [ '..i..'] in JSON4Lua.decode_scanString at position '..a..' : '..t)
� o(),t
�
� o(t,e)
� o=" \n\r\t"
� a=string.len(t)
�(string.find(o,string.sub(t,e,e),1,�)� e<=a)�
e=e+1
�
� e
�
� r(e)
e=string.gsub(e,'\\','\\\\')
e=string.gsub(e,'"','\\"')
e=string.gsub(e,"'","\\'")
e=string.gsub(e,'\n','\\n')
e=string.gsub(e,'\t','\\t')
� e
�
� u(i)
� a=0
� t,o � e.pairs(i)�
�(e.type(t)=='number'� math.floor(t)==t � 1<=t)�
�(� n(o))� � � �
a=math.max(a,t)
�
�(t=='n')�
� o~=table.getn(i)� � � �
�
� n(o)� � � �
�
�
�
� �,a
�
� n(t)
� e=e.type(t)
�(e=='string'� e=='boolean'� e=='number'� e=='nil'� e=='table')�(e=='function'� t==null)
�
json_encode=h
json_decode=i]===], '@../!!!163UI.3dcodecmd!!!/json.lua'))()