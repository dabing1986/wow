aura_env.checkList = {}

-- [0] = "总计", 
-- [724]= "卡雷苟斯", 
-- [725]= "布鲁塔卢斯",
-- [726] = "菲米丝",
-- [727] = "艾瑞达双子",
-- [728] = "穆鲁",
-- [729] = "基尔加丹",

aura_env.checkList = {
    {
        startEid = 0,
        endEid = 724,
        text = "蓝龙前测试",
        icon = "135954"
    },

    -- {
    --     startEid = 0,
    --     endEid = 601,
    --     text = "督军起手dps鼓",
    --     icon = "133325"
    -- },
    {
        startEid = 724,
        endEid = 725,
        text = "布胖前测试",
        icon = "133029"
    },
    --[[{
        startEid = 601,
        endEid = 602,
        text = "boss倒地留药水CD",
        icon = "134715"
    },]]--
    {
        startEid = 725,
        endEid = 726,
        text = "菲米丝前测试",
        icon = "133844"
    },
    -- {
    --     startEid = 601,
    --     endEid = 602,
    --     text = "NBR:骑士无敌聚怪？",
    --     icon = "135841" 艾瑞达双子
    -- },
    {
        startEid = 726,
        endEid = 727,
        text = "艾瑞达双子前测试",
        icon = "134715"
    },
    {
        startEid = 727,
        endEid = 728,
        text = "穆鲁前测试",
        icon = "133844"
    },
    {
        startEid = 728,
        endEid = 729,
        text = "基尔加丹前小怪测试",
        icon = "134715"
    },
    -- {
    --     startEid = 602,
    --     endEid = 603,
    --     text = "阿卡玛不要敲鼓不要敲鼓",
    --     icon = "133844"
    -- },
    -- {
    --     startEid = 602,
    --     endEid = 603,
    --     text = "阿卡玛之影接触的时候T 治疗 远程dps靠近门口移动",
    --     icon = "133029"
    -- },
    -- {
    --     startEid = 603,
    --     endEid = 604,
    --     text = "boss倒地加速鼓 火箭靴",
    --     icon = "133844"
    -- },
    -- -- {
    -- --     startEid = 603,
    -- --     endEid = 604,
    -- --     text = "打完狗门线敲加速",
    -- --     icon = "133844"
    -- -- },
    -- {
    --     startEid = 603,
    --     endEid = 604,
    --     text = "boss前换卡拉波神圣勋章",
    --     icon = "133279"
    -- },
    -- {
    --     startEid = 604,
    --     endEid = 605,
    --     text = "先换火箭鞋再传送",
    --     icon = "133322"
    -- },
    -- {
    --     startEid = 604,
    --     endEid = 605,
    --     text = "三脸p1敲鼓 只允许敲一次",
    --     icon = "133322"
    -- },
    -- {
    --     startEid = 605,
    --     endEid = 606,
    --     text = "boss倒地换火箭靴",
    --     icon = "133029"
    -- },
    -- {
    --     startEid = 605,
    --     endEid = 606,
    --     text = "敲加速鼓",
    --     icon = "133029"
    -- },
    -- {
    --     startEid = 605,
    --     endEid = 606,
    --     text = "血沸不要敲鼓",
    --     icon = "133029"
    -- },
    -- {
    --     startEid = 605,
    --     endEid = 606,
    --     text = "血沸倒地换地精鞋 敲加速鼓",
    --     icon = "133029"
    -- },
    -- {
    --     startEid = 606,
    --     endEid = 607,
    --     text = "放弃隐身装置战术",
    --     icon = "134875"
    -- },
    -- {
    --     startEid = 607,
    --     endEid = 608,
    --     text = "第二个傀儡换双饰品关换装准备隐身",
    --     icon = "132995"
    -- },
}


aura_env.isBossKilled = function(eid)
    if ItemUseInputSaved then
        aura_env.CurrentLog = ItemUseInputSaved.CurrentLog
    end
    if aura_env.CurrentLog and aura_env.CurrentLog[eid] then
        return true
    end
    return false
end


