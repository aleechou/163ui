raoldmodules=1
function psfeaUlduar()

	pseahodirlook=false
SetMapToCurrentZone()
if GetCurrentMapAreaID()==529 then
	RaidAchievement_Ulduar:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end
	RaidAchievement_Ulduar:RegisterEvent("PLAYER_REGEN_DISABLED")
	RaidAchievement_Ulduar:RegisterEvent("ADDON_LOADED")
	RaidAchievement_Ulduar:RegisterEvent("ZONE_CHANGED_NEW_AREA")




pseaspisokach25={
"2926",
"2921",
"2932",
"2948",
"2956",
"3007",
"3077",
"2968",
"2962",
"2965",
"2972",
"3237",
"2997",
"3010",
"2912",
}
pseaspisokach10={
"2925",
"2919",
"2931",
"2947",
"2955",
"3006",
"3076",
"2967",
"2961",
"2963",
"2971",
"2989",
"2996",
"3008",
"2911",
}


if (preaspisokon==nil) then
preaspisokon={}
end


end


function PSFea_OnUpdate(elapsedps)

local pseaCurrentTimepull = GetTime()

	if (pseaDelayTimepull == nil)then
		pseaDelayTimepull = GetTime()+0.5
	end


if (pseahodirlook)then
if (pseaCurrentTimepull >= pseaDelayTimepull) then
pseaDelayTimepull = pseaCurrentTimepull+0.15

--ходир по таймеру чекаем

if (pseaspellname1 and thisraidtableea) then

local i=1

while i<=#thisraidtableea do

local _, _, _, stack = UnitDebuff(thisraidtableea[i], pseaspellname1)
if stack==nil then else
if stack>2 then
pseafailnoreason(8, thisraidtableea[i],1)
if ramanyachon and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
pseahodirlook=false
end
i=90
end
end
i=i+1

end --конец таблицы
end --nil


end
end --pseahodirlook


end




function psfeaUlduaronevent(self,event,...)
local arg1, arg2, arg3,arg4,arg5,arg6 = ...

if event == "ADDON_LOADED" then
	if arg1=="RaidAchievement_Ulduar" then
for i=1,#pseaspisokach25 do
if preaspisokon[i]==nil or preaspisokon[i]=="" then preaspisokon[i]="yes" end
end
	end
end


if event == "PLAYER_REGEN_DISABLED" then
if (rabilresnut and GetTime()<rabilresnut+3) or racheckbossincombat then

else
--обнулять все данные при начале боя тут:


pseahodirlook=false
ratimedefenderlastkill=nil
rallonlyannouncs1=nil


end
end

if event == "ZONE_CHANGED_NEW_AREA" then

pseahodirlook=false
SetMapToCurrentZone()
if GetCurrentMapAreaID()==529 then
RaidAchievement_Ulduar:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
else
RaidAchievement_Ulduar:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

end




if event == "COMBAT_LOG_EVENT_UNFILTERED" then

local arg1, arg2, argnew, arg3,arg4,arg5,argnew2,arg6,arg7,arg8,argnew3,arg9,arg10,arg11,arg12,arg13,arg14, arg15,arg16,arg17,arg18,arg19,arg20 = ...


if arg2=="SPELL_AURA_APPLIED" and arg9==62383 then
if preaspisokon[1]=="yes" and raachdone1 then
pseaignis1(arg1)
end
end

if arg2=="SPELL_CAST_START" and arg9==62666 then
if preaspisokon[2]=="yes" and raachdone1 then
psearazor1()
end
end

if arg2=="SPELL_HEAL" and arg9==62832 then
if preaspisokon[3]=="yes" and raachdone1 then
pseafailnoreason(3)
end
end

if ((arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and (arg9==61916 or arg9==63482 or arg9==61879 or arg9==63479)) then
if preaspisokon[4]=="yes" and raachdone1 then
pseafailnoreason(4)
rabilresnut=GetTime()
end
end


if (arg2=="SPELL_DAMAGE" or (arg2=="SPELL_MISSED" and arg12 and (arg12=="ABSORB" or arg12=="RESIST"))) and (arg9==63346 or arg9==63976) then
if preaspisokon[5]=="yes" and raachdone1 then
pseafailnoreason(5, arg7)
end
end

if arg2=="UNIT_DIED" then
local id=raGetUnitID(arg6)

if id==34014 then
if preaspisokon[6]=="yes" and raachdone1 then
pseafailnoreason(6)
end
end

if preaspisokon[10]=="yes" and raachdone3 then
local pseahodiraddsid={33330,33325,32901,33328,32893,32900,33327,32897,33326,32941,33333,33332,32950,33331,32946,32948}
for i,whodead in ipairs(pseahodiraddsid) do
if whodead == id then
pseafailnoreason3(10)
end
end
end

end

if arg2=="SPELL_AURA_REMOVED" and arg9==64455 then
if preaspisokon[7]=="yes" and raachdone2 then
--pseaachcompl(7)
raachdone2=nil

if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
raplaysound(3,pseaspisokach10[7])
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
raplaysound(3,pseaspisokach25[7])
end

ratimedefenderlastkill=GetTime()

if (wherereportraidach=="sebe") then
	DEFAULT_CHAT_FRAME:AddMessage("- "..achlinnk.." "..pseatrebulda2)
else
	if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportraidach=="raid_warning" then
	razapuskanonsa("raid", "{rt1} "..achlinnk.." "..pseatrebulda2)
	else
	razapuskanonsa(wherereportraidach, "{rt1} "..achlinnk.." "..pseatrebulda2)
	end
end

end
end


if arg2=="UNIT_DIED" and ratimedefenderlastkill then
	local id=raGetUnitID(arg6)
	if id==34035 and GetTime()>ratimedefenderlastkill+3 and GetTime()<ratimedefenderlastkill+200 and rallonlyannouncs1==nil then
    rallonlyannouncs1=1
		pseaachcompl(7)
	end
end


if preaspisokon[8]=="yes" and raachdone1 then
if arg2=="SPELL_CAST_SUCCESS" and (arg9==62038 or arg9==62039) then
thisraidtableea = {}
for i = 1,GetNumGroupMembers() do local name,subgroup = GetRaidRosterInfo(i) if subgroup <= 5 then table.insert(thisraidtableea,(GetRaidRosterInfo(i))) end end
pseahodirlook=true
if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
pseaspellname1 = GetSpellInfo(62038)
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
pseaspellname1 = GetSpellInfo(62039)
end
end
if arg2=="SPELL_DAMAGE" and arg9==62188 then
pseahodirlook=true
raachdone1=nil
if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
pseaspellname1 = GetSpellInfo(62038)
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
pseaspellname1 = GetSpellInfo(62039)
end
end
end

if arg2=="SPELL_AURA_APPLIED" and (arg9==61990 or arg9==61969) then
if preaspisokon[9]=="yes" and raachdone2 then
raunitisplayer(arg6,arg7)
if raunitplayertrue then
pseafailnoreason2(9, arg7)
end
end
end

if (arg2=="SPELL_DAMAGE" or (arg2=="SPELL_MISSED" and arg12 and (arg12=="ABSORB" or arg12=="RESIST"))) and arg9==62466 then
if preaspisokon[11]=="yes" and raachdone1 then
raunitisplayer(arg6,arg7)
if raunitplayertrue then
pseafailnoreason(11, arg7)
end
end
end

if (arg2=="SPELL_DAMAGE" or (arg2=="SPELL_MISSED" and arg12 and (arg12=="ABSORB" or arg12=="RESIST"))) and arg9==63801 then
local id=raGetUnitID(arg3)
if id==33836 then
if preaspisokon[12]=="yes" and raachdone1 then
raunitisplayer(arg6,arg7)
if raunitplayertrue then
pseafailmimiron1(arg7)
end
end
end
end


if (arg2=="SPELL_DAMAGE" or (arg2=="SPELL_MISSED" and arg12 and (arg12=="ABSORB" or arg12=="RESIST"))) and (arg9==63041 or arg9==63036 or arg9==64064 or arg9==64402) then
if preaspisokon[12]=="yes" and raachdone2 then
raunitisplayer(arg6,arg7)
if raunitplayertrue then
pseafailmimiron2(arg7)
end
end
end


if (arg2=="SPELL_DAMAGE" or (arg2=="SPELL_MISSED" and arg12 and (arg12=="ABSORB" or arg12=="RESIST"))) and (arg9==63009 or arg9==66351) then
if preaspisokon[12]=="yes" and raachdone3 then
raunitisplayer(arg6,arg7)
if raunitplayertrue then
pseafailmimiron3(arg7)
end
end
end

if (arg2=="SPELL_DAMAGE" or (arg2=="SPELL_MISSED" and arg12 and (arg12=="ABSORB" or arg12=="RESIST"))) and arg9==62659 then
if preaspisokon[13]=="yes" and raachdone1 then
raunitisplayer(arg6,arg7)
if raunitplayertrue then
pseafailnoreason(13, arg7)
end
end
end

if arg2=="SPELL_AURA_APPLIED" and arg9==63120 then
if preaspisokon[14]=="yes" and raachdone1 then
raunitisplayer(arg6,arg7)
if raunitplayertrue then
pseafailnoreason(14, arg7)
end
end
end

if arg9==62475 then
if preaspisokon[15]=="yes" and raachdone1 then
pseafailnoreason(15)
end
end





end --ульды
end --КОНЕЦ ОНЕВЕНТ

function PSFea_closeallprUlduar()
PSFeamain7:Hide()
end


function PSFea_buttonulda2()
PSFea_closeallpr()
PSFeamain7:Show()
openmenureportra()



if (pseanespamit==nil) then

pseaspislun= # pseaspisokach25
ulracbset={}
for i=1,pseaspislun do
local _, pseaName, _, completed, _, _, _, Description, _, pseaImage = GetAchievementInfo(pseaspisokach25[i])
local _, _, _, completed2 = GetAchievementInfo(pseaspisokach10[i])

pseawheresk=string.find(pseaName, "25")
if pseawheresk==nil then
  pseawheresk=string.find(pseaName, "10")
end
if pseawheresk then
  local a=0
  a=string.find(pseaName," %(")
  if a==nil then
    a=string.find(pseaName,"%(")
  end
  if a==nil then
    a=string.find(pseaName,"%（")
  end
  if a==nil then
    a=string.find(pseaName,"（")
  end
  local b=0
  if a then
    b=string.find(pseaName,"%(",a+3)
    if b==nil then
      b=string.find(pseaName,"%（",a+3)
    end
    if b and b~=0 then
      a=b
    end
  end
  if a and a~=0 then
    pseaName=string.sub(pseaName, 1, a-1)
  end
end


if completed and completed2 then
pseaName="|cff00ff00"..pseaName.."|r"
elseif completed==false and completed2==false then
--no more red
else
	if completed2 then
		pseaName=pseaName.." |cff00ff00(10)|r"
	else
		pseaName=pseaName.." (10)"
	end
	if completed then
		pseaName=pseaName.." |cff00ff00(25)|r"
	else
		pseaName=pseaName.." (25)"
	end
end

if i>14 then
l=280
j=i-14
else
l=0
j=i
end


--текст
local f = CreateFrame("Frame",nil,PSFeamain7)
f:SetFrameStrata("DIALOG")
f:SetWidth(248)
f:SetHeight(24)

if i==12 then
local aaa1=0
if GetAchievementNumCriteria(pseaspisokach10[i])>1 then
local maxcrit=GetAchievementNumCriteria(pseaspisokach10[i])
for q=1,maxcrit do
	local a1,_,a3=GetAchievementCriteriaInfo(pseaspisokach10[i],q)
	local a2,_,a4=GetAchievementCriteriaInfo(pseaspisokach25[i],q)
	if a1==nil or a2==nil then
		q=11
	else
		if aaa1==0 then
			aaa1=1
			--Description=Description.."\n10 / 25"
		end
		if a3 then
			Description=Description.."\n|cff00ff00"..a1.." (10)|r /"
		else
			Description=Description.."\n"..a1.." (10) /"
		end
		if a4 then
			Description=Description.." |cff00ff00"..a2.." (25)|r"
		else
			Description=Description.." "..a2.." (25)"
		end
	end
end
end
end

f:SetScript("OnEnter", function(self) Raulshowtxt(self,Description) end )
f:SetScript("OnLeave", function(self) Raulshowtxt2() end )
f:SetScript("OnMouseDown", function(self) if IsShiftKeyDown() then if ChatFrame1EditBox:GetText() and string.len(ChatFrame1EditBox:GetText())>0 then ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText().." "..GetAchievementLink(pseaspisokach10[i]).." "..GetAchievementLink(pseaspisokach25[i])) else ChatFrame_OpenChat(GetAchievementLink(pseaspisokach10[i]).." "..GetAchievementLink(pseaspisokach25[i])) end end end )

--картинка
local t = f:CreateTexture(nil,"OVERLAY")
t:SetTexture(pseaImage)
t:SetWidth(24)
t:SetHeight(24)
t:SetPoint("TOPLEFT",0,0)

local t = f:CreateFontString(Name)
t:SetFont(GameFontNormal:GetFont(), rafontsset[2])
t:SetWidth(248)
t:SetText(pseaName)
t:SetJustifyH("LEFT")
t:SetPoint("LEFT",27,0)

f:SetPoint("TOPLEFT",l+45,-14-j*30)
f:Show()

--чекбатон
local c = CreateFrame("CheckButton", nil, PSFeamain7, "UICheckButtonTemplate")
c:SetWidth("25")
c:SetHeight("25")
c:SetPoint("TOPLEFT", l+20, -14-j*30)
c:SetScript("OnClick", function(self) PSFeauldagalka(i) end )
table.insert(ulracbset, c)

pseawheresk=nil

end --for i
pseanespamit=1
end --nespam


pseauldagalochki()




end --конец бутоннульда2

function Raulshowtxt(self,i)
	GameTooltip:SetOwner(self or UIParent, "ANCHOR_TOP")
	GameTooltip:SetText(i)
end

function Raulshowtxt2(i)
GameTooltip:Hide()
end

function pseauldagalochki()
for i=1,#pseaspisokach25 do
if(preaspisokon[i]=="yes")then ulracbset[i]:SetChecked(true) else ulracbset[i]:SetChecked(false) end
end
end

function PSFeauldagalka(nomersmeni)
if preaspisokon[nomersmeni]=="yes" then preaspisokon[nomersmeni]="no" else preaspisokon[nomersmeni]="yes" end
end

function PSFea_buttonuldachangeyn(yesno)
pseaspislun= # pseaspisokach25
for i=1,pseaspislun do
preaspisokon[i]=yesno
end
pseauldagalochki()
end

function PSFea_buttonulda1()
pseaspislun= # pseaspisokach25
for i=1,pseaspislun do
if preaspisokon[i]=="yes" then preaspisokon[i]="no" else preaspisokon[i]="yes" end
end
pseauldagalochki()
end


function openmenureportra()
if not DropDownMenureportra then
CreateFrame("Frame", "DropDownMenureportra", PSFeamain7, "UIDropDownMenuTemplate")
end
rachatdropm(DropDownMenureportra,5,7)
end