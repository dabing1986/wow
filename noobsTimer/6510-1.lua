aura_env.checkList = {}

aura_env.checkList = {
    {
        startEid = 0,
        endEid = 601,
        text = "白菜无敌聚怪",
        icon = "135954"
    },
    {
        startEid = 0,
        endEid = 601,
        text = "第一步小怪提前开dps鼓",
        icon = "136012"
    },
    {
        startEid = 0,
        endEid = 601,
        text = "督军起手dps鼓",
        icon = "133325"
    },
    {
        startEid = 601,
        endEid = 602,
        text = "boss倒地换火箭靴",
        icon = "133029"
    },
    --[[{
        startEid = 601,
        endEid = 602,
        text = "boss倒地留药水CD",
        icon = "134715"
    },]]--
    {
        startEid = 601,
        endEid = 602,
        text = "督军倒地后广场前不允许吃爆发药剂",
        icon = "133844"
    },
    -- {
    --     startEid = 601,
    --     endEid = 602,
    --     text = "NBR:骑士无敌聚怪？",
    --     icon = "135841"
    -- },
    {
        startEid = 601,
        endEid = 602,
        text = "第一个恐惧魔王自由",
        icon = "134715"
    },
    {
        startEid = 602,
        endEid = 603,
        text = "阿卡玛房间第一个两波怪开嗜血 敲dps鼓",
        icon = "133844"
    },
    {
        startEid = 602,
        endEid = 603,
        text = "阿卡玛打完两个猎人小怪后后脱战换火箭鞋",
        icon = "134715"
    },
    {
        startEid = 602,
        endEid = 603,
        text = "阿卡玛不要敲鼓不要敲鼓",
        icon = "133844"
    },
    {
        startEid = 602,
        endEid = 603,
        text = "阿卡玛之影接触的时候T 治疗 远程dps靠近门口移动",
        icon = "133029"
    },
    {
        startEid = 603,
        endEid = 604,
        text = "boss倒地加速鼓 火箭靴",
        icon = "133844"
    },
    -- {
    --     startEid = 603,
    --     endEid = 604,
    --     text = "打完狗门线敲加速",
    --     icon = "133844"
    -- },
    {
        startEid = 603,
        endEid = 604,
        text = "boss前换卡拉波神圣勋章",
        icon = "133279"
    },
    {
        startEid = 604,
        endEid = 605,
        text = "先换火箭鞋再传送",
        icon = "133322"
    },
    {
        startEid = 604,
        endEid = 605,
        text = "三脸p1敲鼓 只允许敲一次",
        icon = "133322"
    },
    {
        startEid = 605,
        endEid = 606,
        text = "boss倒地换火箭靴",
        icon = "133029"
    },
    {
        startEid = 605,
        endEid = 606,
        text = "敲加速鼓",
        icon = "133029"
    },
    {
        startEid = 605,
        endEid = 606,
        text = "血沸不要敲鼓",
        icon = "133029"
    },
    {
        startEid = 605,
        endEid = 606,
        text = "血沸倒地换地精鞋 敲加速鼓",
        icon = "133029"
    },
    {
        startEid = 606,
        endEid = 607,
        text = "放弃隐身装置战术",
        icon = "134875"
    },
    {
        startEid = 607,
        endEid = 608,
        text = "第二个傀儡换双饰品关换装准备隐身",
        icon = "132995"
    },
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


