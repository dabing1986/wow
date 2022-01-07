------------------------------------------------------------
-- 战士输出循环
-- Fengshen，風神@匕首岭
-- 2020-7-14
------------------------------------------------------------

local module = DPSCycle:CreateModule("WARRIOR")
if not module then return end

local BATTLE_SHOUT = GetSpellInfo(6673)
local BATTLE_STANCE = GetSpellInfo(2457)
local BERSERKER_RAGE = GetSpellInfo(18499)
local BERSERKER_STANCE = GetSpellInfo(2458)
local BLOODRAGE = GetSpellInfo(2687)
local BLOODTHIRST = GetSpellInfo(23881)
local CHARGE = GetSpellInfo(100)
local CHALLENGING_SHOUT = GetSpellInfo(1161)
local CLEAVE = GetSpellInfo(845)
local CONCUSSION_BLOW = GetSpellInfo(12809)
--local DEATH_WISH = GetSpellInfo(12328)
local DEFENSIVE_STANCE = GetSpellInfo(71)
local DEMORALIZING_SHOUT = GetSpellInfo(1160)
local EXECUTE = GetSpellInfo(5308)
local EXPOSE_ARMOR = GetSpellInfo(8647)
local FLURRY = GetSpellInfo(12319)
local HAMSTRING = GetSpellInfo(1715)
local HERORIC_STRIKE = GetSpellInfo(78)
local INTERCEPT = GetSpellInfo(20252)
local LAST_STAND = GetSpellInfo(12975)
local MORTAL_STRIKE = GetSpellInfo(9347)
local OVERPOWER = GetSpellInfo(7384)
local PUMMEL = GetSpellInfo(6552)
local RECKLESSNESS = GetSpellInfo(1719)
local REND = GetSpellInfo(772)
local REVENGE = GetSpellInfo(6572)
local SHIELD_BASH = GetSpellInfo(72)
local SHIELD_BLOCK = GetSpellInfo(2565)
local SHIELD_SLAM = GetSpellInfo(23922)
local SHIELD_WALL = GetSpellInfo(871)
local SLAM = GetSpellInfo(1464)
local SUNDER_ARMOR = GetSpellInfo(7386)
local SWEEPING_STRIKES = GetSpellInfo(12292)
local TAUNT = GetSpellInfo(355)
local THUNDER_CLAP = GetSpellInfo(6343)
local WHIRLWIND = GetSpellInfo(1680)
local XUNZHAOKUANGWU = GetSpellInfo(2580)
local XIAOGUZHIREN = GetSpellInfo(21153)
local GANZHI = GetSpellInfo(20600)
local JIJIU = GetSpellInfo(3273)
local QIANGXIAOZHENGJIUZHUFU = GetSpellInfo(25895)
local ZHENGJIUZHUFU = GetSpellInfo(1038)
local BAOHUZHUFU = GetSpellInfo(1022)

module.cooldowns = { 3411, 871, 2565, 12975, 12328, 1719, 12292, 676 }

local dpswarrioraoe, dpswarriorhs, dpswarriorchaofeng, dpswarriortank
local incombat, dodgetime, dodgeGUID, swingtime, arr2, arr5, arr8, arr9, arr12, arr13, arr15, arr16, isOffHand, _
local dpswarriorframe = CreateFrame("Frame")
dpswarriorframe:RegisterEvent("PLAYER_REGEN_DISABLED")
dpswarriorframe:RegisterEvent("PLAYER_REGEN_ENABLED")
dpswarriorframe:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
dpswarriorframe:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_REGEN_DISABLED" then
		incombat = 1
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = nil
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		_, arr2, _, _, arr5, _, _, arr8, arr9, _, _, arr12, arr13, _, arr15, arr16, _, _, _, _, isOffHand = CombatLogGetCurrentEventInfo()
		if arr5 == UnitName("player") and (arr12 == "DODGE" or arr15 == "DODGE") then
			dodgetime = GetTime() or 0
			dodgeGUID = arr8
		end
		if arr5 == UnitName("player") and arr13 == OVERPOWER then
			dodgetime = 0
		end
		if arr5 == UnitName("player") and arr13 == SLAM then
			swingtime = GetTime() or 0
		end
		if arr5 == UnitName("player") and arr2 == ("SWING_DAMAGE" or "SWING_MISSED") and not (arr16 or isOffHand) then
			swingtime = GetTime() or 0
		end
	end
end)

function module:InMelee()
	local inmelee = IsSpellInRange(REND, "target")
	if inmelee == 1 then
		return 1
	else
		return nil
	end
end

function module:CanAE()
	local enemycount = 0
	for i = 1, 40 do
		local unit = "nameplate"..i
		if UnitCanAttack("player", unit) and IsSpellInRange(REND, unit) == 1 and self:UnitAura(unit, "变形术", 1) then
			enemycount = 1
			break
		end
		if UnitCanAttack("player", unit) and IsSpellInRange(REND, unit) == 1 and not self:UnitAura(unit, "放逐术", 1) then
			enemycount = enemycount + 1
		end
	end
	if enemycount > 1 then
		return 1
	else
		return nil
	end
end

function module:Canop()
	if not dodgetime then
		dodgetime = 0
	end
	local opCD = self:GetSpellCooldown(OVERPOWER)
	if opCD < 1 and (GetTime() - dodgetime) < 3.1 and UnitGUID("target") == dodgeGUID then
		return 1
	else
		return nil
	end
end

function module:CanSlam()
	if not swingtime then
		swingtime = 0
	end
	if IsCurrentSpell(20569) then
		return nil
	end
	if (GetTime() - swingtime) < 0.5 and GetUnitSpeed("target") == 0 and GetUnitSpeed("player") == 0 then
		return 1
	elseif (GetTime() - swingtime) < 1 and GetUnitSpeed("target") == 0 and GetUnitSpeed("player") == 0 and (GetShapeshiftFormID() == 17 or UnitPower("player") > 65) then
		return 1
	else
		return nil
	end
end

function module:UpgradeProc()
	-- if self:IsUsableSpell(EXECUTE) then
	-- 	return EXECUTE
	-- end

	if UnitPower("player") > 75 then
		return HERORIC_STRIKE
	end

	if self:IsUsableSpell(OVERPOWER) then
		return OVERPOWER
	end

	if self:IsUsableSpell(MORTAL_STRIKE, 1, 1) then
		return MORTAL_STRIKE
	end
--[[
	if self:IsUsableSpell(REND, 1) and not self:TargetDebuff(REND, 1) and hp > 10 then
		return REND
	end
--
--	if UnitPower("player") > 45 and self:IsUsableSpell(SLAM) then
	if self:CanSlam() and self:IsUsableSpell(SLAM) then
		return SLAM
	end
]]--
--	return SLAM
end

function module:ArmsProc()
	local istt = UnitIsUnit("targettarget", "player")

	if self:IsUsableSpell(THUNDER_CLAP, 1) and dpswarrioraoe then
		return THUNDER_CLAP
	end

	if UnitPower("player") > 75 then
		return HERORIC_STRIKE
	end

	if self:IsUsableSpell(MORTAL_STRIKE, 1, 1) then
		return MORTAL_STRIKE
	end

	if self:IsUsableSpell(HAMSTRING, 1, 1) then
		return MORTAL_STRIKE
	end

	if self:IsUsableSpell(OVERPOWER) then
		return OVERPOWER
	end

	-- if self:IsUsableSpell(EXECUTE, 1, 1) then
	-- 	return EXECUTE
	-- end

	if UnitPower("player") > 14 and self:CanSlam() and not istt and self:InMelee() and UnitName("target") ~= ("熔岩奔腾者") and (hp > 30 or self:IsStrongTarget()) then
		return SLAM
	end


	if self:PlayerBuffTime(BATTLE_SHOUT) < 3 then
		return BATTLE_SHOUT
	end
end

function module:FuryHS()
	local weaponspeed = UnitAttackSpeed("player")

	if not swingtime then
		swingtime = 0
	end

	if (swingtime + weaponspeed - GetTime()) < 0.3 and UnitPower("player") < 51 and IsCurrentSpell(11567) and GetShapeshiftFormID() ~= 17 then
		return JIJIU
	end

	if (GetTime() - swingtime) < 1 and not IsCurrentSpell(11567) then
		return HERORIC_STRIKE
	end

	return self:FuryProc()
end

function module:FuryProc()
	local istt = UnitIsUnit("targettarget", "player")
	local hp = self:UnitHealthPercent("target")
	local ihp = self:UnitHealthPercent("player")
	local chargeCD = self:GetSpellCooldown(CHARGE)
	local btCD = self:GetSpellCooldown(BLOODTHIRST)
	local _, _, _, _, zhanshuzhangwo = GetTalentInfo(1, 5)
	local base, posBuff, negBuff = UnitAttackPower("player")
	local playerAP = base + posBuff + negBuff;

	if not incombat and GetShapeshiftFormID() ~= 17 and UnitPower("player") < (zhanshuzhangwo * 5 + 1) and chargeCD < 1 then
		return BATTLE_STANCE
	end

	-- if self:Canop() and UnitPower("player") < (zhanshuzhangwo * 5 + 1) and UnitPower("player") > 4 and GetShapeshiftFormID() ~= 17 then
	-- 	return BATTLE_STANCE
	-- end

	if self:IsUsableSpell(OVERPOWER, 1, 1) then
		return OVERPOWER
	end

	if UnitPower("player") > 25 and self:InMelee() and GetShapeshiftFormID() == 17 and not IsCurrentSpell(11567) then
		return HERORIC_STRIKE
	end

	if incombat and UnitPower("player") < 26 and GetShapeshiftFormID() ~= 19 then
		return BERSERKER_STANCE
	end

	if self:PlayerBuffTime(BATTLE_SHOUT) < 3 then
		return BATTLE_SHOUT
	end

	if self:IsUsableSpell(WHIRLWIND, 1, 1) and self:CanAE() and self:InMelee() and UnitName("target") ~= ("维克尼拉斯大帝") then
		return WHIRLWIND
	end

	-- if self:IsUsableSpell(EXECUTE, 1, 1) then
	-- 	return EXECUTE
	-- end

	if self:IsUsableSpell(BLOODTHIRST, 1, 1) then
		return BLOODTHIRST
	end

	if self:IsUsableSpell(CLEAVE, 1, 1) and UnitPower("player") > 25 and self:CanAE() and self:InMelee() and not IsCurrentSpell(20569) and UnitName("target") ~= ("维克尼拉斯大帝") then
		return CLEAVE
	end
--[[
	if self:IsUsableSpell(DEATH_WISH, 1, 1) and self:InMelee() and not istt then
		return DEATH_WISH
	end
]]--
	if self:IsUsableSpell(BLOODRAGE, 1, 1) and UnitPower("player") < 30 and ihp > 55 and incombat then
		return BLOODRAGE
	end

	if self:IsUsableSpell(WHIRLWIND, 1, 1) and btCD > 4 and self:InMelee() and UnitName("target") ~= ("维克尼拉斯大帝") and UnitName("target") ~= ("克苏恩") then
		return WHIRLWIND
	end

	if self:IsUsableSpell(WHIRLWIND, 1, 1) and btCD > 2 and self:InMelee() and UnitName("target") ~= ("维克尼拉斯大帝") and UnitName("target") ~= ("克苏恩") and UnitPower("player") > 48 then
		return WHIRLWIND
	end

	if self:IsUsableSpell(WHIRLWIND, 1, 1) and self:InMelee() and UnitName("target") ~= ("维克尼拉斯大帝") and UnitName("target") ~= ("克苏恩") and UnitPower("player") > 54 then
		return WHIRLWIND
	end

	if self:IsUsableSpell(BERSERKER_RAGE, 1, 1) and incombat and istt then
		return BERSERKER_RAGE
	end

	if self:IsUsableSpell(HERORIC_STRIKE, 1, 1) and UnitPower("player") > 60 and not IsCurrentSpell(11567) then
		return UnitName("target") == ("堕落的瓦拉斯塔兹") and CLEAVE or HERORIC_STRIKE
	end

	if self:IsUsableSpell(HERORIC_STRIKE, 1, 1) and btCD > 4 and UnitName("target") ~= ("堕落的瓦拉斯塔兹") and UnitPower("player") > 32 and not IsCurrentSpell(11567) then
		return HERORIC_STRIKE
	end

	if self:IsUsableSpell(HERORIC_STRIKE, 1, 1) and btCD > 2 and UnitName("target") ~= ("堕落的瓦拉斯塔兹") and UnitPower("player") > 42 and not IsCurrentSpell(11567) then
		return HERORIC_STRIKE
	end

	if self:IsUsableSpell(BERSERKER_RAGE, 1, 1) and incombat and UnitName("target") ~= ("奥妮克希亚") and UnitName("target") ~= ("玛格曼达") and UnitName("target") ~= ("奈法利安") and UnitName("target") ~= ("古拉巴什狂暴者") and UnitName("target") ~= ("格拉斯") and self:InMelee() then
		return BERSERKER_RAGE
	end
end

function module:TwoHandFury()
	local istt = UnitIsUnit("targettarget", "player")
	local hp = self:UnitHealthPercent("target")
	local ihp = self:UnitHealthPercent("player")
	local chargeCD = self:GetSpellCooldown(CHARGE)
	local btCD = self:GetSpellCooldown(BLOODTHIRST)
	local wwCD = self:GetSpellCooldown(WHIRLWIND)
	local base, posBuff, negBuff = UnitAttackPower("player")
	local playerAP = base + posBuff + negBuff;

	--UnitIsTapped("target") and not UnitIsTappedByPlayer("target")

	if not incombat and GetShapeshiftFormID() ~= 17 and UnitPower("player") < 26 and chargeCD < 1 then
		return BATTLE_STANCE
	end

	-- if self:Canop() and UnitPower("player") < 26 and UnitPower("player") > 4 and GetShapeshiftFormID() ~= 17 then
	-- 	return BATTLE_STANCE
	-- end

	if self:IsUsableSpell(OVERPOWER, 1, 1) then
		return OVERPOWER
	end

	-- if incombat and UnitPower("player") < 26 and GetShapeshiftFormID() ~= 19 and not self:Canop() then
	-- 	return BERSERKER_STANCE
	-- end

	if self:PlayerBuffTime(BATTLE_SHOUT) < 3 then
		return BATTLE_SHOUT
	end

	if self:IsUsableSpell(WHIRLWIND, 1, 1) and self:CanAE() and self:InMelee() and UnitName("target") ~= ("维克尼拉斯大帝") then
		return WHIRLWIND
	end

	-- if self:IsUsableSpell(EXECUTE, 1, 1) then
	-- 	return EXECUTE
	-- end

	if self:IsUsableSpell(BLOODTHIRST, 1, 1) and playerAP > 1200 then
		return BLOODTHIRST
	end

	if self:IsUsableSpell(CLEAVE, 1, 1) and UnitPower("player") > 25 and self:CanAE() and self:InMelee() and wwCD > 0.1 and not IsCurrentSpell(20569) and UnitInRaid("player") and UnitName("target") ~= ("维克尼拉斯大帝") then
		return CLEAVE
	end

	if self:IsUsableSpell(WHIRLWIND, 1, 1) and self:InMelee() and UnitName("target") ~= ("维克尼拉斯大帝") and UnitName("target") ~= ("克苏恩") then
		return WHIRLWIND
	end

	if self:IsUsableSpell(BLOODTHIRST, 1, 1) then
		return BLOODTHIRST
	end

	if UnitPower("player") > 38 and self:CanSlam() and not istt and self:InMelee() and UnitName("target") ~= ("熔岩奔腾者" or "堕落的瓦拉斯塔兹") and (hp > 30 or self:IsStrongTarget()) then
		return SLAM
	end

	if UnitPower("player") > 25 and self:CanSlam() and self:InMelee() and GetShapeshiftFormID() == 17 and btCD > 0.5 and UnitName("target") ~= ("堕落的瓦拉斯塔兹") then
		return SLAM
	end
--[[
	if self:IsUsableSpell(DEATH_WISH, 1, 1) and self:InMelee() and not istt then
		return DEATH_WISH
	end
]]--
	if self:IsUsableSpell(BERSERKER_RAGE) and incombat and istt then
		return BERSERKER_RAGE
	end

	if self:IsUsableSpell(BLOODRAGE) and UnitPower("player") < 30 and ihp > 55 and incombat then
		return BLOODRAGE
	end

	if self:IsUsableSpell(HERORIC_STRIKE, 1, 1) and UnitPower("player") > 84 then
		return UnitName("target") == ("堕落的瓦拉斯塔兹") and CLEAVE or HERORIC_STRIKE
	end

	if self:IsUsableSpell(BERSERKER_RAGE) and incombat and UnitName("target") ~= ("奥妮克希亚") and UnitName("target") ~= ("玛格曼达") and UnitName("target") ~= ("奈法利安") and UnitName("target") ~= ("古拉巴什狂暴者") and UnitName("target") ~= ("格拉斯") and self:InMelee() then
		return BERSERKER_RAGE
	end
end

function module:FuryTank()
	local istt = UnitIsUnit("targettarget", "player")
	local hp = self:UnitHealthPercent("target")
	local chargeCD = self:GetSpellCooldown(CHARGE)

	if self:PlayerBuff("保护祝福") or self:PlayerBuff("拯救祝福") or self:PlayerBuff(QIANGXIAOZHENGJIUZHUFU) then
		return JIJIU
	end

	if not incombat and GetShapeshiftFormID() ~= 17 and UnitPower("player") < 26 and chargeCD < 1 then
		return BATTLE_STANCE
	end

	if self:PlayerBuff(BERSERKER_RAGE) and GetShapeshiftFormID() ~= 18 then
		return DEFENSIVE_STANCE
	end

	if self:IsUsableSpell(CLEAVE, 1) and UnitPower("player") > 60 and self:CanAE() and not IsCurrentSpell(20569) and UnitName("target") ~= ("维克尼拉斯大帝") then
		return CLEAVE
	end

	-- if hp < 20 and UnitName("target") == ("堕落的瓦拉斯塔兹") and GetShapeshiftFormID() == 17 then
	-- 	return EXECUTE
	-- end

	-- if self:IsUsableSpell(EXECUTE, 1, 1) then
	-- 	return EXECUTE
	-- end

	if incombat and UnitPower("player") < 26 and GetShapeshiftFormID() ~= 18 then
		return DEFENSIVE_STANCE
	end

	if self:IsUsableSpell(BLOODTHIRST, 1) and UnitPower("player") > 49 then
		return BLOODTHIRST
	end

	if self:IsUsableSpell(REVENGE, 1) then
		return REVENGE
	end

	if self:IsUsableSpell(BLOODTHIRST, 1, 1) and GetShapeshiftFormID() == 17 then
		return BLOODTHIRST
	end

	if self:IsUsableSpell(HERORIC_STRIKE, 1) and UnitPower("player") > 60 and not IsCurrentSpell(11567) then
		return HERORIC_STRIKE
	end

	if self:IsUsableSpell(HERORIC_STRIKE, 1) and not IsCurrentSpell(11567) and self:TargetDebuffStack(SUNDER_ARMOR) > 4 then
		return HERORIC_STRIKE
	end

	if self:TargetDebuffTime(SUNDER_ARMOR) < 3 or self:TargetDebuffStack(SUNDER_ARMOR) < 5 then
		return SUNDER_ARMOR
	end

	if self:IsUsableSpell(HERORIC_STRIKE, 1) and not IsCurrentSpell(11567) then
		return HERORIC_STRIKE
	end

	if UnitPower("player") > 65 then
		return SUNDER_ARMOR
	end
end

function module:ChaoFeng()
	local istt = UnitIsUnit("targettarget", "player")
	local hp = self:UnitHealthPercent("target")
	local chaofengCD = self:GetSpellCooldown(TAUNT)
	local chengjietongjiCD = self:GetSpellCooldown(CONCUSSION_BLOW)
	local tiaozhannuhouCD = self:GetSpellCooldown(CHALLENGING_SHOUT)

	if self:IsUsableSpell(TAUNT, 1, 1) and not (self:TargetDebuff(TAUNT) or self:TargetDebuff(CONCUSSION_BLOW) or self:TargetDebuff(CHALLENGING_SHOUT)) and not istt then --古拉巴什狂暴者
		return TAUNT
	end

	if GetShapeshiftFormID() ~= 17 and chengjietongjiCD < 1 and chaofengCD > 1 then
		return BATTLE_STANCE
	end

	if self:IsUsableSpell(CONCUSSION_BLOW, 1, 1) and chaofengCD > 1 and not (self:TargetDebuff(TAUNT) or self:TargetDebuff(CONCUSSION_BLOW) or self:TargetDebuff(CHALLENGING_SHOUT)) and not istt then
		return CONCUSSION_BLOW
	end

	if GetShapeshiftFormID() ~= 18 and chengjietongjiCD > 1 and hp > 20 then
		return DEFENSIVE_STANCE
	end

	if self:IsUsableSpell(CHALLENGING_SHOUT, 1, 1) and chaofengCD > 1 and chengjietongjiCD > 1 and not (self:TargetDebuff(TAUNT) or self:TargetDebuff(CONCUSSION_BLOW) or self:TargetDebuff(CHALLENGING_SHOUT)) and not istt then
		return CHALLENGING_SHOUT
	end

	return spec == 2 and self:FuryTank() or self:ProtectionProc()
end

function module:ProtectionProc()
	local chargeCD = self:GetSpellCooldown(CHARGE)

	if self:PlayerBuff("保护祝福") or self:PlayerBuff("拯救祝福") or self:PlayerBuff(QIANGXIAOZHENGJIUZHUFU) then
		return JIJIU
	end

	if not incombat and GetShapeshiftFormID() ~= 17 and UnitPower("player") < 26 and chargeCD < 1 then
		return BATTLE_STANCE
	end

	if self:PlayerBuff(BERSERKER_RAGE) and GetShapeshiftFormID() ~= 18 then
		return DEFENSIVE_STANCE
	end

	if self:IsUsableSpell(CLEAVE, 1) and UnitPower("player") > 60 and self:CanAE() and not IsCurrentSpell(20569) and UnitName("target") ~= ("维克尼拉斯大帝") then
		return CLEAVE
	end

	-- if self:IsUsableSpell(EXECUTE, 1, 1) then
	-- 	return EXECUTE
	-- end

	-- if incombat and UnitPower("player") < 26 and GetShapeshiftFormID() ~= 18 then
	-- 	return DEFENSIVE_STANCE
	-- end

	if self:IsUsableSpell(SHIELD_SLAM, 1) and UnitPower("player") > 45 then
		return SHIELD_SLAM
	end

	if self:IsUsableSpell(REVENGE, 1) then
		return REVENGE
	end

	if self:IsUsableSpell(SHIELD_SLAM, 1) then
		return SHIELD_SLAM
	end

	if self:IsUsableSpell(HERORIC_STRIKE, 1) and UnitPower("player") > 60 and not IsCurrentSpell(11567) then
		return HERORIC_STRIKE
	end

	if self:TargetDebuffTime(SUNDER_ARMOR) < 3 or self:TargetDebuffStack(SUNDER_ARMOR) < 5 then
		return SUNDER_ARMOR
	end

	if self:IsUsableSpell(HERORIC_STRIKE, 1) and not IsCurrentSpell(11567) then
		return HERORIC_STRIKE
	end

	if UnitPower("player") > 65 then
		return SUNDER_ARMOR
	end
end

function module:OnSpellRequest(spec, strongTarget)
	if self:IsUsableSpell(CHARGE, 1, 1, 1) then
		return CHARGE
	end
	if dpswarriorhs and not dpswarrioraoe then
		return self:FuryHS()
	end
	if dpswarriorchaofeng then
		return self:ChaoFeng()
	end
	if dpswarriortank then
		return self:FuryTank()
	elseif spec == 1 then
		return self:ArmsProc()
	elseif spec == 2 then
		if self:IsDualWield() then
			local OffHandLink = GetInventoryItemLink("player", 17)
			local OffHandType = select(7, GetItemInfo(OffHandLink))
			if OffHandType == "盾牌" then
				return self:FuryTank()
			else
				return self:FuryProc()
			end
		else
			return self:TwoHandFury()
		end
	elseif spec == 3 then
		return self:ProtectionProc()
	end
end

SLASH_DPSWARRIOR1 = "/dpswarrior"
SLASH_DPSWARRIOR2 = "/warr"
SlashCmdList["DPSWARRIOR"] = function(msg)
	local command = string.lower(msg)
	if (command == "ae") then
		if dpswarrioraoe then
			dpswarrioraoe = nil
			print("solo solo solo")
		else
			dpswarrioraoe = 1
			print("open AE mode.")
		end
	elseif (command == "hs") then
		if dpswarriorhs then
			dpswarriorhs = nil
			print("恢复常用输出循环")
		else
			dpswarriorhs = 1
			print("开启极限英勇模式")
		end
	elseif (command == "tank") then
		if dpswarriortank then
			dpswarriortank = nil
			print("取消强制狂暴双持坦克")
		else
			dpswarriortank = 1
			print("开启强制狂暴双持坦克模式")
		end
	elseif (command == "chaofeng") then
		if dpswarriorchaofeng then
			dpswarriorchaofeng = nil
			print("关闭嘲讽模式，恢复常用坦克循环")
		else
			dpswarriorchaofeng = 1
			print("开启嘲讽模式，保证目标为自己。")
		end
	elseif (command == "") then
		print("请使用参数ae开关AE模式，使用参数hs开关极限英勇模式，使用参数chaofeng开关坦克嘲讽模式，使用参数tank开关狂暴双持坦克模式。")
	end
end