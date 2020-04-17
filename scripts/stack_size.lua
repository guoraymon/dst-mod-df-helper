local stack_size = GetModConfigData("stack_size")

TUNING.STACK_SIZE_LARGEITEM = stack_size
TUNING.STACK_SIZE_MEDITEM = stack_size
TUNING.STACK_SIZE_SMALLITEM = stack_size

local function stack(self)
    function self.inst.replica.stackable:SetMaxSize(maxsize)
        self._maxsize:set(1)
    end
end

AddComponentPostInit("stackable", stack)
if stack_size > 63 then
    local stackable_replica = GLOBAL.require "components/stackable_replica"
    stackable_replica._ctor = function(self, inst)
    self.inst = inst
        self._stacksize = GLOBAL.net_shortint(inst.GUID, "stackable._stacksize", "stacksizedirty")
        self._maxsize = GLOBAL.net_tinybyte(inst.GUID, "stackable._maxsize")
    end
end