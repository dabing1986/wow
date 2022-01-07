DEFAULT_CHAT_FRAME:AddMessage('No Real Friends loaded! Type "/nrf show" to show friends, or "/nrf hide" to hide them again', 52/255, 198/255, 227/255);

numberOfFriends, onlineFriends = BNGetNumFriends()

BNGetNumFriends = function(...)
	return 0, 0;
end

local function MyAddonCommands(msg, editbox)
  if msg == 'show' then
  
    print('Real Friends Shown!')
	
	BNGetNumFriends = function(...)
		return 1, numberOfFriends;
	end	
	
  elseif msg == 'hide' then
  
    print("Real Friends Hidden!")
	
	BNGetNumFriends = function(...)
		return 0, 0;
	end	
	
  end
  
end

SLASH_NRF1, SLASH_NRF2 = '/nrf', '/norealfriends'

SlashCmdList["NRF"] = MyAddonCommands   -- add /nrf and /norealfriends to command list