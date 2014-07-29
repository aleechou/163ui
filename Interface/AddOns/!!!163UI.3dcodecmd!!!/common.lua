local base_char,keywords=128,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[==[â SetOrHookScript(e,t,a)
ä e:GetScript(t)í
ë e:HookScript(t,a)
Ñ
ë e:SetScript(t,a)
Ü
Ü
ä é CoreUIEnableTooltip í
å t
â CoreUIEnableTooltip(e,a,i,o)
e:EnableMouse(ì);
e.tooltipTitle=a;
e.tooltipText=i;
CoreHookScript(e,"OnEnter",CoreUIShowTooltip);
ä o í e.UpdateTooltip=CoreUIShowTooltip Ü
t=t è â(e)GameTooltip:Hide();Ü
SetOrHookScript(e,"OnLeave",t);
Ü
Ü
â SlashCmdList_AddSlashCommand(t,e,...)
SlashCmdList[t]=e
å e=''
à a=1,select('#',...)É
e=select(a,...)
ä strsub(e,1,1)~='/'í
e='/'..e
Ü
_G['SLASH_'..t..a]=e
Ü
Ü]==], '@../!!!163UI.3dcodecmd!!!/common.lua'))()