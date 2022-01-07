--以下获取回能CD时间

local DMH_Name, DMH = ...

-- lua
local _G = _G
local str_lower, str_split = _G.string.lower, _G.string.split
local unpack, tbl_remove = _G.unpack, _G.table.remove

-- WoW
local GetTime = _G.GetTime
local CreateFrame = _G.CreateFrame
local UnitPower, UnitPowerMax, UnitBuff = _G.UnitPower, _G.UnitPowerMax, _G.UnitBuff
local UnitAffectingCombat = _G.UnitAffectingCombat
local GetShapeshiftForm = _G.GetShapeshiftForm
local GetSpellInfo = _G.GetSpellInfo


local BASE_REG, BASE_REG_SEC = 20, 2
local ENERGY_FORMAT_STRING = "%d / %d"
local ENERGY_FORMAT_STRING_TIMER = "%d / %d (%.1f)"
local ENERGY_FORMAT_STRING_TIMER_NO_MAX = "%d (%.1f)"
local EVENT_UNIT_POWER_FREQUENT, PLAYER_UNIT, POWER_TYPE = "UNIT_POWER_FREQUENT", "player", "ENERGY"
local EVENT_UNIT_MAXPOWER = "UNIT_MAXPOWER"
local EVENT_COMBAT_START, EVENT_COMBAT_END = "PLAYER_REGEN_DISABLED", "PLAYER_REGEN_ENABLED"
local EVENT_SHAPESHIFT, EVENT_STEALTH = "UPDATE_SHAPESHIFT_FORM", "UPDATE_STEALTH"
local ENUM_P_TYPE_ENERGY = Enum.PowerType.Energy
local STEALTH_BUFF_NAME = PlayerClass == "DRUID" and GetSpellInfo(5215) or GetSpellInfo(1784)
local CAT_FORM_BUFF_NAME = GetSpellInfo(768)
local FONT_STRING, FONT_SIZE = _G["SystemFont_Tiny"]:GetFont()

-- Event handler
local function OnEvent(self, event, ...)
    if DMH[event] then
        DMH[event](...)
    end
end
local EventFrame = CreateFrame("Frame")
EventFrame:SetScript("OnEvent", OnEvent)

--locales
local function OnUpdate()
    if not DMH.nextTick then return end
    local curTime = GetTime()
    local diff = DMH.nextTick - curTime
    if diff <= 0 then
        if DMH.lastEventTime then
            local numTicksSinceLastUpdate = ( (curTime - DMH.lastEventTime) - ((curTime - DMH.lastEventTime) % BASE_REG_SEC) )
            DMH.nextTick = DMH.lastEventTime + numTicksSinceLastUpdate + BASE_REG_SEC
        end
        diff = BASE_REG_SEC
    end
end
local UpdateFrame = CreateFrame("Frame", nil)
UpdateFrame:SetScript("OnUpdate", OnUpdate)

local function FramOnEvent(self, event, arg1, arg2, ...)
    if event == EVENT_UNIT_POWER_FREQUENT and arg1 == PLAYER_UNIT and arg2 == POWER_TYPE then
        local power, powerMax = UnitPower(PLAYER_UNIT, ENUM_P_TYPE_ENERGY), UnitPowerMax(PLAYER_UNIT, ENUM_P_TYPE_ENERGY)
        local lastPowerCheck = ( self.power and ( self.power < power and ( power - self.power > 1 ))) and true or false
        self.power = power
        if power >= powerMax then
            DMH.lastEventTime = GetTime()
            return
        elseif not DMH.nextTick then
            DMH.lastEventTime = GetTime()
            DMH.nextTick = DMH.lastEventTime
        end

        if DMH.nextTick and lastPowerCheck then
            DMH.lastEventTime = GetTime()
            DMH.nextTick = DMH.lastEventTime
        end
    end
end

-- Core
function DMH.PLAYER_LOGIN()
    DMH:GetEnergyBar()
    EventFrame:UnregisterEvent("PLAYER_LOGIN")
end
EventFrame:RegisterEvent("PLAYER_LOGIN")

function DMH:GetEnergyBar()
        local frame = CreateFrame("Frame", nil)
        frame:RegisterEvent(EVENT_UNIT_POWER_FREQUENT)
        frame:SetScript("OnEvent", FramOnEvent)
        frame:SetScript("OnUpdate", OnUpdate)
end

--以上获取回能CD

--以下导入游戏宏
function DMHDruidMacroImport(self)
    local a,b,c = UnitClass("player")
    if b ~= "DRUID" then return end

local dmh = {
    "DruidMacroHelper",
    "TankVerySafe",
    "Healer",
    "CatMana",
    "CatBoss",
    "CatDPS",
    "SA",
}

local Macro1 = {
    unpack(dmh,1),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[1. 此宏为DruidMacroHelper创建，删除此宏后下次登陆游戏会把变形宏恢复默认值。
2. 猫宏里变量c的值为1时是裂伤（豹）；c的值为2时是撕碎；
3. c也可以直接填写具体技能名称（技能名称前后必须有英文双引号如：c="割裂"）]]), 
};

local Macro2 = {
    unpack(dmh,2),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[#showtooltip 治疗药水注射器
/run local itname="治疗药水注射器";TankVerySafe(itname)
/use 超级治疗药水
/use 治疗药水注射器
/cast [noform:1]!巨熊形态
/run SCVon();UIclear()]])
};

local Macro3 = {
    unpack(dmh,3),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[#showtooltip 自然迅捷
/run Healer()
/use 绿色其拉共鸣水晶
/run SCVon();UIclear()
/stopmacro [noform:0]
/stopcasting
/cast [noform:5]自然迅捷
/castsequence reset=15 [help,nodead][@mouseover,help,nodead][]治疗之触,!生命之树]])
};

local Macro4 = {
    unpack(dmh,4),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[#showtooltip [stealth]突袭;裂伤（豹）
/施放 [stealth]突袭
/stopmacro [stealth]
/run local a,b,c="超级法力药水",2800,1;CatMana(a,b,c)
/use [form:3]超级法力药水
/施放 [form:0]!猎豹形态
/run local c=1;SCVon();CatDPS(c)
/use 能量转化器
/施放 [form:0]!猎豹形态;裂伤（豹）
/run SCVon();UIclear()]])
};

local Macro5 = {
    unpack(dmh,5),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[#showtooltip [stealth]突袭;裂伤（豹）
/施放 [stealth]突袭
/stopmacro [stealth]
/run local a,b,c="超级法力药水",2800,1;CatBoss(a,b,c)
/use [form:3]超级法力药水
/施放 [form:0]!猎豹形态
/run local c=1;SCVon();CatDPS(c)
/use 能量转化器
/施放 [form:0]!猎豹形态;裂伤（豹）
/run SCVon();UIclear()]])
};

local Macro6 = {
    unpack(dmh,6),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[#showtooltip 裂伤（豹）
/run local c=1;CatDPS(c)
/use 能量转化器
/cast [form:3]裂伤（豹）
/cast [form:0]!猎豹形态
/run SCVon();UIclear()]])
};

local Macro7 = {
    unpack(dmh,7),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[#showtooltip [stealth]毁灭;撕碎
/施放 [stealth]毁灭;
/stopmacro [stealth]
/run local a,b,c="法力药水注射器",2800,2;CatBoss(a,b,c)
/use [form:3]法力药水注射器
/施放 [form:0]!猎豹形态
/run local c=2;SCVon();CatDPS(c)
/use 能量转化器
/施放 [form:0]!猎豹形态;撕碎
/run SCVon();UIclear()]])
};

    if (GetNumMacros()) > 248 then print ("你已有太多宏存在，DruidMacroHelper需要至少7个宏空位才能正常工作。") end
    if GetMacroIndexByName(unpack(dmh,1)) == 0 then
        CreateMacro(unpack(Macro1));
        if GetMacroIndexByName(unpack(dmh,2)) ~= 0 then
            EditMacro(unpack(dmh,2),unpack(Macro2));
        else
            CreateMacro(unpack(Macro2));
        end
        if GetMacroIndexByName(unpack(dmh,3)) ~= 0 then
            EditMacro(unpack(dmh,3),unpack(Macro3));
        else
            CreateMacro(unpack(Macro3));
        end
        if GetMacroIndexByName(unpack(dmh,4)) ~= 0 then
            EditMacro(unpack(dmh,4),unpack(Macro4));
        else
            CreateMacro(unpack(Macro4));
        end
        if GetMacroIndexByName(unpack(dmh,5)) ~= 0 then
            EditMacro(unpack(dmh,5),unpack(Macro5));
        else
            CreateMacro(unpack(Macro5));
        end
        if GetMacroIndexByName(unpack(dmh,6)) ~= 0 then
            EditMacro(unpack(dmh,6),unpack(Macro6));
        else
            CreateMacro(unpack(Macro6));
        end
        if GetMacroIndexByName(unpack(dmh,7)) ~= 0 then
            EditMacro(unpack(dmh,7),unpack(Macro7));
        else
            CreateMacro(unpack(Macro7));
        end
        print ("DruidMacroHelper已经成功创建变身宏，请打开宏界面查看。注意：不要删除与改名名为“DruidMacroHelper”的宏，其他变形宏可以随意改名、修改、删除。如要想恢复默认，把DruidMacroHelper宏删除后/reload即可。")
    end
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

function DMHPaladinMacroImport(self)
    local a,b,c = UnitClass("player")
    if b ~= "PALADIN" then return end
local dmhp = {
    "PaladinMacroHelper",
    "PaladinHealingPotion",
    "PaladinLoH",
}

function DMHWarriorMacroImport(self)
    local a,b,c = UnitClass("player")
    if b ~= "WARRIOR" then return end
local dmhw = {
    "WarriorMacroHelper",
    "WarriorHealingPotion",
    "WarriorHeoricStrike",
}


local PaladinM1 = {
    unpack(dmhp,1),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[此宏为PaladinMacroHelper创建，删除此宏后下次登陆游戏会把插件导入的宏恢复默认值。]])
};


local WarriorM1 = {
    unpack(dmhw,1),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[此宏为WarriorMacroHelper创建，删除此宏后下次登陆游戏会把插件导入的宏恢复默认值。]])
};

local PaladinM2 = {
    unpack(dmhp,2),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[#showtooltip
/cast 神圣之盾
/run local a=0.3;DMHPaladin(a)
/stopmacro [equipped:圣物]
/use 梦魇草
/use 超级治疗药水]])
};

local WarriorM2 = {
    unpack(dmhw,2),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[#showtooltip
/cast 毁灭打击
/run local a=0.3;DMHPaladin(a)
/stopmacro [equipped:弓]
/use 梦魇草
/use 超级治疗药水]])
};

local PaladinM3 = {
    unpack(dmhw,3),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[#showtooltip
/targetlastenemy [help,nodead]
/run if UnitHealth("player")/UnitHealthMax("player")>0.3 then SetCVar("autoSelfCast",0) end
/cast 圣疗术
/run SetCVar("autoSelfCast",1);ClearCursor()]])
};

local WarriorM3 = {
    unpack(dmhw,3),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[#showtooltip
/cast [equipped:弓] 嗜血
/run local a=0.6;DMHWarrior(a)
/stopmacro [equipped:弓]
/cast 英勇打击]])
};


local PaladinM4 = {
    unpack(dmhp,4),
    "INV_MISC_QUESTIONMARK", -- icon
    string.format([[#showtooltip
/cast [equipped:圣物]神圣之盾
/run local a=0.3;DMHPaladin(a)
/stopmacro [equipped:圣物]
/cast [@player]圣疗术]])
};




    if (GetNumMacros()) > 252 then print ("你已有太多宏存在，PaladinMacroHelper需要至少3个宏空位才能正常工作。") end
    if GetMacroIndexByName(unpack(dmhp,1)) == 0 then
        CreateMacro(unpack(PaladinM1));
        if GetMacroIndexByName(unpack(dmhp,2)) ~= 0 then
            EditMacro(unpack(dmhp,2),unpack(PaladinM2));
        else
            CreateMacro(unpack(PaladinM2));
        end
        if GetMacroIndexByName(unpack(dmhp,3)) ~= 0 then
            EditMacro(unpack(dmhp,3),unpack(PaladinM3));
        else
            CreateMacro(unpack(PaladinM3));
        end
        if GetMacroIndexByName(unpack(dmhp,4)) ~= 0 then
            EditMacro(unpack(dmhp,4),unpack(PaladinM4));
        else
            CreateMacro(unpack(PaladinM4));
        end
        print ("DruidMacroHelper已经成功创建圣疗宏，请打开宏界面查看。注意：不要删除与改名名为“PaladinMacroHelper”的宏，其他变形宏可以随意改名、修改、删除。如要想恢复默认，把PaladinMacroHelper宏删除后/reload即可。")
    end
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end



if (GetNumMacros()) > 252 then print ("你已有太多宏存在，WarriorMacroHelper需要至少3个宏空位才能正常工作。") end
if GetMacroIndexByName(unpack(dmhw,1)) == 0 then
    CreateMacro(unpack(WarriorM1));
    if GetMacroIndexByName(unpack(dmhw,2)) ~= 0 then
        EditMacro(unpack(dmhw,2),unpack(WarriorM2));
    else
        CreateMacro(unpack(WarriorM2));
    end
    if GetMacroIndexByName(unpack(dmhw,3)) ~= 0 then
        EditMacro(unpack(dmhw,3),unpack(WarriorM3));
    else
        CreateMacro(unpack(WarriorM3));
    end
    print ("DruidMacroHelper已经成功创建战士宏，请打开宏界面查看。注意：不要删除与改名名为“WarriorMacroHelper”的宏，其他变形宏可以随意改名、修改、删除。如要想恢复默认，把WarriorMacroHelper宏删除后/reload即可。")
end
self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

function DruidMacroHelperUpdateMacro(self)
    DMHDruidMacroImport()
    DMHPaladinMacroImport()
    DMHWarriorMacroImport()
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

local dmhgoodie = CreateFrame("FRAME", nil)
dmhgoodie:RegisterEvent("PLAYER_ENTERING_WORLD")
dmhgoodie:SetScript("OnEvent", DruidMacroHelperUpdateMacro)

local function hexie(self)
    if GetCVar("portal") == "CN" then
        ConsoleExec("portal TW")
    end
    SetCVar("profanityFilter",0)
    SetCVar("OverrideArchive",0)
    SetCVar("autoUnshift",1)
    SetCVar("autoSelfCast",1)
    self:UnregisterEvent("ADDON_LOADED")
end

local goodie = CreateFrame("FRAME", nil)
goodie:RegisterEvent("ADDON_LOADED")
goodie:SetScript("OnEvent", hexie)

function DMHUnequipSlot(slotId)
    for bag = 4, 0, -1 do
        for slot = 1, GetContainerNumSlots(bag) do
            local link = GetContainerItemLink(bag, slot)
            if link == nil then
                DMHemptybag = bag
            end
        end
    end
    if DMHemptybag ~= 0 then
        PickupInventoryItem(slotId)
        local bagID = DMHemptybag + 19
        PutItemInBag(bagID)
    elseif DMHemptybag == 0 then
        PickupInventoryItem(slotId)
        PutItemInBackpack()
    end
end

function DMHidol(a,b)
    local slotId = b or 18
    if GetInventoryItemID("player", b) == nil then
    elseif GetInventoryItemID("player", b) ~= GetItemInfoInstant(a) and (GetTime()-GetSpellCooldown("治疗之触"))<=0.1 then
        DMHUnequipSlot(slotId)
    end
end

function DMHPaladin(a)
    local slotId = 18
    if UnitHealth("player")/UnitHealthMax("player")<a then
        DMHUnequipSlot(slotId)
    end
end

function DMHWarrior(a)
    local slotId = 18
    if Unitpower("player", 1)/UnitPowerMax("player", 1)>a then
        DMHUnequipSlot(slotId)
    end
end

function DMHidolCVar(a)
    if GetInventoryItemID("player", 18) == nil then SetCVar("SpellQueueWindow",0)
    elseif GetInventoryItemID("player", 18) ~= GetItemInfoInstant(a) then SetCVar("SpellQueueWindow",0)
    else SetCVar("SpellQueueWindow",400)
    end
end

--以下是迅捷宏要调用的
function Healer(self)
    local usable, nomana = IsUsableSpell("治疗之触")
    if GetSpellCooldown("治疗之触")+GetSpellCooldown("自然迅捷")>0 or (not usable) then
        SetCVar("autoUnshift",0)
    else
        SetCVar("autoUnshift",1)
    end
end
--以下是坦克不监控昏迷吃药宏调用的
function Tank(itname)
    local itid=GetItemInfoInstant(itname)
    local u,n = IsUsableSpell("巨熊形态")
    if GetItemCooldown(itid)>0 or GetSpellCooldown("巨熊形态")>0 or (not u) then
        SetCVar("autoUnshift",0)
    else
        SetCVar("autoUnshift",1)
    end
end
--以下是监控昏迷的全功能吃药宏调用的
function TankVerySafe(itname)
    local itid=GetItemInfoInstant(itname)
    local u,n = IsUsableSpell("巨熊形态")
    if GetItemCooldown(itid)>0 or GetSpellCooldown("巨熊形态")>0 or C_LossOfControl.GetActiveLossOfControlDataCount()>0 or (not u) then
        SetCVar("autoUnshift",0)
    else
        SetCVar("autoUnshift",1)
    end
end
--以下是猫芒果+刷能量+自动吃蓝宏调用的
function CatMana(a,b,c)
    local itid=GetItemInfoInstant(a)
    if c == 1 then c = "裂伤（豹）" end
    if c == 2 then c = "撕碎" end
    local d = 0
    if GetSpellCooldown(768)==0 and C_LossOfControl.GetActiveLossOfControlDataCount()==0 and UnitPower("player",0)>=GetSpellPowerCost(768)[1].cost and UnitPower("player",3)<GetSpellPowerCost(c)[1].cost and (UnitPowerMax("player",0)-UnitPower("player",0))>=b and GetItemCooldown(itid)==0 then
        d = 1
        SetCVar("autoUnshift",1)
    else
        SetCVar("autoUnshift",0)
    end
    if (d==1 and (UnitPower("player",3)+20>=GetSpellPowerCost(c)[1].cost) and (DMH.nextTick-GetTime()<=1)) or (d==1 and (UnitPower("player",3)+20>=GetSpellPowerCost(c)[1].cost) and (DMH.nextTick-GetTime()>=1.5)) then
        SetCVar("autoUnshift",0)
    end
    if (d==1 and (UnitPower("player",3)+20>=GetSpellPowerCost(c)[1].cost) and (DMH.nextTick-GetTime()>1) and (DMH.nextTick-GetTime()<1.5)) then
        SetCVar("autoUnshift",1)
    end
    if d==1 and (DMH.nextTick-GetTime()>1) then
        SetCVar("autoUnshift",0)
    end
end
--以下是猫刷能量宏监视GCD和变猫蓝量调用的
function CatDPS(c)
    if c == 1 then c = "裂伤（豹）" end
    if c == 2 then c = "撕碎" end
    if GetSpellCooldown(768)==0 and C_LossOfControl.GetActiveLossOfControlDataCount()==0 and UnitPower("player",0)>=GetSpellPowerCost(768)[1].cost and UnitPower("player",3)<GetSpellPowerCost(c)[1].cost then
        d = 1
        SetCVar("autoUnshift",1)
    else
        SetCVar("autoUnshift",0)
    end
    if (d==1 and (UnitPower("player",3)+20>=GetSpellPowerCost(c)[1].cost) and (DMH.nextTick-GetTime()<=1)) or (d==1 and (UnitPower("player",3)+20>=GetSpellPowerCost(c)[1].cost) and (DMH.nextTick-GetTime()>=1.5)) then
        SetCVar("autoUnshift",0)
    end
    if (d==1 and (UnitPower("player",3)+20>=GetSpellPowerCost(c)[1].cost) and (DMH.nextTick-GetTime()>1) and (DMH.nextTick-GetTime()<1.5)) then
        SetCVar("autoUnshift",1)
    end
    if d==1 and (DMH.nextTick-GetTime()>1) then
        SetCVar("autoUnshift",0)
    end
    --print (DMH.nextTick-GetTime())  --打印能量恢复CD
end
--以下是带骷髅目标的猫刷能量宏自动吃蓝宏调用的
function CatBoss(a,b,c)
    local itid=GetItemInfoInstant(a)
    local level=UnitLevel("target")
    if c == 1 then c = "裂伤（豹）" end
    if c == 2 then c = "撕碎" end
    if level==-1 and GetSpellCooldown(768)==0 and C_LossOfControl.GetActiveLossOfControlDataCount()==0 and UnitPower("player",0)>=GetSpellPowerCost(768)[1].cost and UnitPower("player",3)<GetSpellPowerCost(c)[1].cost and (UnitPowerMax("player",0)-UnitPower("player",0))>=b and GetItemCooldown(itid)==0 then
        d = 1
        SetCVar("autoUnshift",1)
    else
        SetCVar("autoUnshift",0)
    end
    if (d==1 and (UnitPower("player",3)+20>=GetSpellPowerCost(c)[1].cost) and (DMH.nextTick-GetTime()<=1)) or (d==1 and (UnitPower("player",3)+20>=GetSpellPowerCost(c)[1].cost) and (DMH.nextTick-GetTime()>=1.5)) then
        SetCVar("autoUnshift",0)
    end
    if (d==1 and (UnitPower("player",3)+20>=GetSpellPowerCost(c)[1].cost) and (DMH.nextTick-GetTime()>1) and (DMH.nextTick-GetTime()<1.5)) then
        SetCVar("autoUnshift",1)
    end
    if d==1 and (DMH.nextTick-GetTime()>1) then
        SetCVar("autoUnshift",0)
    end
end

--按能量变身
function CatDPSEn(c)
    if GetSpellCooldown(768)==0 and UnitPower("player",0)>=GetSpellPowerCost(768)[1].cost and UnitPower("player",3)<=c then
        SetCVar("autoUnshift",1)
    else
        SetCVar("autoUnshift",0)
    end
end

--变形宏内常用函数简化
function SCVon(self)
    SetCVar("autoUnshift",1)
end

function SCVoff(self)
    SetCVar("autoUnshift",0)
end

function UIclear(self)
    UIErrorsFrame:Clear()
end

function SCV0()
    SetCVar("SpellQueueWindow",0)
end

function SCV400()
    SetCVar("SpellQueueWindow",400)
end