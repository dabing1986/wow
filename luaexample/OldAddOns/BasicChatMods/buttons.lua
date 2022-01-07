
if WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC then
	return
end

--[[     Button Hide Module     ]]--

local _, BCM = ...
BCM.modules[#BCM.modules+1] = function()
	if bcmDB.BCM_ButtonHide then return end

	local hideFunc = function(frame) frame:Hide() end
	ChatFrameMenuButton:HookScript("OnShow", hideFunc)
	ChatFrameMenuButton:Hide() --Hide the chat shortcut button for emotes/languages/etc
	ChatFrameChannelButton:HookScript("OnShow", hideFunc)
	ChatFrameChannelButton:Hide() --Hide the chat shortcut button for emotes/languages/etc

	BCM.chatFuncsPerFrame[#BCM.chatFuncsPerFrame+1] = function(_, n)
		local btnFrame = _G[n.."ButtonFrame"]
		btnFrame:HookScript("OnShow", hideFunc) --Hide the up/down arrows
		btnFrame:Hide() --Hide the up/down arrows
	end
end

