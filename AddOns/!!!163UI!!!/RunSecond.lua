---LibSharedMedia
local optionsFuncs;
local optionsLists;
local LSM;
function CtlSharedMediaOptions(type)
    optionsFuncs = optionsFuncs or {};
    optionsLists = optionsLists or {};
    local func = optionsFuncs[type]
    if not func then
        func = function()
            LSM = LSM or (LibStub and LibStub('LibSharedMedia-3.0', true));
            local list = optionsLists[type];
            if not list then list = {} optionsLists[type] = list; end
            table.wipe(list);
            if LSM then
                for _, v in ipairs(LSM:List(type)) do
                    table.insert(list, v)
                    table.insert(list, LSM:Fetch(type, v))
                end
            end
            return list;
        end
        optionsFuncs[type] = func;
    end
    return func;
end
