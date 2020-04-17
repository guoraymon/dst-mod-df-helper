-- 快速采集
if GetModConfigData("quick_pick") == true then
    modimport("scripts/quick_pick.lua")
end

-- 快速丢弃
if GetModConfigData("quick_drop") == true then
    modimport("scripts/quick_drop.lua")
end

-- 掉落堆叠范围
if GetModConfigData("drop_stack") > 0 then
    modimport("scripts/drop_stack.lua")
end

-- 物品堆叠数量
if GetModConfigData("stack_size") > 0 then
    modimport("scripts/stack_size.lua")
end