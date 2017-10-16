function onUse(cid, item, fromPosition, target, toPosition, isHotkey)
    local playerID = cid:getGuid() -- getPlayerGUID(cid)
    local owner = (item.actionid - 100)
    if (owner > 0) then
        if (owner ~= playerID) then
            doPlayerSendCancel(cid, "You aren\'t owner of this container.")
            return true
        end
    end
end