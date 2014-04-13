-- For translations visit:  /  Per le traduzioni vai a:
-- http://wow.curseforge.com/addons/gogomount/localization/itIT/

if GetLocale() == "itIT" then
	BINDING_HEADER_GOGOHEADER = "GoGoMount"
	BINDING_NAME_GOGOBINDING = "Montare / Smontare" -- Needs review
	BINDING_NAME_GOGOBINDING2 = "Montare / Smontare (senza volo)" -- Needs review
	BINDING_NAME_GOGOBINDING3 = "Montare / Smontare Monti passeggeri" -- Needs review
	GoGo_Variables.Localize = {
	Skill = {
		Engineering = "Ingegneria", -- Needs review
		Riding = "Equitazione", -- Needs review
		Tailoring = "Sartoria", -- Needs review
	},
	String = {
		AutomaticallyRemoveBuffs = "Rimuovi automaticamente gli appassionati che impediscono il montaggio", -- Needs review
		AutoStartCrusaderAura = "Avvio automatico Crusader Aura", -- Needs review
		AutoStartCrusaderAura_Long = "Avvia automaticamente Crusader Aura quando si utilizza GoGoMount da montare.", -- Needs review
		Clear = "Cancella", -- Needs review
		ClearGlobalFavoriteMounts = "Cancella supporti globali preferiti", -- Needs review
		CurrentZone = "Zona di corrente", -- Needs review
		CurrentZoneDescription = "Monti contrassegnato qui come preferiti di zona sarà l'unica GoGoMount monti utilizzerà in questa zona. Tutti i supporti e altre forme di forma saranno ignorati. La deselezione di questa lista permette di utilizzare tutte GoGoMount supporti (o preferiti globali se impostato).", -- Needs review
		CurrentZoneExclusions = "Esclusioni zona corrente", -- Needs review
		CurrentZoneFavorites = "Preferiti zona corrente", -- Needs review
		DisableFlyingFromWater = "Disattivare volo da acqua", -- Needs review
		DisableInCombat = "Disattiva pulsanti GoGoMount in combattimento", -- Needs review
		DisableInCombat_Long = "Questa opzione disabilita pulsanti GoGoMount durante il combattimento. Utile per Druidi che carro armato in forma di orso e di premere accidentalmente i tasti GoGoMount. Deve essere abilitato o disabilitato prima di entrare in combattimento.", -- Needs review
		DisableUnknownMountNotices = "Disabilitare sconosciuto avvisi montaggio", -- Needs review
		DisableUpdateNotices = "Disattiva avvisi di aggiornamento", -- Needs review
		DruidFlightPreference = "Utilizzare sempre le forme di volo, invece di quando si muove solo", -- Needs review
		DruidOptions = "Opzioni di Druid", -- Needs review
		DruidSingleClick = "Un solo clic per passare da forma a forma di viaggio", -- Needs review
		EnableAutoDismount = "Attiva smontare automatico", -- Needs review
		ExtraPassengerMounts = "Extra Passenger Mounts", -- Requires localization
		ExtraPassengerMountsDescription = "This list of passenger mounts is used to add passenger mounts to the random selection only when the Passenger Mount button is pressed.  This will allow you to set preferred mount lists excluding passenger mounts but still have them available when using the Passenger Mount button.  These mounts will not be used if they are marked as excluded mounts globally or for the current zone you are in.", -- Requires localization
		Favorites = "Preferiti", -- Needs review
		GlobalExclusions = "Esclusioni globali", -- Needs review
		GlobalExclusionsDescription = "Monti sarà sempre ignorato. Anche se il montaggio qui selezionati sono impostati come preferiti, non saranno utilizzati.", -- Needs review
		GlobalFavorites = "Preferiti globali", -- Needs review
		GlobalPreferences = "Preferenze globali", -- Needs review
		GlobalZoneDescription = "Supporti preferiti qui definiti effetto solo se non ci sono particolari preferenze montaggio di zona previsti per la zona corrente in cui ti trovi", -- Needs review
		HunterOptions = "Hunter Opzioni", -- Needs review
		NewVersionFound = "Una versione più recente di GoGoMount è disponibile.", -- Needs review
		NoShapeInRandom = "Non casuale forme forma con i monti", -- Needs review
		PaladinOptions = "Opzioni Paladin", -- Needs review
		RemoveBuffs = "Rimuovere gli appassionati che possono prevenire il montaggio", -- Needs review
		RemoveBuffs_Long = "GoGoMount cercheranno di rimuovere buff e shapeforms che provengono da incantesimi e oggetti che impediscono il montaggio. Questo funziona solo per gli appassionati di note e, in alcuni casi richiedono 2 clic del tuo pulsante GoGoMount da montare.", -- Needs review
		ShamanOptions = "Shaman Options", -- Requires localization
		ShamanSingleClick = "Single click mount from Ghost Wolf Form instead of dismounting", -- Requires localization
		UnknownMountFound = "Un supporto sconosciuto è stato trovato in te nell'elenco dei monti. Si prega di segnalare questo in modo che può essere aggiunto alle future versioni di GoGoMount.", -- Needs review
		UseAspectOfThePackInstead = "Utilizzare Aspect of the Pack invece di Aspect Of The Cheeta", -- Needs review
		UseAspectOfThePackInstead_Long = "Quando è abilitato, GoGoMount lancerà Aspect of the Pack invece di Aspect of the Cheetah. Zona locale o le impostazioni globali ignorare questa impostazione. Se questo è impostato per utilizzare Aspect of the Pack e si ha Aspect of the Cheetah come preferito zona, Aspect of the Cheetah verrà utilizzato.", -- Needs review
		ZoneExclusionsDescription = "Esclusioni di zona specifiche funzionano come esclusioni globali ma specifiche per questa zona. Ogni montatura contrassegnato qui sotto come esclusione per la zona si sta lavorando nella non verrà mai convocato.", -- Needs review
	},
	Talent = {
		AncestralSwiftness = "Ancestral Swiftness", -- Requires localization
		FeralSwiftness = "Feral Swiftness", -- Requires localization
	},
	Zone = {
		AbyssalDepths = "Abyssal Depths", -- Requires localization
		AmaniMountains = "Amani Mountains", -- Requires localization
		AQ40 = "Ahn'Qiraj", -- Requires localization
		AzuremystIsle = "Azuremyst Isle", -- Requires localization
		BloodmystIsle = "Bloodmyst Isle", -- Requires localization
		CrumblingDepths = "Crumbling Depths", -- Requires localization
		Dalaran = "Dalaran", -- Requires localization
		DarkbreakCove = "Darkbreak Cove", -- Requires localization
		Deepholm = "Deepholm", -- Requires localization
		DireMaul = "Dire Maul", -- Requires localization
		EversongWoods = "Eversong Woods", -- Requires localization
		Ghostlands = "Ghostlands", -- Requires localization
		Icecrown = "Icecrown", -- Requires localization
		Ironforge = "Ironforge", -- Requires localization
		IsleOfQuelDanas = "Isle of Quel'Danas", -- Requires localization
		KrasusLanding = "Krasus' Landing", -- Requires localization
		LegionsRest = "Legion's Rest", -- Requires localization
		Lghorek = "L'ghorek", -- Requires localization
		Nespirah = "Nespirah", -- Requires localization
		ShimmeringExpanse = "Shimmering Expanse", -- Requires localization
		SholazarBasin = "Sholazar Basin", -- Requires localization
		SilvermoonCity = "Silvermoon City", -- Requires localization
		SilverTideHollow = "Silver Tide Hollow", -- Requires localization
		TempleOfBethekk = "Temple of Bethekk", -- Requires localization
		TempleOfEarth = "Tempio della Terra", -- Needs review
		TenebrousCavern = "Tenebrous Cavern", -- Requires localization
		ThalassianPass = "Thalassian Pass", -- Requires localization
		ThalassianRange = "Thalassian Range", -- Requires localization
		TheCerebrillum = "The Cerebrillum", -- Requires localization
		TheExodar = "The Exodar", -- Requires localization
		TheFrozenSea = "Il mare ghiacciato", -- Needs review
		TheOculus = "The Oculus", -- Requires localization
		TheStormPeaks = "La tempesta Peaks", -- Needs review
		TheTempleOfAtalHakkar = "The Temple of Atal'Hakkar", -- Requires localization
		TheUnderbelly = "The Underbelly", -- Requires localization
		TheVioletCitadel = "La Cittadella Viola", -- Needs review
		TheVortexPinnacle = "The Vortex Pinnacle", -- Requires localization
		TolBarad = "Tol Barad", -- Requires localization
		TolBaradPeninsula = "Tol Barad Peninsula", -- Requires localization
		TwistingNether = "Twisting Nether", -- Requires localization
		Vashjir = "Vashj'ir", -- Requires localization
		Wintergrasp = "Wintergrasp", -- Requires localization
	},
}

end --if