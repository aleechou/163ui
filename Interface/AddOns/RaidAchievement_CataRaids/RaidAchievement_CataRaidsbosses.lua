--общий для фейлов с 1 удара
function crrafailnoreason(crranrach, prichina, quant,failsecond)
if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
	if failsecond then
		raachdone2=false
	else
		raachdone1=false
	end
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end
raplaysound(1,crraspisokach25[crranrach])
pseareportfailnoreason(prichina, quant)
end


--общий для выполненого с 1 события
function crraachcompl(icranrach)
raachdone1=nil
raplaysound(2,crraspisokach25[icranrach])
pseareportallok()
end


function crratronpartfail(arg6,ktofail,lnn,lwhat)
raunitisplayer(arg6,ktofail)
if raunitplayertrue then

	if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
		raquantrepdone=raquantrepdone+1
	else
		if lnn==1 then
			raachdone1=false
		end
		if lnn==2 then
			raachdone2=false
		end
		if lnn==3 then
			raachdone3=false
		end
		if lnn==4 then
			raachdone4=false
			ktofail="debuff - "..rallatrontemp2..", dmg - "..ktofail
			rallatrontemp1=nil
			rallatrontemp2=nil --имя на ком дебаф
		end
		if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
			raquantrepdone=raquantrepdone+1
		end
	end
	raplaysound(1,crraspisokach25[2],lnn)
	crrareportfailatron(lwhat, ktofail)
end
end


function crrareportfailatron(pseaotdamag, ktofail2)
local ratemp=""

if ramanyachon and raquantrepeatachtm==0 and raquantrepdone>2 then
ratemp=" #"..(raquantrepdone-1)
end

if ramanyachon and raquantrepeatachtm>0 and raquantrepdone>1 then
ratemp=" #"..raquantrepdone
end

if (wherereportraidach=="sebe") then
out("- "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc.." ("..ktofail2..")."..ratemp)
else
	if pseashowfailreas==true then
if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportraidach=="raid_warning" then
razapuskanonsa("raid", "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc.." ("..ktofail2..")."..ratemp)
else
razapuskanonsa(wherereportraidach, "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc.." ("..ktofail2..")."..ratemp)
end
	else
if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportraidach=="raid_warning" then
razapuskanonsa("raid", "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc..ratemp)
else
razapuskanonsa(wherereportraidach, "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc..ratemp)
end
	end
end
end



--alysrazor
function crraalypartfail(arg6,ktofail,lnn,lwhat)
raunitisplayer(arg6,ktofail)
if raunitplayertrue then

	if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
		raquantrepdone=raquantrepdone+1
	else
		if lnn==1 then
			raachdone1=false
		end
		if lnn==2 then
			raachdone2=false
		end
		if lnn==3 then
			raachdone3=false
		end
		if lnn==4 then
			raachdone4=false
		end
		if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
			raquantrepdone=raquantrepdone+1
		end
	end
	raplaysound(1,crraspisokach25[7],lnn)
	crrareportfailaly(lwhat, ktofail)
end
end


function crrareportfailaly(pseaotdamag, ktofail2)
local ratemp=""

if ramanyachon and raquantrepeatachtm==0 and raquantrepdone>2 then
ratemp=" #"..(raquantrepdone-1)
end

if ramanyachon and raquantrepeatachtm>0 and raquantrepdone>1 then
ratemp=" #"..raquantrepdone
end

if (wherereportraidach=="sebe") then
out("- "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc.." ("..ktofail2..")."..ratemp)
else
	if pseashowfailreas==true then
if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportraidach=="raid_warning" then
razapuskanonsa("raid", "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc.." ("..ktofail2..")."..ratemp)
else
razapuskanonsa(wherereportraidach, "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc.." ("..ktofail2..")."..ratemp)
end
	else
if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportraidach=="raid_warning" then
razapuskanonsa("raid", "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc..ratemp)
else
razapuskanonsa(wherereportraidach, "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc..ratemp)
end
	end
end
end


function raragnatimeron (pstext, pstime)
local sender22=UnitName("player")

--DBM
if(DBM)then
		DBM:CreatePizzaTimer(pstime, pstext, sender22)

else
		SendAddonMessage("D4", ("%s\t%s\t%s"):format("U",pstime, pstext), "RAID")
end

--BIGWIGS
SendAddonMessage("BigWigs", "T:BWCustomBar "..pstime.." "..pstext, "RAID")


--DXE
SendAddonMessage("DXE", "^1^SAlertsRaidBar^N"..pstime.."^S~`"..pstext.."^^", "RAID")

if IsAddOnLoaded("DXE") then
	SlashCmdList.DXEALERTLOCALBAR(pstime.." "..pstext)
end


--RW2
SendAddonMessage("RW2","^1^SStartCommBar^F"..(math.random()*10).."^f-53^N"..pstime.."^S"..pstext.."^^", "RAID")

end