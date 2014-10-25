--личный фейл
function nxramyfail(nxranrach)
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
raachdone1=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end

if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
raplaysound(1,nxraspisokach10[nxranrach])
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
raplaysound(1,nxraspisokach25[nxranrach])
end

out(achlinnk.." |cffff0000"..pseatreb4.."|r"..ratemp)
end


--общий для выполненого с 1 события
function nxraachcompl(nxranrach)
raachdone1=nil

if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
raplaysound(2,nxraspisokach10[nxranrach])
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
raplaysound(2,nxraspisokach25[nxranrach])
end

pseareportallok()
end

--общий для фейлов с 1 удара
function nxrafailnoreason(nxranrach, prichina)
if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
raachdone1=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end
if select(3,GetInstanceInfo())==3 or select(3,GetInstanceInfo())==5 then
raplaysound(1,nxraspisokach10[nxranrach])
end
if select(3,GetInstanceInfo())==4 or select(3,GetInstanceInfo())==6 then
raplaysound(1,nxraspisokach25[nxranrach])
end

pseareportfailnoreason(prichina)
end