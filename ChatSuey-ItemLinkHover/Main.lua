local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();

local isItemUri = function (uri)
    local scheme, _ = ChatSuey.UriComponents(uri);
    return scheme == "item";
end;

local onHyperlinkEnter = function ()
    hooks[this].OnHyperlinkEnter();

    local uri = _G.arg1;
    if not isItemUri(uri) then
        return;
    end

    _G.GameTooltip_SetDefaultAnchor(_G.GameTooltip, UIParent);
    _G.GameTooltip:SetHyperlink(uri);
    _G.GameTooltip:Show();
end;

local onHyperlinkLeave = function ()
    hooks[this].OnHyperlinkLeave();

    local uri = _G.arg1;
    if not isItemUri(uri) then
        return;
    end

    _G.GameTooltip:Hide();
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];
    hooks:RegisterScript(chatFrame, "OnHyperlinkEnter", onHyperlinkEnter);
    hooks:RegisterScript(chatFrame, "OnHyperlinkLeave", onHyperlinkLeave);
end