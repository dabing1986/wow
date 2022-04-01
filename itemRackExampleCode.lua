
unitid = ...
if unitid=="player" then
    IRScriptBuffs = IRScriptBuffs or {}
    local buffs = IRScriptBuffs
    for i in pairs(buffs) do
      if not AuraUtil.FindAuraByName(i,"player") then
        buffs[i] = nil
      end
    end
    local i,b = 1,1
    while b do
      b = AuraUtil.FindAuraByName(i,"player")
      if b and not buffs[b] then
        ItemRack.Print("Gained buff: "..b)
        buffs[b] = 1
      end
      i = i+1
    end
end
  --[[For script demonstration purposes. Doesn't equip anything just informs when a buff is gained.]]
  
  



  local set = "Name of set"
  if IsSwimming() and not IsSetEquipped(set) then
    EquipSet(set)
    if not SwimmingEvent then
      function SwimmingEvent()
        if not IsSwimming() then
          ItemRack.StopTimer("SwimmingEvent")
          UnequipSet(set)
        end
      end
      ItemRack.CreateTimer("SwimmingEvent",SwimmingEvent,.5,1)
    end
    ItemRack.StartTimer("SwimmingEvent")
  end
  --[[Equips a set when swimming and breath gauge appears and unequips soon after you stop swimming.]]




unitid = ...

local findAura = AuraUtil.FindAura

local function findAuraBySpellId(spellId, unit, filter)
    return findAura(spellIdPredicate, unit, filter, spellId)
end


local slot  = 14
local start = 0 
local set = "test"
local set2 = "test2"
local timeLeft = 0
local start,duration,enable = GetInventoryItemCooldown("player",slot)

local timeLeft = math.max(start + duration - GetTime(),0)
local baseID = ItemRack.GetIRString(GetInventoryItemLink("player",slot),true,true)
local icon = _G["ItemRackButton"..slot.."Queue"]

local buff = GetItemSpell(baseID)

ItemRack.Print("start: " .. start .. "\n" .. "duration: " .. duration .. "\n" .. "enable: " .. enable .. "\n".. "timeLeft: " .. timeLeft .. "\n".. "baseID: " .. baseID .. "\n".. "buff: " .. buff )


if unitid == "player" then
    local buffs = {
        "邪甲术"
    
    }
    ItemRack.Print(4)
    
    for i in pairs(buffs) do
        ItemRack.Print(buffs[i])
        -- local buff = GetItemSpell(i)
        -- if  AuraUtil.FindAuraByName(i,"player") then
        ItemRack.Print("ssss")
        local spellId = select(10, AuraUtil.FindAuraByName(buffs[i], 'player'))

        print("spellId" .. spellId)
        if  spellId ~= nil then
            if start == 0 then
                start = GetTime()
            end
            print("start" .. start)
            timeLeft = math.max(start - GetTime(),0)
            print("timeleftabove" .. timeLeft)
            if timeLeft < 39 then
                EquipSet(set) 
            end
        end

        if timeLeft < 5  then
            -- body
            print("timeleft" .. timeLeft)
            -- EquipSet(set2) 
            -- start = 0 
            -- timeLeft = 0
        end
        -- 没有 buff and timeLeft = 0 
        --  装备 
        --  发现有buff create timer 
        --  delay 6 秒 换下 饰品 

        --  45 秒 结束 换上 饰品 

        --  timeleft 归零 


        ItemRack.Print("ssss：" .. spellId)
        -- end
    end  
end

-- 13 上饰品 14 下饰品 

  



unitid = ...

local findAura = AuraUtil.FindAura

local function findAuraBySpellId(spellId, unit, filter)
    return findAura(spellIdPredicate, unit, filter, spellId)
end

local function isbuff()
    local buffs = {
        "邪甲术"
    
    }
    ItemRack.Print(4)
    
    for i in pairs(buffs) do
        ItemRack.Print(buffs[i])
        -- local buff = GetItemSpell(i)
        -- if  AuraUtil.FindAuraByName(i,"player") then
        ItemRack.Print("ssss")
        local spellId = select(10, AuraUtil.FindAuraByName(buffs[i], 'player'))

        print("spellId" .. spellId)
        if  spellId ~= nil  then
            return true
        end
        -- end
    end  
    return false
end

local slot  = 14
local start = 0 
local set = "test"
local set2 = "test2"
local timeLeft = 0



if unitid == "player" then

    
    if isbuff() and not IsSetEquipped(set) then
        print("1 loop")
        EquipSet(set)
        if not EyeEvent then
            function EyeEvent()
                if not isbuff() then
                    print("12 loop")
                    ItemRack.StopTimer("EyeEvent")
                    EquipSet(set2)
                end
            end
            ItemRack.CreateTimer("EyeEvent",EyeEvent,.5,1 )
        end
        ItemRack.StartTimer("EyeEvent")
    end

end

