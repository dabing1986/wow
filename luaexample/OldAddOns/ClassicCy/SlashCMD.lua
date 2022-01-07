----------
--SlashCMD Modified by yeunga[NGA] 2019-12-01
----------
SLASH_ClassicCy1 = "/ccy"
SLASH_ClassicCy2 = "/classiccy"
SLASH_ClassicCy3 = "/CCY"
SLASH_ClassicCy4 = "/ClassicCy"

CCY_StringSplit = function(s, p)
    local rt = {}
    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
    return rt

end

SlashCmdList["ClassicCy"] = function(text)
	text = text:lower()
	msg = CCY_StringSplit(text," ")

	if msg[1] == "c" and msg[2] then
		if msg[2] == "on" then 
			CCYtable[1] = true
			print("ClassicCy_CombatHint:on 交战提示已打开")		
		elseif msg[2] == "off" then 
			CCYtable[1] = false
			print("ClassicCy_CombatHint:off 交战提示已关闭")
		end
	elseif msg[1] == "i" and msg[2] then
		if msg[2] == "on" then 
			CCYtable[2] = true
			print("ClassicCy_InterruptHint:on 打断提示已打开")
		elseif msg[2] == "off" then 
			CCYtable[2] = false
			print("ClassicCy_InterruptHint:off 打断提示已关闭")
		end
	elseif msg[1] == "q" then
		if CCYtable[1] == true then print("CMD_CCYtable[1] = true") end
		if CCYtable[1] == false then print("CMD_CCYtable[1] = false") end
		if CCYtable[2] == true then print("CMD_CCYtable[2] = true") end
		if CCYtable[2] == false then print("CMD_CCYtable[2] = false") end
	elseif (#msg < 1 or msg[1] =="" or msg[1] == " " or msg[1] == "?" or msg[1] == "help" or msg[1] == "？") then
		print(" ClassicCy 命令格式：")
		print("/ccy c on或off - 打开或关闭交战提示")
		print("/ccy i on或off - 打开或关闭打断提示")
		print("/ccy q 查询当前开关状态")
	end	
end

----------
--LOADING HINT FOR DEBUG
----------
--print("ClassicCy_SlashCMD 加载成功") -- for debug
