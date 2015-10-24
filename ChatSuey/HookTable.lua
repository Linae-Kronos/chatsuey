local _G = getfenv();
local HookTable = {};

function HookTable:new()
    local hookTable = {};

    setmetatable(hookTable, {
        __index = self,
        __mode = "k",
    });

    return hookTable;
end

local noOp = function () end;

function HookTable:RegisterScript(frame, script, handler)
    self[frame] = self[frame] or {};

    if self[frame][script] then
        local err = string.format("Attempted to register multiple \"%s\" handlers for the same frame", script);
        error(err);
    end

    self[frame][script] = frame:GetScript(script) or noOp;
    frame:SetScript(script, handler);
end

function HookTable:RegisterFunc(frame, funcName, func)
    self[frame] = self[frame] or {};

    if self[frame][funcName] then
        local err = string.format("Attempted to register multiple \"%s\" hooks for the same frame", funcName);
        error(err);
    end

    self[frame][funcName] = frame[funcName] or noOp;
    frame[funcName] = func;
end

_G.ChatSuey.HookTable = HookTable;