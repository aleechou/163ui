local _
function wodhraonload()
	wodhraachdone1=true
	wodhracounter1=0
	_, wodhraenglishclass = UnitClass("player")
	wodhrahuntertime=0
	
	raWoDModVers="not yet used"

local _, a2 = GetInstanceInfo()
if select(3,GetInstanceInfo())==2 and a2=="party" then
	RaidAchievement_wodhra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_wodhra:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_wodhra:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_wodhra:RegisterEvent("PLAYER_ALIVE")
end
	RaidAchievement_wodhra:RegisterEvent("PLAYER_REGEN_DISABLED")
	RaidAchievement_wodhra:RegisterEvent("PLAYER_REGEN_ENABLED")
	RaidAchievement_wodhra:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	RaidAchievement_wodhra:RegisterEvent("ADDON_LOADED")







wodhraspisokach5={

8993,--http://www.wowhead.com/achievement=8993 bloodmaul slag mines
9008,--http://www.wowhead.com/achievement=9008 bloodmaul slag mines
9082, -- iron docks
9551,--http://www.wowhead.com/achievement=9551 auchidon
9036,--http://www.wowhead.com/achievement=9036 skyreach
9033,--http://www.wowhead.com/achievement=9033 skyrich
9025,--http://www.wowhead.com/achievement=9025 shadowmoon
9017,--http://www.wowhead.com/achievement=9017 everbloom
9045, --blackrock
9057,--http://www.wowhead.com/achievement=9057 blackrock

}



if (wodhraspisokon==nil) then
wodhraspisokon={}
end


end


function wodhraonupdate()


--ачивка на пауков есть
if wohspiderList2 and GetTime()>wohspiderList2 then
	wohspiderList2=nil
	if wohspiderList and #wohspiderList>15 then
		raplaysound(3,wodhraspisokach5[7])
		if (wherereportpartyach=="sebe") then
			DEFAULT_CHAT_FRAME:AddMessage("- "..achlinnk.." "..#wohspiderList.." / 25!")
		else
			if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportpartyach=="raid_warning" then
				razapuskanonsa("raid", "{rt1} "..achlinnk.." "..#wohspiderList.." / 25!")
			else
				razapuskanonsa(wherereportpartyach, "{rt1} "..achlinnk.." "..#wohspiderList.." / 25!")
			end
		end
	end
end



if wodhracheckzonedelay and GetTime()>wodhracheckzonedelay then
wodhracheckzonedelay=nil

local _, a2 = GetInstanceInfo()
if select(3,GetInstanceInfo())==2 and a2=="party" then
	RaidAchievement_wodhra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_wodhra:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_wodhra:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_wodhra:RegisterEvent("PLAYER_ALIVE")
else
	RaidAchievement_wodhra:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_wodhra:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_wodhra:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_wodhra:UnregisterEvent("PLAYER_ALIVE")
end

end


end


function wodhraonevent(self,event,...)
local arg1, arg2, arg3,arg4,arg5,arg6 = ...

if event == "PLAYER_ALIVE" then
ralldelaycombatrezet=GetTime()+4
end



if event == "PLAYER_REGEN_DISABLED" then

if ralldelaycombatrezet==nil or (ralldelaycombatrezet and GetTime()>ralldelaycombatrezet) then

--ханты 3.5 сек проверка
if wodhraenglishclass=="HUNTER" and GetTime()>wodhrahuntertime then

--ТОЛЬКО ДЛЯ ХАНТОВ

wodhraachdone1=true
wodhracounter1=0


rawodonecounter1=nil
wohbosskilled=nil
wohspiderList=nil
wohspiderList2=nil


if UnitGUID("boss1") and UnitName("boss1")~="" then
	local id2=UnitGUID("boss1")
	local id=raGetUnitID(id2)

else
rachtimerbossrecheck=GetTime()+3
end

elseif wodhraenglishclass=="HUNTER" then else

--ТУТ ОБНУЛЯТЬ ВСЕ

wodhraachdone1=true
wodhracounter1=0

rawodonecounter1=nil
wohbosskilled=nil
wohspiderList=nil
wohspiderList2=nil


if UnitGUID("boss1") and UnitName("boss1")~="" then
	local id2=UnitGUID("boss1")
	local id=raGetUnitID(id2)




end


end --хантер


end
end

if event == "PLAYER_REGEN_ENABLED" then

	wodhrahuntertime=GetTime()+3.5

end

if event == "ZONE_CHANGED_NEW_AREA" then

wodhracheckzonedelay=GetTime()+2
wodhracounter1=0




end


if event == "ADDON_LOADED" then
	if arg1=="RaidAchievement_WoDHeroics" then

for i=1,#wodhraspisokach5 do
if wodhraspisokon[i]==nil then wodhraspisokon[i]=1 end
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


--Bloodmaul Slag Mines
if GetCurrentMapAreaID()==964 then

if arg2=="UNIT_DIED" and wohbosskilled==nil then
  if wodhraspisokon[1]==1 and wodhraachdone1 then
  local id=raGetUnitID(arg7)
  if id==74571 or id==74570 then
    wodhrafailnoreason(1)
  end
  end
end
if arg2=="UNIT_DIED" then
  local id=raGetUnitID(arg7)
  if id==86221 or id==74475 then
    wohbosskilled=1
  end
end



if arg2=="UNIT_DIED" and wohbosskilled==nil then
  if wodhraspisokon[2]==1 and wodhraachdone1 then
  local id=raGetUnitID(arg7)
  if id==74927 then
    wodhrafailnoreason(2)
  end
  end
end
if arg2=="UNIT_DIED" then
  local id=raGetUnitID(arg7)
  if id==74790 or id==86224 then
    wohbosskilled=1
  end
end



end
--

--Железные доки
if GetCurrentMapAreaID()==987 then


if arg2=="SPELL_DAMAGE" and (arg10==169129 or arg10==168390) and arg4 and arg8 then
	raunitisplayer(arg7,arg8)
	if raunitplayertrue then
		if wodhraspisokon[3]==1 and wodhraachdone1 then
			wodhrafailnoreason(3,arg8)
		end
	end
end



end
--

--Auchindoun
if GetCurrentMapAreaID()==984 then

if arg2=="UNIT_DIED" and wohbosskilled==nil then
  if wodhraspisokon[4]==1 and wodhraachdone1 then
  local id=raGetUnitID(arg7)
  if id==76259 or id==76260 or id==76220 then
    wodhrafailnoreason(4)
  end
  end
end
if arg2=="UNIT_DIED" then
  local id=raGetUnitID(arg7)
  if id==86219 or id==75927 then
    wohbosskilled=1
  end
end

end
--

--Skyreach
if GetCurrentMapAreaID()==989 then

if arg2=="UNIT_DIED" and wohbosskilled==nil then
  if wodhraspisokon[5]==1 and wodhraachdone1 then
  local id=raGetUnitID(arg7)
  if id==76292 then --76083 76267
    wodhrafailnoreason(5)
  end
  end
end
if arg2=="UNIT_DIED" then
  local id=raGetUnitID(arg7)
  if id==76266 or id==86241 then
    wohbosskilled=1
  end
end

if ((arg2=="SPELL_DAMAGE" and (arg10==153544 or arg10==153315 or arg10==153139)) or (arg2=="SPELL_AURA_APPLIED" and arg10==154043)) and arg4 and arg8 and UnitName("boss1") and arg7==UnitGUID("player") then
	raunitisplayer(arg7,arg8)
	if raunitplayertrue then
		if wodhraspisokon[6]==1 and wodhraachdone1 then
			wodhramyfail(6)
		end
	end
end

end
--

--Shadowmoon Burial Grounds
if GetCurrentMapAreaID()==969 then

if arg2=="SPELL_DAMAGE" and (arg10==153908) and arg7 then
if wodhraspisokon[7]==1 and wodhraachdone1 then
	if wohspiderList==nil then
		wohspiderList={}
	end
	local id=raGetUnitID(arg7)
	if id==77006 then
		local bil=0
		if #wohspiderList>0 then
			for i=1,#wohspiderList do
				if wohspiderList[i]==arg7 then
					bil=1
				end
			end
		end
		if bil==0 then
			table.insert(wohspiderList,arg7)
			wohspiderList2=GetTime()+5
		end
		if (#wohspiderList==25) then
			wohspiderList2=nil
			wodhraachcompl(7)
		end
	end
end
end

end
--

--Grimrail Depot
if GetCurrentMapAreaID()==993 then

end
--

--The Everbloom
if GetCurrentMapAreaID()==1008 then

if arg2=="SPELL_ENERGIZE" and (arg10==164438) and arg4 and arg8 then
	if wodhraspisokon[8]==1 and wodhraachdone1 then
		wodhrafailnoreason(8)
	end
end

end
--

--Верхняя часть пика черной горы
if GetCurrentMapAreaID()==995 then


if arg2=="SPELL_CAST_START" and arg10==154899 and arg4 then
	if rawodonecounter1==nil then
		rawodonecounter1=0
	end
	rawodonecounter1=rawodonecounter1+1
	if rawodonecounter1==4 then
		if wodhraspisokon[9]==1 and wodhraachdone1 then
			wodhrafailnoreason(9)
		end
	end
end


if arg2=="SPELL_CAST_START" and arg10==154899 and arg4 then
	if rawodonecounter1==nil then
		rawodonecounter1=0
	end
	local id=raGetUnitID(arg7)
	if id==82428 then
		rawodonecounter1=rawodonecounter1+1
		if rawodonecounter1==5 then
			if wodhraspisokon[10]==1 and wodhraachdone1 then
				wodhraachcompl(10)
			end
		end
	end
end



end
--











end

end --КОНЕЦ ОНЕВЕНТ

function wodhra_closeallpr()
wodhramain6:Hide()
end


function wodhra_button2()
PSFea_closeallpr()
wodhramain6:Show()
openmenureportwodhra()



if (wodhranespamit==nil) then

wodhraspislun= # wodhraspisokach5
wodhracbset={}
for i=1,wodhraspislun do

if i>14 then
l=280
j=i-14
else
l=0
j=i
end

if GetAchievementLink(wodhraspisokach5[i]) then

local _, wodhraName, _, completed, _, _, _, Description, _, wodhraImage = GetAchievementInfo(wodhraspisokach5[i])


--текст
local f = CreateFrame("Frame",nil,wodhramain6)
f:SetFrameStrata("DIALOG")
f:SetWidth(248)
f:SetHeight(24)
f:SetScript("OnEnter", function(self) Rawhershowtxt(self,Description) end )
f:SetScript("OnLeave", function(self) Rawhershowtxt2() end )
f:SetScript("OnMouseDown", function(self) if IsShiftKeyDown() then if ChatFrame1EditBox:GetText() and string.len(ChatFrame1EditBox:GetText())>0 then ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText().." "..GetAchievementLink(wodhraspisokach5[i])) else ChatFrame_OpenChat(GetAchievementLink(wodhraspisokach5[i])) end end end )

--картинка
local t = f:CreateTexture(nil,"OVERLAY")
t:SetTexture(wodhraImage)
t:SetWidth(24)
t:SetHeight(24)
t:SetPoint("TOPLEFT",0,0)

local t = f:CreateFontString()
t:SetFont(GameFontNormal:GetFont(), rafontsset[2])
t:SetWidth(248)
if completed then
t:SetText("|cff00ff00"..wodhraName.."|r")
else
--no more red
t:SetText(wodhraName)
end
t:SetJustifyH("LEFT")
t:SetPoint("LEFT",27,0)


f:SetPoint("TOPLEFT",l+45,-14-j*30)
f:Show()

end

--чекбатон
local c = CreateFrame("CheckButton", nil, wodhramain6, "UICheckButtonTemplate")
c:SetWidth("25")
c:SetHeight("25")
c:SetPoint("TOPLEFT", l+20, -14-j*30)
c:SetScript("OnClick", function(self) wodhragalka(i) end )
table.insert(wodhracbset, c)

end --for i
wodhranespamit=1
end --nespam

wodhragalochki()



end --конец бутон2

function Rawhershowtxt(self,i)
	GameTooltip:SetOwner(self or UIParent, "ANCHOR_TOP")
	GameTooltip:SetText(i)
end

function Rawhershowtxt2(i)
GameTooltip:Hide()
end


function wodhragalochki()
for i=1,#wodhraspisokach5 do
if wodhracbset[i] then
if(wodhraspisokon[i]==1)then wodhracbset[i]:SetChecked(true) else wodhracbset[i]:SetChecked(false) end
end
end
end

function wodhragalka(nomersmeni)
if wodhraspisokon[nomersmeni]==1 then wodhraspisokon[nomersmeni]=0 else wodhraspisokon[nomersmeni]=1 end
end

function wodhra_buttonchangeyn(yesno)
wodhraspislun= # wodhraspisokach5
for i=1,wodhraspislun do
wodhraspisokon[i]=yesno
end
wodhragalochki()
end

function wodhra_button1()
wodhraspislun= # wodhraspisokach5
for i=1,wodhraspislun do
if wodhraspisokon[i]==1 then wodhraspisokon[i]=0 else wodhraspisokon[i]=1 end
end
wodhragalochki()
end


function openmenureportwodhra()
if not DropDownMenureportwodhra then
CreateFrame("Frame", "DropDownMenureportwodhra", wodhramain6, "UIDropDownMenuTemplate")
end

DropDownMenureportwodhra:ClearAllPoints()
DropDownMenureportwodhra:SetPoint("BOTTOMLEFT", 5, 7)
DropDownMenureportwodhra:Show()

local items = lowmenuchatlistea

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownMenureportwodhra, self:GetID())

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

UIDropDownMenu_Initialize(DropDownMenureportwodhra, initialize)
UIDropDownMenu_SetWidth(DropDownMenureportwodhra, 90);
UIDropDownMenu_SetButtonWidth(DropDownMenureportwodhra, 105)
UIDropDownMenu_SetSelectedID(DropDownMenureportwodhra,bigma2num)
UIDropDownMenu_JustifyText(DropDownMenureportwodhra, "LEFT")
end