-- 

function onThink(interval, lastExecution)
	local messages = {
	"[TICKETS]: Utilize nosso atendimento por tickets para falar com um membro superior.",
	"[TEAMSPEAK3]: Servidor de teamSpeak 3 com 1000 slots disponiveis, liberado para criar salas particulares e com senha. IP: Localhost.",
	"[REGRAS]: Não viole nossas regras. http://localhost/index.php?subtopic=tibiarules",
	"[SISTEMA]: O global save do servidor ocorre todos os dias às 06:00hrs.",
	"[COMANDOS]: !buyhouse - !serverinfo - !online - !uptime."
	}

    Game.broadcastMessage(messages[math.random(#messages)], MESSAGE_EVENT_ADVANCE) 
    return true
end

