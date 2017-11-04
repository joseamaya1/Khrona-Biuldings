function onThink(interval)
    for _, player in ipairs(Game.getPlayers()) do
        if player:getStorageValue(8178237) == 1 then -- here is the storage to check if is "on" or "off"
            local outfit = player:getOutfit()
            outfit.lookHead = math.random(0, 132)
            outfit.lookBody = math.random(0, 132)
            outfit.lookLegs = math.random(0, 132)
            outfit.lookFeet = math.random(0, 132)
            player:setOutfit(outfit)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        end
    end
    return true
end