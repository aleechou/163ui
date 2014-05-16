function pseaignis1(arg1)
if pseatime1==0 then pseatime1=arg1 else
psearex1=arg1-ratime1
if psearex1<4.8 then

if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
raplaysound(2,pseaspisokach10[1])
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
raplaysound(2,pseaspisokach25[1])
end

pseareportallok()
raachdone1=nil
else
ratime1=arg1
end

end
end

function psearazor1()
ratime1=ratime1+1
if ratime1>2 then
raachdone1=nil

if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
raplaysound(1,pseaspisokach10[2])
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
raplaysound(1,pseaspisokach25[2])
end

pseareportfailnoreason()
end
end


--общий для выполненого с 1 события
function pseaachcompl(pseanrach)
raachdone2=nil

if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
raplaysound(2,pseaspisokach10[pseanrach])
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
raplaysound(2,pseaspisokach25[pseanrach])
end

pseareportallok()
end



--общий для фейлов с 1 удара
function pseafailnoreason(pseanrach, prichina,norezet)
if norezet==nil then
if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
raachdone1=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end
end
if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
raplaysound(1,pseaspisokach10[pseanrach])
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
raplaysound(1,pseaspisokach25[pseanrach])
end

pseareportfailnoreason(prichina)
end

--общий для фейлов с 1 удара но откл 2 ачив лист
function pseafailnoreason2(pseanrach, prichina)
if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
raachdone2=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end

if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
raplaysound(1,pseaspisokach10[pseanrach])
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
raplaysound(1,pseaspisokach25[pseanrach])
end

pseareportfailnoreason(prichina)
end

--общий для фейлов с 1 удара но откл 3 ачив лист
function pseafailnoreason3(pseanrach, prichina)
if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
raachdone3=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end

if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
raplaysound(1,pseaspisokach10[pseanrach])
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
raplaysound(1,pseaspisokach25[pseanrach])
end

pseareportfailnoreason(prichina)
end


function pseafailmimiron1(ktofail)
if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
raachdone1=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end

if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
raplaysound(1,pseaspisokach10[12],3)
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
raplaysound(1,pseaspisokach25[12],3)
end

pseareportfailmimi(pseamimifailloc1, ktofail)
end

function pseafailmimiron2(ktofail)
if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
raachdone2=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end
if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
raplaysound(1,pseaspisokach10[12],2)
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
raplaysound(1,pseaspisokach25[12],2)
end

pseareportfailmimi(pseamimifailloc2, ktofail)
end

function pseafailmimiron3(ktofail)
if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
raachdone3=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end
if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
raplaysound(1,pseaspisokach10[12],1)
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
raplaysound(1,pseaspisokach25[12],1)
end

pseareportfailmimi(pseamimifailloc3, ktofail)
end

function pseareportfailmimi(pseaotdamag, ktofail2)
local ratemp=""

if ramanyachon and raquantrepeatachtm==0 and raquantrepdone>2 then
ratemp=" #"..(raquantrepdone-1)
end

if ramanyachon and raquantrepeatachtm>0 and raquantrepdone>1 then
ratemp=" #"..raquantrepdone
end

if (wherereportraidach=="sebe") then
out("- "..pseaotdamag.." "..achlinnk.." "..pseamimifailloc5.." ("..ktofail2..")."..ratemp)
else
	if pseashowfailreas==true then
if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportraidach=="raid_warning" then
razapuskanonsa("raid", "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseamimifailloc5.." ("..ktofail2..")."..ratemp)
else
razapuskanonsa(wherereportraidach, "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseamimifailloc5.." ("..ktofail2..")."..ratemp)
end
	else
if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportraidach=="raid_warning" then
razapuskanonsa("raid", "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseamimifailloc5..ratemp)
else
razapuskanonsa(wherereportraidach, "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseamimifailloc5..ratemp)
end
	end
end
end