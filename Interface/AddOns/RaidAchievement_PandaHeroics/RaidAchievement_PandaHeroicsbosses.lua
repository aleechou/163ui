﻿--общий для выполненого с 1 события
function phraachcompl(phranrach)
phraachdone1=nil
raplaysound(2,phraspisokach5[phranrach])
phrareportallok()
end


--выполн треб. для персонал. ачивки
function phramyfailgood(phranrach,nn)
phraachdone1=nil
raplaysound(2,phraspisokach5[phranrach])
end



--общий для фейлов с 1 удара
function phrafailnoreason(phranrach, prichina)
if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
phraachdone1=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end
raplaysound(1,phraspisokach5[phranrach])
phrareportfailnoreason(prichina)
end

--мой фейл
function phramyfail(phranrach)
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
phraachdone1=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end
raplaysound(1,phraspisokach5[phranrach])
out(achlinnk.." |cffff0000"..pseatreb4.."|r"..ratemp)
end


function phrareportfailnoreason(prichina2)
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

function phrareportallok()
if(wherereportpartyach=="sebe" or (GetNumGroupMembers()==0 and wherereportpartyach=="party"))then
out("- "..achlinnk.." "..pseatreb2)
else
razapuskanonsa(wherereportpartyach, "RA: {rt1} "..achlinnk.." "..pseatreb2)
end
end