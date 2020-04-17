-- 快速采集
if GetModConfigData("quick_pick") == true then
    modimport("scripts/quick_pick.lua")
end

-- 快速丢弃
if GetModConfigData("quick_drop") == true then
    modimport("scripts/quick_drop.lua")
end