local list = {
    "grass", -- 草
    "sapling", -- 树枝
    "sapling_moon", -- 月岛树枝

    "berrybush", -- 坚果丛
    "berrybush2", -- 浆果丛2
    "berrybush_juicy", -- 多汁浆果丛

    "reeds", -- 芦苇
    "marsh_bush", -- 荆棘丛
    
    "cactus", -- 仙人掌
    "oasis_cactus", -- 绿洲仙人掌

    "red_mushroom", -- 红蘑菇
    "green_mushroom", -- 绿蘑菇
    "blue_mushroom", -- 蓝蘑菇

    "flower_cave", -- 萤光花1
    "flower_cave_double", -- 萤光花2
    "flower_cave_triple", -- 萤光花3

    "lichen", -- 菌藻
    "wormlight_plant", -- 小发光浆果
    "cave_banana_tree", -- 洞穴香蕉
    
    "bullkelp_plant", -- 海藻
    "rock_avocado_bush" -- 石果灌木丛
}

for k, v in pairs(list) do
    AddPrefabPostInit(v, function(inst)
        if inst.components.pickable then
            inst.components.pickable.quickpick = true
        end
    end)
end