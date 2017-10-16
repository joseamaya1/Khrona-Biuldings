local config = {
    cost = 1000, -- Cost (GP)
    ownTime = 24 * 60 * 60 * 1000, -- Time (24 horas)
    backpackId = 2000
}
 
function onSay(player, words, param)
    local playerID = player:getGuid()
    local owner = (playerID + 100)
    local ownerName = player:getName()
 
    local function noOwner(o)
        o:removeAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
        o:setActionId(0)
    end
 
    if (player:removeMoney(config.cost) == true) then
        local backpack = doPlayerAddItem(player:getId(), config.backpackId, 1)
        if (backpack ~= nil) then
            doSetItemSpecialDescription(backpack, ownerName..' owns this container.')
            doSetItemActionId(backpack, owner)
            addEvent(noOwner, 1000 * config.ownTime, backpack)
        end
    else
        doPlayerSendCancel(cid, "You do not have the amount of GP ("..config.cost..").")
    end
end