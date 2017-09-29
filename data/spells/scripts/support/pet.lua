--Script By Igor Labanca
function onCastSpell(creature, variant)
		
	local STORAGE_PET = 60045
		
	    vocationid = creature:getVocation():getId()
	        if  vocationid == 5 then
				pet = "thundergiant"
			
			elseif vocationid == 6 then
				pet = "grovebeast"
			
			elseif vocationid == 7 then
				pet = "emberwing"

			elseif vocationid == 8 then
				pet = "skullfrost"
		end
            
	local monsterType = MonsterType(pet)
	
		if not monsterType:isPet() then
			creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)

			
		if #creature:getSummons() >= 1 then
			creature:sendCancelMessage("You cannot summon more creatures.")
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
			end
	end
	
	local position = creature:getPosition()
	local summonpet = Game.createMonster(pet,position)
	if not summonpet then
		creature:sendCancelMessage(RETURNVALUE_NOTENOUGHROOM)
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end

	creature:addSummon(summonpet)
	position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	
	local timestorage = 900 --15 minutes
	creature:setStorageValue(STORAGE_PET,0)
	creature:setStorageValue(STORAGE_PET,os.time()+timestorage)
	return true
	
end
