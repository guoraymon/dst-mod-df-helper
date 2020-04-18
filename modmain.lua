-- 快速采集
if GetModConfigData("quick_pick") == true then
    modimport("scripts/quick_pick.lua")
end

-- 快速收获
if GetModConfigData("quick_harvest") == true then
    modimport("scripts/quick_harvest.lua")
end

-- 快捷丢弃
if GetModConfigData("shortcut_drop") == true then
    modimport("scripts/shortcut_drop.lua")
end

-- 无草蜥蜴
if GetModConfigData("no_grassgekko") == true then
    modimport("scripts/no_grassgekko.lua")
end

-- 无疾病
if GetModConfigData("no_disease") == true then
    modimport("scripts/no_disease.lua")
end

-- 掉落堆叠范围
if GetModConfigData("drop_stack") > 0 then
    modimport("scripts/drop_stack.lua")
end

-- 物品堆叠数量
if GetModConfigData("stack_size") > 0 then
    modimport("scripts/stack_size.lua")
end