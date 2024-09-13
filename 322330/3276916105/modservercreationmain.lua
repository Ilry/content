local ENV = env
GLOBAL.setfenv(1, GLOBAL)

--	Play funny sound on activation ~

local ServerCreationScreen = TheFrontEnd:GetActiveScreen()

if tostring(ServerCreationScreen) == "ServerCreationScreen" then
	staticScheduler:ExecuteInTime(0, function()
		local play_sounds = {
			"meta4/otter/vo_attack_f4",
			"meta4/otter/vo_death_f4",
			"meta4/otter/vo_run_pre_f3",
			"meta4/otter/vo_taunt_f8",
		}
		
		TheFrontEnd:GetSound():PlaySound(play_sounds[math.random(#play_sounds)])
	end)
end