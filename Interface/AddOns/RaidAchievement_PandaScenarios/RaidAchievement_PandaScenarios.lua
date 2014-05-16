local _
function pzraonload()
	pzraachdone1=true
	pzracounter1=0
	_, pzraenglishclass = UnitClass("player")
	pzrahuntertime=0

if select(3,GetInstanceInfo())==11 or select(3,GetInstanceInfo())==12 then
	RaidAchievement_pzra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_pzra:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_pzra:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_pzra:RegisterEvent("PLAYER_ALIVE")
end
	RaidAchievement_pzra:RegisterEvent("PLAYER_REGEN_DISABLED")
	RaidAchievement_pzra:RegisterEvent("PLAYER_REGEN_ENABLED")
	RaidAchievement_pzra:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	RaidAchievement_pzra:RegisterEvent("ADDON_LOADED")




--http://mop.wowhead.com/zone=5963
--Stormstout Brewery входит в мета или это временный данж по фесту? ИСПРАВИТЬ в базе ачивок





pzraspisokach5={
7261,
7258,
7257,


7231,

7276,

7267,
7266,

7273,

7529,
7530,

8017,

7984,
--7986,

8330,
8347,
8295,
}

if UnitFactionGroup("player")=="Alliance" then
pzraspisokach5[9]=7526
pzraspisokach5[10]=7527
end


if (pzraspisokon==nil) then
pzraspisokon={}
end


end


function pzraonupdate()




if pzracheckzonedelay and GetTime()>pzracheckzonedelay then
pzracheckzonedelay=nil


if select(3,GetInstanceInfo())==11 or select(3,GetInstanceInfo())==12 then
	RaidAchievement_pzra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_pzra:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_pzra:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_pzra:RegisterEvent("PLAYER_ALIVE")
else
	RaidAchievement_pzra:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_pzra:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_pzra:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_pzra:UnregisterEvent("PLAYER_ALIVE")
end

end


end


function pzraonevent(self,event,...)
local arg1, arg2, arg3,arg4,arg5,arg6 = ...

if event == "PLAYER_ALIVE" then
ralldelaycombatrezet=GetTime()+4
end



if event == "PLAYER_REGEN_DISABLED" then

if ralldelaycombatrezet==nil or (ralldelaycombatrezet and GetTime()>ralldelaycombatrezet) then

--ханты 3.5 сек проверка
if pzraenglishclass=="HUNTER" and GetTime()>pzrahuntertime then

--ТОЛЬКО ДЛЯ ХАНТОВ

pzraachdone1=true
pzracounter1=0




if UnitGUID("boss1") and UnitName("boss1")~="" then
	local id2=UnitGUID("boss1")
	local id=tonumber(string.sub(id2,6,10),16)

else
rachtimerbossrecheck=GetTime()+3
end

elseif pzraenglishclass=="HUNTER" then else

--ТУТ ОБНУЛЯТЬ ВСЕ

pzraachdone1=true
pzracounter1=0


racountaddskilled=nil



if UnitGUID("boss1") and UnitName("boss1")~="" then
	local id2=UnitGUID("boss1")
	local id=tonumber(string.sub(id2,6,10),16)




end


end --хантер


end
end

if event == "PLAYER_REGEN_ENABLED" then

	pzrahuntertime=GetTime()+3.5

end

if event == "ZONE_CHANGED_NEW_AREA" then

pzracheckzonedelay=GetTime()+2
pzracounter1=0


rabrewstillonetime=nil
pszraonetimeonlylight=nil
rascbochka=nil
rascbochka2=nil


end


if event == "ADDON_LOADED" then
	if arg1=="RaidAchievement_PandaScenarios" then
    for i=1,#pzraspisokach5 do
      if pzraspisokon[i]==nil then
        pzraspisokon[i]=1
      end
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
--A Brewing Storm
if GetCurrentMapAreaID()==878 then
if arg2=="SPELL_DAMAGE" and arg10==111544 then
  if pzraspisokon[1]==1 and pszraonetimeonlylight==nil then
    raunitisplayer(arg7,arg8)
    if raunitplayertrue then
      pzrafailnoreason(1,arg8)
      pszraonetimeonlylight=1
    end
  end
end


if arg2=="UNIT_DIED" and razfailekilloneadd==nil then
  if pzraspisokon[2]==1 then
  local id=tonumber(string.sub(arg7,6,10),16)
  if id==59779 or id==64381 then
    pzrafailnoreason(2)
    razfailekilloneadd=1
  end
  end
end




if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and arg10==115013 and arg7==UnitGUID("player") then
  if pzraspisokon[3]==1 and pzraachdone1 then
    pzramyfail(3)
  end
end


end
--




--Unga Ingoo
if GetCurrentMapAreaID()==882 then

if arg2=="SPELL_AURA_APPLIED" and arg10==123137 and rabrewstillonetime==nil then
  if pzraspisokon[4]==1 then
    pzrafailnoreason(4)
    rabrewstillonetime=1
  end
end


end
--



--гробницы забытых королей
if GetCurrentMapAreaID()==900 then

if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and arg10==120742 then
  if pzraspisokon[5]==1 and pzraachdone1 then
    raunitisplayer(arg7,arg8)
    if raunitplayertrue then
      pzrafailnoreason(5,arg8)
    end
  end
end


end
--


--деревня зеленой скалы
if GetCurrentMapAreaID()==880 then

if arg2=="UNIT_DIED" and rascbochka==nil then
  if pzraspisokon[6]==1 then
  local id=tonumber(string.sub(arg7,6,10),16)
  if id==62682 then
      pzrafailnoreason(6)
      rascbochka=1
    end
  end
end

if arg2=="SPELL_CAST_SUCCESS" and arg10==119090 and rascbochka2==nil then
  if pzraspisokon[7]==1 then
    pzrafailnoreason(7,arg5)
    rascbochka2=1
  end
end

end
--

--арена
if GetCurrentMapAreaID()==899 then

if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and arg10==123965 then
  if pzraspisokon[8]==1 and pzraachdone1 then
    raunitisplayer(arg7,arg8)
    if raunitplayertrue then
      pzrafailnoreason(8,arg8)
    end
  end
end


end
--


--терамор
if GetCurrentMapAreaID()==906 then

if arg2=="UNIT_DIED" then
  local id=tonumber(string.sub(arg7,6,10),16)
  if id==64956 then
    if pzraspisokon[9]==1 and pzraachdone1 then
      pzrafailnoreason(9)
    end
  end
end


--метка
if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and (arg10==125915 or arg10==114565 or arg10==114568) then
  if pzraspisokon[10]==1 and pzraachdone1 then
--    raunitisplayer(arg7,arg8)
--    if raunitplayertrue then
      pzrafailnoreason(10,arg8)
--    end
  end
end
--свинг удар от вратолома
if arg2=="SWING_DAMAGE" then
  if pzraspisokon[10]==1 and pzraachdone1 then
    local id=tonumber(string.sub(arg4,6,10),16)
    if id==64479 or id==58787 then
      pzrafailnoreason(10,arg8)
    end
  end
end


end
--


--Zan'vess
if GetCurrentMapAreaID()==883 then

if arg2=="UNIT_DIED" then
  local id=tonumber(string.sub(arg7,6,10),16)
  if id==2351 then
    if pzraspisokon[11]==1 and pzraachdone1 then
      pzrafailnoreason(11)
    end
  end
end

end
--

--knife
if GetCurrentMapAreaID()==914 then

--1 ачивка зоны
if arg2=="SPELL_DAMAGE" and arg10==133121 then
  if racountaddskilled==nil then
    racountaddskilled=0
  end
  local id=tonumber(string.sub(arg7,6,10),16)
  if id==68037 or id==67257 or id==67259 then
    racountaddskilled=racountaddskilled+1
  end
  if racountaddskilled==3 then
    if pzraspisokon[12]==1 and pzraachdone1 then
      pzraachcompl(12)
    end
  end
end


--2 ачивка зоны
--НЕТ данных о тотеме
if arg2=="SPELL_AURA_APPLIED" and arg10==133002 and arg13 and arg13>=0 then
raachknifetrack=1
end
if arg2=="SPELL_CAST_SUCCESS" and arg10==132984 then
raachknifetrack=1
end




end
--





if arg2=="SPELL_CAST_SUCCESS" and arg10==141423 then
  if pzraspisokon[13]==1 then
    local id=tonumber(string.sub(arg3,6,10),16)
    if id==70544 then
      pzrafailnoreason(13)
    end
  end
end

if arg2=="SPELL_DAMAGE" and arg10==132938 and rascbochka2==nil then
  if pzraspisokon[14]==1 then
    raunitisplayer(arg7,arg8)
    if raunitplayertrue then
      pzrafailnoreason(14,arg8)
      rascbochka2=1
    end
  end
end


--секреты огненной пропасти
if GetCurrentMapAreaID()==938 then

if (arg2=="SPELL_DAMAGE" or arg2=="SWING_DAMAGE") and rascbochka2==nil then
  --получение ид
  if pzraspisokon[15]==1 then
      local id=tonumber(string.sub(arg7,6,10),16)
      if id==70605 or id==70606 or id==70607 or id==70608 or id==70609 then
        pzrafailnoreason(15,arg8)
        rascbochka2=1
      end
  end
end

end
--



end


end --КОНЕЦ ОНЕВЕНТ

function pzra_closeallpr()
pzramain6:Hide()
end


function pzra_button2()
PSFea_closeallpr()
pzramain6:Show()
openmenureportpzra()



if (pzranespamit==nil) then

pzraspislun= # pzraspisokach5
pzracbset={}
for i=1,pzraspislun do

if i>14 then
l=280
j=i-14
else
l=0
j=i
end

if GetAchievementLink(pzraspisokach5[i]) then

local _, pzraName, _, completed, _, _, _, Description, _, pzraImage = GetAchievementInfo(pzraspisokach5[i])


--текст
local f = CreateFrame("Frame",nil,pzramain6)
f:SetFrameStrata("DIALOG")
f:SetWidth(248)
f:SetHeight(24)
f:SetScript("OnEnter", function(self) Rawhershowtxt(self,Description) end )
f:SetScript("OnLeave", function(self) Rawhershowtxt2() end )
f:SetScript("OnMouseDown", function(self) if IsShiftKeyDown() then if ChatFrame1EditBox:GetText() and string.len(ChatFrame1EditBox:GetText())>0 then ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText().." "..GetAchievementLink(pzraspisokach5[i])) else ChatFrame_OpenChat(GetAchievementLink(pzraspisokach5[i])) end end end )

--картинка
local t = f:CreateTexture(nil,"OVERLAY")
t:SetTexture(pzraImage)
t:SetWidth(24)
t:SetHeight(24)
t:SetPoint("TOPLEFT",0,0)

local t = f:CreateFontString()
t:SetFont(GameFontNormal:GetFont(), rafontsset[2])
t:SetWidth(248)
if completed then
t:SetText("|cff00ff00"..pzraName.."|r")
else
--no more red
t:SetText(pzraName)
end
t:SetJustifyH("LEFT")
t:SetPoint("LEFT",27,0)


f:SetPoint("TOPLEFT",l+45,-14-j*30)
f:Show()

end

--чекбатон
local c = CreateFrame("CheckButton", nil, pzramain6, "UICheckButtonTemplate")
c:SetWidth("25")
c:SetHeight("25")
c:SetPoint("TOPLEFT", l+20, -14-j*30)
c:SetScript("OnClick", function(self) pzragalka(i) end )
table.insert(pzracbset, c)

end --for i
pzranespamit=1
end --nespam

pzragalochki()



end --конец бутон2

function Rawhershowtxt(self,i)
	GameTooltip:SetOwner(self or UIParent, "ANCHOR_TOP")
	GameTooltip:SetText(i)
end

function Rawhershowtxt2(i)
GameTooltip:Hide()
end


function pzragalochki()
for i=1,#pzraspisokach5 do
if pzracbset[i] then
if(pzraspisokon[i]==1)then pzracbset[i]:SetChecked() else pzracbset[i]:SetChecked(false) end
end
end
end

function pzragalka(nomersmeni)
if pzraspisokon[nomersmeni]==1 then pzraspisokon[nomersmeni]=0 else pzraspisokon[nomersmeni]=1 end
end

function pzra_buttonchangeyn(yesno)
pzraspislun= # pzraspisokach5
for i=1,pzraspislun do
pzraspisokon[i]=yesno
end
pzragalochki()
end

function pzra_button1()
pzraspislun= # pzraspisokach5
for i=1,pzraspislun do
if pzraspisokon[i]==1 then pzraspisokon[i]=0 else pzraspisokon[i]=1 end
end
pzragalochki()
end


function openmenureportpzra()
if not DropDownMenureportpzra then
CreateFrame("Frame", "DropDownMenureportpzra", pzramain6, "UIDropDownMenuTemplate")
end

DropDownMenureportpzra:ClearAllPoints()
DropDownMenureportpzra:SetPoint("BOTTOMLEFT", 5, 7)
DropDownMenureportpzra:Show()

local items = lowmenuchatlistea

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownMenureportpzra, self:GetID())

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

UIDropDownMenu_Initialize(DropDownMenureportpzra, initialize)
UIDropDownMenu_SetWidth(DropDownMenureportpzra, 90);
UIDropDownMenu_SetButtonWidth(DropDownMenureportpzra, 105)
UIDropDownMenu_SetSelectedID(DropDownMenureportpzra,bigma2num)
UIDropDownMenu_JustifyText(DropDownMenureportpzra, "LEFT")
end