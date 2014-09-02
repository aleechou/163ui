raoldmodules=1
local _
function chraonload()

	chraachdone1=true
	chracounter1=0
	_, chraenglishclass = UnitClass("player")
	chrahuntertime=0

local _, a2 = GetInstanceInfo()
if select(3,GetInstanceInfo())==2 and a2=="party" then
	RaidAchievement_chra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_chra:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_chra:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_chra:RegisterEvent("PLAYER_ALIVE")
end
	RaidAchievement_chra:RegisterEvent("PLAYER_REGEN_DISABLED")
	RaidAchievement_chra:RegisterEvent("PLAYER_REGEN_ENABLED")
	RaidAchievement_chra:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	RaidAchievement_chra:RegisterEvent("ADDON_LOADED")




chraspisokach5={
5292,
5366,
5368,
--5369,
5370,
5371,

5503,
5504,

5505,--8
--проп

5281,
5282,
5283,
5284,
--проп

5288,--Vortex Pinnacle
--проп


5297,
--5298, --no for Don't Need to Break Eggs to Make an Omelet

--hallsof origi
5293,
5296, --мб убрать нада будет?!
5295,

--5290,

--2 пропуска

--27 итог

--ZA AG
5750,
5743,
5762,
5765,

--End Time 22ой
6130,
6132,
6070,
6127,
}



if (chraspisokon==nil) then
chraspisokon={}
end


end


function chraonupdate()

if rachtimerbossrecheck and GetTime()>rachtimerbossrecheck then
rachtimerbossrecheck=nil
if UnitGUID("boss1") and UnitName("boss1")~="" then
	local id=tonumber(string.sub(UnitGUID("boss1"),6,10),16)

	if id==49541 or id==49429 then
		rachtimervanessa=nil
	end
end
end

if rachtimerhoo and GetTime()>rachtimerhoo then
rachtimerhoo=nil
SetMapToCurrentZone()
if GetCurrentMapAreaID()==759 then
if chraspisokon[16]==1 and chraachdone1 then
chrafailnoreason(16)
end
end
end

if rachtimervanessa and GetTime()>rachtimervanessa then
rachtimervanessa=nil
if GetCurrentMapAreaID()==756 then
if chraspisokon[5]==1 and chraachdone1 then
chrafailnoreason(5)
end
end
end

if chratimerstart and GetTime()>chratimerstart+15 then --убрать все psfailoklala
chratimerstart=nil
if GetCurrentMapAreaID()==759 then
  if chracounter1==2 then
    chrafailnoreason(15) --ыытест проверить ИД совпадает ли в конце
  end
end
end


if chracheckzonedelay and GetTime()>chracheckzonedelay then
chracheckzonedelay=nil

local _, a2 = GetInstanceInfo()
if select(3,GetInstanceInfo())==2 and a2=="party" then
	RaidAchievement_chra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_chra:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_chra:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_chra:RegisterEvent("PLAYER_ALIVE")
else
	RaidAchievement_chra:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_chra:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_chra:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_chra:UnregisterEvent("PLAYER_ALIVE")
end

end


end


function chraonevent(self,event,...)
local arg1, arg2, arg3,arg4,arg5,arg6 = ...

if event == "PLAYER_ALIVE" then
ralldelaycombatrezet=GetTime()+4
end


if event == "PLAYER_REGEN_DISABLED" then

if ralldelaycombatrezet==nil or (ralldelaycombatrezet and GetTime()>ralldelaycombatrezet) then

--ханты 3.5 сек проверка
if chraenglishclass=="HUNTER" and GetTime()>chrahuntertime then

--ТОЛЬКО ДЛЯ ХАНТОВ

chraachdone1=true
chracounter1=0
chratableid=nil

if UnitGUID("boss1") and UnitName("boss1")~="" then
	local id2=UnitGUID("boss1")
	local id=tonumber(string.sub(id2,6,10),16)

	if id==49541 or id==49429 then
		rachtimervanessa=nil
	end
else
rachtimerbossrecheck=GetTime()+3
end

elseif chraenglishclass=="HUNTER" then else

--ТУТ ОБНУЛЯТЬ ВСЕ

chraachdone1=true
chracounter1=0
chratableid=nil
rahourtrackstart=nil

if UnitGUID("boss1") and UnitName("boss1")~="" then
	local id2=UnitGUID("boss1")
	local id=tonumber(string.sub(id2,6,10),16)

	if id==49541 then
		rachtimervanessa=nil
	end

	--Faster Than the Speed of Light
	if id==39788 then
		rachtimerhoo=nil
	end


end


end --хантер


end
end

if event == "PLAYER_REGEN_ENABLED" then

	chrahuntertime=GetTime()+3.5

end

if event == "ZONE_CHANGED_NEW_AREA" then

chracheckzonedelay=GetTime()+2
chratableid=nil
rahourtrackstart=nil

end


if event == "ADDON_LOADED" then
	if arg1=="RaidAchievement_CataHeroics" then

for i=1,#chraspisokach5 do
if chraspisokon[i]==nil then chraspisokon[i]=1 end
end
	end
end


if event == "CHAT_MSG_MONSTER_YELL" or event=="CHAT_MSG_MONSTER_SAY" then

if arg1==chhrbrannyell and GetCurrentMapAreaID()==759 then
if chraspisokon[16]==1 and chraachdone1 then
rachtimerhoo=GetTime()+298
ratempadd_c=nil
end
end

end


if event == "COMBAT_LOG_EVENT_UNFILTERED" then

local arg1, arg2, arg3,arg4,arg5,arg6,argNEW1,arg7,arg8,arg9,argNEW2,arg10,arg11,arg12,arg13,arg14, arg15 = ...




--проверка на возможный выход с боя
if arg5==UnitName("player") and arg2=="SPELL_AURA_REMOVED" and (arg10==58984 or arg10==66 or arg10==1856 or arg10==11327) then
ralldelaycombatrezet=GetTime()+4
end




--achieves:

--dead mines

if arg2=="SPELL_AURA_APPLIED_DOSE" and (arg10==93959 or arg10==91871) and arg14==3 then

if chraspisokon[1]==1 and chraachdone1 then
local _, _, _, chramyach = GetAchievementInfo(5292)
if arg8==UnitName("player") then
if (chramyach) then else
chramyfailgood(1,1)
end
end
end

end


if GetCurrentMapAreaID()==756 then
if (arg2=="SPELL_DAMAGE" or (arg2=="SPELL_MISSED" and arg13 and (arg13=="ABSORB" or arg13=="RESIST"))) and arg10==91397 then
if chraspisokon[2]==1 and chraachdone1 then
local _, _, _, chramyach = GetAchievementInfo(5366)
if arg8==UnitName("player") then
if (chramyach) then else
chramyfail(2)
end
end
end
end


if chraspisokon[3]==1 and chraachdone1 then
	if (arg2=="SPELL_MISSED" or arg2=="SPELL_DAMAGE" or arg2=="SPELL_PERIODIC_DAMAGE" or arg2=="SWING_DAMAGE") and arg7 then
		local id=tonumber(string.sub(arg7,6,10),16)
		local id2=1
if UnitGUID("boss1") and UnitName("boss1")~="" then
		local id3=UnitGUID("boss1")
		id2=tonumber(string.sub(id3,6,10),16)
end

		if id==49208 and UnitGUID("boss1") and id2==43778 then
		if UnitGUID("boss1") then
		local bossid=tonumber(string.sub(UnitGUID("boss1"),6,10),16)
		if bossid==43778 then
			local percent=100
			if UnitGUID("pet") then
				local iiid=tonumber(string.sub(UnitGUID("pet"),6,10),16)
				if iiid==49208 then
					percent=UnitHealth("pet")*100/UnitHealthMax("pet")
				end
			end
			for op=1,4 do
				if UnitGUID("partypet"..op) then
					local iiid=tonumber(string.sub(UnitGUID("partypet"..op),6,10),16)
					if iiid==49208 then
						percent=UnitHealth("partypet"..op)*100/UnitHealthMax("partypet"..op)
					end
				end
			end
			if percent<90 then
				chrafailnoreason(3)
			end
		end
		end
		end
	end
end

if arg2=="SPELL_AURA_APPLIED_DOSE" and arg8==UnitName("player") and arg10==92066 and arg14 and arg14>1 then
	if chraspisokon[4]==1 and chraachdone1 then
local _, _, _, whramyach = GetAchievementInfo(chraspisokach5[4])
if (whramyach) then else
		chramyfail(4)
end
	end
end



if arg2=="SPELL_CAST_SUCCESS" and arg10==92100 then
	if chraspisokon[5]==1 and chraachdone1 then
		rachtimervanessa=GetTime()+300
	end
end

end



--Shadowfang Keep
if GetCurrentMapAreaID()==764 then

if arg2=="SPELL_CAST_SUCCESS" and arg10==93710 then
ralldelaycombatrezet=GetTime()+15
end

if arg2=="SPELL_HEAL" and arg10==93706 then
	if chraspisokon[6]==1 and chraachdone1 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==46962 then
			chrafailnoreason(6)
		end
	end
end

if arg2=="SPELL_HEAL" and arg10==93844 then
	if chraspisokon[7]==1 and chraachdone1 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==4278 then
			chrafailnoreason(7)
		end
	end
end


if arg2=="SPELL_DAMAGE" and arg10==93784 and arg14 and arg14>0 then
	if chraspisokon[8]==1 and chraachdone1 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==50561 then
			chracounter1=chracounter1+1
			if chracounter1==5 then
				raplaysound(0,5505)
				razapuskanonsa(wherereportpartyach, achlinnk..": "..chracounter1.." / 12")
			end
			if chracounter1==8 then
				raplaysound(0,5505)
				razapuskanonsa(wherereportpartyach, achlinnk..": "..chracounter1.." / 12")
			end
			if chracounter1==10 then
				raplaysound(0,5505)
				razapuskanonsa(wherereportpartyach, achlinnk..": "..chracounter1.." / 12")
			end

			if chracounter1==12 then
				chraachcompl(8)
			end
		end
	end
end


end

--



--blackrock
if GetCurrentMapAreaID()==753 then

if arg2=="SPELL_DAMAGE" and arg10==93454 then
	if chraspisokon[9]==1 and chraachdone1 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==50376 then
			chracounter1=chracounter1+1
			if chracounter1==10 then
				chraachcompl(9)
			end
		end
	end
end

if arg2=="UNIT_DIED" then
	if chraspisokon[10]==1 and chraachdone1 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==50284 then
			chracounter1=chracounter1+1
			if chracounter1==3 then
				chraachcompl(10)
			end
		end
	end

	if rachtimerhoo then
		if ratempadd_c==nil then
			ratempadd_c=0
		end
		local id=tonumber(string.sub(arg7,6,10),16)
		if (id==39803 or id==39801 or id==39800 or id==39802) then
			ratempadd_c=ratempadd_c+1
			if ratempadd_c==4 then
				rachtimerhoo=nil
			end
		end
	end

end

if arg2=="SPELL_AURA_APPLIED_DOSE" and arg10==93567 and arg14 and arg14>14 then
	if chraspisokon[11]==1 and chraachdone1 then
		--local id=tonumber(string.sub(arg7,6,10),16)
		--if id==39698 then
			chraachcompl(11)
		--end
	end
end

if arg2=="SPELL_AURA_APPLIED_DOSE" and arg10==76189 and arg14 and arg14>3 then
if chraspisokon[12]==1 and chraachdone1 then
--raunitisplayer(arg7,arg8)
--if raunitplayertrue then
chrafailnoreason(12, arg8)
--end
end
end



end



if arg2=="SPELL_AURA_APPLIED" and arg10==87618 and arg8==UnitName("player") then
	if chraspisokon[13]==1 and chraachdone1 then
local _, _, _, whramyach = GetAchievementInfo(chraspisokach5[13])
if (whramyach) then else
		chramyfail(13)
end
	end
end


--grim batol
if GetCurrentMapAreaID()==757 then

if arg2=="SPELL_AURA_APPLIED" and arg10==90170 then
	if chraspisokon[14]==1 and chraachdone1 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==39625 then
			chramyfailgood(14,2)
		end
	end
end

--there is something strange in combatlog!
--ыытест
--if arg2=="SPELL_CAST_SUCCESS" or arg2=="SPELL_CAST_START" and arg10==91049 then
--	if chraspisokon[15]==1 and chraachdone1 then
--		if UnitGUID("boss1") then
--			local a2=tonumber(string.sub(UnitGUID("boss1"),6,10),16)
--			if a2==40484 then
--				chrafailnoreason(15)
--			end
--		end
--	end
--end


end
--

--halls of orig
if GetCurrentMapAreaID()==759 then
if arg2=="SPELL_AURA_APPLIED" and arg10==75322 then                 --ЫЫТЕСТ меняя тут ИД менять также и в онапдейт функции!
	if chraspisokon[15]==1 and chraachdone1 then
		chratimerstart=GetTime()
		chracounter1=chracounter1+1
	end
end

if arg2=="SPELL_CAST_SUCCESS" and arg10==77437 then
rachtimerhoo=nil
end

if arg2=="SPELL_AURA_REMOVED" and arg10==75322 then
if chratimerstart then
  if chraspisokon[15]==1 and chraachdone1 then
    chraachcompl(15)
  end
end
chratimerstart=nil
end


if arg2=="SPELL_PERIODIC_ENERGIZE" and arg10==89879 then
	if chraspisokon[17]==1 and chraachdone1 then
		chracounter1=chracounter1+1
		if chracounter1>19 then            --ыытестили больше 18???
			chrafailnoreason(17)
		end
	end
end


end

--lost city
--if GetCurrentMapAreaID()==747 then




--end
--

--Zul'Aman
if GetCurrentMapAreaID()==781 then

if chraspisokon[18]==1 and chraachdone1 then
	if arg2=="SPELL_PERIODIC_DAMAGE" and arg14 and arg14>0 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==52755 or id==24224 then
			if UnitGUID("boss1") then
				local id=tonumber(string.sub(UnitGUID("boss1"),6,10),16)
				if id==23577 then
					chrafailnoreason(18,arg5)
				end
			end
		end
	end
	if arg2=="SPELL_DAMAGE" and arg14 and arg14>0 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==52755 or id==24224 then
			if UnitGUID("boss1") then
				local id=tonumber(string.sub(UnitGUID("boss1"),6,10),16)
				if id==23577 then
					chrafailnoreason(18,arg5)
				end
			end
		end
	end
	if arg2=="SWING_DAMAGE" and arg11 and arg11>0 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==52755 or id==24224 then
			if UnitGUID("boss1") then
				local id=tonumber(string.sub(UnitGUID("boss1"),6,10),16)
				if id==23577 then
					chrafailnoreason(18,arg5)
				end
			end
		end
	end
	if arg2=="RANGE_DAMAGE" and arg14 and arg14>0 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==52755 or id==24224 then
			if UnitGUID("boss1") then
				local id=tonumber(string.sub(UnitGUID("boss1"),6,10),16)
				if id==23577 then
					chrafailnoreason(18,arg5)
				end
			end
		end
	end
	if arg2=="UNIT_DIED" or arg2=="UNIT_DESTROYED" then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==52755 or id==24224 then
			if UnitGUID("boss1") then
				local id=tonumber(string.sub(UnitGUID("boss1"),6,10),16)
				if id==23577 then
					chrafailnoreason(18,arg5)
				end
			end
		end
	end
end


end
--

--Zul'Gurub
if GetCurrentMapAreaID()==793 then
--кто попал в 3 абилки!
if arg2=="SPELL_DAMAGE" and (arg10==96515 or arg10==96638 or arg10==96685) then
	if chraspisokon[19]==1 and chraachdone1 then
local _, _, _, chramyach = GetAchievementInfo(5743)
if arg8==UnitName("player") then
if (chramyach) then else
chramyfail(19)
end
end
	end
end


--

if chraspisokon[20]==1 and chraachdone1 then
	if arg2=="SPELL_PERIODIC_DAMAGE" and arg14 and arg14>0 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==52157 then
			chrafailnoreason(20,arg5)
		end
	end
	if arg2=="SPELL_DAMAGE" and arg14 and arg14>0 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==52157 then
			chrafailnoreason(20,arg5)
		end
	end
	if arg2=="SWING_DAMAGE" and arg11 and arg11>0 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==52157 then
			chrafailnoreason(20,arg5)
		end
	end
	if arg2=="RANGE_DAMAGE" and arg14 and arg14>0 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==52157 then
			chrafailnoreason(20,arg5)
		end
	end
	if arg2=="UNIT_DIED" then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==52157 then
			chrafailnoreason(20)
		end
	end
end

if chraspisokon[21]==1 and chraachdone1 then
	if arg2=="SPELL_AURA_APPLIED" and arg10==98239 then
		chracounter1=chracounter1+1
		if chracounter1==4 then
			chraachcompl(21)
		end
	end
end



end
--


--end time without ID
if arg2=="SPELL_CAST_SUCCESS" and arg10==100686 then
chracounter1=0
end

if arg2=="UNIT_DIED" and chraspisokon[22]==1 and chraachdone1 then
	local id=tonumber(string.sub(arg7,6,10),16)
	if id==54191 and GetCurrentMapAreaID()==820 then
		chracounter1=chracounter1+1
		if chracounter1==2 then
			chraachcompl(22)
		end
	end
end

--hour of twi
if arg2=="SPELL_AURA_APPLIED" and arg10==103754 then
	if chraspisokon[23]==1 and chraachdone1 then
    rahourtrackstart=1
  end
end

if rahourtrackstart then
	if chraspisokon[23]==1 and chraachdone1 then
		if arg2=="SPELL_PERIODIC_DAMAGE" and arg14 and arg14>=0 then
			local id=tonumber(string.sub(arg7,6,10),16)
			if id==55466 then
        chracounter1=chracounter1+1
        if chracounter1==10 then
          chraachcompl(23)
        end
			end
		end
		if arg2=="SPELL_DAMAGE" and arg14 and arg14>=0 then
			local id=tonumber(string.sub(arg7,6,10),16)
			if id==55466 then
        chracounter1=chracounter1+1
        if chracounter1==10 then
          chraachcompl(23)
        end
			end
		end
		if arg2=="SWING_DAMAGE" and arg11 and arg11>=0 then
			local id=tonumber(string.sub(arg7,6,10),16)
			if id==55466 then
        chracounter1=chracounter1+1
        if chracounter1==10 then
          chraachcompl(23)
        end
			end
		end
		if arg2=="RANGE_DAMAGE" and arg14 and arg14>=0 then
			local id=tonumber(string.sub(arg7,6,10),16)
			if id==55466 then
        chracounter1=chracounter1+1
        if chracounter1==10 then
          chraachcompl(23)
        end
			end
		end
	end
end


--well of the eternity

if arg2=="SPELL_INSTAKILL" and arg10==104961 then
	local id=tonumber(string.sub(arg7,6,10),16)
	if id==55419 and chraspisokon[24]==1 and chraachdone1 then
		chraachcompl(24)
  	end
end

if arg2=="SPELL_AURA_APPLIED" and arg10==105493 then
	if chraspisokon[25]==1 and chraachdone1 then
		chrafailnoreason(25,arg8)
  	end
end



end
end --КОНЕЦ ОНЕВЕНТ

function chra_closeallpr()
chramain6:Hide()
end


function chra_button2()
PSFea_closeallpr()
chramain6:Show()
openmenureportchra()



if (chranespamit==nil) then

chraspislun= # chraspisokach5
chracbset={}
for i=1,chraspislun do

if i>14 then
l=280
j=i-14
else
l=0
j=i
end

if GetAchievementLink(chraspisokach5[i]) then

local _, chraName, _, completed, _, _, _, Description, _, chraImage = GetAchievementInfo(chraspisokach5[i])


--текст
local f = CreateFrame("Frame",nil,chramain6)
f:SetFrameStrata("DIALOG")
f:SetWidth(248)
f:SetHeight(24)
f:SetScript("OnEnter", function(self) Rawhershowtxt(self,Description) end )
f:SetScript("OnLeave", function(self) Rawhershowtxt2() end )
f:SetScript("OnMouseDown", function(self) if IsShiftKeyDown() then if ChatFrame1EditBox:GetText() and string.len(ChatFrame1EditBox:GetText())>0 then ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText().." "..GetAchievementLink(chraspisokach5[i])) else ChatFrame_OpenChat(GetAchievementLink(chraspisokach5[i])) end end end )

--картинка
local t = f:CreateTexture(nil,"OVERLAY")
t:SetTexture(chraImage)
t:SetWidth(24)
t:SetHeight(24)
t:SetPoint("TOPLEFT",0,0)

local t = f:CreateFontString()
t:SetFont(GameFontNormal:GetFont(), rafontsset[2])
t:SetWidth(248)
if completed then
t:SetText("|cff00ff00"..chraName.."|r")
else
--no more red
t:SetText(chraName)
end
t:SetJustifyH("LEFT")
t:SetPoint("LEFT",27,0)


f:SetPoint("TOPLEFT",l+45,-14-j*30)
f:Show()

end

--чекбатон
local c = CreateFrame("CheckButton", nil, chramain6, "UICheckButtonTemplate")
c:SetWidth("25")
c:SetHeight("25")
c:SetPoint("TOPLEFT", l+20, -14-j*30)
c:SetScript("OnClick", function(self) chragalka(i) end )
table.insert(chracbset, c)

end --for i
chranespamit=1
end --nespam

chragalochki()



end --конец бутон2

function Rawhershowtxt(self,i)
	GameTooltip:SetOwner(self or UIParent, "ANCHOR_TOP")
	GameTooltip:SetText(i)
end

function Rawhershowtxt2(i)
GameTooltip:Hide()
end


function chragalochki()
for i=1,#chraspisokach5 do
if chracbset[i] then
if(chraspisokon[i]==1)then chracbset[i]:SetChecked() else chracbset[i]:SetChecked(false) end
end
end
end

function chragalka(nomersmeni)
if chraspisokon[nomersmeni]==1 then chraspisokon[nomersmeni]=0 else chraspisokon[nomersmeni]=1 end
end

function chra_buttonchangeyn(yesno)
chraspislun= # chraspisokach5
for i=1,chraspislun do
chraspisokon[i]=yesno
end
chragalochki()
end

function chra_button1()
chraspislun= # chraspisokach5
for i=1,chraspislun do
if chraspisokon[i]==1 then chraspisokon[i]=0 else chraspisokon[i]=1 end
end
chragalochki()
end


function openmenureportchra()
if not DropDownMenureportchra then
CreateFrame("Frame", "DropDownMenureportchra", chramain6, "UIDropDownMenuTemplate")
end

DropDownMenureportchra:ClearAllPoints()
DropDownMenureportchra:SetPoint("BOTTOMLEFT", 5, 7)
DropDownMenureportchra:Show()

local items = lowmenuchatlistea

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownMenureportchra, self:GetID())

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

UIDropDownMenu_Initialize(DropDownMenureportchra, initialize)
UIDropDownMenu_SetWidth(DropDownMenureportchra, 90);
UIDropDownMenu_SetButtonWidth(DropDownMenureportchra, 105)
UIDropDownMenu_SetSelectedID(DropDownMenureportchra,bigma2num)
UIDropDownMenu_JustifyText(DropDownMenureportchra, "LEFT")
end