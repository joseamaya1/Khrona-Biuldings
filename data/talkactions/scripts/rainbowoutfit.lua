function onSay(player, words, param)
    if param == 'on' or param == 'ON' then
        player:setStorageValue(8178237, 1)
        player:sendCancelMessage("rainbow outfit is actived.")
    elseif param == 'off' or param == 'OFF' then
        player:setStorageValue(8178237, 0)
        player:sendCancelMessage("rainbow outfit is disabled.")
    else
        player:sendCancelMessage("wrong parameter, use on or off.")
    end
    return false
end