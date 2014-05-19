------------------------------------------------------------
-- TerraceOfEndlessSpring.lua
-- 作者 Abin
-- 更新 小渔(www.fishui.net)
-- 2012/11/06
------------------------------------------------------------

local module = CompactRaid:FindModule("RaidDebuff")
if not module then return end

local TIER = 5 -- MOP
local INSTANCE = 320 -- Terrace of Endless Spring

--Protector Kaolan 683
module:RegisterDebuff(TIER, INSTANCE, 683, 117519) --Touch of Sha
module:RegisterDebuff(TIER, INSTANCE, 683, 111850) --Lightning Prison
module:RegisterDebuff(TIER, INSTANCE, 683, 117436) --Lightning Prison: Stunned
module:RegisterDebuff(TIER, INSTANCE, 683, 118191, 5) --Corrupted Essence
module:RegisterDebuff(TIER, INSTANCE, 683, 117986, 5) --Defiled Ground: Stacks
module:RegisterDebuff(TIER, INSTANCE, 683, 122874)
module:RegisterDebuff(TIER, INSTANCE, 683, 117235) --Purified (buff from Corrupted Waters)
module:RegisterDebuff(TIER, INSTANCE, 683, 117283) --Cleansing Waters (buff from Cleansing Waters, don't dispell off players, dispel off enemy targets)
module:RegisterDebuff(TIER, INSTANCE, 683, 117955) --Expelled Corruption: Elite Order only
module:RegisterDebuff(TIER, INSTANCE, 683, 117988) --Defiled Ground (This is the spellID doing damage in logs)

--Tsulong 742
module:RegisterDebuff(TIER, INSTANCE, 742, 122768, 5) --Dread Shadows
module:RegisterDebuff(TIER, INSTANCE, 742, 122752, 5) --Shadow Breath
module:RegisterDebuff(TIER, INSTANCE, 742, 122777) --Nightmares (dispellable)
module:RegisterDebuff(TIER, INSTANCE, 742, 122789) --Sunbeam
module:RegisterDebuff(TIER, INSTANCE, 742, 123012) --Terrorize: 5% (dispellable)
module:RegisterDebuff(TIER, INSTANCE, 742, 123011) --Terrorize: 10% (dispellable)
module:RegisterDebuff(TIER, INSTANCE, 742, 123036) --Fright (dispellable)
module:RegisterDebuff(TIER, INSTANCE, 742, 122858) --Bathed in Light

--Lei Shi 729
module:RegisterDebuff(TIER, INSTANCE, 729, 123121, 5) --Spray
module:RegisterDebuff(TIER, INSTANCE, 729, 123705, 5) --Scary Fog

--Sha of Fear 709
module:RegisterDebuff(TIER, INSTANCE, 709, 119414) --Breath of Fear
module:RegisterDebuff(TIER, INSTANCE, 709, 129147) --Onimous Cackle
module:RegisterDebuff(TIER, INSTANCE, 709, 119983, 5) --Dread Spray
module:RegisterDebuff(TIER, INSTANCE, 709, 120669) --Naked and Afraid
module:RegisterDebuff(TIER, INSTANCE, 709, 75683) --Waterspout
module:RegisterDebuff(TIER, INSTANCE, 709, 120629) --Huddle in Terror
module:RegisterDebuff(TIER, INSTANCE, 709, 120394) --Eternal Darkness
module:RegisterDebuff(TIER, INSTANCE, 709, 129189) --Sha Globe
module:RegisterDebuff(TIER, INSTANCE, 709, 119086) --Penetrating Bolt
module:RegisterDebuff(TIER, INSTANCE, 709, 119775) --Reaching Attack
module:RegisterDebuff(TIER, INSTANCE, 709, 117999)
module:RegisterDebuff(TIER, INSTANCE, 709, 119985)

--Trash
module:RegisterDebuff(TIER, INSTANCE, 0, 130115) --Grip of Fear (dispellable)
module:RegisterDebuff(TIER, INSTANCE, 0, 125758) --Overwhelming Fear (dispellable/interruptable)
module:RegisterDebuff(TIER, INSTANCE, 0, 125760, 5) --Enveloping Darkness  (dispellable)
