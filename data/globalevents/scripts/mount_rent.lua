function onThink(interval, lastExecution)

	for _, player in pairs(Game.getPlayers()) do
		player:checkRentMounts()
	end

	return true
end