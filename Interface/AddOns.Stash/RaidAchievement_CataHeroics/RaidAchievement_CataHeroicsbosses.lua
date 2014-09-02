--общий для выполненого с 1 события
function chraachcompl(chranrach)
chraachdone1=nil
raplaysound(2,chraspisokach5[chranrach])
chrareportallok()
end


--выполн треб. для персонал. ачивки
function chramyfailgood(chranrach,nn)
chraachdone1=nil
raplaysound(2,chraspisokach5[chranrach])
if nn==1 then
out(achlinnk.." "..charakillintime)
elseif nn==2 then
if(wherereportpartyach=="sebe" or (GetNumGroupMembers()==0 and wherereportpartyach=="party"))then
out("- "..achlinnk.." "..charakillintime2)
else
razapuskanonsa(wherereportpartyach, "RA: {rt1} "..achlinnk.." "..charakillintime2)
end
end
end



--общий для фейлов с 1 удара
function chrafailnoreason(chranrach, prichina)
if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
chraachdone1=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end
raplaysound(1,chraspisokach5[chranrach])
chrareportfailnoreason(prichina)
end

--мой фейл
function chramyfail(chranrach)
local ratemp=""

if ramanyachon and raquantrepeatachtm==0 and raquantrepdone>2 then
ratemp=" #"..(raquantrepdone-1)
end

if ramanyachon and raquantrepeatachtm>0 and raquantrepdone>1 then
ratemp=" #"..raquantrepdone
end

if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
chraachdone1=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end
raplaysound(1,chraspisokach5[chranrach])
out(achlinnk.." |cffff0000"..pseatreb4.."|r"..ratemp)
end


function chrareportfailnoreason(prichina2)
local ratemp=""

if ramanyachon and raquantrepeatachtm==0 and raquantrepdone>2 then
ratemp=" #"..(raquantrepdone-1)
end

if ramanyachon and raquantrepeatachtm>0 and raquantrepdone>1 then
ratemp=" #"..raquantrepdone
end

	if prichina2==nil then
if(wherereportpartyach=="sebe" or (GetNumGroupMembers()==0 and wherereportpartyach=="party"))then
out("- "..achlinnk.." |cffff0000"..pseatreb4.."|r"..ratemp)
else
razapuskanonsa(wherereportpartyach, "RA: {rt8} "..achlinnk.." "..pseatreb4..ratemp)
end
	else
if(wherereportpartyach=="sebe" or (GetNumGroupMembers()==0 and wherereportpartyach=="party"))then
out("- "..achlinnk.." |cffff0000"..pseatreb4.."|r ("..prichina2..")."..ratemp)
else
	if pseashowfailreas==true then
razapuskanonsa(wherereportpartyach, "RA: {rt8} "..achlinnk.." "..pseatreb4.." ("..prichina2..")."..ratemp)
	else
razapuskanonsa(wherereportpartyach, "RA: {rt8} "..achlinnk.." "..pseatreb4..ratemp)
	end
end
	end

end

function chrareportallok()
if(wherereportpartyach=="sebe" or (GetNumGroupMembers()==0 and wherereportpartyach=="party"))then
out("- "..achlinnk.." "..pseatreb2)
else
razapuskanonsa(wherereportpartyach, "RA: {rt1} "..achlinnk.." "..pseatreb2)
end
end