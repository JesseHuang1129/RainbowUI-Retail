if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2645, "DBM-Raids-WarWithin", 1, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250116171406")
mod:SetCreatureID(229953)--TODO, verify ID
mod:SetEncounterID(3015)
--mod:SetHotfixNoticeRev(20240921000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1216142 474461 472659 472782 470910 466470 466509 1221302 466518 472458 467379 466545 1221299 1214991 469491 1217791 1215953 1216142",
	"SPELL_CAST_SUCCESS 468658 468694 467380",
	"SPELL_AURA_APPLIED 466459 466460 1222408 472631 1214623 466476 467202 467225 467380 469369 1215595 1222948 469490 469391 1215898 471419",
	"SPELL_AURA_APPLIED_DOSE 466385 469391",
	"SPELL_AURA_REMOVED 466459 466460 1222408 467202 467380 469369 1222948 469490 1215898",--472631
	"SPELL_PERIODIC_DAMAGE 474554 470089 472057",
	"SPELL_PERIODIC_MISSED 474554 470089 472057",
	"UNIT_DIED"
--	"CHAT_MSG_RAID_BOSS_WHISPER",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, how double minded fury works. Do bosses reset energy on honcho rotations, or pause energy but resume where they left off?
--TODO, multiple EarthshakerGaol targets?
--TODO, timer starts/stops
--TODO, validate distance checks
--TODO, verify frostshatter boots cast events
--TODO, auto mark crawlers with https://www.wowhead.com/ptr-2/spell=466539/unstable-crawler-mines ?
--TODO, personal https://www.wowhead.com/ptr-2/spell=472061/unstable-crawler-mines tracking?
--TODO, https://www.wowhead.com/ptr-2/spell=469043/searing-shrapnel tracker?
--TODO, correct event for goblin guided rocket cast
--TODO, Volunteer Rocketeer spells? Rocket jump and Disintegration Beam
--TODO, detect Mk II Electro Shocker spawn for initial timers and possible spawn alert
--TODO, target scan Surging Arc?
--TODO, fastest event for double whammy
--TODO, fine tune tank swaps
--TODO, detect intermission start/end cleanly for best timer canceling
--TODO, announce https://www.wowhead.com/ptr-2/spell=463967/bloodlust ? it's passive for p2
--Stage One: The Heads of Security
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31662))
local warnHHMug										= mod:NewTargetNoFilterAnnounce(466459, 3)
local warnHHZee										= mod:NewTargetNoFilterAnnounce(466460, 3)
local warnHHMugZee									= mod:NewTargetNoFilterAnnounce(1222408, 2)
local warnMoxie										= mod:NewStackAnnounce(466385, 2)

local specWarnElementalCarnage						= mod:NewSpecialWarningSpell(468658, nil, nil, nil, 2, 2)
local specWarnUncontrolledDestruction				= mod:NewSpecialWarningSpell(468694, nil, nil, nil, 2, 2)
local specWarnDoubleMindedFury						= mod:NewSpecialWarningSpell(1216142, nil, nil, nil, 3, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(474554, nil, nil, nil, 1, 8)

--local timerDoubleMindedFuryCD						= mod:NewAITimer(97.3, 1216142, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
--Mug
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31677))
local warnSolidGold									= mod:NewTargetNoFilterAnnounce(467225, 2)

local specWarnEarthshakerGaol						= mod:NewSpecialWarningYou(474461, nil, nil, nil, 1, 2)
--local yellEarthshakerGaol							= mod:NewYell(474461)
--local yellEarthshakerGaolFades					= mod:NewShortFadesYell(474461)
local specWarnFrostshatterBoots						= mod:NewSpecialWarningYou(466476, nil, nil, nil, 1, 2)
local specWarnStormfuryFingerGun					= mod:NewSpecialWarningDodgeCount(466509, nil, nil, nil, 2, 15)
local specWarnMoltenGoldKnuckles					= mod:NewSpecialWarningDefensive(466518, nil, nil, nil, 1, 2)
local specWarnGoldenDripTaunt						= mod:NewSpecialWarningTaunt(467202, nil, nil, nil, 1, 2)
local specWarnGoldenDripMove						= mod:NewSpecialWarningKeepMove(467202, nil, nil, nil, 1, 2)

local timerEarthshakerGaolCD						= mod:NewAITimer(20.5, 474461, nil, nil, nil, 3)
local timerFrostshatterBootsCD						= mod:NewAITimer(20.5, 466476, nil, nil, nil, 3)
local timerStormfuryFingerGunCD						= mod:NewAITimer(20.5, 466509, nil, nil, nil, 3)
local timerMoltenGoldKnucklesCD						= mod:NewAITimer(20.5, 466518, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--Gallagio Goon
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31679))
local warnEnraged									= mod:NewTargetNoFilterAnnounce(1214623, 2)

local specWarnShakedown								= mod:NewSpecialWarningDodge(472659, nil, nil, nil, 2, 15)
local specWarnPayRespects							= mod:NewSpecialWarningInterruptCount(472782, "HasInterrupt", nil, nil, 1, 2)
local specWarnGaolBreak								= mod:NewSpecialWarningSpell(470910, nil, nil, nil, 2, 2)

--local timerShakedownCD							= mod:NewCDNPTimer(20.5, 472659, nil, nil, nil, 3)
--local timerPayRespectsCD							= mod:NewCDNPTimer(20.5, 472782, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
--Zee
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31693))
local warnUnstableCrawlerMines						= mod:NewCountAnnounce(466539, 2)
local warnSprayandPray								= mod:NewTargetNoFilterAnnounce(466545, 2)
local warnSurgingArc								= mod:NewCastAnnounce(1214991, 2)
local warnFaultyWiring								= mod:NewTargetNoFilterAnnounce(1215591, 1)
local warnElectroChargedShield						= mod:NewTargetNoFilterAnnounce(1222948, 2)

local specWarnGoblinGuidedRocket					= mod:NewSpecialWarningMoveTo(467380, nil, nil, nil, 1, 2)
local yellGoblinGuidedRocket						= mod:NewYell(467380)
local yellGoblinGuidedRocketFades					= mod:NewShortFadesYell(467380)
local specWarnSprayandPray							= mod:NewSpecialWarningMoveAway(466545, nil, nil, nil, 1, 2)
local yellSprayandPray								= mod:NewYell(466545)
local yellSprayandPrayFades							= mod:NewShortFadesYell(466545)
local specWarnDoubleWhammy							= mod:NewSpecialWarningDefensive(469491, nil, nil, nil, 1, 2)
local specWarnDoubleWhammyVictim					= mod:NewSpecialWarningYou(469491, nil, nil, nil, 1, 17)
local yellDoubleWhammy								= mod:NewYell(469491)
local yellDoubleWhammyFades							= mod:NewShortFadesYell(469491)
local specWarnDoubleWhammyTaunt						= mod:NewSpecialWarningTaunt(469490, nil, nil, nil, 1, 2)

local timerUnstableCrawlerMinesCD					= mod:NewAITimer(20.5, 466539, nil, nil, nil, 1)
local timerGoblinGuidedRocketCD						= mod:NewAITimer(20.5, 467380, nil, nil, nil, 3)
local timerSprayandPrayCD							= mod:NewAITimer(20.5, 466545, nil, nil, nil, 3)
--local timerSurgingArcCD							= mod:NewCDNPTimer(20.5, 1214991, nil, nil, nil, 3)
local timerDoubleWhammyCD							= mod:NewAITimer(20.5, 469491, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddPrivateAuraSoundOption(472354, true, 466539, 1)--Fixate debuff linked to unstable crawler mines
mod:AddNamePlateOption("NPAuraOnChargedShield", 1222948)
--Intermission: Bulletstorm
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30517))
local specWarnElectrocutionMatrix					= mod:NewSpecialWarningDodge(1216495, nil, nil, nil, 3, 2)
local specWarnStaticCharge							= mod:NewSpecialWarningYou(1215953, nil, nil, nil, 2, 2)
local yellStaticCharge								= mod:NewYell(1215953)
local yellStaticChargeFades							= mod:NewShortFadesYell(1215953)
local specWarnStaticChargeOther						= mod:NewSpecialWarningMoveTo(1215953, nil, nil, nil, 1, 2)
local specWarnBulletstorm							= mod:NewSpecialWarningDodgeCount(471419, nil, nil, nil, 2, 2)

local timerStaticChargeCD							= mod:NewAITimer(20.5, 1215953, nil, nil, nil, 3)
local timerBulletstormCD							= mod:NewAITimer(20.5, 471419, nil, nil, nil, 3)
--Stage Two: The Head Honcho
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30510))
local warnPhase2									= mod:NewPhaseAnnounce(2, nil, nil, nil, nil, nil, nil, 2)

mod.vb.gaolCount = 0
mod.vb.frostShatterCount = 0
mod.vb.fingerGunCount = 0
mod.vb.knucklesCount = 0
mod.vb.crawlerMinesCount = 0
mod.vb.goblinGuidedRocketCount = 0
mod.vb.sprayPrayCount = 0
mod.vb.whammyCount = 0
mod.vb.chargeCount = 0
mod.vb.bulletCount = 0
local castsPerGUID = {}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.gaolCount = 0
	self.vb.frostShatterCount = 0
	self.vb.fingerGunCount = 0
	self.vb.knucklesCount = 0
	self.vb.crawlerMinesCount = 0
	self.vb.goblinGuidedRocketCount = 0
	self.vb.sprayPrayCount = 0
	self.vb.whammyCount = 0
	self.vb.chargeCount = 0
	self.vb.bulletCount = 0
	table.wipe(castsPerGUID)
	self:EnablePrivateAuraSound(472354, "bombyou", 12)
	if self.Options.NPAuraOnChargedShield then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnChargedShield then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1216142 then
		specWarnDoubleMindedFury:Show()
		specWarnDoubleMindedFury:Play("stilldanger")
	elseif spellId == 474461 then
		self.vb.gaolCount = self.vb.gaolCount + 1
		timerEarthshakerGaolCD:Start()
	elseif spellId == 472659 then
		--timerShakedownCD:Start(nil, args.sourceGUID)
		if self:CheckBossDistance(args.sourceGUID, false, 17626, 13) then
			specWarnShakedown:Show()
			specWarnShakedown:Play("frontal")
		end
	elseif spellId == 470910 then
		if self:CheckBossDistance(args.sourceGUID, false, 17626, 13) then
			specWarnGaolBreak:Show()
			specWarnGaolBreak:Play("carefly")
		end
	elseif spellId == 472782 then
		--timerPayRespectsCD:Start(nil, args.sourceGUID)
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnPayRespects:Show(args.sourceName, count)
			if count == 1 then
				specWarnPayRespects:Play("kick1r")
			elseif count == 2 then
				specWarnPayRespects:Play("kick2r")
			elseif count == 3 then
				specWarnPayRespects:Play("kick3r")
			elseif count == 4 then
				specWarnPayRespects:Play("kick4r")
			elseif count == 5 then
				specWarnPayRespects:Play("kick5r")
			else
				specWarnPayRespects:Play("kickcast")
			end
		end
	elseif spellId == 466470 then
		self.vb.frostShatterCount = self.vb.frostShatterCount + 1
		timerFrostshatterBootsCD:Start()
	elseif spellId == 466509 or spellId == 1221302 then
		self.vb.fingerGunCount = self.vb.fingerGunCount + 1
		specWarnStormfuryFingerGun:Show(self.vb.fingerGunCount)
		specWarnStormfuryFingerGun:Play("frontal")
		timerStormfuryFingerGunCD:Start()
	elseif spellId == 466518 then
		self.vb.knucklesCount = self.vb.knucklesCount + 1
		timerMoltenGoldKnucklesCD:Start()
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnMoltenGoldKnuckles:Show()
			specWarnMoltenGoldKnuckles:Play("carefly")
		end
	elseif spellId == 472458 then
		self.vb.crawlerMinesCount = self.vb.crawlerMinesCount + 1
		warnUnstableCrawlerMines:Show(self.vb.crawlerMinesCount)
		timerUnstableCrawlerMinesCD:Start()
	elseif spellId == 467379 and self:AntiSpam(5, 1) then
		self.vb.goblinGuidedRocketCount = self.vb.goblinGuidedRocketCount + 1
		timerGoblinGuidedRocketCD:Start()
	elseif spellId == 466545 or spellId == 1221299 then
		self.vb.sprayPrayCount = self.vb.sprayPrayCount + 1
		timerSprayandPrayCD:Start()
	elseif spellId == 1214991 then
		warnSurgingArc:Show()
		--timerSurgingArcCD:Start(nil, args.sourceGUID)
	elseif spellId == 469491 then
		self.vb.whammyCount = self.vb.whammyCount + 1
		if self:IsTank() then
			specWarnDoubleWhammy:Show()
			specWarnDoubleWhammy:Play("defensive")
		end
		timerDoubleWhammyCD:Start()
	elseif spellId == 1217791 then
		specWarnElectrocutionMatrix:Show()
		specWarnElectrocutionMatrix:Play("watchstep")
	elseif spellId == 1215953 then
		self.vb.chargeCount = self.vb.chargeCount + 1
		timerStaticChargeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 468658 then
		specWarnElementalCarnage:Show()
		specWarnElementalCarnage:Play("aesoon")
	elseif spellId == 468694 then
		specWarnUncontrolledDestruction:Show()
		specWarnUncontrolledDestruction:Play("aesoon")
	elseif spellId == 467380 and self:AntiSpam(5, 1) then
		self.vb.goblinGuidedRocketCount = self.vb.goblinGuidedRocketCount + 1
		timerGoblinGuidedRocketCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 466459 then--Head Honcho: Mug
		warnHHMug:Show(args.destName)
		--Reset counts?
		self.vb.gaolCount = 0
		timerEarthshakerGaolCD:Start(1)
		timerFrostshatterBootsCD:Start(1)
		timerStormfuryFingerGunCD:Start(1)
		timerMoltenGoldKnucklesCD:Start(1)
	elseif spellId == 466460 then--Head Honcho: Zee
		warnHHZee:Show(args.destName)
		timerUnstableCrawlerMinesCD:Start(1)
		timerGoblinGuidedRocketCD:Start(1)
		timerSprayandPrayCD:Start(1)
		timerDoubleWhammyCD:Start(1)
	elseif spellId == 1222408 then--Head Honcho: Mug'Zee
		self:SetStage(2)
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		warnHHMugZee:Show(args.destName)
		timerEarthshakerGaolCD:Stop()
		timerFrostshatterBootsCD:Stop()
		timerStormfuryFingerGunCD:Stop()
		timerMoltenGoldKnucklesCD:Stop()
		timerUnstableCrawlerMinesCD:Stop()
		timerGoblinGuidedRocketCD:Stop()
		timerSprayandPrayCD:Stop()
		timerDoubleWhammyCD:Stop()
		--Restart all timers
		timerEarthshakerGaolCD:Start(2)
		timerFrostshatterBootsCD:Start(2)
		timerStormfuryFingerGunCD:Start(2)
		timerMoltenGoldKnucklesCD:Start(2)
		timerUnstableCrawlerMinesCD:Start(2)
		timerGoblinGuidedRocketCD:Start(2)
		timerSprayandPrayCD:Start(2)
		timerDoubleWhammyCD:Start(2)
	elseif spellId == 466385 then
		local amount = args.amount or 1
		if amount % 10 == 0 then
			warnMoxie:Show(args.destName, amount)
		end
	elseif spellId == 472631 then
		if args:IsPlayer() then
			specWarnEarthshakerGaol:Show()
			specWarnEarthshakerGaol:Play("targetyou")
			--yellEarthshakerGaol:Yell()
			--yellEarthshakerGaolFades:Countdown(spellId)
		end
	elseif spellId == 1214623 then
		warnEnraged:Show(args.destName)
	elseif spellId == 466476 then
		if args:IsPlayer() then
			specWarnFrostshatterBoots:Show()
			specWarnFrostshatterBoots:Play("targetyou")
		end
	elseif spellId == 467202 then
		if args:IsPlayer() then
			specWarnGoldenDripMove:Show()
			specWarnGoldenDripMove:Play("keepmove")
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnGoldenDripTaunt:Show(args.destName)
				specWarnGoldenDripTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 467225 then
		warnSolidGold:Show(args.destName)
	elseif spellId == 467380 then
		if args:IsPlayer() then
			specWarnGoblinGuidedRocket:Show(DBM_COMMON_L.ALLIES)
			specWarnGoblinGuidedRocket:Play("gathershare")
			yellGoblinGuidedRocket:Yell()
			yellGoblinGuidedRocketFades:Countdown(spellId)
		else
			if self:IsHard() then
				--Split soaking due to https://www.wowhead.com/ptr-2/spell=469076/radiation-sickness
				if self.vb.goblinGuidedRocketCount % 2 == 1 then
					specWarnGoblinGuidedRocket:Play("shareone")
				else
					specWarnGoblinGuidedRocket:Play("sharetwo")
				end
			else
				specWarnGoblinGuidedRocket:Play("helpsoak")
			end
		end
	elseif spellId == 469369 then
		if args:IsPlayer() then
			specWarnSprayandPray:Show()
			specWarnSprayandPray:Play("runout")
			yellSprayandPray:Yell()
			yellSprayandPrayFades:Countdown(spellId)
		else
			warnSprayandPray:Show(args.destName)
		end
	elseif spellId == 1215595 then
		warnFaultyWiring:Show(args.destName)
	elseif spellId == 1222948 then
		warnElectroChargedShield:Show(args.destName)
		if self.Options.NPAuraOnChargedShield then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 469490 then
		if args:IsPlayer() then
			specWarnDoubleWhammyVictim:Show()
			specWarnDoubleWhammyVictim:Play("lineyou")
			yellDoubleWhammy:Yell()
			yellDoubleWhammyFades:Countdown(spellId)
		end
	elseif spellId == 469391 and not args:IsPlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) and not DBM:UnitDebuff("player", spellId) then--Fine tune
			specWarnDoubleWhammyTaunt:Show(args.destName)
			specWarnDoubleWhammyTaunt:Play("tauntboss")
		end
	elseif spellId == 1215898 then
		if args:IsPlayer() then
			specWarnStaticCharge:Show()
			specWarnStaticCharge:Play("targetyou")
			yellStaticCharge:Yell()
			yellStaticChargeFades:Countdown(spellId)
		else
			specWarnStaticChargeOther:Show(args.destName)
			specWarnStaticChargeOther:Play("helpsoak")
		end
	elseif spellId == 471419 then
		self.vb.bulletCount = self.vb.bulletCount + 1
		specWarnBulletstorm:Show(self.vb.bulletCount)
		specWarnBulletstorm:Play("watchstep")
		timerBulletstormCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 466459 then--Head Honcho: Mug
		timerEarthshakerGaolCD:Stop()
		timerFrostshatterBootsCD:Stop()
		timerStormfuryFingerGunCD:Stop()
		timerMoltenGoldKnucklesCD:Stop()
	elseif spellId == 466460 then--Head Honcho: Zee
		timerUnstableCrawlerMinesCD:Stop()
		timerGoblinGuidedRocketCD:Stop()
		timerSprayandPrayCD:Stop()
		timerDoubleWhammyCD:Stop()
	elseif spellId == 1222408 then--Head Honcho: Mug'Zee

	--elseif spellId == 472631 then
	--	if args:IsPlayer() then
	--		yellEarthshakerGaolFades:Cancel()
	--	end
	elseif spellId == 467380 then
		if args:IsPlayer() then
			yellGoblinGuidedRocketFades:Cancel()
		end
	elseif spellId == 469369 then
		if args:IsPlayer() then
			yellSprayandPrayFades:Cancel()
		end
	elseif spellId == 1222948 then
		if self.Options.NPAuraOnChargedShield then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 469490 then
		if args:IsPlayer() then
			yellDoubleWhammyFades:Cancel()
		end
	elseif spellId == 1215898 then
		if args:IsPlayer() then
			yellStaticChargeFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 470089 or spellId == 474554 or spellId == 472057) and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 233474 then--gallagio goon
		--timerShakedownCD:Stop(args.destGUID)
		--timerPayRespectsCD:Stop(args.destGUID)
	elseif cid == 231788 then--unstable-cluster-mine

	elseif cid == 230316 then--mk-ii-electro-shocker
		--timerSurgingArcCD:Stop(args.destGUID)
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 433475 then

	end
end
--]]
