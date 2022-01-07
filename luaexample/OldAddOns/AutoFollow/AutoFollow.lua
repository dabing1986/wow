----------------
---AutoFollow---
----------------
--Novaspark-Arugal OCE (classic) / Venomisto-Frostmourne OCE (retail).
--https://www.curseforge.com/members/venomisto/projects
--Spams /follow <name> every 2 seconds.
--Use /af playername to start it, or just /af with a player target selected.
--Use /af stop to end it.
--Pauses follow when drinking/eating.

local afEnabled, followTarget;

local function isDrinkingOrEating()
	for i = 1, 32 do
		local name, _, _, _, _, expirationTime = UnitBuff("player", i);
		if (name and (name == "Drink" or name == "Food" or name == "Refreshment")) then
			return true;
		end
	end
end

local function doAutoFollow()
	if (afEnabled) then
		C_Timer.After(2, function()
			if (afEnabled) then
				if (not isDrinkingOrEating()) then
					FollowUnit(followTarget, true);
				end
			end
			doAutoFollow();
		end)
	end
end

local function startAutoFollow(msg)
	print("|cffff8700AutoFollowing " .. msg .. " every 2 seconds. (Type \"/af stop\" to stop)");
	FollowUnit(msg, true);
	afEnabled = true;
	followTarget = msg;
	doAutoFollow();
end

local function printHelp(msg)
	print("|cffff8700AutoFollow Help:");
	print("|cffff8700Type \"/af playername\" to start following every 2 seconds.");
	print("|cffff8700Or just type \"/af\" with a player targeted.");
	print("|cffff8700To stop type \"/af stop\".");
end

local followspam = CreateFrame("Frame");
SLASH_PUNKAF1, SLASH_PUNKAF2 = '/autofollow', '/af';
function SlashCmdList.PUNKAF(msg, editBox)
	if (msg == "") then
		if (UnitIsPlayer("target")) then
			if (UnitName("target") == UnitName("player")) then
				print("|cffff8700You can't follow yourself.");
				return;
			else
				startAutoFollow(UnitName("target"));
				return;
			end
		elseif UnitExists("target") then
			print("|cffff8700Current target is not a player, target a player first or type \"/af playername\".");
			return;
		end
		print("|cffff8700You need to specify a target name to follow. Example: /autofollow Joe");
		return;
	end
	if (msg == "help") then
		printHelp();
	end
	if (msg == "stop" or msg == "end" or msg == "cancel" or msg == "off") then
		afEnabled = false;
		print("|cffff8700Stopping autofollow.");
		return;
	else
		if (string.lower(msg) == string.lower(UnitName("player"))) then
			print("|cffff8700You can't follow yourself.");
			return;
		end
		startAutoFollow(msg);
    end
end