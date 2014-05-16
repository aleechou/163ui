-- -------------------------------------------------------------------------- --
-- BattlegroundTargets - localized battleground names                         --
-- Please make sure to save this file as UTF-8. ¶                             --
-- -------------------------------------------------------------------------- --

local BGN, _, prg = {}, ...
prg.BGN = BGN

local locale = GetLocale()
if locale == "frFR" then --> tested with Patch 5.3.0.17128-frFR (LIVE)
	-- GetBattlegroundInfo() : L'Œil du cyclone
	-- GetBattlefieldStatus(): L’Œil du cyclone
	BGN["L’Œil du cyclone"] = "L'Œil du cyclone" -- Eye of the Storm
	-- GetBattlegroundInfo() : Vallée d'Alterac
	-- GetBattlefieldStatus(): Vallée d’Alterac
	BGN["Vallée d’Alterac"] = "Vallée d'Alterac" -- Alterac Valley
end