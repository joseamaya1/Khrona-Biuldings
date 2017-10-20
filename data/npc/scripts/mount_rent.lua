local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

local keywords = {"aluguel", "alugar", "rent", "mounts", "mount"}




function Player.isVip(self)
	return false
end

npcHandler:addModule(FocusModule:new())

function creatureSayCallback(cid, type_, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	
	local msg = string.lower(msg)
	local player = Player(cid)

	if isInArray(keywords, msg) then
		local str = "You can rent"
		local amount = 0

		for name, v in pairs(MOUNT_H) do
			if not ((v.premium and player:getPremiumDays() < 1) or (v.vip and not player:isVip()) or 
				(player:getLevel() < v.level) or (player:getStorageValue(v.storage) >= os.time())) then
				
				str = str .. " {".. name .. "},"
				amount = amount + 1
			end
		end		

		if amount > 0 then
			npcHandler:say(str:sub(1, #str - 1) .. "!", cid)
			npcHandler.topic[cid] = 1			
		else
			npcHandler:say("You are not allowed to rent any mount.", cid)
		end
	elseif npcHandler.topic[cid] == 1 and MOUNT_H[msg] then
		local mount = MOUNT_H[msg]

		if mount.premium and player:getPremiumDays() < 1 then
			npcHandler:say("You must be premium to rent this mount.", cid)
			return true
		elseif player:getLevel() < mount.level then
			npcHandler:say("You must be, at least, level " .. mount.level .. " to rent this mount.", cid)
			return true
		elseif player:getStorageValue(mount.storage) >= os.time() then
			npcHandler:say("You already have rented this mount!", cid)
			return true
		end

		local str = "You want to rent ".. msg .." for ".. mount.hours .. " hour".. (mount.hours > 1 and "s" or "")

		npcHandler:say(str .. " for ".. mount.price .. " gold pieces?", cid)
		npcHandler.topic[cid] = msg
	elseif type(npcHandler.topic[cid]) == "string" then
		local mount = MOUNT_H[npcHandler.topic[cid]]

		if player:removeMoney(mount.price) then
 			player:addMount(mount.mountid)
			player:setStorageValue(mount.storage, os.time() + mount.hours * 60)
			npcHandler:say("Here is your ".. npcHandler.topic[cid] ..", it will last until ".. os.date("%d %B %Y %X", os.time() + mount.hours * 60) ..".", cid)
		else
			npcHandler:say("Sorry, you do not have enough money to rent the mount!", cid)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, "no") then 
		npcHandler:say("Ok then.", cid)
		npcHandler.topic[cid] = 0
	end
	
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())