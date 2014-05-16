local _, ns = ...

local encounters = {
	-- Pandaria
	[132205] = 691, -- Sha of Anger
	[132206] = 725, -- Salyis' Warband
	[136381] = 814, -- Nalak, The Storm God
	[137554] = 826, -- Oondasta
	[148317] = 857, -- Chi-Ji, The Red Crane
	[148317] = 858, -- Yu'lon, The Jade Serpent
	[148317] = 859, -- Niuzao, The Black Ox
	[148317] = 860, -- Xuen, The White Tiger
	[148316] = 861, -- Ordos, Fire-God of the Yaungol

	-- Mogu'Shan Vaults
	[125144] = 679, -- The Stone Guard
	[132189] = 689, -- Feng the Accursed
	[132190] = 682, -- Gara'jal the Spiritbinder
	[132191] = 687, -- The Spirit Kings
	[132192] = 726, -- Elegon
	[132193] = 677, -- Will of the Emperor

	-- Heart of Fear
	[132194] = 745, -- Imperial Vizier Zor'lok
	[132195] = 744, -- Blade Lord Tay'ak
	[132196] = 713, -- Garalon
	[132197] = 741, -- Wind Lord Mel'jarak
	[132198] = 737, -- Amber-Shaper Un'sok
	[132199] = 743, -- Grand Empress Shek'zeer

	-- Terrace of Endless Spring
	[132200] = 683, -- Protectors of the Endless
	[132204] = 683, -- Protectors of the Endless (Elite)
	[132201] = 742, -- Tsulong
	[132202] = 729, -- Lei Shi
	[132203] = 709, -- Sha of Fear

	-- Throne of Thunder
	[139674] = 827, -- Jin'rokh the Breaker
	[139677] = 819, -- Horridon
	[139679] = 816, -- Council of Elders
	[139680] = 825, -- Tortos
	[139682] = 821, -- Magaera
	[139684] = 828, -- Ji'kun, the Ancient Mother
	[139686] = 818, -- Durumu the Forgotten
	[139687] = 820, -- Primordious
	[139688] = 824, -- Dark Animus
	[139689] = 817, -- Iron Qon
	[139690] = 829, -- Twin Consorts
	[139691] = 832, -- Lei Shen, The Thunder King
	[139692] = 831, -- Ra-den

	-- Siege of Orgrimmar
	[145909] = 852, -- Immerseus
	[145910] = 849, -- The Fallen Protectors
	[145911] = 866, -- Norushen
	[145912] = 867, -- Sha of Pride
	[145913] = 868, -- Galakras
	[145914] = 864, -- Iron Juggernaut
	[145915] = 856, -- Kor'kron Dark Shaman
	[145916] = 850, -- General Nazgrim
	[145917] = 846, -- Malkorok
	[145919] = 870, -- Spoils of Pandaria
	[145920] = 851, -- Thok the Bloodthirsty
	[145918] = 865, -- Siegecrafter Blackfuse
	[145921] = 853, -- Paragons of the Klaxxi
	[145922] = 869, -- Garrosh Hellscream
}

function ns.GetEncounterID(spellID)
	return encounters[spellID]
end
