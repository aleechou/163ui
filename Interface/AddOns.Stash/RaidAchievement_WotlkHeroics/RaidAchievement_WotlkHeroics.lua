raoldmodules=1
local _
function whraonload()

	whraachdone1=true
	whratime1=0
	whrabosson=0
	whrabossanet=0
	whramyname=UnitName("player")
	_, whraenglishclass = UnitClass("player")
	whrahuntertime=0

local _, a2 = GetInstanceInfo()
if select(3,GetInstanceInfo())==2 and a2=="party" then
	RaidAchievement_whra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_whra:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_whra:RegisterEvent("PLAYER_ALIVE")
end
	RaidAchievement_whra:RegisterEvent("PLAYER_REGEN_DISABLED")
	RaidAchievement_whra:RegisterEvent("PLAYER_REGEN_ENABLED")
	RaidAchievement_whra:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	RaidAchievement_whra:RegisterEvent("ADDON_LOADED")




whraspisokach5={
"2153",
"2038",
"2056",
"2157",
"1297",
"2058",
"2040",
"2152",
"2151",
"2039",
"2154",
"2155",
"2042",
"2037",
"2036",
"3804",
"4522",
"4523",
"4524",
"4525"
}



if (whraspisokon==nil) then
whraspisokon={}
end


end




function whraonevent(self,event,...)
local arg1, arg2, arg3,arg4,arg5,arg6 = ...

if event == "PLAYER_ALIVE" then
whrabilresnut=GetTime()
end


if event == "PLAYER_REGEN_DISABLED" then

if (whrabilresnut and GetTime()<whrabilresnut+4.5) or racheckbossincombat then
else
--обнулять все данные при начале боя тут:

--ханты 3.5 сек проверка
if whraenglishclass=="HUNTER" and GetTime()>whrahuntertime then

--ТОЛЬКО ДЛЯ ХАНТОВ

whraachdone1=true
whratime1=0
whrabosson=0

elseif whraenglishclass=="HUNTER" then else

--ТУТ ОБНУЛЯТЬ ВСЕ

whraachdone1=true
whratime1=0
whrabosson=0


end --хантер


end
end

if event == "PLAYER_REGEN_ENABLED" then

	whrahuntertime=GetTime()+3.5

end

if event == "ZONE_CHANGED_NEW_AREA" then

whrabossanet=0

local _, a2 = GetInstanceInfo()
if select(3,GetInstanceInfo())==2 and a2=="party" then
	RaidAchievement_whra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_whra:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_whra:RegisterEvent("PLAYER_ALIVE")
else
	RaidAchievement_whra:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_whra:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_whra:UnregisterEvent("PLAYER_ALIVE")
end

end


if event == "ADDON_LOADED" then
	if arg1=="RaidAchievement_WotlkHeroics" then
--whraspislun= #whraspisokach5
for i=1,#whraspisokach5 do
if whraspisokon[i]==nil or whraspisokon[i]=="" then whraspisokon[i]="yes" end
end
	end
end


if event == "CHAT_MSG_MONSTER_YELL" then

--бранн евент
if string.find(arg1, whrabrannemo)==nil then else
if arg2==whrabrann then
whrabossanet=1
end end

if string.find(arg1, whrabrannemo2)==nil then else
whrabossanet=0
end

--гундрак ласт
if string.find(arg1, whragundemo)==nil then else
whrabossanet=1
whratablegundrak=nil
end

end


if event == "COMBAT_LOG_EVENT_UNFILTERED" then

local arg1, arg2, argnew, arg3,arg4,arg5,argnew2,arg6,arg7,arg8,argnew3,arg9,arg10,arg11,arg12,arg13,arg14, arg15 = ...




--проверка на возможный выход с боя
if arg4==whramyname and arg2=="SPELL_AURA_REMOVED" and (arg9==58984 or arg9==66 or arg9==1856 or arg9==11327) then
whrabilresnut=GetTime()
end

if GetCurrentMapAreaID()==536 then
	if whraspisokon[1]=="yes" and whraachdone1 then
		if arg2=="SPELL_PERIODIC_DAMAGE" and arg13 and arg13>0 then
			local id=tonumber(string.sub(arg6,6,10),16)
			if id==29364 then
				whrafailnoreason(1,arg4)
			end
		end
		if arg2=="SPELL_DAMAGE" and arg13 and arg13>0 then
			local id=tonumber(string.sub(arg6,6,10),16)
			if id==29364 then
				whrafailnoreason(1,arg4)
			end
		end
		if arg2=="SWING_DAMAGE" and arg10 and arg10>0 then
			local id=tonumber(string.sub(arg6,6,10),16)
			if id==29364 then
				whrafailnoreason(1,arg4)
			end
		end
		if arg2=="RANGE_DAMAGE" and arg13 and arg13>0 then
			local id=tonumber(string.sub(arg6,6,10),16)
			if id==29364 then
				whrafailnoreason(1,arg4)
			end
		end

	end
end

if arg2=="UNIT_DIED" then

local id=tonumber(string.sub(arg6,6,10),16)

if id==30176 then
	if whraspisokon[2]=="yes" and whraachdone1 then
		whrafailnoreason(2)
	end
end

if id==30385 then
if whraspisokon[3]=="yes" and whraachdone1 then
whrafailnoreason(3)
end
end


if id==35451 then
if whraspisokon[16]=="yes" and whraachdone1 then
whratime1=whratime1+1
if whratime1>2 then
whraachdone1=nil
whrabilresnut=GetTime()
end
end
end


if id==29364 then
if whraspisokon[1]=="yes" and whraachdone1 then
whrafailnoreason(1)
end
end


if id==27483 or id==27978 then
whrabosson=0
whratime1=0
whrabossanet=1
whraachdone1=nil
end


if id==26628 or id==26641 then
if whraspisokon[10]=="yes" and whraachdone1 and whrabosson==1 and whrabossanet==0 then
whratime1=whratime1+1
if whratime1>5 then
whratime1=0
whraachcompl(10)
end
end
end

if id==28165 then
if whraspisokon[12]=="yes" and whraachdone1 and whrabosson==1 and whrabossanet==0 then
whratime1=whratime1+1
if whratime1>4 then
whratime1=0
whraachcompl(12)
end
end
end

if id==26918 then
if whraspisokon[14]=="yes" and whraachdone1 and whrabosson==1 then
whrafailnoreason(14)
end
end

if id==36535 then
	if whrabosson==0 then
		whratime1=whratime1-1
		if whratime1==3 then
			raplaysound(1,whraspisokach5[17])
			if(wherereportpartyach=="sebe" or (GetNumGroupMembers()==0 and wherereportpartyach=="party"))then
				DEFAULT_CHAT_FRAME:AddMessage("- "..whraaddkilled1.." "..achlinnk.." "..whraaddkilled2)
			else
				razapuskanonsa(wherereportpartyach, "RA: {rt8} "..whraaddkilled1.." "..achlinnk.." "..whraaddkilled2)
			end
		end
	end
end


if id==36497 then
whrabosson=1
end

end


if whraachdone1 and rabattlev==1 and arg6 then
local id=tonumber(string.sub(arg6,6,10),16)
if id==27483 or id==27978 then
if arg9==1130 then else
whrabosson=1
end
end
end



if (arg2=="SPELL_DAMAGE" or (arg2=="SPELL_MISSED" and arg12 and (arg12=="ABSORB" or arg12=="RESIST"))) and (arg9==48295 or arg9==59302) then
if whraspisokon[4]=="yes" and whraachdone1 then
whrafailnoreason(4, arg7)
end
end

if arg2=="SPELL_CAST_SUCCESS" and arg9==53177 then
if whraspisokon[5]=="yes" and whraachdone1 then
whrafailnoreason(5)
end
end

if arg2=="SPELL_SUMMON" and arg9==55126 then
if whraspisokon[6]=="yes" and whraachdone1 then
whrafailnoreason(6, arg4)
end
end

if arg2=="SPELL_AURA_APPLIED" and arg9==55098 then
if whraspisokon[7]=="yes" and whraachdone1 then
whrafailnoreason(7)
end
end

if arg2=="SPELL_AURA_APPLIED" and arg9==59827 then
	if whraspisokon[8]=="yes" and whrabossanet==1 then
	if (whratablegundrak==nil or whratablegundrak=={}) then whratablegundrak = {} end

		local bililine=0
		for i,getcrash in ipairs(whratablegundrak) do 
			if getcrash == arg7 then bililine=1
			end
		end
		if(bililine==0)then
			table.insert(whratablegundrak,arg7) 
		end

		local whradlinatabl= # whratablegundrak
		if (whradlinatabl>4) then
			whrabossanet=0
			whraachcompl(8)
		end

	end
end

if arg2=="SPELL_AURA_APPLIED_DOSE" and arg9==59805 then
if whraspisokon[9]=="yes" and whraachdone1 then
if arg13>9 then
whrafailnoreason(9)
end
end
end




if (arg2=="SPELL_DAMAGE" or arg2=="SWING_DAMAGE") and arg7 and arg7==whrabrann then
if whraspisokon[11]=="yes" and whrabossanet==1 then
whrabossanet=0
whrafailnoreason(11)
end
end


if arg2=="SPELL_CAST_START" and arg9==52238 then
if whraspisokon[13]=="yes" and whraachdone1 then
whratime1=whratime1+1
if whratime1>2 then
whrafailnoreason(13)
end
end
end

if arg2=="SPELL_SUMMON" and arg9==47743 then
if whraspisokon[14]=="yes" and whraachdone1 then
whrabosson=1
end
end




if arg2=="SPELL_AURA_APPLIED_DOSE" and arg9==48095 and arg13>2 then
if whraspisokon[15]=="yes" and whraachdone1 then
local _, _, _, whramyach = GetAchievementInfo(2036)
if arg7==whramyname then
if (whramyach) then else
whramyfail(15)
end
end
end
end


if (arg2=="SPELL_DAMAGE" or (arg2=="SPELL_MISSED" and arg12 and (arg12=="ABSORB" or arg12=="RESIST"))) and arg9==67886 then
if whraspisokon[16]=="yes" and whraachdone1 then
whrafailnoreason(16, arg7)
end
end

if whraspisokon[17]=="yes" then
	if arg2=="SPELL_SUMMON" and arg9==68846 then
		whratime1=whratime1+1
		if whratime1==4 then
			whraachcompl(17)
		end
	end
end


if (arg2=="SPELL_DAMAGE" or (arg2=="SPELL_MISSED" and arg12 and (arg12=="ABSORB" or arg12=="RESIST"))) and arg9==70322 then
if whraspisokon[18]=="yes" and whraachdone1 then
whrafailnoreason(18)
end
end

if arg2=="SPELL_AURA_APPLIED_DOSE" and arg9==70336 and arg13>10 then
if whraspisokon[19]=="yes" and whraachdone1 then
--fails from pets too, if change - use NEW check raunitisplayer(id,name)
--if UnitInParty(arg7) then
whrafailnoreason(19, arg7)
--end
end
end


if (arg2=="SPELL_DAMAGE" or (arg2=="SPELL_MISSED" and arg12 and (arg12=="ABSORB" or arg12=="RESIST"))) and arg9==70827 then
if whraspisokon[20]=="yes" and whraachfirsttry==nil then
--local niknoserv=arg7
--if string.find(niknoserv, "%-") then
--niknoserv=string.sub(niknoserv,1,string.find(niknoserv, "%-")-1)
--end
raunitisplayer(arg6,arg7)
if raunitplayertrue then
whraachfirsttry=1
whrafailnoreason(20, arg7)
end
end
end


end
end --КОНЕЦ ОНЕВЕНТ

function whra_closeallpr()
whramain6:Hide()
end


function whra_button2()
PSFea_closeallpr()
whramain6:Show()
openmenureportwhra()



if (whranespamit==nil) then

whraspislun= # whraspisokach5
whracbset={}
for i=1,whraspislun do
local _, whraName, _, completed, _, _, _, Description, _, whraImage = GetAchievementInfo(whraspisokach5[i])


if i>14 then
l=280
j=i-14
else
l=0
j=i
end


--текст
local f = CreateFrame("Frame",nil,whramain6)
f:SetFrameStrata("DIALOG")
f:SetWidth(248)
f:SetHeight(24)
f:SetScript("OnEnter", function(self) Rawhershowtxt(self,Description) end )
f:SetScript("OnLeave", function(self) Rawhershowtxt2() end )
f:SetScript("OnMouseDown", function(self) if IsShiftKeyDown() then if ChatFrame1EditBox:GetText() and string.len(ChatFrame1EditBox:GetText())>0 then ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText().." "..GetAchievementLink(whraspisokach5[i])) else ChatFrame_OpenChat(GetAchievementLink(whraspisokach5[i])) end end end )

--картинка
local t = f:CreateTexture(nil,"OVERLAY")
t:SetTexture(whraImage)
t:SetWidth(24)
t:SetHeight(24)
t:SetPoint("TOPLEFT",0,0)

local t = f:CreateFontString()
t:SetFont(GameFontNormal:GetFont(), rafontsset[2])
if completed then
t:SetText("|cff00ff00"..whraName.."|r")
else
t:SetText(whraName)
end
t:SetWidth(248)
t:SetJustifyH("LEFT")
t:SetPoint("LEFT",27,0)


f:SetPoint("TOPLEFT",l+45,-14-j*30)
f:Show()

--чекбатон
local c = CreateFrame("CheckButton", nil, whramain6, "UICheckButtonTemplate")
c:SetWidth("25")
c:SetHeight("25")
c:SetPoint("TOPLEFT", l+20, -14-j*30)
c:SetScript("OnClick", function(self) whragalka(i) end )
table.insert(whracbset, c)

end --for i
whranespamit=1
end --nespam

whragalochki()



end --конец бутон2

function Rawhershowtxt(self,i)
	GameTooltip:SetOwner(self or UIParent, "ANCHOR_TOP")
	GameTooltip:SetText(i)
end

function Rawhershowtxt2(i)
GameTooltip:Hide()
end


function whragalochki()
for i=1,#whraspisokach5 do
if(whraspisokon[i]=="yes")then whracbset[i]:SetChecked() else whracbset[i]:SetChecked(false) end
end
end

function whragalka(nomersmeni)
if whraspisokon[nomersmeni]=="yes" then whraspisokon[nomersmeni]="no" else whraspisokon[nomersmeni]="yes" end
end

function whra_buttonchangeyn(yesno)
whraspislun= # whraspisokach5
for i=1,whraspislun do
whraspisokon[i]=yesno
end
whragalochki()
end

function whra_button1()
whraspislun= # whraspisokach5
for i=1,whraspislun do
if whraspisokon[i]=="yes" then whraspisokon[i]="no" else whraspisokon[i]="yes" end
end
whragalochki()
end


function openmenureportwhra()
if not DropDownMenureportwhra then
CreateFrame("Frame", "DropDownMenureportwhra", whramain6, "UIDropDownMenuTemplate")
end

DropDownMenureportwhra:ClearAllPoints()
DropDownMenureportwhra:SetPoint("BOTTOMLEFT", 5, 7)
DropDownMenureportwhra:Show()

local items = lowmenuchatlistea

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownMenureportwhra, self:GetID())

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

UIDropDownMenu_Initialize(DropDownMenureportwhra, initialize)
UIDropDownMenu_SetWidth(DropDownMenureportwhra, 90);
UIDropDownMenu_SetButtonWidth(DropDownMenureportwhra, 105)
UIDropDownMenu_SetSelectedID(DropDownMenureportwhra,bigma2num)
UIDropDownMenu_JustifyText(DropDownMenureportwhra, "LEFT")
end