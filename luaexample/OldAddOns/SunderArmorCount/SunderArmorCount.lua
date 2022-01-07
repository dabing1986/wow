local addon = CreateFrame("FRAME", nil, UIParent)



local COLOR_RED = "|cFFFF0000"
local COLOR_GREEN = "|cFF1EFF00"
local COLOR_BLUE = "|cFF0070DD"
local COLOR_GOLD = "|cFFE6CC80"
local COLOR_TITLE = "|cffff6060"
local COLOR_RESET = "|r"
local version = 'v1.1'
local ADDON_NAME = COLOR_TITLE.."Sunder Armor Count 破甲统计 "..version..COLOR_RESET
local AddonMessagePrefix = 'SAC'

local spellTable = {
	1680, --旋风斩
	23881, --嗜血
	23892, 
	23893, 
	23894,
	11597, --破甲
}

local playerCount = {
	["effectSunderCount"] = 0,
	["inEffectSunderCount"] = 0,
	["notSunderCount"] = 0
}


function addon:CHAT_MSG_ADDON(prefix,text,channel,sender)
	if prefix == AddonMessagePrefix and channel == "RAID" then
		if text == 'checkVerison' then
			local version_msg = '破甲统计插件版本为 '..version
			SendChatMessage(version_msg, "RAID")
		end
	end
end

function addon:UNIT_SPELLCAST_SUCCEEDED(caster, castGUID, spellID)
	if caster == "player" then
		if tContains(spellTable, spellID) then -- Check if they cast one of the listed spells
			for i = 1, 16 do
				name, rank, count = UnitDebuff("target", i) 
				if name == "Expose Armor" then 
					self:ProgressSunder("EA", spellID)
					break
				end
				if name == "破甲攻击" then 
					self:ProgressSunder(count, spellID)
					break
				elseif i == 16 then -- No sunders
					self:ProgressSunder(0, spellID)
				end
			end
		end
	end
end

function addon:ProgressSunder(sunders, spellID)
	local guid = UnitGUID("target") or ""
	local targetId = tonumber(guid:match("-(%d+)-%x+$"), 10)

	if spellID == 11597 then
		if sunders == "EA" then 
			playerCount["inEffectSunderCount"] = playerCount["inEffectSunderCount"] + 1
		elseif sunders < 5 then
			playerCount["effectSunderCount"] = playerCount["effectSunderCount"] + 1
			C_ChatInfo.SendAddonMessage(AddonMessagePrefix, 'effectSunder-'..targetId , 'RAID')
		else
			playerCount["inEffectSunderCount"] = playerCount["inEffectSunderCount"] + 1
		end
	else
		if sunders ~= "EA" and sunders < 5 then 
			playerCount["notSunderCount"] = playerCount["notSunderCount"] + 1
		end
	end
end


function addon:PLAYER_ENTERING_WORLD(name)
    self:RegisterSlashCommands()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	C_ChatInfo.RegisterAddonMessagePrefix(AddonMessagePrefix)
    print(ADDON_NAME.." 已加载，输入 /sac -help 查看帮助")
end


function addon:RegisterSlashCommands()
    SLASH_SUNDERARMORCOUNT1 = "/SAC"
	SLASH_SUNDERARMORCOUNT2 = "/sac"
	SLASH_SUNDERARMORCOUNT3 = "/sunderArmorCount"
    SlashCmdList["SUNDERARMORCOUNT"] = function (text) self:SlashCommand(text) end
end


SAC_StringSplit = function(s, p)
    local rt = {}
    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
    return rt
end

SAC_Show = function() 
	local effectSunderMsg = format("有效破甲 %d", playerCount["effectSunderCount"])
	local inEffectSunderMsg = format("无效破甲 %d", playerCount["inEffectSunderCount"])
	local notSunderMsg = format("未满破技能数 %d", playerCount["notSunderCount"])
	print(COLOR_GREEN..effectSunderMsg..COLOR_RESET)
	print(COLOR_RED..inEffectSunderMsg..COLOR_RESET)
	print(COLOR_BLUE..notSunderMsg..COLOR_RESET)
end

SAC_Message = function()
	local flag = "SAC "..version 
	local effectSunderMsg = format(" 有效破甲 %d", playerCount["effectSunderCount"])
	local inEffectSunderMsg = format(" 无效破甲 %d", playerCount["inEffectSunderCount"])
	local notSunderMsg = format(" 未满破技能数 %d", playerCount["notSunderCount"])
	return flag..effectSunderMsg..inEffectSunderMsg..notSunderMsg
end

SAC_Help = function()
	print(ADDON_NAME.." 使用帮助")
	print("/sac -h    显示使用帮助")
	print("/sac -s    显示当前破甲统计")
	print("/sac -r    重置当前破甲统计")
	print("/sac -w <player>    密语发送破甲统计")
	print("/sac -m    显示更多信息")
end

SAC_More = function()
	print(ADDON_NAME.." 输入 /sac -help 查看帮助 \n《旧城》竞速团面向全服招募各职业精英玩家 帕奇维克转服已开 \n战网联系: houwanejie521@163.com \n游戏内联系: 猴子爱沫沫 弍哥 皆可")
end

function addon:SlashCommand(text)
	local lower_text = text:lower()
	local msg = SAC_StringSplit(lower_text," ")
	if msg[1] == '-r' or msg[1] == '-reset' then
		playerCount["effectSunderCount"] = 0
		playerCount["inEffectSunderCount"] = 0
		playerCount["notSunderCount"] = 0
		print(ADDON_NAME.." 已重置破甲统计")
		SAC_Show()
	elseif msg[1] == '-s' or msg[1] == '-show' then
		print(ADDON_NAME.." 当前破甲统计")
		SAC_Show()
	elseif (msg[1] == '-w' or msg[1] == '-whisper') and msg[2] then
		SendChatMessage(SAC_Message(), "WHISPER", nil, msg[2])
	elseif msg[1] == '-h' or msg[1] == '-help' then
		SAC_Help()
	elseif msg[1] == '-h' or msg[1] == '-help' then
		SAC_More()
	else
		SAC_More()
	end
end


addon:RegisterEvent("PLAYER_ENTERING_WORLD")
addon:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
addon:RegisterEvent("CHAT_MSG_ADDON")
addon:SetScript("OnEvent", function(self, event, ...)
    return self[event](self, ...)
end)