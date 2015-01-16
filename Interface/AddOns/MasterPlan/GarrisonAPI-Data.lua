local _, T = ...
if T.Mark ~= 23 then return end

local lhc = {} do
	local ht, hp = UnitFactionGroup("player") ~= "Horde" and [[6Áäñ©mûÂñMyÙ;ï“ğlšyÿÿtİó³ÿûg?ÊŸû2|ÿÉ3Ÿäü™BMŸ?Îzó‘>Ö7äû¾æ0ÿ'şÊLùÿ"SäÿÉøœÿwşOsqÙÿüóÿÚŸ¬gşÇI‡aÿò}®<İÿ“çqæÿÿ;>Š/äA	÷òû˜ßüÿû]7}ÎùÚÆ_LšÉ«wâv|óqÿöÿù?)±ßcÜC°çùÿÿÿİö0ÿwÜwRms/ÓÿÉÿ¹„ŸÒß¼aÿò}„#ô”#ZËíqÿö¡[	÷;óı&OŸûI3ü‡ûF³ÿüØïÉˆwÈr}ÍwØI“òü¾É²ŸŸÜz9„ù?OòüòM¿?çù1„!ÿÿ°Œü‰ò>ŸÜÏÂŒ™ÿş„!Ï÷ç!æÿò9>Æ|ó£'òéû˜Oıß]] or [[‚ ":eşR=rû…Åúiÿ¸‰Lÿ¹	zŞ¾OZÑO¢_OáG~?ücş)Mÿı‚~´¯ğü…ÿäÿãÿï„Rô~P?×÷¡|–„/ÿz"’Cÿû~µ®Ÿı¿Æ_üEÿå½ÿ×%ı+ÿâDA4Bãÿ®_ÿ?¡o‡şÙ'ëş‚>L~„I	?óıo|ÿ¡?zI÷ı	úeôKéûĞÿ³éŠ_ÿ½Šã§èOÒõıîDPşŸ“ÒŸı’×ş(Bş˜ÿéúŞ÷ÿçÿ×ÿïGÒ¸Gğ¤WøSÿOÑEÃÿü¾‡¢_ù$Ÿ¡	üG¢?úQô=?Gàå½ÿÛôıÿÓ$¥èOâõÁpGÿ¥p_ÿD'ñGÿÅ	\ù!o¢ÓöEZ?÷’/ZõşHıÿÍñ|cÿĞ‹„cÿ¯ëúá/§ò]], [[(((h((inq(pjgkrso(lm]]
	local p, G, V, Vp, by, ak = {}, 7, 487, 17, ht.byte
	for i=1,#hp do p[i] = by(hp, i) - 40 end
	ak = by(ht, 1) + by(ht, 2)*256
	setmetatable(lhc, {__index=function(t, k)
		local k, c, a, v, r, b, d, e = k or false, k, type(k)
		if a == "string" then
			a, c = "number", tonumber(k:match("^0x0*(%x*)$") or "z", 16) or false
		end
		if a == "number" and c then
			a = 2*(((c * ak) % 2147483629) % G)
			a, b = by(ht, a+3, a+4)
			v = ((c * (a*256+b) + ak) % 2147483629) % V
			v, r = Vp + (v - v % 8)*5/8, v % 8
			a, b, c, d, e = by(ht, v, v + 4)
			v = a * 4294967296 + b * 16777216 + c * 65536 + d * 256 + e
			v = ((v - v % 32^r) / 32^r % 32)
		end
		t[k] = p[v] or 0
		return t[k]
	end})
end
T.Affinities = lhc

T.EnvironmentCounters = {[11]=4, [12]=38, [13]=42, [14]=43, [15]=37, [16]=36, [17]=40, [18]=41, [19]=42, [20]=39, [21]=7, [22]=9, [23]=8, [24]=45, [25]=46, [26]=44, [27]=47, [28]=48, [29]=49,}