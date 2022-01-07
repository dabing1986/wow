hooksecurefunc("AuctionFrame_LoadUI", function()
  if AuctionFrameBrowse_Update then
      hooksecurefunc("AuctionFrameBrowse_Update", function()
          local NumAuctionItems = GetNumAuctionItems("list")
          local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame)
          for i=1, NUM_BROWSE_TO_DISPLAY do
              local index = offset + i + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page)
              if index <= NumAuctionItems + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page) then
                  local name, _, count, _, canUse, _, _, minBid, _, buyoutPrice, bidAmount, highBidder
                  	 =  GetAuctionItemInfo("list", offset + i)
                  local alpha = 0.5
                  local color = "yellow"
                  
                  if name then
									 	local itemTexture = "BrowseButton"..i.."ItemIconTexture"
										local itemtime =  GetAuctionItemTimeLeft("list", offset + i)
										local closetime = "BrowseButton"..i.."ClosingTimeText"
                    local itemName = "BrowseButton"..i.."Name"
                    local moneyFrame = "BrowseButton"..i.."MoneyFrame"
                    local buyoutMoney = "BrowseButton"..i.."BuyoutFrameMoney"

            			 --显示剩余时间
            			 if itemtime == 4 then timeleft = "|cff".."333333".."8h+|r"
	            			 elseif itemtime == 3 then timeleft = "|cff".."555555".."8h|r"
	            			 elseif itemtime == 2 then timeleft = "|cff".."999999".."2h|r"
	            			 elseif itemtime == 1 then timeleft = "|cff".."ff0000".."30m|r"
            			 end
            			 
	            		 _G[closetime]:SetText(timeleft)
            			 _G[closetime]:SetFont(STANDARD_TEXT_FONT, 12, nil)

                   _G[itemName]:SetText(name)
                   _G[moneyFrame]:SetAlpha(alpha)
                   SetMoneyFrameColor(_G[buyoutMoney]:GetName(), color)
									
									--显示单价/竞标
									if (buyoutPrice > 0) and (count > 1) then
										local unitprice = GSC(buyoutPrice / count)
										if bidAmount > 0 then
                  	   local bidded = unitprice.." |cff".."ffd700".."(Bid)|r"
												_G[itemName]:SetText(name..": "..bidded)
										else
												_G[itemName]:SetText(name..": "..unitprice)
										end
									end
								end
             end
          end
      end)
  end
end)

function GSC(value)
	--return "|cffffffff"..GetCoinTextureString(value,12).."|r"  --图标显示方式有bug
	local n = "|cffffffff%d|r"
	local g,s,c = "|cff".."ffd700".."g|r","|cff".."c7c7cf".."s|r","|cff".."eda55f".."c|r"

	local gold = floor(math.abs(value) / 10000)
	local silver = mod(floor(math.abs(value) / 100), 100)
	local copper = mod(floor(math.abs(value)), 100)

	if gold ~= 0 then
		if copper ~= 0 then 
			return format(n..g..n..s..n..c, gold, silver, copper)
		elseif silver ~= 0 then
			return format(n..g..n..s, gold, silver)
		else
			return format(n..g, gold)
		end
	elseif silver ~= 0 then 
		if copper ~= 0 then
			return format(n..s..n..c, silver, copper)
		else
			return format(n..s, silver)
		end
	elseif copper ~= 0 then
			return format(n..c, copper)
	else
		return
	end
end

do
	LoadAddOn("Blizzard_AuctionUI")
	SortAuctionItems("list", "unitprice")	--1. 按<单价> 从低到高排序 (只能 2选1)
	--SortAuctionItems("list", "buyout")  --2. 按<一口价> 从低到高排序 (只能 2选1)
end

--BrowseCurrentBidSort:Hide() --隐藏竞价排序按钮(避免按错)

