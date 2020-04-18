AddStategraphPostInit("wilson", function(inst)
    local actionhandler = GLOBAL.ActionHandler(GLOBAL.ACTIONS.HARVEST, "doshortaction")
    inst.actionhandlers[GLOBAL.ACTIONS.HARVEST] = actionhandler
end)