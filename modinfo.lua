name = "稻花助手"
description = ""
author = "颠三倒四"
version = "1.0.0"

priority = 0

api_version = 6
api_version_dst = 10

dst_compatible = true 
dont_starve_compatible = false
reign_of_giants_compatible = false 
shipwrecked_compatible = false

all_clients_require_mod = true
client_only_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

local function AddOption(name, label, hover, options, default_setting)
    return {
        name = name or "",
        label = label or "",
        hover = hover or "",
		options = options or  {
            { description = "关闭", data = false },
            { description = "开启", data = true, hover = "默认" },
        },
        default = default_setting or true
    }
end

configuration_options = {
    AddOption("quick_pick", "快速采集", "快速采集植物"),
    AddOption("quick_drop", "快速丢弃", "快速丢弃物品"),
    {
        name = "drop_stack",
        label = "掉落堆叠范围",
        hover = "设置掉落物自动堆叠范围或关闭",
        options =
        {
			{ description = "关闭", data = 0 },
			{ description = "10", data = 10, hover = "默认" },
			{ description = "20", data = 20 },
			{ description = "30", data = 30 },
        },
        default = 10,
    },
    {
        name = "stack_size",
        label = "物品堆叠数量",
        hover = "设置物品堆叠数量",
        options =
        {
			{ description = "关闭", data = 0 },
			{ description = "40", data = 40 },
			{ description = "63", data = 63 },
			{ description = "99", data = 99, hover = "默认，两位数堆叠上限" },
			{ description = "127", data = 127 },
			{ description = "255", data = 255 },
			{ description = "500", data = 500 },
			{ description = "999", data = 999 },
        },
        default = 99,
    }
}