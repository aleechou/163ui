-- Prevent tainting global _.
local _

local function CopyTable(SrcTable)
	local TarTable = {};
	for sKey, sValue in pairs(SrcTable) do
		if type(sValue) == "table" then
			TarTable[sKey] = {};
			TarTable[sKey] = CopyTable(sValue);
		else
			TarTable[sKey] = sValue;
		end
	end
	return TarTable;
end

function EventAlert_LoadClassSpellArray(ItemType)
	--if EA_Items[EA_playerClass] == nil then EA_Items[EA_playerClass] = {} end;
	--if EA_AltItems[EA_playerClass] == nil then EA_AltItems[EA_playerClass] = {} end;
	--if EA_Items[EA_CLASS_OTHER] == nil then EA_Items[EA_CLASS_OTHER] = {} end;
	--if EA_TarItems[EA_playerClass] == nil then EA_TarItems[EA_playerClass] = {} end;
	--if EA_ScdItems[EA_playerClass] == nil then EA_ScdItems[EA_playerClass] = {} end;
	--if EA_GrpItems[EA_playerClass] == nil then EA_GrpItems[EA_playerClass] = {} end;

	if (ItemType == 1) or (ItemType == 9 and EA_Items[EA_playerClass] == nil) then
		EA_Items[EA_playerClass] = {};
		for i, v in pairsByKeys(EADef_Items[EA_playerClass]["ITEMS"]) do
			i = tonumber(i);
			if EA_Items[EA_playerClass][i] == nil then EA_Items[EA_playerClass][i] = v end;
			if GetSpellInfo(i) == nil then EA_Items[EA_playerClass][i] = nil end;
		end
	end
	if (ItemType == 2) or (ItemType == 9 and EA_AltItems[EA_playerClass] == nil) then
		EA_AltItems[EA_playerClass] = {};
		for i, v in pairsByKeys(EADef_Items[EA_playerClass]["ALTITEMS"]) do
			i = tonumber(i);
			if EA_AltItems[EA_playerClass][i] == nil then EA_AltItems[EA_playerClass][i] = v end;
			if GetSpellInfo(i) == nil then EA_AltItems[EA_playerClass][i] = nil end;
		end
	end
	if (ItemType == 3) or (ItemType == 9 and EA_Items[EA_CLASS_OTHER] == nil) then
		EA_Items[EA_CLASS_OTHER] = {};
		for i, v in pairsByKeys(EADef_Items[EA_CLASS_OTHER]) do
			i = tonumber(i);
			if EA_Items[EA_CLASS_OTHER][i] == nil then EA_Items[EA_CLASS_OTHER][i] = v  end;
			if GetSpellInfo(i) == nil then EA_Items[EA_CLASS_OTHER][i] = nil end;
		end
	end
	if (ItemType == 4) or (ItemType == 9 and EA_TarItems[EA_playerClass] == nil) then
		EA_TarItems[EA_playerClass] = {};
		for i, v in pairsByKeys(EADef_Items[EA_playerClass]["TARITEMS"]) do
			i = tonumber(i);
			if EA_TarItems[EA_playerClass][i] == nil then EA_TarItems[EA_playerClass][i] = v end;
			if GetSpellInfo(i) == nil then EA_TarItems[EA_playerClass][i] = nil end;
		end
	end
	if (ItemType == 5) or (ItemType == 9 and EA_ScdItems[EA_playerClass] == nil) then
		EA_ScdItems[EA_playerClass] = {};
		for i, v in pairsByKeys(EADef_Items[EA_playerClass]["SCDITEMS"]) do
			i = tonumber(i);
			if EA_ScdItems[EA_playerClass][i] == nil then EA_ScdItems[EA_playerClass][i] = v end;
			if GetSpellInfo(i) == nil then EA_ScdItems[EA_playerClass][i] = nil end;
		end
	end
	if (ItemType == 6) or (ItemType == 9 and EA_GrpItems[EA_playerClass] == nil) then
		EA_GrpItems[EA_playerClass] = {};
		local iGroupCnts = 0;
		--if (#EA_GrpItems[EA_playerClass] ~= nil) then iGroupCnts = #EA_GrpItems[EA_playerClass] end;
		for i, v in pairsByKeys(EADef_Items[EA_playerClass]["GRPITEMS"]) do
			i = tonumber(i);
			if EA_GrpItems[EA_playerClass][iGroupCnts+i] == nil then EA_GrpItems[EA_playerClass][iGroupCnts+i] = {} end;
			-- EA_GrpItems[EA_playerClass][iGroupCnts+i] = v;
			EA_GrpItems[EA_playerClass][iGroupCnts+i] = CopyTable(v);
		end
	end
end


function EventAlert_LoadSpellArray()

	EADef_Items = {};

--------------------------------------------------------------------------------
-- Death Knight / ���`�M�h
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_DK] = {
		-- Primary Alert / ��¾�~������
		["ITEMS"] = {
			[48707] = {enable=true,},   -- ���]�k�@�n
			[48792] = {enable=true,},   -- �B�D��
			[49039] = {enable=true,},   -- �ŧ�����
			[49222] = {enable=true,},   -- �e������
			[51124] = {enable=true,},   -- Killing  Machine / �����ŦD
			[52424] = {enable=true,},   -- ��������
			[53386] = {enable=true,},   -- Cinderglacier (Runeforge) /  �B�u
			[57330] = {enable=true,},   -- ���V����
			[59052] = {enable=true,},   -- Rime (Freezing Fog) / �B�ʤ���
			[81141] = {enable=true,},   -- ����a��
		},
		-- Alternate Alert / ��¾�~�B�~������
		["ALTITEMS"] = {
			[56815] = {enable=true,},   -- Rune Strike / �Ť奴��
		},
		-- Target Alert / �ؼд�����
		["TARITEMS"] = {
			[55095] = {enable=true, self=true,},    -- �B������
			[55078] = {enable=true, self=true,},    -- ��z�E��
			[81130] = {enable=true, self=true,},    -- ������
			[81326] = {enable=true, self=false},	-- ���z����
			[115798] = {enable=true, self=false,},	-- �z�Ƨ���
			[117737] = {enable=true, self=false,},	-- ���g (�]�j�s4��)
			[117756] = {enable=true, self=false,},	-- ���� (�]�j�s4��)
			[123059] = {enable=true, self=false,},	-- �ʷn (����5���W��buff)
			[123471] = {enable=true, self=false},	-- �W�j (���ߤ���2��)
			[126958] = {enable=true, self=false,},	-- �ǩԥd�٤�Ĳ (�]�j�s�p��)
			[127372] = {enable=true, self=false,},	-- ��í�w��M
			[131996] = {enable=true, self=false,},	-- �h�� (�׬u�x4���j��)			
			[132726] = {enable=true, self=false,},	-- ����
			[136431] = {enable=true, self=false,},	-- �t�߽��� (�p�^4���W��)
		},
		-- Spell Cooldown Alert / ��¾�~�ޯ�CD��
		["SCDITEMS"] = {
			[43265] = {enable=true,},   -- ���`��s
			[45524] = {enable=true,},   -- �B��N
			[47476] = {enable=true,},   -- ����
			[47528] = {enable=true,},   -- �ߴ��B��
			[48707] = {enable=true,},   -- ���]�k�@�n
			[48721] = {enable=true,},   -- �m��N
			[48792] = {enable=true,},   -- �B�D��
			[49020] = {enable=true,},   -- ���I
			[49576] = {enable=true,},   -- ���`����
			[49998] = {enable=true,},   -- ���`����
			[77575] = {enable=true,},   -- �̯f�z�o
			[85948] = {enable=true,},   -- �w�H����
		},
		-- GroupEvent Alert / ��¾�~����ޯ��
		["GRPITEMS"] = {
			[1] = {
				enable=false,
				LocX = 0,
				LocY = -200,
				IconSize = 80,
				IconAlpha = 0.5,
				IconPoint = "Top",
				IconRelatePoint = "Top",
				-- ActiveTalentGroup=1,	-- nil for all, 1 for primary, 2 for secondary
				Spells = {
					[1] = {
						SpellIconID = 57330,	-- 57330 ���V����
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {	-- ���a���W�S�����������B�åB���V�������bCD��
										SubCheckAndOp = true,		-- �s��1���޿�B��i�H�L��
										EventType = "UNIT_AURA",	-- �ƥ�O�A�ݩ�"AURA������"
										UnitType = "player",		-- �˴���H�A��"���a"
										CheckAuraNotExist = 57330,	-- �˴�"���V����"Buff�O�_"���s�b"
										CheckCD = 57330,		-- �˴�"���V����"�ޯ�O�_"CD��"
									},
									[2] = {	-- �åB(true)�A���W�S���Ԥh���O�q��q(���ˬd���ޯधCD)
										SubCheckAndOp = true,		-- true:�åB, false:�Ϊ�
										EventType = "UNIT_AURA",	-- �ƥ�O�A�ݩ�"AURA������"
										UnitType = "player",		-- �˴���H�A��"���a"
										CheckAuraNotExist = 6673, 	-- �˴�"�O�q��q"Buff�O�_"���s�b"
									},
								},
							},
						},
					},
				},
			},
			[2] = {
				enable=false,
				LocX = 80,
				LocY = -200,
				IconSize = 80,
				IconAlpha = 0.5,
				IconPoint = "Top",
				IconRelatePoint = "Top",
				ActiveTalentGroup=1,	-- nil for all, 1 for primary, 2 for secondary
				Spells = {
					[1] = {
						SpellIconID = 49222,	-- 49222 �b������
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {
										SubCheckAndOp = true,
										EventType = "UNIT_AURA",
										UnitType = "player",
										CheckAuraNotExist = 49222,
										CheckCD = 49222,
									},
								},
							},
						},
					},
				},
			},
		},
	}


--------------------------------------------------------------------------------
-- Druid / �w�|��
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_DRUID] = {
		-- Primary Alert / ��¾�~������
		["ITEMS"] = {
			[16870] = {enable=true,},   -- Omen of Clarity / �M���w��
			[16886] = {enable=true,},   -- Nature's Grace / �۵M����
			[48517] = {enable=true,},   -- Eclipse / ��k
			[48518] = {enable=true,},   -- Eclipse / ��k
			[50334] = {enable=true,},   -- Berserk / �g��
			[52610] = {enable=true,},   -- Savage Roar / ���Z�H�S
			[81192] = {enable=true,},   -- ��N
			[93400] = {enable=true,},   -- �g�P�N
			[93622] = {enable=true,},   -- �g��(�K�O�θH)
			[100977] = {enable=true,},  -- �@��
		},
		-- Alternate Alert / ��¾�~�B�~������
		["ALTITEMS"] = {
		},
		-- Target Alert / �ؼд�����
		["TARITEMS"] = {
			--[770] = {enable=true, self=true,},    -- Faerie Fire / ���F����
			--[16857] = {enable=true, self=true,},  -- Faerie Fire (Feral) / ���F����(����)
			--[48564] = {enable=true, self=true,},  -- Mangle(Bear) / �θH(���κA)
			[99] = {enable=true, self=true,},       -- ���өH��
			[774] = {enable=true, self=true,},      -- �^�K�N
			[1079] = {enable=true, self=true,},     -- Rip / ����
			[1822] = {enable=true, self=true,},     -- Rake / ����
			[5570] = {enable=true, self=true,},     -- Insect Swarm / �θs
			[8921] = {enable=true, self=true,},     -- Moonfire / ����N
			[33745] = {enable=true, self=true,},    -- Lacerate / �ε�
			[33763] = {enable=true, self=true,},    -- �ͩR����
			[33876] = {enable=true, self=true,},    -- Mangle(Cat) / �θH(�y�\�κA)
			[52610] = {enable=true, self=true,},    -- ���Z�H��
			[81326] = {enable=true, self=false},	-- ���z����
			[93402] = {enable=true, self=true,},    -- Moonfire / �骢�N
			[115798] = {enable=true, self=false,},	-- �z�Ƨ���
			[117737] = {enable=true, self=false,},	-- ���g (�]�j�s4��)
			[117756] = {enable=true, self=false,},	-- ���� (�]�j�s4��)
			[123059] = {enable=true, self=false,},	-- �ʷn (����5���W��buff)
			[123471] = {enable=true, self=false},	-- �W�j (���ߤ���2��)
			[126958] = {enable=true, self=false,},	-- �ǩԥd�٤�Ĳ (�]�j�s�p��)
			[127372] = {enable=true, self=false,},	-- ��í�w��M
			[131996] = {enable=true, self=false,},	-- �h�� (�׬u�x4���j��)			
			[132726] = {enable=true, self=false,},	-- ����
			[136431] = {enable=true, self=false,},	-- �t�߽��� (�p�^4���W��)
		},
		-- Spell Cooldown Alert / ��¾�~�ޯ�CD��
		["SCDITEMS"] = {
			[17116] = {enable=true,},   -- �۵M����
			[18562] = {enable=true,},   -- ��¡
			[29166] = {enable=true,},   -- �Ұ�
			[48438] = {enable=true,},   -- ���ʲ�¡
			[78674] = {enable=true,},   -- �P��N
		},
		-- GroupEvent Alert / ��¾�~����ޯ��
		["GRPITEMS"] = {
			[1] = {
				enable=false,
				LocX = 0,
				LocY = -200,
				IconSize = 80,
				IconAlpha = 0.5,
				IconPoint = "Top",
				IconRelatePoint = "Top",
				ActiveTalentGroup=1,	-- nil for all, 1 for primary, 2 for secondary
				Spells = {
					[1] = {
						SpellIconID = 5217,	-- 5217 �r�ꤧ��
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {
										SubCheckAndOp = true,
										EventType = "UNIT_POWER",
										UnitType = "player",
										PowerTypeNum = 3,
										PowerType = "ENERGY",
										CheckCD = 5217,
										PowerCompType = 2,
										PowerLessThanValue = 40,
									},
								},
							},
						},
					},
				},
			},
			[2] = {
				enable=false,
				LocX = 0,
				LocY = -200,
				IconSize = 80,
				IconAlpha = 0.5,
				IconPoint = "Top",
				IconRelatePoint = "Top",
				ActiveTalentGroup=2,	-- nil for all, 1 for primary, 2 for secondary
				Spells = {
					[1] = {
						SpellIconID = 48438,	-- 48438 ����¡�X
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {
										SubCheckAndOp = true,
										EventType = "UNIT_POWER",
										UnitType = "player",
										PowerTypeNum = 0,
										PowerType = "MANA",
										CheckCD = 48438,
										PowerCompType = 4,
										PowerLessThanValue = 5000,
									},
								},
							},
						},
					},
				},
			},
			[3] = {
				enable=false,
				LocX = 80,
				LocY = -200,
				IconSize = 80,
				IconAlpha = 0.5,
				IconPoint = "Top",
				IconRelatePoint = "Top",
				ActiveTalentGroup=2,	-- nil for all, 1 for primary, 2 for secondary
				Spells = {
					[1] = {
						SpellIconID = 29166,	-- 29166 �Ұ�
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {
										SubCheckAndOp = true,
										EventType = "UNIT_POWER",
										UnitType = "player",
										PowerTypeNum = 0,
										PowerType = "MANA",
										CheckCD = 29166,
										PowerCompType = 2,
										PowerLessThanPercent = 80,
									},
								},
							},
						},
					},
				},
			},
			[4] = {
				enable=false,
				LocX = -80,
				LocY = -200,
				IconSize = 80,
				IconAlpha = 0.5,
				IconPoint = "Top",
				IconRelatePoint = "Top",
				ActiveTalentGroup=2,	-- nil for all, 1 for primary, 2 for secondary
				Spells = {
					[1] = {
						SpellIconID = 18562,	-- 18562 ���U
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {
										SubCheckAndOp = true,
										EventType = "UNIT_POWER",
										UnitType = "player",
										PowerTypeNum = 0,
										PowerType = "MANA",
										CheckCD = 18562,
										PowerCompType = 4,
										PowerLessThanValue = 1700,
									},
								},
							},
						},
					},
				},
			},
			-- 1.�θH 2.�L�ε��A�ɳε� 3.���ε��L���H�A�ɯ��H 4.�h�� 5.����
			[5] = {
				enable=false,
				LocX = -80,
				LocY = -200,
				IconSize = 80,
				IconAlpha = 0.5,
				IconPoint = "Top",
				IconRelatePoint = "Top",
				ActiveTalentGroup=1,	-- nil for all, 1 for primary, 2 for secondary
				Spells = {
					[1] = {
						SpellIconID = 33878,	-- �θH
						Checks = {
							[1] = {
								CheckAndOp = true,	-- �i�L��
								SubChecks = {
									[1] = {	-- ���a���15�H�W�A�åB�θH���bCD��
										SubCheckAndOp = true,		-- �i�L��
										EventType = "UNIT_POWER",	-- �ƥ�O�A�ݩ�"��q������"
										UnitType = "player",		-- �˴���H�A��"���a"
										PowerTypeNum = 1, 		-- ��q�����s��(1:���)
										PowerType = "RAGE",		-- ��q����, �i�L��
										CheckCD = 33878,		-- �˴�"�θH"�ޯ�O�_"CD��"
										PowerCompType = 4,		-- ��q, true:�p�󵥩�, false:�j�󵥩�
										PowerLessThanValue = 15,	-- 15
									},
								},
							},
						},
					},
					[2] = {
						SpellIconID = 33745,	-- �ε�
						Checks = {
							[1] = {
								CheckAndOp = true,	-- �i�L��
								SubChecks = {
									[1] = {	-- ���a���15�H�W�A�åB�ε����bCD��
										SubCheckAndOp = true,		-- �i�L��
										EventType = "UNIT_POWER",       -- �ƥ�O�A�ݩ�"��q������"
										UnitType = "player",            -- �˴���H�A��"���a"
										PowerTypeNum = 1,               -- ��q�����s��(1:���)
										PowerType = "RAGE",             -- ��q����, �i�L��
										CheckCD = 33745,                -- �˴�"�ε�"�ޯ�O�_"CD��"
										PowerCompType = 4,          -- ��q, true:�p�󵥩�, false:�j�󵥩�
										PowerLessThanValue = 15,        -- 15
									},
								},
							},
							[2] = {
								CheckAndOp = true,	-- true:�åB, false:�Ϊ�
								SubChecks = {
									[1] = {	-- �ؼШ��W�L�ε�
										SubCheckAndOp = true,		-- �i�L��
										EventType = "UNIT_AURA",	-- �ƥ�O�A�ݩ�"AURA������"
										UnitType = "target",		-- �˴���H�A��"�ؼ�"
										CastByPlayer = true,		-- true:�u�˴����a�I��
										CheckAuraNotExist = 33745,	-- �˴�"�ε�"DeBuff�O�_"���s�b"
									},
									[2] = {	-- �Ϊ�(false)�A�ؼШ��W�ε��p�󵥩�2�h���|
										SubCheckAndOp = false,		-- true:�åB, false:�Ϊ�
										EventType = "UNIT_AURA",	-- �ƥ�O�A�ݩ�"AURA������"
										UnitType = "target",		-- �˴���H�A��"�ؼ�"
										CheckAuraExist = 33745,		-- �˴�"�ε�"DeBuff�O�_"�s�b"
										CastByPlayer = true,		-- true:�u�˴����a�I��
										StackCompType = 2,		-- ���|�h��, true:�p�󵥩�, false:�j�󵥩�
										StackLessThanValue = 2,		-- 2�h
									},
									[3] = {	-- �Ϊ�(false)�A�ؼШ��W�ε��Ѿl�ɶ��A�p�󵥩�3��
										SubCheckAndOp = false,		-- true:�åB, false:�Ϊ�
										EventType = "UNIT_AURA",	-- �ƥ�O�A�ݩ�"AURA������"
										UnitType = "target",		-- �˴���H�A��"�ؼ�"
										CheckAuraExist = 33745,		-- �˴�"�ε�"DeBuff�O�_"�s�b"
										CastByPlayer = true,		-- true:�u�˴����a�I��
										TimeCompType = 2,		-- �Ѿl�ɶ�, true:�p�󵥩�, false:�j�󵥩�
										TimeLessThanValue = 3,		-- 3��
									},
								},
							},
						},
					},
					[3] = {
						SpellIconID = 80313,	-- ���H
						Checks = {
							[1] = {
								CheckAndOp = true,	-- �i�L��
								SubChecks = {
									[1] = {	-- ���a���15�H�W�A�åB���H���bCD��
										SubCheckAndOp = true,		-- �i�L��
										EventType = "UNIT_POWER",       -- �ƥ�O�A�ݩ�"��q������"
										UnitType = "player",            -- �˴���H�A��"���a"
										PowerTypeNum = 1,               -- ��q�����s��(1:���)
										PowerType = "RAGE",             -- ��q����, �i�L��
										CheckCD = 80313,                -- �˴�"�θH"�ޯ�O�_"CD��"
										PowerCompType = 4,          -- ��q, true:�p�󵥩�, false:�j�󵥩�
										PowerLessThanValue = 15,        -- 15
									},
									[2] = {	-- �åB(true)�A�ؼШ��W�����a�I�񪺳ε�Debuff
										SubCheckAndOp = true,		-- true:�åB, false:�Ϊ�
										EventType = "UNIT_AURA",	-- �ƥ�O�A�ݩ�"AURA������"
										UnitType = "target",		-- �˴���H�A��"�ؼ�"
										CastByPlayer = true,		-- true:�u�˴����a�I��
										CheckAuraExist = 33745,		-- �˴�"�ε�"DeBuff�O�_"�s�b"
									},
								},
							},
							[2] = {
								CheckAndOp = true,	-- true:�åB, false:�Ϊ�
								SubChecks = {
									[1] = {	-- ���a���W�����HBuff�Ѿl�ɶ��A�p�󵥩�3��
										SubCheckAndOp = true,		-- �i�L��
										EventType = "UNIT_AURA",	-- �ƥ�O�A�ݩ�"AURA������"
										UnitType = "player",		-- �˴���H�A��"���a"
										CheckAuraExist = 80951,		-- �˴�"���H"Buff�O�_"�s�b"
										TimeCompType = 2,		-- �Ѿl�ɶ�, true:�p�󵥩�, false:�j�󵥩�
										TimeLessThanValue = 3,		-- 3��
									},
									[2] = {	-- �Ϊ�(false)�A���a���W�S�����HBuff
										SubCheckAndOp = false,		-- true:�åB, false:�Ϊ�
										EventType = "UNIT_AURA",	-- �ƥ�O�A�ݩ�"AURA������"
										UnitType = "player",		-- �˴���H�A��"���a"
										CheckAuraNotExist = 80951,	-- �˴�"���H"Buff�O�_"���s�b"
									},
								},
							},
						},
					},
					[4] = {
						SpellIconID = 77758,	-- �h��
						Checks = {
							[1] = {
								CheckAndOp = true,	-- �i�L��
								SubChecks = {
									[1] = {	-- ���a���25�H�W�A�åB�h�����bCD��
										SubCheckAndOp = true,		-- �i�L��
										EventType = "UNIT_POWER",       -- �ƥ�O�A�ݩ�"��q������"
										UnitType = "player",            -- �˴���H�A��"���a"
										PowerTypeNum = 1,               -- ��q�����s��(1:���)
										PowerType = "RAGE",             -- ��q����, �i�L��
										CheckCD = 77758,                -- �˴�"�h��"�ޯ�O�_"CD��"
										PowerCompType = 4,          -- ��q, true:�p�󵥩�, false:�j�󵥩�
										PowerLessThanValue = 25,        -- 25
									},
								},
							},
						},
					},
					[5] = {
						SpellIconID = 779,	-- ����
						Checks = {
							[1] = {
								CheckAndOp = true,	-- �i�L��
								SubChecks = {
									[1] = {	-- ���a���25�H�W�A�åB�������bCD��
										SubCheckAndOp = true,		-- �i�L��
										EventType = "UNIT_POWER",       -- �ƥ�O�A�ݩ�"��q������"
										UnitType = "player",            -- �˴���H�A��"���a"
										PowerTypeNum = 1,               -- ��q�����s��(1:���)
										PowerType = "RAGE",             -- ��q����, �i�L��
										CheckCD = 779,                  -- �˴�"����"�ޯ�O�_"CD��"
										PowerCompType = 4,          -- ��q, true:�p�󵥩�, false:�j�󵥩�
										PowerLessThanValue = 15,        -- 15
									},
								},
							},
						},
					},
				},
			},
		},
	}


--------------------------------------------------------------------------------
-- Hunter / �y�H
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_HUNTER] = {
		-- Primary Alert / ��¾�~������
		["ITEMS"] = {
			[3045] = {enable=true,},    -- ��t�g��
			[34471] = {enable=true,},   -- �~��
			[34477] = {enable=true,},   -- �~��
			[35079] = {enable=true,},   -- �~��
			[53220] = {enable=true,},   -- Improved Stead Shot / �j��í�T�g��
			[53257] = {enable=true,},   -- ����D����
			[53434] = {enable=true,},   -- �g���I��
			[56453] = {enable=true,},   -- Lock and Load / �W�իݵo
			[70728] = {enable=true,},   -- �����z�I
			[82925] = {enable=true,},   -- �ǳơB�N���B�˷ǡK
			[82926] = {enable=true,},   -- �g��!
			[89388] = {enable=true,},   -- �����ĤH
			[94007] = {enable=true,},   -- �s��
			[95712] = {enable=true,},   -- X���˷Ǿ�
		},
		-- Alternate Alert / ��¾�~�B�~������
		["ALTITEMS"] = {
			[53351] = {enable=true,},   -- Kill Shot / �����g��
		},
		-- Target Alert / �ؼд�����
		["TARITEMS"] = {
			[1978] = {enable=true, self=true,},     -- �r�D�v��
			[1130] = {enable=true, self=true,},     -- �y�H�L�O
			[19503] = {enable=true, self=true,},    -- �X���g��
			[63468] = {enable=true, self=true,},    -- ��z�g��
			[117737] = {enable=true, self=false,},	-- ���g (�]�j�s4��)
			[117756] = {enable=true, self=false,},	-- ���� (�]�j�s4��)
			[123059] = {enable=true, self=false,},	-- �ʷn (����5���W��buff)
			[123471] = {enable=true, self=false},	-- �W�j (���ߤ���2��)
			[126958] = {enable=true, self=false,},	-- �ǩԥd�٤�Ĳ (�]�j�s�p��)
			[127372] = {enable=true, self=false,},	-- ��í�w��M
			[131996] = {enable=true, self=false,},	-- �h�� (�׬u�x4���j��)			
			[132726] = {enable=true, self=false,},	-- ����
			[136431] = {enable=true, self=false,},	-- �t�߽��� (�p�^4���W��)
		},
		-- Spell Cooldown Alert / ��¾�~�ޯ�CD��
		["SCDITEMS"] = {
			[781] = {enable=true,},     -- �k��
		},
		-- GroupEvent Alert / ��¾�~����ޯ��
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Mage / �k�v
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_MAGE] = {
		-- Primary Alert / ��¾�~������
		["ITEMS"] = {
			[12042] = {enable=true,},   -- ���k�j��
			[12051] = {enable=true,},   -- ���
			[36032] = {enable=true,},   -- Arcane Blast / ���İ��|
			[44544] = {enable=true,},   -- Fingers of Frost / �B������
			[48108] = {enable=true,},   -- Hot Streak / �J������
			[57761] = {enable=true,},   -- Brain Freeze / �����ᵲ
			[64343] = {enable=true,},   -- ����
			[79683] = {enable=true,},   -- Missile Barrage! / ���k���u!
			[87023] = {enable=true,},   -- �N�`
			[116257] = {enable=true,},   -- ���v���� (���)
		},
		-- Alternate Alert / ��¾�~�B�~������
		["ALTITEMS"] = {
		},
		-- Target Alert / �ؼд�����
		["TARITEMS"] = {
			[12654] = {enable=true, self=true,},    -- �I�U
			[22959] = {enable=true, self=true,},    -- ���K����
			[31589] = {enable=true, self=true,},    -- Slow / ��t�N
			[44457] = {enable=true, self=true,},    -- Living Bomb / �����z�u
			[117737] = {enable=true, self=false,},	-- ���g (�]�j�s4��)
			[117756] = {enable=true, self=false,},	-- ���� (�]�j�s4��)
			[123059] = {enable=true, self=false,},	-- �ʷn (����5���W��buff)
			[123471] = {enable=true, self=false},	-- �W�j (���ߤ���2��)
			[126958] = {enable=true, self=false,},	-- �ǩԥd�٤�Ĳ (�]�j�s�p��)
			[127372] = {enable=true, self=false,},	-- ��í�w��M
			[131996] = {enable=true, self=false,},	-- �h�� (�׬u�x4���j��)			
			[132726] = {enable=true, self=false,},	-- ����
			[136431] = {enable=true, self=false,},	-- �t�߽��� (�p�^4���W��)
		},
		-- Spell Cooldown Alert / ��¾�~�ޯ�CD��
		["SCDITEMS"] = {
			[122] = {enable=true,},     -- �B���s�P
			[1953] = {enable=true,},    -- �{�{
			[12042] = {enable=true,},   -- ���k�j��
			[12043] = {enable=true,},   -- ��w����
			[12051] = {enable=true,},   -- ���
			[44572] = {enable=true,},   -- ���צB��
			[45438] = {enable=true,},   -- �H�B�̻�
		},
		-- GroupEvent Alert / ��¾�~����ޯ��
		["GRPITEMS"] = {
			[1] = {
				enable=false,
				LocX = 0,
				LocY = -200,
				IconSize = 80,
				IconAlpha = 0.5,
				IconPoint = "Top",
				IconRelatePoint = "Top",
				-- ActiveTalentGroup=1,	-- nil for all, 1 for primary, 2 for secondary
				Spells = {
					[1] = {
						SpellIconID = 12051,	-- 12051 ���
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {
										SubCheckAndOp = true,
										EventType = "UNIT_POWER",
										UnitType = "player",
										PowerTypeNum = 0,
										PowerType = "MANA",
										CheckCD = 12051,
										PowerCompType = 2,
										PowerLessThanPercent = 40,
									},
								},
							},
						},
					},
				},
			},
		},
	}


--------------------------------------------------------------------------------
-- Paladin / �t�M�h
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_PALADIN] = {
		-- Primary Alert / ��¾�~������
		["ITEMS"] = {
			[498] = {enable=true,},     -- �t���N
			[642] = {enable=true,},     -- �t�޳N
			[20925] = {enable=true,},   -- �R�t�@��
			[31821] = {enable=true,},   -- �@�ۥ���
			[31842] = {enable=true,},   -- �����N
			[31850] = {enable=true,},   -- ���ۨ��ê�
			[31884] = {enable=true,},   -- �_������
			[53657] = {enable=true,},   -- �¼�f�P
			[59578] = {enable=true,},   -- �Ԫ����N
			[84963] = {enable=true,},   -- ���ݼf��
			[86659] = {enable=true,},   -- ���j�Ѥ��u�@��(�Z)
			[86698] = {enable=true,},   -- ���j�Ѥ��u�@��(DD)
			[90174] = {enable=true,},	-- ���t�N��
			[105809] = {enable=true,},   -- ���t�_����
			[114163] = {enable=true,},	-- �ë���
			[114637] = {enable=true,},	-- �aģ���S
			[121467] = {enable=true,},	-- ���դ���
			[132403] = {enable=true,},	-- ��������(���)
		},
		-- Alternate Alert / ��¾�~�B�~������
		["ALTITEMS"] = {
			[24275] = {enable=true,},   -- Hammer of Wrath / ���㤧��
		},
		-- Target Alert / �ؼд�����
		["TARITEMS"] = {
			[853] = {enable=true, self=true,},      -- �������
			[10326] = {enable=true, self=true,},    -- �h���N
			[20066] = {enable=true, self=true,},    -- �b��
			[31803] = {enable=true, self=true,},    -- ���d
			[81298] = {enable=true, self=true},		-- �^�m
			[81326] = {enable=true, self=false},	-- ���z����
			[110300] = {enable=true, self=true,},	-- �o������
			[114163] = {enable=true, self=true,},	-- �ë���
			[114916] = {enable=true, self=true,},	-- ���D�ŧP
			[115798] = {enable=true, self=false,},	-- �z�Ƨ���
			[117737] = {enable=true, self=false,},	-- ���g (�]�j�s4��)
			[117756] = {enable=true, self=false,},	-- ���� (�]�j�s4��)
			[123059] = {enable=true, self=false,},	-- �ʷn (����5���W��buff)
			[123471] = {enable=true, self=false},	-- �W�j (���ߤ���2��)
			[126958] = {enable=true, self=false,},	-- �ǩԥd�٤�Ĳ (�]�j�s�p��)
			[127372] = {enable=true, self=false,},	-- ��í�w��M
			[131996] = {enable=true, self=false,},	-- �h�� (�׬u�x4���j��)			
			[132726] = {enable=true, self=false,},	-- ����
			[136431] = {enable=true, self=false,},	-- �t�߽��� (�p�^4���W��)
		},
		-- Spell Cooldown Alert / ��¾�~�ޯ�CD��
		["SCDITEMS"] = {
			[498] = {enable=true,},     -- �t���N
			[853] = {enable=true,},     -- �������
			[20066] = {enable=true,},   -- �b��
			[20925] = {enable=true,},   -- �R�t�@��
			[28730] = {enable=true,},   -- ���y���N
			[54428] = {enable=true,},   -- ���ʬ�D
			[96231] = {enable=true,},   -- �d��
			[114157] = {enable=true,},   -- ���D�ŧP
			[114158] = {enable=true,},   -- �t������
			[114165] = {enable=true,},   -- ���t�W��
			[115750] = {enable=true,},   -- ���ؤ���
		},
		-- GroupEvent Alert / ��¾�~����ޯ��
		["GRPITEMS"] = {
			[1] = {
				enable=false,
				LocX = 0,
				LocY = -200,
				IconSize = 80,
				IconAlpha = 0.5,
				IconPoint = "Top",
				IconRelatePoint = "Top",
				ActiveTalentGroup=2,	-- nil for all, 1 for primary, 2 for secondary
				Spells = {
					[1] = {
						SpellIconID = 85673,	-- 85673 �aģ�t��
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {
										SubCheckAndOp = true,
										EventType = "UNIT_POWER",
										UnitType = "player",
										PowerTypeNum = 9,
										PowerType = "HOLY_POWER",
										CheckCD = 85673,
										PowerCompType = 4,
										PowerLessThanValue = 3,
									},
									[2] = {
										SubCheckAndOp = true,
										EventType = "UNIT_HEALTH",
										UnitType = "target",
										HealthCompType = 2,
										HealthLessThanPercent = 80,
									},
								},
							},
						},
					},
					[2] = {
						SpellIconID = 85222,	-- 85222 �����ƥ�(��q��)
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {
										SubCheckAndOp = true,
										EventType = "UNIT_POWER",
										UnitType = "player",
										PowerTypeNum = 9,
										PowerType = "HOLY_POWER",
										CheckCD = 85222,
										PowerCompType = 4,
										PowerLessThanValue = 3,
									},
								},
							},
						},
					},
				},
			},
			[2] = {
				["enable"] = false,
				["LocX"] = 0,
				["LocY"] = -200,
				["IconSize"] = 80,
				["IconAlpha"] = 0.5,
				["IconPoint"] = "Top",
				["IconRelatePoint"] = "Top",
				["ActiveTalentGroup"] = 1,
				["HideOnLostTarget"] = true,
				["Spells"] = {
					[1] = {
						["SpellIconID"] = 24275,
						["Checks"] = {
							[1] = {
								["CheckAndOp"] = true,
								["SubChecks"] = {
									[1] = {
										["HealthLessThanPercent"] = 20,
										["UnitType"] = "target",
										["CheckCD"] = 24275,
										["SubCheckResult"] = false,
										["SubCheckAndOp"] = true,
										["EventType"] = "UNIT_HEALTH",
										["HealthCompType"] = 1,
									}, -- [1]
								},
							}, -- [1]
						},
					}, -- [1]
					[2] = {
						["SpellIconID"] = 879,
						["Checks"] = {
							[1] = {
								["CheckAndOp"] = true,
								["SubChecks"] = {
									[1] = {
										["SubCheckResult"] = false,
										["UnitType"] = "player",
										["SubCheckAndOp"] = true,
										["CheckCD"] = 879,
										["CheckAuraExist"] = 59578,
										["EventType"] = "UNIT_AURA",
									}, -- [1]
								},
							}, -- [1]
						},
					}, -- [2]
					[3] = {
						["SpellIconID"] = 85256,
						["Checks"] = {
							[1] = {
								["CheckAndOp"] = true,
								["SubChecks"] = {
									[1] = {
										["SubCheckAndOp"] = true,
										["PowerType"] = "HOLY_POWER",
										["UnitType"] = "player",
										["PowerLessThanValue"] = 3,
										["CheckCD"] = 85256,
										["PowerTypeNum"] = 9,
										["EventType"] = "UNIT_POWER",
										["PowerCompType"] = 4,
									}, -- [1]
									[2] = {
										["SubCheckResult"] = false,
										["UnitType"] = "player",
										["SubCheckAndOp"] = false,
										["CheckCD"] = 85256,
										["CheckAuraExist"] = 90174,
										["EventType"] = "UNIT_AURA",
									}, -- [2]
								},
							}, -- [1]
						},
					}, -- [3]
					[4] = {
						["SpellIconID"] = 20271,
						["Checks"] = {
							[1] = {
								["CheckAndOp"] = true,
								["SubChecks"] = {
									[1] = {
										["SubCheckAndOp"] = true,
										["EventType"] = "UNIT_POWER",
										["SubCheckResult"] = false,
										["PowerType"] = "MANA",
										["UnitType"] = "player",
										["PowerLessThanValue"] = 90,
										["PowerTypeNum"] = 0,
										["CheckCD"] = 20271,
										["PowerCompType"] = 4,
									}, -- [1]
								},
							}, -- [1]
						},
					}, -- [4]
					[5] = {
						["SpellIconID"] = 35395,
						["Checks"] = {
							[1] = {
								["CheckAndOp"] = true,
								["SubChecks"] = {
									[1] = {
										["SubCheckAndOp"] = true,
										["EventType"] = "UNIT_POWER",
										["SubCheckResult"] = false,
										["PowerType"] = "HOLY_POWER",
										["UnitType"] = "player",
										["PowerLessThanValue"] = 3,
										["PowerTypeNum"] = 9,
										["CheckCD"] = 35395,
										["PowerCompType"] = 1,
									}, -- [1]
									[2] = {
										["SubCheckAndOp"] = false,
										["EventType"] = "UNIT_POWER",
										["SubCheckResult"] = false,
										["PowerType"] = "MANA",
										["UnitType"] = "player",
										["PowerLessThanValue"] = 100,
										["PowerTypeNum"] = 0,
										["CheckCD"] = 35395,
										["PowerCompType"] = 4,
									}, -- [2]
								},
							}, -- [1]
						},
					}, -- [5]
				},
			}, -- [2]
		},
	}


--------------------------------------------------------------------------------
-- Priest / ���v
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_PRIEST] = {
		-- Primary Alert / ��¾�~������
		["ITEMS"] = {
			[17] = {enable=true,},      -- �u���N:��
			[6788] = {enable=true,},    -- ��z�F��
			[47585] = {enable=true,},   -- �v��
			[63735] = {enable=true,},   -- ���t�^�_
			[77487] = {enable=true,},   -- �t�v�_�]
			[81206] = {enable=true,},   -- �߽��B��:���@
			[81208] = {enable=true,},   -- �߽��B��:���R
			[81209] = {enable=true,},   -- �߽��B��:���d
			[81782] = {enable=true,},   -- �u���N:��
			[87153] = {enable=true,},   -- �¤Ѩ�
			[87160] = {enable=true,},   -- ���F���k
		},
		-- Alternate Alert / ��¾�~�B�~������
		["ALTITEMS"] = {
		},
		-- Target Alert / �ؼд�����
		["TARITEMS"] = {
			[139] = {enable=true, self=true,},      -- ��_
			[589] = {enable=true, self=true,},      -- Shadow Word: Pain / �t���N:�h
			[2944] = {enable=true, self=true,},     -- Devouring Plague / ���F�E��
			[6788] = {enable=true, self=true,},     -- Weakened Soul / ��z�F��
			[34914] = {enable=true, self=true,},    -- Vampiric Touch / �l�大Ĳ
			[47753] = {enable=true, self=true,},    -- ���m����
			[117737] = {enable=true, self=false,},	-- ���g (�]�j�s4��)
			[117756] = {enable=true, self=false,},	-- ���� (�]�j�s4��)
			[123059] = {enable=true, self=false,},	-- �ʷn (����5���W��buff)
			[123471] = {enable=true, self=false},	-- �W�j (���ߤ���2��)
			[126958] = {enable=true, self=false,},	-- �ǩԥd�٤�Ĳ (�]�j�s�p��)
			[127372] = {enable=true, self=false,},	-- ��í�w��M
			[131996] = {enable=true, self=false,},	-- �h�� (�׬u�x4���j��)			
			[132726] = {enable=true, self=false,},	-- ����
			[136431] = {enable=true, self=false,},	-- �t�߽��� (�p�^4���W��)
		},
		-- Spell Cooldown Alert / ��¾�~�ޯ�CD��
		["SCDITEMS"] = {
			[17] = {enable=true,},      -- �u���N:��
			[10060] = {enable=true,},   -- �`�J��q
			[28730] = {enable=true,},   -- ���y���N
			[32379] = {enable=true,},   -- �t���N:��
			[33206] = {enable=true,},   -- �h�W����
			[34433] = {enable=true,},   -- �t�v�c�]
			[47540] = {enable=true,},   -- �b��
			[47585] = {enable=true,},   -- �v��
			[81700] = {enable=true,},   -- �j�Ѩ�
			[88684] = {enable=true,},   -- �t���N:��
			[89485] = {enable=true,},   -- ���F�M�`
			[126172] = {enable=true,},   -- �߽��B��
		},
		-- GroupEvent Alert / ��¾�~����ޯ��
		["GRPITEMS"] = {
			[1] = {
				enable=false,
				LocX = 0,
				LocY = -200,
				IconSize = 80,
				IconAlpha = 0.5,
				IconPoint = "Top",
				IconRelatePoint = "Top",
				-- ActiveTalentGroup=1,	-- nil for all, 1 for primary, 2 for secondary
				Spells = {
					[1] = {
						SpellIconID = 34433,	-- 34433 �t�v�c�]
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {
										SubCheckAndOp = true,
										EventType = "UNIT_POWER",
										UnitType = "player",
										PowerTypeNum = 0,
										PowerType = "MANA",
										CheckCD = 34433,
										PowerCompType = 2,
										PowerLessThanPercent = 70,
									},
								},
							},
						},
					},
				},
			},
			[2] = {
				enable=false,
				LocX = 80,
				LocY = -200,
				IconSize = 80,
				IconAlpha = 0.5,
				IconPoint = "Top",
				IconRelatePoint = "Top",
				ActiveTalentGroup=2,	-- nil for all, 1 for primary, 2 for secondary
				Spells = {
					[1] = {
						SpellIconID = 32379,	-- 32379 �t���N: ��
						Checks = {
							[1] = {	-- �ؼЦ�q�p�󵥩�25%�B�åB�t���N:�����bCD���C
								CheckAndOp = true,
								SubChecks = {
									[1] = {	-- �ؼЦ�q�p�󵥩�25%�B�åB�t���N:�����bCD���C
										SubCheckAndOp = true,		-- �i�L��
										EventType = "UNIT_HEALTH",	-- �ƥ�O�A�ݩ�"��q������"
										UnitType = "target",		-- �˴���H�A��"�ؼ�"
										CheckCD = 32379,		-- �˴�"�t���N: ��"�ޯ�O�_"CD��"
										HealthCompType = 2,		-- ��q, true:�p�󵥩�, false:�j�󵥩�
										HealthLessThanPercent = 25,	-- 25%
									},
								},
							},
						},
					},
				},
			},
			[3] = {
				enable=false,
				LocX = -80,
				LocY = -200,
				IconSize = 80,
				IconAlpha = 0.5,
				IconPoint = "Top",
				IconRelatePoint = "Top",
				ActiveTalentGroup=2,	-- nil for all, 1 for primary, 2 for secondary
				Spells = {
					[1] = {
						SpellIconID = 8092,	-- 8092 ���F�_�z
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {	-- ���z��CD�A�BMP��
										SubCheckAndOp = true,
										EventType = "UNIT_POWER",
										UnitType = "player",
										PowerTypeNum = 0,
										PowerType = "MANA",
										CheckCD = 8092,
										PowerCompType = 4,
										PowerLessThanValue = 3500,
									},
									[2] = {	-- �B �²y�s�b
										SubCheckAndOp = true,
										EventType = "UNIT_AURA",
										UnitType = "player",
										CheckAuraExist = 77487,
									},
								},
							},
							[2] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {	-- ���y��3��
										SubCheckAndOp = true,
										EventType = "UNIT_AURA",
										UnitType = "player",
										CheckAuraExist = 95799,
										TimeCompType = 2,
										TimeLessThanValue = 3,
									},
									[2] = {	-- �� ���y���s�b
										SubCheckAndOp = false,
										EventType = "UNIT_AURA",
										UnitType = "player",
										CheckAuraNotExist = 95799,
									},
									[3] = {	-- �� �²yx3
										SubCheckAndOp = false,
										EventType = "UNIT_AURA",
										UnitType = "player",
										CheckAuraExist = 77487,
										StackCompType = 4,
										StackLessThanValue = 3,
									},
								},
							},
						},
					},
					[2] = {
						SpellIconID = 34914,	-- 34914 �l�大Ĳ
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {	-- �l�大Ĳ��CD�A�BMP��
										SubCheckAndOp = true,
										EventType = "UNIT_POWER",
										UnitType = "player",
										PowerTypeNum = 0,
										PowerType = "MANA",
										CheckCD = 34914,
										PowerCompType = 4,
										PowerLessThanValue = 3300,
									},
								},
							},
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {	-- �l�大Ĳ��2��
										SubCheckAndOp = true,
										EventType = "UNIT_AURA",
										UnitType = "target",
										CastByPlayer = true,
										CheckAuraExist = 34914,
										TimeCompType = 2,
										TimeLessThanValue = 2,
									},
									[2] = {	-- �� �ؼШ��W �L �l�大Ĳ
										SubCheckAndOp = false,
										EventType = "UNIT_AURA",
										UnitType = "target",
										CastByPlayer = true,
										CheckAuraNotExist = 34914,
									},
								},
							},
						},
					},
					[3] = {
						SpellIconID = 589,	-- 589 �t���N:�h
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {
										SubCheckAndOp = true,
										EventType = "UNIT_POWER",
										UnitType = "player",
										PowerTypeNum = 0,
										PowerType = "MANA",
										CheckCD = 589,
										PowerCompType = 4,
										PowerLessThanValue = 4100,
									},
									[2] = {
										SubCheckAndOp = true,
										EventType = "UNIT_AURA",
										UnitType = "target",
										CastByPlayer = true,
										CheckAuraNotExist = 589,
									},
								},
							},
						},
					},
					[4] = {
						SpellIconID = 2944,	-- 2944 ���F�E��
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {
										SubCheckAndOp = true,
										EventType = "UNIT_POWER",
										UnitType = "player",
										PowerTypeNum = 0,
										PowerType = "MANA",
										CheckCD = 2944,
										PowerCompType = 4,
										PowerLessThanValue = 4800,
									},
									[2] = {
										SubCheckAndOp = true,
										EventType = "UNIT_AURA",
										UnitType = "target",
										CastByPlayer = true,
										CheckAuraNotExist = 2944,
									},
								},
							},
						},
					},
				},
			},
		},
	}


--------------------------------------------------------------------------------
-- Rogue / �s��
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_ROGUE] = {
		-- Primary Alert / ��¾�~������
		["ITEMS"] = {
			[5171] = {enable=true,},    -- ����
			[1966] = {enable=true,},    -- �˧�
			[57934] = {enable=true,},   -- ���Ѵ���
			[59628] = {enable=true,},   -- ���Ѵ���
			[58427] = {enable=true,},   -- ��������
			[84590] = {enable=true,},   -- �P�R���}
		},
		-- Alternate Alert / ��¾�~�B�~������
		["ALTITEMS"] = {
			[14251] = {enable=true,},   -- Riposte / ����
		},
		-- Target Alert / �ؼд�����
		["TARITEMS"] = {
			[1943] = {enable=true, self=true,},     -- �ε�
			[84617] = {enable=true, self=true,},    -- ��������
			[117737] = {enable=true, self=false,},	-- ���g (�]�j�s4��)
			[117756] = {enable=true, self=false,},	-- ���� (�]�j�s4��)
			[123059] = {enable=true, self=false,},	-- �ʷn (����5���W��buff)
			[123471] = {enable=true, self=false},	-- �W�j (���ߤ���2��)
			[126958] = {enable=true, self=false,},	-- �ǩԥd�٤�Ĳ (�]�j�s�p��)
			[127372] = {enable=true, self=false,},	-- ��í�w��M
			[131996] = {enable=true, self=false,},	-- �h�� (�׬u�x4���j��)			
			[132726] = {enable=true, self=false,},	-- ����
			[136431] = {enable=true, self=false,},	-- �t�߽��� (�p�^4���W��)
		},
		-- Spell Cooldown Alert / ��¾�~�ޯ�CD��
		["SCDITEMS"] = {
			[65961] = {enable=true,},   -- �t�v�ܭ�
			[79140] = {enable=true,},   -- �J��
		},
		-- GroupEvent Alert / ��¾�~����ޯ��
		["GRPITEMS"] = {
			[1] = {
				enable=false,
				LocX = 0,
				LocY = -200,
				IconSize = 80,
				IconAlpha = 0.5,
				IconPoint = "Top",
				IconRelatePoint = "Top",
				--ActiveTalentGroup=2,	-- nil for all, 1 for primary, 2 for secondary
				Spells = {
					[1] = {
						SpellIconID = 53,	-- 53 �I��
						Checks = {
							[1] = {
								CheckAndOp = true,
								SubChecks = {
									[1] = {
										SubCheckAndOp = true,
										EventType = "UNIT_POWER",
										UnitType = "player",
										PowerTypeNum = 3,
										PowerType = "ENERGY",
										CheckCD = 53,
										PowerCompType = 4,
										PowerLessThanValue = 40,
									},
									[2] = {
										SubCheckAndOp = true,
										EventType = "UNIT_HEALTH",
										UnitType = "target",
										HealthCompType = 2,
										HealthLessThanPercent = 35,
									},
								},
							},
						},
					},
				},
			},
		},
	}


--------------------------------------------------------------------------------
-- Shaman / �ĺ�
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_SHAMAN] = {
		-- Primary Alert / ��¾�~������
		["ITEMS"] = {
			[324] = {enable=true,},		-- �{�q����
			[16166] = {enable=true,},	-- ��q����
			[16188] = {enable=true,},	-- ��������
			[30884] = {enable=true,},	-- �۵M�u�@��
			[53390] = {enable=true,},	-- �v������
			[53817] = {enable=true, stack=5,},	-- ��x�Z��
			[73685] = {enable=true,},	-- ����j�a�ͩR
			[79206] = {enable=true,},	-- �F��̤���
			[105763] = {enable=true,},	-- ���F�E�y (�k�O����)
			[114050] = {enable=true,},	-- ���V�N�]�����^
			[114051] = {enable=true,},	-- ���V�N�]�W�j�^
			[114052] = {enable=true,},	-- ���V�N�]��_�^
			[114893] = {enable=true,},	-- �ۤ����S
			[118522] = {enable=true,},	-- ��������
		},
		-- Alternate Alert / ��¾�~�B�~������
		["ALTITEMS"] = {
		},
		-- Target Alert / �ؼд�����
		["TARITEMS"] = {
			[8050] = {enable=true, self=true,},		-- �P�K�_��
			[51514] = {enable=true, self=true,},	-- ���N
			[100955] = {enable=true, self=true,},	-- �p�^����
			[117737] = {enable=true, self=false,},	-- ���g (�]�j�s4��)
			[117756] = {enable=true, self=false,},	-- ���� (�]�j�s4��)
			[123059] = {enable=true, self=false,},	-- �ʷn (����5���W��buff)
			[123471] = {enable=true, self=false},	-- �W�j (���ߤ���2��)
			[126958] = {enable=true, self=false,},	-- �ǩԥd�٤�Ĳ (�]�j�s�p��)
			[127372] = {enable=true, self=false,},	-- ��í�w��M
			[131996] = {enable=true, self=false,},	-- �h�� (�׬u�x4���j��)			
			[132726] = {enable=true, self=false,},	-- ����
			[136431] = {enable=true, self=false,},	-- �t�߽��� (�p�^4���W��)
		},
		-- Spell Cooldown Alert / ��¾�~�ޯ�CD��
		["SCDITEMS"] = {
			[16166] = {enable=true,},	-- ��q����
			[16188] = {enable=true,},	-- ��������
			[16190] = {enable=true,},	-- �k�O�������
			[51505] = {enable=true,},	-- �����z�o
			[61295] = {enable=true,},	-- �E�y
			[73680] = {enable=true,},	-- ���񤸯���q
			[73920] = {enable=true,},	-- �v¡���B
			[79206] = {enable=true,},	-- �F��̤���
			[98008] = {enable=true,},	-- �F��s������
			[108270] = {enable=true,},	-- �ۤ����S����
			[108271] = {enable=true,},	-- �P���ಾ
			[108280] = {enable=true,},	-- ��¡�������
			[108285] = {enable=true,},	-- �����I��

		},
		-- GroupEvent Alert / ��¾�~����ޯ��
		["GRPITEMS"] = {
			[1] = {
				["enable"] = false,
				["LocX"] = 0,
				["LocY"] = -200,
				["IconSize"] = 80,
				["IconAlpha"] = 0.5,
				["IconPoint"] = "Top",
				["IconRelatePoint"] = "Top",
				["ActiveTalentGroup"] = 2,
				["HideOnLeaveCombat"] = true,
				["Spells"] = {
					[1] = {
						["SpellIconID"] = 51505,
						["Checks"] = {
							[1] = {
								["CheckAndOp"] = true,
								["SubChecks"] = {
									[1] = {
										["SubCheckAndOp"] = true,
										["EventType"] = "UNIT_POWER",
										["UnitType"] = "player",
										["PowerTypeNum"] = 0,
										["PowerType"] = "MANA",
										["CheckCD"] = 51505,
										["PowerCompType"] = 4,
										["PowerLessThanValue"] = 380,
									}, -- [1]
								},
							}, -- [1]
						},
					}, -- [1]
					[2] = {
						["SpellIconID"] = 8050,
						["Checks"] = {
							[1] = {
								["CheckAndOp"] = true,
								["SubChecks"] = {
									[1] = {
										["SubCheckAndOp"] = true,
										["EventType"] = "UNIT_AURA",
										["UnitType"] = "target",
										["CheckCD"] = 8050,
										["CheckAuraNotExist"] = 8050,
										["CastByPlayer"] = true,
									}, -- [1]
									[2] = {
										["SubCheckAndOp"] = false,
										["EventType"] = "UNIT_AURA",
										["UnitType"] = "target",
										["CastByPlayer"] = true,
										["CheckAuraExist"] = 8050,
										["CheckCD"] = 8050,
										["TimeCompType"] = 2,
										["TimeLessThanValue"] = 5,
									}, -- [2]
								},
							}, -- [1]
						},
					}, -- [2]
					[3] = {
						["SpellIconID"] = 8042,
						["Checks"] = {
							[1] = {
								["CheckAndOp"] = true,
								["SubChecks"] = {
									[1] = {
										["SubCheckAndOp"] = true,
										["EventType"] = "UNIT_AURA",
										["UnitType"] = "target",
										["CheckCD"] = 8042,
										["CastByPlayer"] = true,
										["CheckAuraExist"] = 8050,
										["TimeCompType"] = 5,
										["TimeLessThanValue"] = 5,
									}, -- [1]
									[2] = {
										["SubCheckAndOp"] = true,
										["EventType"] = "UNIT_AURA",
										["UnitType"] = "player",
										["CheckAuraExist"] = 324,
										["StackCompType"] = 4,
										["StackLessThanValue"] = 9,
									}, -- [2]
								},
							}, -- [1]
							[2] = {
								["CheckAndOp"] = false,
								["SubChecks"] = {
									[1] = {
										["SubCheckAndOp"] = true,
										["EventType"] = "UNIT_AURA",
										["UnitType"] = "target",
										["CheckCD"] = 8042,
										["CastByPlayer"] = true,
										["CheckAuraExist"] = 8050,
										["TimeCompType"] = 3,
										["TimeLessThanValue"] = 5,
									}, -- [1]
									[2] = {
										["SubCheckAndOp"] = true,
										["EventType"] = "UNIT_AURA",
										["UnitType"] = "player",
										["CheckAuraExist"] = 324,
										["StackCompType"] = 4,
										["StackLessThanValue"] = 7,
									}, -- [2]
								},
							}, -- [2]
						},
					}, -- [3]
				},
			}, -- [1]
			[2] = {
				["enable"] = false,
				["LocX"] = 0,
				["LocY"] = -200,
				["IconSize"] = 80,
				["IconAlpha"] = 0.5,
				["IconPoint"] = "Top",
				["IconRelatePoint"] = "Top",
				["ActiveTalentGroup"] = 2,
				["Spells"] = {
					[1] = {
						["SpellIconID"] = 324,
						["Checks"] = {
							[1] = {
								["CheckAndOp"] = true,
								["SubChecks"] = {
									[1] = {
										["SubCheckAndOp"] = true,
										["EventType"] = "UNIT_AURA",
										["UnitType"] = "player",
										["CheckCD"] = 324,
										["CheckAuraExist"] = 324,
										["CastByPlayer"] = true,
										["TimeCompType"] = 1,
										["TimeLessThanValue"] = 60,
									}, -- [1]
									[2] = {
										["SubCheckAndOp"] = false,
										["EventType"] = "UNIT_AURA",
										["UnitType"] = "player",
										["CheckAuraNotExist"] = 324,
									}, -- [2]
								},
							}, -- [1]
						},
					}, -- [1]
				},
			}, -- [2]
		},
	}


--------------------------------------------------------------------------------
-- Warlock / �N�h
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_WARLOCK] = {
		-- Primary Alert / ��¾�~������
		["ITEMS"] = {
			[18095] = {enable=true,},   -- �]��
			[19028] = {enable=true,},   -- �F���쵲
			[34939] = {enable=true,},   -- �Ͻ�
			[47283] = {enable=true,},   -- Empowered Imp / �j�O�p��
			[63158] = {enable=true,},   -- �O�h
			[63167] = {enable=true,},   -- �O�h
			[71165] = {enable=true,},   -- ��������
			[85383] = {enable=true,},   -- �j���F���
			[89937] = {enable=true,},   -- �]�Ƥ���
		},
		-- Alternate Alert / ��¾�~�B�~������
		["ALTITEMS"] = {
		},
		-- Target Alert / �ؼд�����
		["TARITEMS"] = {
			[172] = {enable=true, self=true,},      -- Corruption / �G�k�N
			[348] = {enable=true, self=true,},      -- Immolate / �m��
			[686] = {enable=true, self=true,},      -- ����a��
			[603] = {enable=true, self=true,},      -- �t�v�b
			[980] = {enable=true, self=true,},      -- �h�W�a��
			[1490] = {enable=true, self=true,},     -- Curse of the Elements / �����A�G
			[29722] = {enable=true, self=true,},    -- �N��
			[30108] = {enable=true, self=true,},    -- �h�W����
			[48181] = {enable=true, self=true,},    -- �k��N
			[50796] = {enable=true, self=true,},    -- �V�P�b
			[80240] = {enable=true, self=true,},    -- �E�T�a��
			[86000] = {enable=true, self=true,},    -- �j�����A�G
			[117737] = {enable=true, self=false,},	-- ���g (�]�j�s4��)
			[117756] = {enable=true, self=false,},	-- ���� (�]�j�s4��)
			[123059] = {enable=true, self=false,},	-- �ʷn (����5���W��buff)
			[123471] = {enable=true, self=false},	-- �W�j (���ߤ���2��)
			[126958] = {enable=true, self=false,},	-- �ǩԥd�٤�Ĳ (�]�j�s�p��)
			[127372] = {enable=true, self=false,},	-- ��í�w��M
			[131996] = {enable=true, self=false,},	-- �h�� (�׬u�x4���j��)			
			[132726] = {enable=true, self=false,},	-- ����
			[136431] = {enable=true, self=false,},	-- �t�߽��� (�p�^4���W��)
		},
		-- Spell Cooldown Alert / ��¾�~�ޯ�CD��
		["SCDITEMS"] = {
			[17962] = {enable=true,},   -- �I�N
			[59672] = {enable=true,},   -- �c�]�ƨ�
			[71165] = {enable=true,},   -- ��������
		},
		-- GroupEvent Alert / ��¾�~����ޯ��
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Warrior / �Ԥh
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_WARRIOR] = {
		-- Primary Alert / ��¾�~������
		["ITEMS"] = {
			[871] = {enable=true,},     -- ����(���m���A)
			[1134] = {enable=true,},    -- ���F����
			[2565] = {enable=true,},    -- �޵P����(���m���A)
			[12328] = {enable=true,},   -- �����(�԰��A�g�ɫ��A)
			[12964] = {enable=true,},   -- �԰��H��
			[12975] = {enable=true,},   -- �}��H��
			[14202] = {enable=true,},   -- �g��(���� 3)
			[16491] = {enable=true,},   -- �大�g��
			[20230] = {enable=true,},   -- ��������(�԰����A)
			[23885] = {enable=true,},   -- �ݦ�
			[23920] = {enable=true,},   -- �k�N�Ϯg(�԰��A���m���A)
			[29841] = {enable=true,},   -- �_�d����(����1)
			[32216] = {enable=true,},   -- �ӧQ
			[46916] = {enable=true,},   -- Bloodsurge (Slam) / ����m��
			[50227] = {enable=true,},   -- �C�ަX��
			[52437] = {enable=true,},   -- �J�`
			[55694] = {enable=true,},   -- �g���_
			[57516] = {enable=true,},   -- �g��(���� 2)
			[57519] = {enable=true,},   -- �g��(���� 2)
			[60503] = {enable=true,},   -- ��{����
			[65156] = {enable=true,},   -- �դ��i��
			[82368] = {enable=true,},   -- �ӧQ
			[84586] = {enable=true,},   -- �O�_(���� 3)
			[84620] = {enable=true,},   -- ��u�}�u
			[85730] = {enable=true,},   -- �I�۱���
			[86627] = {enable=true,},   -- �E��
			[87096] = {enable=true,},   -- �p��
			[90806] = {enable=true,},   -- �B�M��
		},
		-- Alternate Alert / ��¾�~�B�~������
		["ALTITEMS"] = {
		},
		-- Target Alert / �ؼд�����
		["TARITEMS"] = {
			[81326] = {enable=true, self=false},	-- ���z����
			[94009] = {enable=true, self=true,},    -- ����
			[115798] = {enable=true, self=false,},	-- �z�Ƨ���
			[117737] = {enable=true, self=false,},	-- ���g (�]�j�s4��)
			[117756] = {enable=true, self=false,},	-- ���� (�]�j�s4��)
			[123059] = {enable=true, self=false,},	-- �ʷn (����5���W��buff)
			[123471] = {enable=true, self=false},	-- �W�j (���ߤ���2��)
			[126958] = {enable=true, self=false,},	-- �ǩԥd�٤�Ĳ (�]�j�s�p��)
			[127372] = {enable=true, self=false,},	-- ��í�w��M
			[131996] = {enable=true, self=false,},	-- �h�� (�׬u�x4���j��)			
			[132726] = {enable=true, self=false,},	-- ����
			[136431] = {enable=true, self=false,},	-- �t�߽��� (�p�^4���W��)
		},
		-- Spell Cooldown Alert / ��¾�~�ޯ�CD��
		["SCDITEMS"] = {
		},
		-- GroupEvent Alert / ��¾�~����ޯ��
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Monk / �Z��
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_MONK] = {
		-- Primary Alert / ��¾�~������
		["ITEMS"] = {
			[115175] = {enable=true,},   -- �ΩM����
			[118674] = {enable=true,},   -- �묡�g��
			[119611] = {enable=true,},   -- �^�Ͱg��
			[120954] = {enable=true,},   -- �ۧε��C
			[125359] = {enable=true,},   -- ���
			[132120] = {enable=true,},   -- �g��·¶
		},
		-- Alternate Alert / ��¾�~�B�~������
		["ALTITEMS"] = {
		},
		-- Target Alert / �ؼд�����
		["TARITEMS"] = {
			[81326] = {enable=true, self=false},	-- ���z����
			[115078] = {enable=true, self=true,},   -- �I��
			[115175] = {enable=true, self=true,},   -- �ΩM����
			[115798] = {enable=true, self=false,},	-- �z�Ƨ���
			[119611] = {enable=true, self=true,},   -- �^�Ͱg��
			[132120] = {enable=true, self=true,},   -- �g��·¶
			[115798] = {enable=true, self=false,},	-- �z�Ƨ���
			[117737] = {enable=true, self=false,},	-- ���g (�]�j�s4��)
			[117756] = {enable=true, self=false,},	-- ���� (�]�j�s4��)
			[123059] = {enable=true, self=false,},	-- �ʷn (����5���W��buff)
			[123471] = {enable=true, self=false},	-- �W�j (���ߤ���2��)
			[126958] = {enable=true, self=false,},	-- �ǩԥd�٤�Ĳ (�]�j�s�p��)
			[127372] = {enable=true, self=false,},	-- ��í�w��M
			[131996] = {enable=true, self=false,},	-- �h�� (�׬u�x4���j��)			
			[132726] = {enable=true, self=false,},	-- ����
			[136431] = {enable=true, self=false,},	-- �t�߽��� (�p�^4���W��)
		},
		-- Spell Cooldown Alert / ��¾�~�ޯ�CD��
		["SCDITEMS"] = {
			[101545] = {enable=true,},   -- ���s�}
			[109132] = {enable=true,},   -- ����½
			[113656] = {enable=true,},   -- �g���s��
			[115008] = {enable=true,},   -- �u���s��
			[115078] = {enable=true,},   -- �I��
			[115080] = {enable=true,},   -- �խߴx
			[115098] = {enable=true,},   -- �u��i
			[115151] = {enable=true,},   -- �^�Ͱg��
			[115203] = {enable=true,},   -- �ۧε��C
			[115288] = {enable=true,},   -- �������C
			[115399] = {enable=true,},   -- �u���C
			[116705] = {enable=true,},   -- �ѥ�����
			[116847] = {enable=true,},   -- ���ɯe��
			[119381] = {enable=true,},   -- �����L
			[119392] = {enable=true,},   -- �K���ľW�i
			[122278] = {enable=true,},   -- ���l�Z
			[122470] = {enable=true,},   -- ���[����
			[122783] = {enable=true,},   -- ���]�Z
			[123904] = {enable=true,},   -- �l��ժ곷��
		},
		-- GroupEvent Alert / ��¾�~����ޯ��
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Other / ��¾�~�@�q��
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_OTHER] = {
		[17] = {enable=true,},		-- ���v - �u���N:��
		[7001] = {enable=true,},	-- ���v - �����u��_
		[10060] = {enable=true,},	-- ���v - �`�J��q
		[16191] = {enable=true,},	-- �ĺ� - �k�O�������
		[29166] = {enable=true,},	-- �w�|�� - �Ұ�
		[33206] = {enable=true,},	-- ���v - �h�W����
		[81782] = {enable=true,},	-- ���v - �u���N:��
		[98007] = {enable=true,},	-- �ĺ� - �F��s������

		[32182] = {enable=true,},	-- �ĺ� - �^�i��
		[80353] = {enable=true,},	-- �k�v - �ɶ��ᦱ
		[90355] = {enable=true,},	-- �y�H - �W�j�g��

		[104993] = {enable=true,},	-- �ɻ� (���])
		[116631] = {enable=true,},	-- ���� (���])
		[120032] = {enable=true,},	-- ���K���R (���])
		[125487] = {enable=true,},	-- ���� (���])
		[125488] = {enable=true,},	-- �t�� (���])
		[126266] = {enable=true,},	-- �һX (�Ū����G��)
		[126577] = {enable=true,},	-- ���F���� (�t�z����)
		[126582] = {enable=true,},	-- �������O (�p�����̫�R�O)
		[126599] = {enable=true,},	-- �e�t (�A�ɨ��r�蹳)
		[126640] = {enable=true,},	-- �P�� (�Ӷ�����)
		[126646] = {enable=true,},	-- Ĳ�I���� (���L����)
		[126657] = {enable=true,},	-- �B�� (�t���۴�)
		[128984] = {enable=true,},	-- �ѯ���� (����t��)
		[128985] = {enable=true,},	-- �ѯ���� (���N�t��)
		[128986] = {enable=true,},	-- �ѯ���� (����t��)
		[128987] = {enable=true,},	-- �ѯ���� (���s�t��)
		[128988] = {enable=true,},	-- �ѯ��@�� (����t��)
		[136087] = {enable=true,},	-- �x�ߪ� (�v�蠟ŧ����w�G��)
		[138728] = {enable=true,},	-- �Բ���i (�v�蠟ŧ����w�G��)
	
		[117878] = {enable=true,overgrow=6},	-- �W�� (�]�j�s�_�w5��-��Ա^)
		[118091] = {enable=true,overgrow=5},	-- ���p���a (�׬u�x1��)
		[118977] = {enable=true,redsectext=5},	-- �L�� (�׬u�x4��)
		[122752] = {enable=true,},	-- �t�v���� (�׬u�x2��)
		[122768] = {enable=true,overgrow=8},	-- ���Ƴ��v (�׬u�x2��)
		[122858] = {enable=true,},	-- ���Ţ�n (�׬u�x2��)
		[123081] = {enable=true,},	-- �ӷP (���ߤ���3��)
		[123121] = {enable=true,overgrow=8},	-- �Q�q (�׬u�x3��)
		[123180] = {enable=true,},	-- �e���B (���ߤ���2��)
		[123474] = {enable=true,overgrow=2},	-- ���˩�ŧ�� (���ߤ���2��)
		[123707] = {enable=true,overgrow=3},	-- �k�Ӥ��� (���ߤ���6��)
		[130742] = {enable=true,redsectext=5},	-- �L�� (�׬u�x4��)
		
		[136767] = {enable=true,overgrow=5},	-- �T����� (�p�^2��)
		[136903] = {enable=true,overgrow=9},	-- �Y�H���� (�p�^3��-����)
		[136911] = {enable=true,overgrow=9},	-- �Y�H���� (�p�^3��-����)
		[138002] = {enable=true,},	-- �y��ĪG (�p�^1���W��)
		[138349] = {enable=true,},	-- �R�q�ж� (�p�^1��)
		[138389] = {enable=true,},	-- �R�q�ж� (�p�^1��)
		
	}


end