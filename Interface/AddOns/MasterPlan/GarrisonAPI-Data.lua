local _, T = ...
if T.Mark ~= 23 then return end

local lhc = {} do
	local ht, hp = UnitFactionGroup("player") ~= "Horde" and [[6���m���My�;��l�y��t����g?ʟ��2|���3����BM�?�z�>�7����0�'��L���"S������w�O�sq�����ڟ��g��I�a��}�<����q���;>�/�A	��������]7}����_L�ɫw�v|�q����?)��c�C��������0�w�wRms/���������߼�a��}�#��#Z��q���[	�;��&O���I3���F�����Ɉw�r}�w�I����ɲ���z9��?O����M�?��1�!�������>��������!���!���9>�|�'����O��]] or [[��":e�R=r����i���L��	zޏ�OZ�O�_O�G~?�c�)M���~�����������R�~P?���|��/�z"�C��~������_�E�����%�+��DA4B����_�?�o���'���>L~�I	�?��o|��?zI��	�e�K������_������O����DP����ҟ����(B�������������GҸG�W�S�O�E������_�$��	�G�?�Q�=?G��������$��O���pG��p_�D'�G��	\�!o���EZ?��/Z��H����|c�Ћ�c�����/��]], [[(((h((inq(pjgkrso(lm]]
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