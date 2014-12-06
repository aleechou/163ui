--общий для выполненого с 1 события
function wodhraachcompl(wodhranrach)
wodhraachdone1=nil
raplaysound(2,wodhraspisokach5[wodhranrach])
wodhrareportallok()
end


--выполн треб. для персонал. ачивки
function wodhramyfailgood(wodhranrach,nn)
wodhraachdone1=nil
raplaysound(2,wodhraspisokach5[wodhranrach])
end



--общий для фейлов с 1 удара
function wodhrafailnoreason(wodhranrach, prichina)
if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
wodhraachdone1=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end
raplaysound(1,wodhraspisokach5[wodhranrach])
wodhrareportfailnoreason(prichina)
end

--мой фейл
function wodhramyfail(wodhranrach)
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
wodhraachdone1=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end
raplaysound(1,wodhraspisokach5[wodhranrach])
out(achlinnk.." |cffff0000"..pseatreb4.."|r"..ratemp)
end


function wodhrareportfailnoreason(prichina2)
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

function wodhrareportallok()
if(wherereportpartyach=="sebe" or (GetNumGroupMembers()==0 and wherereportpartyach=="party"))then
out("- "..achlinnk.." "..pseatreb2)
else
razapuskanonsa(wherereportpartyach, "RA: {rt1} "..achlinnk.." "..pseatreb2)
end
end