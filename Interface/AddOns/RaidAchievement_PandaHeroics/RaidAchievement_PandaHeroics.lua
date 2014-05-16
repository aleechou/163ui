local _
function phraonload()
	phraachdone1=true
	phracounter1=0
	_, phraenglishclass = UnitClass("player")
	phrahuntertime=0

local _, a2 = GetInstanceInfo()
if select(3,GetInstanceInfo())==2 and a2=="party" then
	RaidAchievement_phra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_phra:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_phra:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_phra:RegisterEvent("PLAYER_ALIVE")
end
	RaidAchievement_phra:RegisterEvent("PLAYER_REGEN_DISABLED")
	RaidAchievement_phra:RegisterEvent("PLAYER_REGEN_ENABLED")
	RaidAchievement_phra:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	RaidAchievement_phra:RegisterEvent("ADDON_LOADED")




--http://mop.wowhead.com/zone=5963
--Stormstout Brewery входит в мета или это временный данж по фесту? ИСПРАВИТЬ в базе ачивок





phraspisokach5={
6684,
6427,

6946,
--6928, нет лога
6929,

6394,
6396,

6688,
6485,

6089,

6460,


6471,


6945,


}



if (phraspisokon==nil) then
phraspisokon={}
end


end


function phraonupdate()


--ачивка на ласте в могушан палаце?
if racheckhpannounce and GetTime()>racheckhpannounce then
  racheckhpannounce=GetTime()+1
  if UnitHealth("boss1") and UnitHealthMax("boss1") then
    local percboss=(UnitHealth("boss1")/UnitHealthMax("boss1"))*100
    if percboss<=15 then
      if phraspisokon[11]==1 and phraachdone1 then
        phraachcompl(11)
      end
      racheckhpannounce=nil
    end
  end
end


if phracheckzonedelay and GetTime()>phracheckzonedelay then
phracheckzonedelay=nil

local _, a2 = GetInstanceInfo()
if select(3,GetInstanceInfo())==2 and a2=="party" then
	RaidAchievement_phra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_phra:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_phra:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_phra:RegisterEvent("PLAYER_ALIVE")
else
	RaidAchievement_phra:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_phra:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_phra:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_phra:UnregisterEvent("PLAYER_ALIVE")
end

end


end


function phraonevent(self,event,...)
local arg1, arg2, arg3,arg4,arg5,arg6 = ...

if event == "PLAYER_ALIVE" then
ralldelaycombatrezet=GetTime()+4
end



if event == "PLAYER_REGEN_DISABLED" then

if ralldelaycombatrezet==nil or (ralldelaycombatrezet and GetTime()>ralldelaycombatrezet) then

--ханты 3.5 сек проверка
if phraenglishclass=="HUNTER" and GetTime()>phrahuntertime then

--ТОЛЬКО ДЛЯ ХАНТОВ

phraachdone1=true
phracounter1=0

ratablefordummy=nil
razombiidtable=nil
ratableofnoobs=nil
rarezurecttable=nil
radebufcrazy=nil
racheckhpannounce=nil


if UnitGUID("boss1") and UnitName("boss1")~="" then
	local id2=UnitGUID("boss1")
	local id=tonumber(string.sub(id2,6,10),16)

else
rachtimerbossrecheck=GetTime()+3
end

elseif phraenglishclass=="HUNTER" then else

--ТУТ ОБНУЛЯТЬ ВСЕ

phraachdone1=true
phracounter1=0

ratablefordummy=nil
razombiidtable=nil
ratableofnoobs=nil
rarezurecttable=nil
radebufcrazy=nil
racheckhpannounce=nil


if UnitGUID("boss1") and UnitName("boss1")~="" then
	local id2=UnitGUID("boss1")
	local id=tonumber(string.sub(id2,6,10),16)




end


end --хантер


end
end

if event == "PLAYER_REGEN_ENABLED" then

	phrahuntertime=GetTime()+3.5

end

if event == "ZONE_CHANGED_NEW_AREA" then

phracheckzonedelay=GetTime()+2
phracounter1=0

phbosskilled=nil
ratableofnoobs=nil
ratablefordummy=nil
razombiidtable=nil
rarezurecttable=nil
radebufcrazy=nil
racheckhpannounce=nil
rablockuntilreset=nil


end


if event == "ADDON_LOADED" then
	if arg1=="RaidAchievement_PandaHeroics" then

for i=1,#phraspisokach5 do
if phraspisokon[i]==nil then phraspisokon[i]=1 end
end
	end
end


if event == "CHAT_MSG_MONSTER_YELL" or event=="CHAT_MSG_MONSTER_SAY" then



end


if event == "COMBAT_LOG_EVENT_UNFILTERED" then

local arg1, arg2,arg3,arg4,arg5,arg6,argNEW1,arg7,arg8,arg9,argNEW2,arg10,arg11,arg12,arg13,arg14,arg15 = ...




--проверка на возможный выход с боя
if arg5==UnitName("player") and arg2=="SPELL_AURA_REMOVED" and (arg10==58984 or arg10==66 or arg10==1856 or arg10==11327) then
ralldelaycombatrezet=GetTime()+4
end




--achieves tracker:
--Scarlet Halls
if GetCurrentMapAreaID()==871 then
if arg2=="UNIT_DIED" and phbosskilled==nil and rablockuntilreset==nil then
  if phraspisokon[1]==1 and phraachdone1 then
  local id=tonumber(string.sub(arg7,6,10),16)
  if id==59309 or id==58674 or id==58876 then
    phrafailnoreason(1)
    rablockuntilreset=1
  end
  end
end


if arg2=="UNIT_DIED" then
  local id=tonumber(string.sub(arg7,6,10),16)
  if id==59303 then
    phbosskilled=1
  end
end

--if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and arg10==111215 and arg7 then
if arg2=="SPELL_AURA_APPLIED" and arg10==112955 and arg4 then
  if ratableofnoobs==nil then
    ratableofnoobs={}
  end
  local bil=0
  if #ratableofnoobs>0 then
    for i=1,#ratableofnoobs do
      if ratableofnoobs[i]==arg4 then
        bil=1
      end
    end
  end
  if bil==0 then
    local id=tonumber(string.sub(arg4,6,10),16)
    raunitisplayer(arg4,arg5)
    if id==58998 or raunitplayertrue then
      table.insert(ratableofnoobs,arg4)
      if #ratableofnoobs==8 then
        if phraspisokon[2]==1 and phraachdone1 then
          phraachcompl(2)
        end
      end
    end
  end
end

--резет таблицы ид, так как считаем только за 1 захват
if arg2=="SPELL_CAST_START" and arg10==111216 then
  ratableofnoobs=nil
end


end
--


--Scarlet Monastery
if GetCurrentMapAreaID()==874 then
if arg2=="SPELL_SUMMON" and arg10==115250 then
if razombiidtable==nil then
  razombiidtable={}
end
local bil=0
if #razombiidtable>0 then
  for i=1,#razombiidtable do
    if razombiidtable[i]==arg7 then
      bil=1
    end
  end
end
if bil==0 then
  table.insert(razombiidtable,arg7)
  if #razombiidtable==3 then
    if phraspisokon[3]==1 then
      phraachcompl(3)
    end
  end
end
end

if arg2=="UNIT_DIED" then
  if razombiidtable and #razombiidtable>0 then
    local bil=0
    for i=1,#razombiidtable do
      if razombiidtable[i] and razombiidtable[i]==arg7 then
        table.remove(razombiidtable,i)
      end
    end
  end
end

if arg2=="SPELL_DAMAGE" and arg10==113766 and arg8=="Unknown" and fsdgsdfgfgdfgdfgdfg then --ыытест не сменял ли лог и работает ли ВРЕМЕННО НЕ РАБОТАЕТ!!! --//////////////// and fsdgsdfgfgdfgdfgdfg чтобы не работала часть!
  if ratablefordummy==nil then
    ratablefordummy={}
  end
  local bil=0
  if #ratablefordummy>0 then
    for i=1,#ratablefordummy do
      if ratablefordummy[i]==arg7 then
        bil=1
      end
    end
  end
  if bil==0 then
    table.insert(ratablefordummy,arg7)
    if #ratablefordummy==6 then
      if phraspisokon[4]==1 and phraachdone1 then
        --phraachcompl(4)
      end
    end
  end
end

--ыытест не проверено
if arg2=="SPELL_CAST_START" and arg10==113134 then --ыытест нет инфы об окончании каста
  if rarezurecttable==nil then
    rarezurecttable=0
  end
end

if arg2=="UNIT_DIED" and rarezurecttable then
  local id=tonumber(string.sub(arg7,6,10),16)
  if id==58605 then
    rarezurecttable=rarezurecttable+1
    if rarezurecttable==13 then
      if phraspisokon[4]==1 and phraachdone1 then
        phraachcompl(4)
      end
    end
  end
end


end
--


--Scholomance
if GetCurrentMapAreaID()==898 then



if arg2=="SPELL_AURA_APPLIED_DOSE" and arg10==113765 and arg14>5 then
  if phraspisokon[5]==1 and phraachdone1 then
    phrafailnoreason(5)
  end
end

if arg2=="SPELL_AURA_APPLIED_DOSE" and arg10==114141 and arg14>98 then
  if phraspisokon[6]==1 and phraachdone1 then
    phraachcompl(6)
  end
end

end
--


--Siege of Niuzao Temple
if GetCurrentMapAreaID()==887 then
if arg2=="UNIT_DIED" then
  if phraspisokon[7]==1 and phraachdone1 then
  local id=tonumber(string.sub(arg7,6,10),16)
  if id==61699 then
    phraachcompl(7)
  end
  end
end


if arg2=="SPELL_AURA_APPLIED_DOSE" and arg10==119395 and arg14==20 then
  if phraspisokon[8]==1 then
    phraachcompl(8)
  end
end



end
--


--Stormstout Brewery
if GetCurrentMapAreaID()==876 then

if arg2=="SPELL_DAMAGE" and arg10==106784 then
  phracounter1=phracounter1+1
  if phracounter1==20 then
    if phraspisokon[9]==1 then
      phraachcompl(9)
    end
  end
end



end
--



--Temple of the Jade Serpent
if GetCurrentMapAreaID()==867 then

if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and (arg10==115167 or arg10==106105 or arg10==106334) and UnitName("player")==arg8 then
  if phraspisokon[10]==1 and phraachdone1 then
    phramyfail(10)
  end
end


end
--




--Shado-Pan Monastery
if GetCurrentMapAreaID()==877 then

--12
--ыытест ИЗМЕНЯЯ ЦИФРУ, ИЗМЕНЯТЬ ТАК ЖЕ И В ОНАПДЕЙТ ФУНКЦИИ\

if arg2=="SPELL_AURA_APPLIED" and arg10==107087 then
  if radebufcrazy==nil then
    radebufcrazy={}
  end
  local bil=0
  if #radebufcrazy>0 then
    for i=1,#radebufcrazy do
      if radebufcrazy[i]==arg7 then
        bil=1
      end
    end
  end
  if bil==0 then
    table.insert(radebufcrazy,arg7)
    if #radebufcrazy==GetNumGroupMembers() or (GetNumGroupMembers()==0 and #radebufcrazy==1) then
      racheckhpannounce=GetTime()-1
    end
  end
end
if arg2=="SPELL_AURA_REMOVED" and arg10==107087 and radebufcrazy then
  for i=1,#radebufcrazy do
    if radebufcrazy[i] and radebufcrazy[i]==arg7 then
      table.remove(radebufcrazy,i)
      racheckhpannounce=nil
    end
  end
end

end
--


--Gate of the Setting Sun
if GetCurrentMapAreaID()==875 then

if arg2=="UNIT_DIED" and UnitName("boss1") then
  if phraspisokon[12]==1 and phraachdone1 then
  local id=tonumber(string.sub(arg7,6,10),16)
  if id==56929 or id==56912 or id==56930 then
    phrafailnoreason(12)
  end
  end
end


end
--










end

end --КОНЕЦ ОНЕВЕНТ

function phra_closeallpr()
phramain6:Hide()
end


function phra_button2()
PSFea_closeallpr()
phramain6:Show()
openmenureportphra()



if (phranespamit==nil) then

phraspislun= # phraspisokach5
phracbset={}
for i=1,phraspislun do

if i>14 then
l=280
j=i-14
else
l=0
j=i
end

if GetAchievementLink(phraspisokach5[i]) then

local _, phraName, _, completed, _, _, _, Description, _, phraImage = GetAchievementInfo(phraspisokach5[i])


--текст
local f = CreateFrame("Frame",nil,phramain6)
f:SetFrameStrata("DIALOG")
f:SetWidth(248)
f:SetHeight(24)
f:SetScript("OnEnter", function(self) Rawhershowtxt(self,Description) end )
f:SetScript("OnLeave", function(self) Rawhershowtxt2() end )
f:SetScript("OnMouseDown", function(self) if IsShiftKeyDown() then if ChatFrame1EditBox:GetText() and string.len(ChatFrame1EditBox:GetText())>0 then ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText().." "..GetAchievementLink(phraspisokach5[i])) else ChatFrame_OpenChat(GetAchievementLink(phraspisokach5[i])) end end end )

--картинка
local t = f:CreateTexture(nil,"OVERLAY")
t:SetTexture(phraImage)
t:SetWidth(24)
t:SetHeight(24)
t:SetPoint("TOPLEFT",0,0)

local t = f:CreateFontString()
t:SetFont(GameFontNormal:GetFont(), rafontsset[2])
t:SetWidth(248)
if completed then
t:SetText("|cff00ff00"..phraName.."|r")
else
--no more red
t:SetText(phraName)
end
t:SetJustifyH("LEFT")
t:SetPoint("LEFT",27,0)


f:SetPoint("TOPLEFT",l+45,-14-j*30)
f:Show()

end

--чекбатон
local c = CreateFrame("CheckButton", nil, phramain6, "UICheckButtonTemplate")
c:SetWidth("25")
c:SetHeight("25")
c:SetPoint("TOPLEFT", l+20, -14-j*30)
c:SetScript("OnClick", function(self) phragalka(i) end )
table.insert(phracbset, c)

end --for i
phranespamit=1
end --nespam

phragalochki()



end --конец бутон2

function Rawhershowtxt(self,i)
	GameTooltip:SetOwner(self or UIParent, "ANCHOR_TOP")
	GameTooltip:SetText(i)
end

function Rawhershowtxt2(i)
GameTooltip:Hide()
end


function phragalochki()
for i=1,#phraspisokach5 do
if phracbset[i] then
if(phraspisokon[i]==1)then phracbset[i]:SetChecked() else phracbset[i]:SetChecked(false) end
end
end
end

function phragalka(nomersmeni)
if phraspisokon[nomersmeni]==1 then phraspisokon[nomersmeni]=0 else phraspisokon[nomersmeni]=1 end
end

function phra_buttonchangeyn(yesno)
phraspislun= # phraspisokach5
for i=1,phraspislun do
phraspisokon[i]=yesno
end
phragalochki()
end

function phra_button1()
phraspislun= # phraspisokach5
for i=1,phraspislun do
if phraspisokon[i]==1 then phraspisokon[i]=0 else phraspisokon[i]=1 end
end
phragalochki()
end


function openmenureportphra()
if not DropDownMenureportphra then
CreateFrame("Frame", "DropDownMenureportphra", phramain6, "UIDropDownMenuTemplate")
end

DropDownMenureportphra:ClearAllPoints()
DropDownMenureportphra:SetPoint("BOTTOMLEFT", 5, 7)
DropDownMenureportphra:Show()

local items = lowmenuchatlistea

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownMenureportphra, self:GetID())

lowmenuchatea(self:GetID())
wherereportpartyach=wherereporttempbigma
end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end

lowmenuchatea2(wherereportpartyach)
if bigma2num==0 then
bigma2num=1
wherereportpartyach="party"
end

UIDropDownMenu_Initialize(DropDownMenureportphra, initialize)
UIDropDownMenu_SetWidth(DropDownMenureportphra, 90);
UIDropDownMenu_SetButtonWidth(DropDownMenureportphra, 105)
UIDropDownMenu_SetSelectedID(DropDownMenureportphra,bigma2num)
UIDropDownMenu_JustifyText(DropDownMenureportphra, "LEFT")
end