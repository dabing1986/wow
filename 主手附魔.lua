
C_Timer.After(0.1, function()
        WeakAuras.ScanEvents("ITEM_ENCH_TG") 
    end
)

aura_env.tg_time=0

aura_env.list = {
    [1] = {"Rockbiter", 136086, 300},
    [2] = {"Frostbrand", 135847, 300},
    [3] = {"Flametongue", 135814, 300},
    [4] = {"Flametongue", 135814, 300},
    [5] = {"Flametongue", 135814, 300},
    [6] = {"Rockbiter", 136086, 300},
    [7] = {"Deadly Poison", 132290, 1800},
    [8] = {"Deadly Poison", 132290, 1800},
    [12] = {"Frostbrand", 135847, 300},
    [13] = {"粗制磨刀石", 135249, 1800}, --[+3 Damage]
    [14] = {"Sharpened", 135250, 1800}, --[+4 Damage]
    [19] = {"Weighted", 135255, 1800}, --[+2 Damage]
    [20] = {"Weighted", 135256, 1800}, --[+3 Damage]
    [21] = {"Weighted", 135257, 1800}, --[+4 Damage]
    [22] = {"Crippling Poison", 132274, 1800},
    [23] = {"Mind-Numbing Poison", 136066, 1800},
    [25] = {"Shadow Oil", 134803, 1800},
    [26] = {"Frost Oil", 134800, 1800},
    [29] = {"Rockbiter", 136086, 300},
    [35] = {"Mind-numbing Poison", 136066, 1800},
    [39] = {"Sharpened", 135248, 1800}, --[+1 Damage] ????
    [40] = {"劣质磨刀石", 135248, 1800}, --[+2 Damage]
    [42] = {"Instant Poison", 132273, 1800},
    [124] = {"Flametongue Totem", 135814, 120},
    [283] = {"Windfury", 136018, 300},
    [284] = {"Windfury", 136018, 300},
    [285] = {"Flametongue Totem", 135814, 120},
    [323] = {"Instant Poison", 132273, 1800},
    [324] = {"Instant Poison", 132273, 1800},
    [325] = {"Instant Poison", 132273, 1800},
    [483] = {"坚固的磨刀石", 135251, 1800}, --[+6 Damage]
    [484] = {"Weighted", 135258, 1800}, --[+6 Damage]
    [503] = {"Rockbiter", 136086, 300},
    [504] = {"Rockbiter", 136086, 300},
    [523] = {"Flametongue", 135814, 300},
    [524] = {"Frostbrand", 135847, 300},
    [525] = {"Windfury", 136018, 300},
    [543] = {"Flametongue Totem", 135814, 120},
    [563] = {"Windfury Totem", 136114, 120},
    [564] = {"Windfury Totem", 136114, 120},
    [603] = {"Crippling Poison", 134799, 1800},
    [623] = {"Instant Poison", 132273, 1800},
    [624] = {"Instant Poison", 132273, 1800},
    [625] = {"Instant Poison", 132273, 1800},
    [626] = {"Deadly Poison", 132290, 1800},
    [627] = {"Deadly Poison", 132290, 1800},
    [643] = {"Mind-Numbing Poison", 136066, 1800},
    [683] = {"Rockbiter", 136086, 300},
    [703] = {"致伤毒药", 132274, 1800},
    [704] = {"致伤毒药", 132274, 1800},
    [705] = {"致伤毒药", 132274, 1800},
    [706] = {"致伤毒药", 132274, 1800},
    [1643] = {"致密磨刀石", 135252, 1800}, --[+8 Damage]
    [1663] = {"Rockbiter", 136086, 300},
    [1664] = {"Rockbiter", 136086, 300},
    [1665] = {"Flametongue", 135814, 300},
    [1666] = {"Flametongue", 135814, 300},
    [1667] = {"Frostbrand", 135847, 300},
    [1668] = {"Frostbrand", 135847, 300},
    [1669] = {"Windfury", 136018, 300},
    [1683] = {"Flametongue Totem", 135814, 120},
    [1703] = {"Weighted", 135259, 1800}, --[+8 Damage]
    [1783] = {"Windfury Totem", 136114, 120},
    [2506] = {"元素磨刀石", 135841, 1800},
    [28421] = {"精金平衡石", 34340, 1800},
    [23529] = {"精金磨刀石", 29453, 1800},
    [2623] = {"Minor Wizard Oil", 134711, 1800},
    [2624] = {"{Minor Mana Oil", 134878, 1800},
    [2625] = {"Lesser Mana Oil", 134879, 1800},
    [2626] = {"Lesser Wizard Oil", 134725, 1800},
    [2627] = {"Wizard Oil", 134726, 1800},
    [2628] = {"Brilliant Wizard Oil", 134727, 1800},
    [2629] = {"Brilliant Mana Oil", 134722, 1800},
    [2630] = {"Deadly Poison", 132290, 1800},
    [2632] = {"Rockbiter", 136086, 300},
    [2633] = {"Rockbiter", 136086, 300},
    [2634] = {"Flametongue Totem", 135814, 120},
    [2635] = {"Frostbrand", 135847, 300},
    [2636] = {"Windfury", 136018, 300},
    [2637] = {"Flametongue Totem", 135814, 120},
    [2638] = {"Windfury Totem", 136114, 120},
    [2639] = {"Windfury Totem", 136114, 120},
    [2641] = {"Instant Poison", 132273, 1800},
    [2642] = {"致命毒药", 132290, 1800}, --6
    [2643] = {"致命毒药", 132290, 1800}, --7
    [2644] = {"Wound Poison", 13220, 1800},
    [2684] = {"神圣磨刀石",135249,3600},
    [2685] = {"神圣巫师之油",134806,3600},
}




local e = aura_env 
if not _G[e.id.."Button"] then 
    local region = WeakAuras.GetRegion(e.id) 
    e.btn = CreateFrame("Button", e.id.."Button", region, "SecureActionButtonTemplate") 
    e.btn:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
    e.btn:SetAllPoints(region) 
end 
local btn = _G[e.id.."Button"] 
local    className, classFilename, classID = UnitClass("player") 
if classID==1 then  --战士
    btn:SetScript("OnMouseUp", function(btn)
            local buttonName = GetMouseButtonClicked()
            --   print(buttonName)
            if buttonName=="LeftButton" then
                btn:SetAttribute("type1", "macro")
                btn:SetAttribute("macrotext","/use item:23529\n/use 16\n/click StaticPopup1Button1")            
            end 
            if buttonName=="RightButton" then          
                btn:SetAttribute("type2", "macro")
                btn:SetAttribute("macrotext","/use item:18262\n/use 16\n/click StaticPopup1Button1")
            end
            if buttonName=="MiddleButton" then          
                btn:SetAttribute("type3", "macro")
                btn:SetAttribute("macrotext","/use item:28421\n/use 16\n/click StaticPopup1Button1")
            end
    end)
    btn:SetScript("OnEnter", function(self)               
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cffa335ee主手|r\n|cffffffff左键：|r精金磨刀石|cff04f192（"..GetItemCount(23529).."）|r\n|cffffffff右键：|r元素磨刀石|cff04f192（"..GetItemCount(18262).."）|r\n|cffffffff中键：|r精金平衡石|cff04f192（"..GetItemCount(28421).."）|r", 0, 1, 0, 1, 1)
    end)
    btn:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
elseif classID == 4 then --盗贼
    
    btn:SetScript("OnMouseUp", function(btn)
            local buttonName = GetMouseButtonClicked()
            if buttonName=="LeftButton" then           
                btn:SetAttribute("type1", "macro")
                btn:SetAttribute("macrotext","/use item:8928\n/use 16\n/click StaticPopup1Button1")            
            end 
            if buttonName=="RightButton" then           
                btn:SetAttribute("type2", "macro")
                btn:SetAttribute("macrotext","/use item:23122\n/use 16\n/click StaticPopup1Button1")
            end
            if buttonName=="MiddleButton" then          
                btn:SetAttribute("type3", "macro")
                btn:SetAttribute("macrotext","/use item:18262\n/use 16\n/click StaticPopup1Button1")
            end
    end)
    
    btn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cffa335ee主手|r\n|cffffffff左键：|r速效毒药 VI|cff04f192（"..GetItemCount(8928).."）|r\n|cffffffff右键：|r神圣磨刀石|cff04f192（"..GetItemCount(23122).."）|r\n|cffffffff中键：|r元素磨刀石|cff04f192（"..GetItemCount(18262).."）|r", 0, 1, 0, 1, 1)
    end)
    btn:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
    
    
elseif classID==8   or classID==9 then  --法师，术士
    
    btn:SetScript("OnMouseUp", function(btn)
            local buttonName = GetMouseButtonClicked()
            --print(buttonName)
            if buttonName=="LeftButton" then           
                btn:SetAttribute("type1", "macro")
                btn:SetAttribute("macrotext","/站立\n/dismount\n/use item:20749\n/use 16\n/click StaticPopup1Button1")            
            end 
            if buttonName=="RightButton" then           
                btn:SetAttribute("type2", "macro")
                btn:SetAttribute("macrotext","/站立\n/dismount\n/use item:23123\n/use 16\n/click StaticPopup1Button1")
            end
    end)
    
    btn:SetScript("OnEnter", function(self)               
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT") 
            GameTooltip:SetText("|cffa335ee主手|r\n|cffffffff左键：|r卓越巫师之油|cff04f192（"..GetItemCount(20749).."）|r\n|cffffffff右键：|r神圣巫师之油|cff04f192（"..GetItemCount(23123).."）|r", 0, 1, 0, 1, 1)
    end)
    btn:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
    
    
elseif   classID==2 or  classID==3  or  classID==7  or  classID==11  or classID==5 then  --圣骑 萨满 德鲁伊  牧师 猎人
    
    btn:SetScript("OnMouseUp", function(btn)
            local buttonName = GetMouseButtonClicked()
            -- print(buttonName)
            if buttonName=="LeftButton" then           
                btn:SetAttribute("type1", "macro")
                btn:SetAttribute("macrotext","/站立\n/dismount\n/use item:20748\n/use 16\n/click StaticPopup1Button1")            
            end 
            if buttonName=="RightButton" then           
                btn:SetAttribute("type2", "macro")
                btn:SetAttribute("macrotext","/站立\n/dismount\n/use item:20748\n/use 16\n/click StaticPopup1Button1")
            end 
            
    end)
    
    btn:SetScript("OnEnter", function(self)               
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT") 
            GameTooltip:SetText("|cffa335ee主手|r\n|cffffffff左键：|r卓越法力之油|cff04f192（"..GetItemCount(20748).."）|r\n|cffffffff右键：|r卓越法力之油|cff04f192（"..GetItemCount(20748).."）|r", 0, 1, 0, 1, 1)
    end)
    
    btn:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
    
end

