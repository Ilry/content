local _G = GLOBAL
local require = _G.require
local STRINGS = _G.STRINGS

-- Nightmare Throne (Maxwell).
local kyno_maxwell = {"kyno_endgame_maxwell"}
for i, maxwell in ipairs(kyno_maxwell) do
	AddPrefabPostInit(maxwell, function(inst)
		local function ShutUpMaxwell(inst)
			inst.SoundEmitter:KillSound("talk_LP")
		end
	
		inst:AddTag("MaxwellTalker")
		
		inst:AddComponent("talker")
		inst.components.talker.ontalk = ontalk
		inst.components.talker.fontsize = 40
		inst.components.talker.font = TALKINGFONT
		inst.components.talker.offset = _G.Vector3(0,-700,0)
		
		if not _G.TheWorld.ismastersim then
		   return inst
		end
		
		local talk_time = 100 * (0.8 + 0.4 * math.random()) --500
		inst:DoPeriodicTask(talk_time, function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()
			local ents = _G.TheSim:FindEntities(x, y, z, 16, { "player" })
			ent = ents[1]
			
			if ent and ent.userid ~= nil then
				if math.random() < 0.050 then	
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("Forgive me if I don't get up.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP") 
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("They'll show you terrible, beautiful things.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then	
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("Just dust. And the Void. And Them.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("You can't change the rules of the game.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("Go on, stay a while. Keep us company.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("I don't know what they want. They... they just watch.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("Either way, you're just delaying the inevitable.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("I'm so tired...")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("Is this how it ends?")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("I hope Charlie is okay...")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("Maybe I was wrong, maybe...")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("At least you have freedom.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("Heh. Took them long enough.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("God Mode Disabled")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("You've been an interesting plaything, but I've grown tired of this game.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("I've learned so much since then. I've built so much.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("There wasn't much here when I showed up.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("Unless you get too close... Then...")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("What year is it out there? Time moves differently here.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("Well, there's a reason I stay so dapper.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("Reality is like that, sometimes.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("󰀅󰀆󰀅")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("I think I've said enough.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("I suppose I deserve that.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("This is the end of the line. We have no escape.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("It will change you, like it did me.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("I'm so sorry, Charlie.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("Maybe you can give me a little hand here?")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("They are watching us...")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("You can't escape from them.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("You Can (Not) Redo.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("You should watch Thalz on Twitch.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("You should watch Jazzy on Twitch.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("You should watch Freddo on Twitch.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("You should watch Glermz on Twitch.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("You should watch Griever on Twitch.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("DA PIPOCA PRO PAI")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("I've lost all my friends, I diserved.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				elseif math.random() < 0.050 then
					inst.AnimState:PlayAnimation("dialog_loop")
					inst.components.talker:Say("People always complain about Wolfgang's damage, but they cheese bosses.")
					inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP_world6", "talk_LP")
					inst:ListenForEvent("animover", ShutUpMaxwell)
					inst.AnimState:PushAnimation("idle_loop", true)
				end
			end
		end)
	end)
end

-- Parrots.
local parrot_pirate = {"kyno_shipmast", "parrot_pirate", "kyno_parrot_boat"}
for i, parrot in ipairs(parrot_pirate) do
	AddPrefabPostInit(parrot, function(inst)
		inst:AddTag("parrot_pirate")
		inst:AddComponent("talker")
		inst.components.talker.ontalk = ontalk
		inst.components.talker.fontsize = 30
		inst.components.talker.font = TALKINGFONT
		inst.components.talker.colour = _G.Vector3(.9, .4, .4)
		inst.components.talker.offset = _G.Vector3(0,-600,0)
		
		if not _G.TheWorld.ismastersim then
		   return inst
		end
		local talk_time = 100 * (0.8 + 0.4 * math.random()) --500
		inst:DoPeriodicTask(talk_time, function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()
			local ents = _G.TheSim:FindEntities(x, y, z, 16, { "player" })
			ent = ents[1]
			
			if ent and ent.userid ~= nil then
				if math.random() < 0.050 then
					inst.components.talker:Say("Arrr! you little shit!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk") 
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Glermz big head!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Chump!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("You stink!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Feed me!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Glermz stop complaining!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Cracker!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("MERDA MERDA MERDA")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("CUT STONES!!!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Ogait we need more resources!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("I bet-t-t OoOogait is dying!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Willow is the best!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")					
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Wigfrid Mains")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("1 Hit Kill Mode Disabled")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Alt+F4 to avoid death!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Filthy Wes main!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Why aren't you insane, noob?")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("I don't struggle with any boss!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Arr! Pools is cheating cobblestones again!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Kynoox! Arrr! Fix this!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Nice farm chump! I'll steal this.")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Klei Forums 󰀅󰀆󰀅")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Hey guys, keyboard again.")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Yo, 12 living logs are missing! Arrr!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("LORO QUER BISCOITO!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Can you stop talking shit about Wolfgang?")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("FOR THE FIRE LORD! ARRR!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("I know where is James Bucket's discord, chump!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Jazzy big nose!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Hey, weeabo!")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				elseif math.random() < 0.050 then
					inst.components.talker:Say("Wes is bes")
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/parrot/chirp", "talk")
				end
			end
		end)
	end)
end

-- Hamlet Pigs.
STRINGS.CITYPIGNAMES =
{
    UNISEX = {
        "Melbourne",
        "Peel",
        "Derby",
        "Palmerston",
        "Gladstone",
        "Disraeli",
        "Salisbury",
        "Kensington",
        "Conroy",
        "Greville",
        "Hastings",
        "Aberdeen",
        "Talbot",
        "Thames",
        "Stockton",
        "Darlington",
    },
    FEMALE = {
        "Elizabeth",
        "Alexandrina",
        "Alice",
        "Agnes",
        "Arabella",
        "Belle",
        "Beryl",
        "Briar",
        "Beatrice",
        "Catherine",
        "Charlotte",
        "Della",
        "Ebba",
        "Edith",
        "Flora",
        "Florence",
        "Georgette",
        "Henrietta",
        "Luella",
        "Lilian",
        "Louise",
        "Ottilie",
        "Ophelia",
        "Sophronia",
		"Cah",
    },
    MALE = {
        "William",
        "Clarence",
        "Frederick",
        "Edward",
        "George",
        "Charles",
        "Leopold",
        "Albert",
        "Alfred",
        "Arthur",
        "Ewart",
        "Herbert",
        "Henry",
        "Charley",
        "Douglas",
        "Edison",
        "Edmund",
        "Larkin",
        "Oliver",
        "Merritt",
        "Sterling",
        "Tesla",
        "Thaddeus",
        "Wellington",
        "Gulliver",
		"Thalz",
		"Ogait",
		"Kirby",
		"Glermz",
		"Jazzy",
		"Rhovious",
		"Kyno",
    },
}

STRINGS.CITY_PIG_TALK_FOLLOWWILSON = {
	DEFAULT = {"WHEREFORE ART THINE BAD GUYS?", "ONCE MORE UNTO THE BREACH, UNPIG", "TAKE ARMS!", "KILL, KILL, KILL!", "CRY HAVOC!", "THE GAME IS AFOOTS!",},
	pigman_beautician = {"VISIT MINE SHOP FOR MEDICINES", "SELLEST ME THINE FEATHERS", "I HATH NEED OF FEATHERS"},
	pigman_mechanic = {"SELLEST ME THINE REFINED'D THINGS", "IN NEED OF FIXINGS?", "SELLEST ME THINE ROPE", "SELLEST ME THINE BOARDS"},
	pigman_mayor = {"YOU VOTETH?", "GIVE ME THINE GOLD FOR GOOD CAUSE", "ENDORSETH ME?",},
	pigman_collector = {"WANT'ST STRANGE THINGS?", "SELLEST ME THINE WEIRDITIES",},
	pigman_banker = {"ALL THAT GLITTERS WORTH OINCS", "HAST THOU JEWELS?", "I BUY THOU JEWELS"},
	pigman_florist = {"VISIT MINE SHOP FOR SEEDS", "HAST THOU PLOP TO SELL?", "HAST THOU PETALS?"},
	pigman_farmer = {"I HAST FARM", "SELLETH ME THINE GRASS", "STEALEST NAUGHT MINE STUFFS"},
	pigman_miner = {"I WILLST BUY THINE ROCKS", "HAST THOU ROCKS TO SELL?", "STEAL NOT FROM MINE MINE"},
	pigman_shopkeep = {"HAST THOU CLIPPINGS", "I LIKETH CLIPPINGS", "TRIM YON SHRUBS FOR CLIPPINGS"},
	pigman_storeowner = {"HAS'T THOU CUTTINGS O' HEDGE?", "", "COME TO SHOP"},
	pigman_erudite = {"NEED'ST THOU MAGICS? COME'ST TO MINE SHOP", "NEED'ST FUEL O' NIGHTMARES", "HAST THOU FUEL O' NIGHTMARES?"},
	pigman_hatmaker = {"NEED'ST HATS? VISIT YON HAT SHOP", "HAST THOU SILK?", "THY HEAD IS'T IN NEED O' COVERINGS"},
	pigman_professor = {"VISIT YON ACADEMY", "HA'ST THOU RELICS?", "HATH THOU STUFFS O' OLDEN'D TIMES?"},
	pigman_hunter = {"NEED'ST THOU WEAPONS? VISIT MINE SHOP", "HAS'T THOU TOOTH O' THE HOUND?", "GET THEE TO YON WEAPONS SHOP"},
}

STRINGS.CITY_PIG_TALK_FIND_LIGHT = {
	DEFAULT = {"ONCE MORE UNTO THE LIGHT!", "WHEREFORE ART LIGHT?", "WHEREFORE IS'T SUN?", "FREINDS, PIGGIES, UNPIGGIES, LEND ME YOUR LIGHT"},
	pigman_beautician = {"I AM TOO MUCH I' THE DARK", "'TIS DARK!", "WHEREFORE ART THE LIGHT?"},
	pigman_mechanic = {"IS'T DARK! IS'T SCARY!", "THAT WAY MADNESS LIES!",},
	pigman_mayor = {"FRIENDS, PIGGIES, UNPIGMEN, LEND ME YOUR LIGHT!", "WHEREFORE ART MINE LIGHT?"},
	pigman_royalguard = {"TAKE NAUGHT THE LIGHT!", "TAKE ARMS!", "ONCE MORE UNTO THE LIGHT!"},
	pigman_royalguard = {"TAKE NAUGHT THE LIGHT!", "TAKE ARMS!", "ONCE MORE UNTO THE LIGHT!"},
	pigman_collector = {"WHEREFORE ART THE LIGHT?!", "I NEED'ST LIGHT!",},
	pigman_banker = {"BRINGETH BACK THE LIGHT!", "THIS WAY DARKNESS LIES!"},
	pigman_florist = {"I AM TOO MUCH I' THE DARK!", "THIS WAY DARKNESS LIES!",},
	pigman_storeowner = {"ONCE MORE UNTO THE LIGHT!", "WHEREFORE ART THOU, LIGHT?"},
	pigman_farmer = {"WHEREFORE IS'T SUN?", "NEED'ST LIGHT!",},
	pigman_miner = {"FINDETH LIGHT!", "IS'T TOO MUCH SCARY"},
	pigman_shopkeep = {"PROTECTETH ME!", "TAKETH NAUGHT THE LIGHT!",},
	pigman_erudite = {"'TIS TOO MUCH DARKNESS!", "DARKNESS IS AFOOTS!"},
	pigman_hatmaker = {"THIS WAY DARKNESS LIES!", "I AM TOO MUCH I' THE DARK!"},
	pigman_professor = {"THIS WAY DARKNESS LIES!", "DARKNESS 'TIS NAUGHT GOOD!"},
	pigman_hunter = {"BRING'ST BACK THE LIGHT!", "IS'T DARK! IS'T SCARY!"},
}

STRINGS.CITY_PIG_TALK_LOOKATWILSON_TRADER = {
	pigman_beautician = {"HAS'T THOU FEATHERS?", "VISIT SHOP IF THOU HAS'T BOO BOOS", "SELLEST ME FEATHERS"},
	pigman_mechanic = {"WHATFORE IS YOU?", "HAS'T THOU BOARDS?", "HAS'T THOU ROPE?", "I BUY'ST THINGS REFINED'D"},
	pigman_mayor = {"WANTS THOU HOME IN HAMLET?", "WANTS THOU PIG O' SECURITY?", "VOTE FOR ME ONLY"},
	pigman_collector = {"HAS'T THOU ODD STUFFS?", "I CAN'ST BUY YOUR ODD STUFFS?", "I SELL'ST ODD STUFFS!"},
	pigman_banker = {"HAS'T THOU JEWELS?", "I BUY'ST JEWELS FROM THOU", "WILL-TH THOU SELLEST ME THINE JEWELS?"},
	pigman_florist = {"NEED'ST I STUFFS O' PLANTS", "HAS'T THOU PLOP?", "HAS'T THOU PETALS?"},
	pigman_farmer = {"HAS'T THOU GRASS?", "DON'T TAKETH MINE FARM STUFFS", "CAN'ST THOU SELL ME THINE GRASS?"},
	pigman_miner = {"HAS'T THOU ROCKS?", "TAKETH NAUGHT MINE ROCKS", "I WILL GIVETH THEE OINCS FOR ROCKS"},
	pigman_shopkeep = {"HAS'T THOU CLIPPINGS?", "GET THEE TO A SHRUBBERY", "SELLEST ME THINE CLIPPINGS"},
	pigman_storeowner = {"HAS'T THOU CLIPPINGS?", "GET THEE TO A SHRUBBERY", "SELLEST ME THINE CLIPPINGS"},
	pigman_erudite = {"HAS'T THOU RELICS O' PIGGIES?", "SELLEST ME THINE PIGGY RELICS", "RELIC HATH MUCH WORTH"},
	pigman_hatmaker = {"HAS'T THOU HATS?", "ME HAVE HATS FOR UNPIG HEAD", "ME BUY FEATHERS FROM YOU"},
	pigman_professor = {"YOU HAVE RELICS?", "COME TO SHOP, ME HAVE RELICS", "I NEED OLD STUFFS"},
	pigman_hunter = {"YOU NEED SMASH STUFF?", "ME TAKE OINCS FOR WEAPON", "WEAPON MAKE YOU NOT SCARED"},
	DEFAULT = {"HOW NOW, UNPIG?","GOOD FORTUNE","WELL MET","GOOD FORTUNE, THOSE WHO HAVE OINCS","MY KINGDOM FOR SOME OINCS"},
}

STRINGS.CITY_PIG_TALK_LOOKATROYALTY_TRADER = { 
	pigman_beautician = {"THOU HAST MOST BEAUTIFUL SNOUT", "YON MAJESTY", "TAKETH THEE A GIFT?"},
	pigman_mechanic = {"HOW NOW, YOUR MAJESTY", "AT-ETH YON SERVICE", "THOU MIGHTY SCEPTER'D BEING"},
	pigman_mayor = {"YON MAJESTY!", "ME HONORED'D!", "AT YON SERVICE"},
	pigman_royalguard = {"MINE SERVICE UNTO YOU", "YON MAJESTY", "LONG LIVE YON MAJESTY!"},
	pigman_royalguard_2 = {"THY HONOR US LOWLY PIGS", "YON MAJESTY", "THOU MIGHTY SCEPTER'D BEING"},
	pigman_collector = {"AT THINE SERVICE", "THOU DO-EST US AN HONOR", "TAKEST THOU A GIFT?"},
	pigman_banker = {"YON MAJESTY!", "THOU DO-EST ME AN HONOR", "I AM AT-ETH THY SERVICE",},
	pigman_florist = {"TAKEST THINE MINE FLOWERS?", "AT YON SERVICE", "ME HONORED'D AT THINE PRESENCE!"},
	pigman_farmer = {"THINE HUMBL'EST SERVENT", "YOUR MAJESTY", "AT THINE SERVICE"},
	pigman_miner = {"YOU HONOR ME", "TAKE'ST THOU A GIFT", "ACCEPT'ETH MINE GIFT!"},
	pigman_shopkeep = {"HOW NOW, YON MAJESTY?", "LIKETH THY MINE GIFT?", "TAKE'ST THEE A GIFT?",},
	pigman_storeowner = {"AT THINE SERVICE", "LIKEST THY MINE GIFT?", "THOU MIGHTY SCEPTER'D BEING"},
	pigman_erudite = {"ACCEPT MINE HUMBLEST GIFT", "LONG LIVE YON MAJESTY", "WILL'ST THOU ACCEPT A GIFT?"},
	pigman_hatmaker = {"YON MAJESTY", "AT THINE SERVICE", "THOU MIGHTY SCEPTER'D BEING"},
	pigman_professor = {"ACCEPT'ST THOU A GIFT?", "THY HONOR ME?", "I AM THOU MOST HUMBLEST PIGGY SERVANT"},
	pigman_hunter = {"THY HONOR US LOWLY PIGS", "YON MAJESTY", "AT YON SERVICE, YON MAJESTY"},
	DEFAULT = {"GREETINGS YOUR HIGHNESS","NEED'ST THOU OINCS?","GOOD DAY","NEED'ST OINCS. HAV'TH THOU THAT?","I WANT'ST OINCS. WILL BUY", "YOUR MAJESTY"},
}

STRINGS.CITY_PIG_TALK_LOOKATWILSON = {
	DEFAULT = {"WHAT HO, UNPIG", "HOW NOW, GOOD UNPIG", "WHAT NEWS?", "WELL MET"},
	ROYALTY = {"LONG LIVE THE QUEEN!","HAIL, GOOD NOBLE PIG!", "MINE LIEGE", "HAIL TO YOU, GOOD GENTLEPIGGY",}, 
}

STRINGS.CITY_PIG_TALK_APORKALYPSE_SOON = { 
	DEFAULT = { "THE APORKALYPSE APPROACH-ETH", "WOE, DESTRUCTION, RUIN, AND DECAY!", "DOOMSDAY IS NEAR!", "SOMETHING WICKED THIS WAY COMES", "PORKTENTOUS FIGURES!", "FEAR AND PORKTENT!"},
}

STRINGS.CITY_TALK_ANNOUNCE_APORKALYPSE = {
	DEFAULT = { "THE APORKALYPSE COMETH!", "THE CRACK OF DOOM!", "DEATH HAVE ITS DAY!", "THEY HATH RETURNED!", "THEY KILL US FOR THEIR SPORT", "A PLAGUE ON ALL OUR HOUSES!", "BE ALL AND END ALL!"},
}

STRINGS.CITY_PIG_TALK_RUNAWAY_WILSON = {
	DEFAULT = {"THOUST ART NOT KIND!", "STAYEST THOU AWAY!", "GET-ETH THEE AWAY!", "ADIEU YOU!"},
	pigman_beautician = {"GOODNESS!", "EEP! SNORT!", "LEAVETH THOU!!", "THOU HAST THE SMELL OF UNPIG"},
	pigman_mechanic = {"I TRUST THEE NOT!", "STAY'ST THOU BACK", "GET THEE GONE, UNPIG"},
	pigman_mayor = {"GET THEE GONE!", "GO-EST THOU AWAY!", "GUARDS! PROTECT-ETH ME!",},
	pigman_shopkeep = {"TOO CLOSE! THOU TOO CLOSE!", "BACK-ETH THEE OFF!", "GET THEE GONE!"},
	pigman_royalguard = {"STAYEST THOU AWAY!", "GET THEE GONE!", "THOU HAST THE STENCH OF UNPIG!"},
	pigman_royalguard_2 = {"GO'ST THOU AWAY", "BACK-ETH THEE OFF!", "TALK'ST THOU TO ME?"},
	pigman_storeowner = {"THINE CLOSENESS DOST OFFENDETH ME", "TOO CLOSE!", "BACK'ST THOU UP!"},
	pigman_farmer = {"WHATFORE THOU WANT'ETH WITH ME?", "GET'ST BACK!", "BACK-ETH OFF!"},
	pigman_miner = {"LEAVE'ST ME BE!", "SHOO!", "STAYEST THOU AWAY!"},
	pigman_collector = {"TAKETH NAUGHT MINE STUFFS!", "GET THEE GONE", "GO'EST THOU AWAY!"},
	pigman_banker = {"THOU HAST THE SMELL OF UNPIG", "TAKE-ETH OFF!", "GET THEE GONE!"},
	pigman_florist = {"ADIEU!", "THOU ART TOO CLOSE!", "STAND-EST NAUGHT SO CLOSE TO ME!"},
	pigman_erudite = {"LEAVETH ME BE!", "WHYFORE YOU BUG-ETH ME?", "BACK-EST THOU OFF!"},
	pigman_hatmaker = {"GO'ST THOU AWAY!", "WANT THOU TO STEAL'EST MINE STUFFS?", "GET THEE GONE!", "I TRUSTETH THEE NAUGHT!"},
	pigman_professor = {"LEAVETH ME BE!", "GO-EST THOU AWAY", "WHYFORE YOU SO CLOSE?"},
	pigman_hunter = {"BACK-ETH AWAY!", "CROWD-EST ME NAUGHT!", "GET-ETH THEE AWAY!"},
}

STRINGS.CITY_PIG_TALK_FIGHT = {
	DEFAULT = {"AVAST!", "TO THINE DEATH!", "RAAAWR!", "I BITE MY HOOF AT THEE!"},
	pigman_beautician = {"DIE-EST NOW!", "ME KILL THEE", "TO THY DEATH!"},
	pigman_mechanic = {"I HAMMER THEE!", "HIT, HAMMER! HIT!", "I DESTROY THEE!"},
	pigman_mayor = {"KILL!", "DIE THOU!", "ME MOST VEXED!", "DESTROY!"},
	pigman_shopkeep = {"I GET THEE!", "THOU NOT NICE!", "I GET THEE!"},
	pigman_storeowner = {"GETEST THEE OUT!", "THY NOT BE WELCOME!", "GET OFF MINE PROPERTY!"},
	pigman_farmer = {"GET THEE BACK!!", "I BURY THINE!", "I GET THEE!"},
	pigman_miner = {"I CRUSHETH YOU!", "THY DYING!", "THOU DONE IT NOW!"},
	pigman_collector = {"THOU ART DONE FOR!", "GET THINE HENCE!", "THY BAD UNPIG!"},
	pigman_banker = {"THY NOT MINE FRIEND!", "I CHOP-ETH THEE!", "DIE! DIE!"},
	pigman_florist = {"THOU ART THE WORST!", "GO AWAY-EST!", "THOU ART A VILLAIN!"},
	pigman_erudite = {"VILLAIN UNPIG! BAD!", "THINE ART THE BADEST!", "AWAY FROM ME!"},
	pigman_hatmaker = {"YOU BE UNDONE!", "I SAY THEE OUT!!", "YOU MOST VEXING!"},
	pigman_professor = {"BE DONE-EST WITH THEE!", "WILL NOT YOU GO?!!", "OUT DAMNED UNPIG!"},
	pigman_hunter = {"I ATTACK-ETH THEE!", "GET THOU AWAY FROM HERE!", "YOU MOST NOT WELCOME!"},
}

STRINGS.CITY_PIG_TALK_DAILYGIFT = {
	DEFAULT = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"}
}

STRINGS.CITY_PIG_TALK_POOPTIP = {
	DEFAULT = {"OUT, DAMNED PLOP", "HUMBLE THANKS, KIND UNPIG", "MY THANKS"},
	pigman_beautician = {"TAKEST THEE THY COIN", "HERE BE YOUR OUTRAGEOUS FORTUNE", "THANK YE, UNPIG"},
	pigman_mechanic = {"OUT, DAMNED PLOP!", "FAIR PRICE, FAIR UNPIG?", "LET-EST ME PAY FOR THYST HELP"},
	pigman_mayor = {"IS THAT PLOP I SEE BEFORE THEE?", "HONEST UNPIG", "KINDEST UNPIG"},
	pigman_shopkeep = {"UNPIG IS AN HONORABLE UNPIG", "I GIVE EVERY PLOP MY OINC", "FAIR TERMS"},
	pigman_storeowner = {"FOR THY PLOP PICKING", "MOST EXCELLENT PICKING", "HONORABLE UNPIG"},
	pigman_farmer = {"FOR THY HONEST MANURING", "TAKEST THOU WHAT THOU'ST OWED", "HONEST OINC FOR UNPIG"},
	pigman_miner = {"'TIS FOUL", "IS A JUST PAYMENT?", "'TIS WORTHY DEED"},
	pigman_collector = {"HERE BE OINC FOR THOUST MANURE", "ALAS POOR UNPIG", "FORTUNE SMILES ONST THEE"},
	pigman_banker = {"AN OINC FOR THY TROUBLE", "A TAX FOR THY PLOP PICKING", "MANY THANKS"},
	pigman_florist = {"WE WILLST PAY FOR THY PLOPPING", "IS POO, UNPIG?", "ME PAYEST FOR PLOP PICKING"},
	pigman_erudite = {"FAIR PRICE FOR FOUL DEED", "THY PLOP-PICKING IS MOST PROFESSIONALS", "FOR PLOP OF PIGGY MAN"},
	pigman_hatmaker = {"I GIVE THE UNPIG ITS DUE", "WHAT PIECE OF WORK IS UNPIG", "YOU'ST PAID FOR PLOP OF PIG"},
	pigman_professor = {"THOUST MILK OF UNPIG KINDNESS", "SUCH STUFF AS PLOP IS MADE ON", "FOR THY "},
	pigman_hunter = {"PLOP AND CIRCUMSTANCE", "FOR POUND OF PLOP", "HAVE OINCS THRUST UPON THEE"}, 
}

STRINGS.CITY_PIG_TALK_PAYTAX = {
	DEFAULT = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
}

STRINGS.CITY_PIG_TALK_PROTECT = {
	DEFAULT = {"MOST FOUL! MOST FOUL!", "TAKE ARMS! TAKE ARMS!", "THOU WRETCH", "THOU COWARD!"},
}

STRINGS.CITY_PIG_TALK_EXTINGUISH = {
	DEFAULT = {"OUT OUT, BRIEF FIRES!", "FIRE IS'T BAD!", "YON FIRE BE OUT!"},
}

STRINGS.CITY_PIG_TALK_STAYOUT = {
	DEFAULT = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
}

STRINGS.CITY_PIG_TALK_FLEE = {
	DEFAULT = {"ROGUE!", "PEASANT SLAVE!", "O HORRIBLE!", "O STRANGE"},
	pigman_beautician = {"O HORRIBLE!", "O STRANGE!", "MOST HORRIBLE"},
	pigman_mechanic = {"MOST NOTABLE COWARD", "FLEE!", "AVAST!"},
	pigman_mayor = {"THAT WAY MADNESS LIES!", "NO MORE OF THAT!", "CRY MERCY"},
	pigman_royalguard = {"KILL, KILL, KILL, KILL", "FARE THEE WELL!", "ONCE MORE UNTO THE BREACH!"},
	pigman_royalguard_2 = {"TO ARMS!", "I DASH YOU TO PIECES!", "THE GAME IS UP!"},
	pigman_shopkeep = {"FOUL!", "LESS THAN FAIR!", "WOE IS ME!"},
	pigman_storeowner = {"PIGS BE UP IN ARMS", "'TIS A WILD PIG CHASE", "WHAT A PIECE OF WORK!"},
	pigman_farmer = {"THOU LILY-LIVERED UNPIG!", "LIE LOW!", "O MISERY!"},
	pigman_miner = {"IF YOU PRICK US, WE BLEED!", "'TIS RUIN'D!", "A POX ON'T!"},
	pigman_collector = {"I AM TOO MUCH ON THE RUN!", "FLEE, FIE, FO, FUM!", "SOMETHING ROTTEN!"},
	pigman_banker = {"ADIEU, ADIEU!", "REMEMBER ME!", "FIE ON THEE!"},
	pigman_florist = {"S'WOUNDS!", "ZOUNDS!", "COWARD!"},
	pigman_erudite = {"A PLAGUE ON YOUR HOUSES!", "THOU'RT MAD!", "AWAY FROM ME!"},
	pigman_hatmaker = {"RUINOUS!", "HARK! NO MORE!", "CUR!"},
	pigman_professor = {"MOST FOUL!", "NOT FAIR!", "LEAVE ME!"},
	pigman_hunter = {"TAKETH THEM AWAY!", "FIE ON THEE!", "TOIL AND TROUBLE!"},
}

STRINGS.CITY_PIG_TALK_RUN_FROM_SPIDER = {
	DEFAULT = {"SPIDER IS'T BAD!", "LIKETH NAUGHT YON SPIDER!", "GO'ST THOU AWAY!"},
	pigman_beautician = {"O MONSTROUS!", "O HORRIBLE!", "MOST VEXING!"},
	pigman_mayor = {"GET-ETH THEE AWAY!", "ALAS!! ALACK!", "I HATE-ETH THEE, SPIDERS!"},
	pigman_mechanic = {"O MONSTROUS THING!", "WRECK-ETH NAUGHT OUR STUFFS", "GO'ST THOU AWAY!"},
	pigman_royalguard = {"PROTECT-ETH THE CITY!", "SPIDERS NAUGHT WELCOME!", "GET THEE GONE!"},
	pigman_royalguard_2 = {"PROTECT-ETH THE CITY", "SQUASH-ETH THE SPIDERS!", "GET THEE GONE!"},
	pigman_shopkeep = {"PROTECT-ETH MINE STORE!", "GET-ETH THEE GONE!", "GO-EST AWAY!"},
	pigman_storeowner = {"EEK! SNORT! AVAST!", "MOST VEXING!", "O HORRIBLE!"},
	pigman_farmer = {"O MONSTROUS THING!", "SPIDERS NAUGHT WELCOME!", "MOST VEXING!"},
	pigman_miner = {"GO-ETH THOU AWAY!", "GET THEE GONE!", "THOU AREN'ST WELCOME HENCE"},
	pigman_collector = {"GET THEE GONE!", "THOU ART BAD GUY!!", "MOST VEXING!"},
	pigman_banker = {"FOUL! FOUL! MOST FOUL!", "MONSTROUS THING!", "GET THEE GONE!!"},
	pigman_florist = {"SPIDER IS'T BAD!", "O MONSTROUS!!", "O HORROR!"},
	pigman_erudite = {"GET THEE GONE!", "AWAY! AWAY!!", "EEK!"},
	pigman_hatmaker = {"CREEP NAUGHT HENCH!", "GO'ST THOU AWAY!", "GUARD!"},
	pigman_professor = {"GET-ETH THEE AWAY!", "ALAS! ALACK!", "GET THEE GONE!"},
	pigman_hunter = {"I HATE-ETH THEE!", "LIKE-ETH THEE NAUGHT!", "EEK! SNORT! AVAST!!"},
}

STRINGS.CITY_PIG_TALK_HELP_CHOP_WOOD = {
	DEFAULT = {"TAKETH THAT TREE!", "I SMASH-ETH YON TREE!", "I PUNCH-ETH TREE!"},
	pigman_beautician = {"I SHALL CHOP-ETH!", "YON TREE NEEDS CHOPPIN'!",},
	pigman_mechanic = {"SHALL I COMPARE TREE TO SUMMER'S DAY?", "WORK-ETH, WORK-ETH, WORK-ETH",},
	pigman_mayor = {"WHAT PIECE OF WORK IS CHOPPING", "FALL, TREE!",},
	pigman_royalguard = {"I TAKETH DOWN YON TREE", "I CHOPTING", "I GOOD FRIEND, I CHOPT TREE"},
	pigman_royalguard_2 = {"CHOP'T CHOP'T", "I AXE THEE!", "FAIR TREE SHALT FALL!"},
	pigman_shopkeep = {"'TIS HARD WORK", "I SMASH-ETH", "I SMASH THEE"},
	pigman_storeowner = {"SMASH-ETH! SMASH-ETH", "DOTH HARD WORK!", "HAVE AT THEE TREE!"},
	pigman_farmer = {"THIS TREE DOTH CHOP'T", "I TOIL", "CHOP'T CHOP'T!"},
	pigman_miner = {"YON TREE IS'T CHOP'T", "'TIS EASIER THAN MINING", "YON TREE IS'T DONE FOR!"},
	pigman_collector = {"'TIS HARD WORK", "WHAT A PIECE OF WORK IS CHOPPING",},
	pigman_banker = {"MINE HOOVES GET-ETH DIRTY", "FALL, TREE!",},
	pigman_florist = {"CHOP'T, CHOP'T", "SMASHINGS!", "TOIL, TOIL"},
	pigman_erudite = {"I HELP-ETH", "FALL, TREE!", "I AXE THEE!"},
	pigman_hatmaker = {"YON TREE SHALL FALL!", "THUS FALL-ETH THY TREE",},
	pigman_professor = {"WITH MINE LAST BREATH I CHOP AT THEE!", "CHOP'T CHOP'T", "HAVE AT THEE TREE"},
	pigman_hunter = {"THUS FALL THE TREE", "I BID THEE FALL!", "I WIN!"},
}

STRINGS.CITY_PIG_TALK_ATTEMPT_TRADE = {
	DEFAULT = {"WHAT HAS'T THEE, UNPIG?", "NEED'ST THEE WARES?"},
	pigman_beautician = {"THEE HAS'T FEATHERS?", "THEE HAS'T BIRDY FEATHERS?", "HAS'T THEE PRETTY FEATHERS?"},
	pigman_mechanic = {"THINE NEED'ST REPAIRS?", "BRING FORTH YON REPAIRS", "THEE HAS'T REFINED GOODS?"},
	pigman_mayor = {"NEED'ST THOU A HOME?", "DEEDS BE IN YON CITY HALL", "THY WANT'ST HOME IN HAMLET?"},
	pigman_shopkeep = {"GET THEE TO SOME SHRUBBERY!", "HAS'T THEE CLIPPINGS?", "HAS'T THEE SHRUB STUFFS?"},
	pigman_storeowner = {"GET THEE TO SOME SHRUBBERY!", "HAS'T THEE CLIPPINGS?", "HAS'T THEE SHRUB STUFFS?"},
	pigman_farmer = {"HAS'T THOU GRASS?", "SELL'ST ME THINE GRASS PARTS", "ME WANT'ST GRASS STUFFS"},
	pigman_miner = {"HAS'T THOU A ROCK?", "ME PAY'ST FOR ROCKS", "I GIVETH OINC FOR THY ROCK"},
	pigman_collector = {"HAS'T THOU STRANGE THINGS?", "I BUYEST THING O' STRANGENESS", "SELLEST ME THINE WANT WEIRD STUFF?"},
	pigman_banker = {"HAST THOU JEWELS?", "I WILL'ST BUYEST JEWELS FROM THEE", "I PAYST OINCS FOR JEWELS"},
	pigman_florist = {"HAS'T THOU PLOP?", "PETALS FOR MINE SHOP?", "ME LIKE'ST PRETTY FLOWER", "ME LIKE'ST SMELLY PLOP"},
	pigman_erudite = {"HAS'T THOU DARK MAGICS?", "HAS'T THOU FUEL O' NIGHTMARE?", "SELL'ST ME THY DARK MAGICS STUFFS"},
	pigman_hatmaker = {"HAST THOU SILK?", "I NEED'TH SILK", "SELLEST ME THINE SILK"},
	pigman_professor = {"RELICS?", "HAS'T THOU RELICS?", "PAY'ST THOU OINCS FOR RELICS"},
	pigman_hunter = {"HAS'T THOU HOUNDS TOOTH?", "SELLETH THEE HOUNDS TOOTH?", "I BUY'ST TOOTH O' THE HOUNDS"},                               
}

STRINGS.CITY_PIG_TALK_PANIC = {
	DEFAULT = {"O HORRIBLE", "AAAAAAAAAH!!", "AVAST!", "NO LIKETH", "HURLEYBURLY!"},
	pigman_beautician = {"EVIL 'TIS AFOOT", "SOMETHING WICKED THIS WAY COMES!", "O HORRORS"},
	pigman_mechanic = {"ADIEU!", "I AM TOO MUCH IN THE FEAR", "MOST FOUL! MOST FOUL!"},
	pigman_mayor = {"MOST HORRIBLE", "O' CURSED SPITE", "THIS BE MADNESS"},
	pigman_royalguard = {"ONCE MORE INTO THE BREACH!", "GUARDS PROTECT THEE!", "AVAST! AVAIL!"},
	pigman_royalguard_2 = {"ONCE MORE INTO THE BREACH!", "GUARDS PROTECT THEE!", "AVAST! AVAIL!"},
	pigman_shopkeep = {"O HORROR! O HORROR! O HORROR!", "O SLINGS AND ARROWS!", "O OUTRAGEOUS FORTUNE!"},
	pigman_storeowner = {"HEIGH, MY HEARTS!", "A PLAGUE UPON IT!", "ALL LOST!"},
	pigman_farmer = {"ALL IS'T LOST!", "ADIEU! ADIEU!", "I EXEUNT!"},
	pigman_miner = {"I GET ME GONE!", "O, WOE THE DAY!", "'TIS THE END!"},
	pigman_collector = {"BAD THINGS ARE NIGH!", "ME PROTEST SO MUCH!", "I WANT'ST NOT TO DIE!"},
	pigman_banker = {"O MONSTROUS!", "O STRANGE!", "HELP'TH ME!"},
	pigman_florist = {"OUT! OUT!", "TAKE ARMS!", "SOMETHING WICKED THIS WAY COMES!"}, 
	pigman_erudite = {"O CURSE'D SPITE!", "GO AWAY'TH!", "MOST UNKIND!"},
	pigman_hatmaker = {"OUT! OUT!", "SAVETH ME!", "MOST HORRIBLE! MOST STRANGE!"},
	pigman_professor = {"CRY YOU MERCY!", "MOST HORRIBLE! MOST STRANGE!", "IT COMETH FOR US!"},
	pigman_hunter = {"SOUND AND FURY!", "HOWL, HOWL, HOWL, HOWL!", "ALL IS'T LOST!"},
}

STRINGS.CITY_PIG_TALK_PANICFIRE = {
	DEFAULT = {"IT BURN-ETH!", "FIRE BURN AND PIGGY BUBBLES", "FIGHT FIRE WITH WATER!", "SOMETHING FIREY THIS WAY COMES!", "FIRE FIRE FIRE"},
}

STRINGS.CITY_PIG_TALK_FIND_MEAT = {
	DEFAULT = {"IS'T MEAT!", "'TIS MEAT I SEE BEFORE ME?!", "I EAT'TH!", "FOOD TIME IS NIGH!"},
	pigman_beautician = {"MEAT BE THE FOOD OF LOVE", "I HATH STOMACH FOR IT", "VERILY I EAT",},
	pigman_mechanic = {"THIS MEAT I SEE BEFORE ME?", "WELL SERVED", "SOMETHING YUMMY THIS WAY COMES"},
	pigman_mayor = {"'TIS A DISH FIT FOR PIGS", "GIVE'ST MAYOR MINE DUE"},
	pigman_royalguard = {"EAT OR NOT TO EAT, THERE BE NO QUESTION", "MEATS FOR'ST PIGGY"},
	pigman_royalguard_2 = {"TO MINE OWN BELLY BE TRUE!", "'TIS MEAT! 'TIS FOOD!", "HUZZA!"},
	pigman_shopkeep = {"TO MINE OWN BELLY BE TRUE", "ALLS WELL THAT ENDS IN BELLY",},
	pigman_storeowner = {"'TIS EATS!", "I EATS!", "SOMETHING YUMMY THIS WAY COMES"},
	pigman_farmer = {"MMMM...MEAT MOST FOUL!", "FOR MINE FAT PAUNCH!", "BELLY BURN, AND MEAT BUBBLE"},
	pigman_miner = {"MEAT BE THE SOUL OF FOOD", "WOULD IT WERE IN MY BELLY", "MARRY THOUGH I LOVETH FOODS!"},
	pigman_collector = {"'TIS SLOP! 'TIS FOOD!", "WHENCE COME THIS FOOD?", "PRITHEE, LET ME EAT!"},
	pigman_banker = {"THE FOOD'S THE THING", "ZOUNDS, FOR MINE FAT PAUNCH!", "WHENCE COMES THIS FOOD?!"},
	pigman_florist = {"MARRY, 'TIS MEAT!", "ALACK THE DAY,'TIS MEAT!"},
	pigman_erudite = {"AY, THERE'S THE GRUB!", "INTO THE BOWELS OF MY BELLY", "MEAT GOETH IN MINE BELLY!"},
	pigman_hatmaker = {"MINE BELLY NOT PROTEST TOO MUCH", "SIRRAH! MY FOOD!", "NOT SALAD DAYS!"},
	pigman_professor = {"MMM... MEAT THRUST UPON ME", "WHYFORE ART THERE GROUND MEAT?"},
	pigman_hunter = {"A POUND OF FLESH!", "'TIS GOOD, 'TIS GOOD INDEED!", "MUCH ADO ABOUT MEAT!"},
}

STRINGS.CITY_PIG_TALK_FIND_MONEY = {    
	DEFAULT = {"'TIS SHINY THING!", "ALL THAT GLITTERS IS GOLD!", "YEA, THO I HAST SHINY THING!", "I GO FORTH AND BUY'ST THINGS"},
	pigman_beautician = {"OINC HAST PRETTYNESS!", "'TIS PRETTIES", "OINC HATH WORTH"},
	pigman_mechanic = {"LIKEST OINCS!", "PUT'ST OINC IN MINE POCKET", "CAN'ST ME BUY'ST STUFFS"},
	pigman_mayor = {"MINE-ETH!", "IS'T BUY'ST VOTES", "GIVE MAYOR MINE DUE"},
	pigman_royalguard = {"OUTRAGEOUS FORTUNE!", "ME KEEP'TH", "PUT MONEY IN MINE PURSE!"},
	pigman_royalguard_2 = {"MINE OINC BE TRUE!", "FORTUNE SMILE 'PON ME"},
	pigman_shopkeep = {"IT SUFFICETH", "ME TAKETH!", "SOMETHING SHINY THIS WAY COMES"},
	pigman_storeowner = {"MARRY!", "ME LIKETH", "WILL SCREW THIS TO STICKING-PLACE", "ME TAKE'ST!"},
	pigman_farmer = {"MOST EXCELLENT FANCY", "'TIS FOR HONEST DAYS WORK", "WHATFORE ART THIS?"},
	pigman_miner = {"MINE'ST!", "A POUND OF OINC", "'TIS MINE"},
	pigman_collector = {"YEA, THO I HAST SHINY THING!", "MINE OWN PURSE BE TRUE",},
	pigman_banker = {"A POUND OF OINC!", "MARRY, 'TIS COIN!", "'TIS LOST OINC FOR MINE PURSE"},
	pigman_florist = {"HATH LOVELINESS", "'TIS PRETTY!", "ALL THAT GLITTERS IS GOLD"},
	pigman_erudite = {"CATCHETH MINE EYE", "HAST VALUE", "'TIS SHININESS"},
	pigman_hatmaker = {"ME LIKETH!", "PUT MONEY IN MINE PURSE", "WHATFORE ART THIS?"},
	pigman_professor = {"OUTRAGEOUS FORTUNE!", "WANT MONEYS", "CATCHETH MINE EYE"},
	pigman_hunter = {"'TIS MINE!", "FORTUNE SMILE 'PON ME!"},
}

STRINGS.CITY_PIG_TALK_FORGIVE_PLAYER = {    
	DEFAULT = {"I SHOW QUALITY OF MERCY", "ALL IS'T FORGIVEN", "HEARTILY I FORGIVEST THEE", "A POUND OF OINCS HATH SUFFICETH"},
}

STRINGS.CITY_PIG_TALK_NOT_ENOUGH = {
	DEFAULT = {"I WANT-ETH MORE", "DOTH NOT SUFFICETH", "I REQUIRETH MORE", "NEEDETH MORE"}, -- NEW
}

STRINGS.CITY_PIG_TALK_EAT_MEAT = {
	DEFAULT = {"NOM-ETH NOM-ETH, NOM-ETH", "O FOOD! O SLOP!", "MUNCH'D, AND MUNCH'D, AND MUNCH'D"},
}

STRINGS.CITY_PIG_TALK_GO_HOME = {
	DEFAULT = {"ANON! ADIEU!", "I GET ME TO BED!"},
	pigman_beautician = {"MOST HUMBLY I LEAVES", "I SLEEP", "PERCHANCE I DREAMS"},
	pigman_mechanic = {"FARES'T THEE WELL", "MY KINGDOM FOR SOME JAMMIES", "GOOD EVENTIME"},
	pigman_mayor = {"FAIR ME WELL", "I MAKE ME BEDFELLOWS", "MY DREAMS MAY COME"},
	pigman_shopkeep = {"GET ME TO A BEDDY-BYES", "I GO MY CHAMBERS", "NIGHTY NIGHTS, SWEET UNPIGS"},
	pigman_storeowner = {"I SEE WHAT DREAMS MAY COME", "ADIEU ADIEU", "REMEMBER ME"},
	pigman_farmer = {"UNPIG, GOOD NIGHT", "PARTING SUCH SWEET SORROW", "TIL IT BE MORROW"},
	pigman_miner = {"TIL TOMORROW AND TOMORROW AND TOMORROW", "I SLUMBER'DING", "TO SLEEP OR NOT TO SLEEP?"},
	pigman_collector = {"GOOD NIGHT UNTO YOU ALL", "SWEET GOOD NIGHT!", "I BID ADIEU TO YOUS"},
	pigman_banker = {"ADIEU, UNPIG", "FARE THEE WELL", "GOOD PIGS, LET'S RETIRE"},
	pigman_florist = {"GENTLE NIGHTY-NIGHTS", "ONCE MORE UNTO MY JAMMIES", "ANON, GOOD NIGHT"},
	pigman_erudite = {"NOW IS NIGHTTIMES OF OUR DISCONTENT", "I BID ADIEUS", "UNTIL THE MORROW"},
	pigman_hatmaker = {"WHEREFORE ART MY JAMMIES?", "ALAS, I DEPART", "I BID THEE NIGHTY NIGHTS"},
	pigman_professor = {"LIGHT THROUGH MY WINDOW BREAKS", "TIS WITCHING TIME OF NIGHT", "I TAKING MY LEAVE"},
	pigman_hunter = {"ME DREAM A DREAM TONIGHT", "MY TOO TIRED FLESH GOES SLEEPIES", "SEE YOU ON THE MORROW"},
}

STRINGS.CITY_PIG_TALK_FIX = {
	DEFAULT = {"ALL FIX'D!", "I DO'ST GOOD FIXINGS!"},
	pigman_beautician = {"I FIXETH NOT", "GET THEE TO A MECHANIC"},
	pigman_mechanic = {"I MAKETH NICE NICE", "BUILD, BUILD", "I USETH MINE HAMMER GOOD"},
	pigman_mayor = {"MAYOR SHALL NOT FIXETH","I FIXETH NOT", "GET THEE TO A MECHANIC"},                                    
}

STRINGS.CITY_PIG_GUARD_TALK_TORCH = {
	DEFAULT = {"BURN BRIGHT THE TORCHES!", "LIGHT THE TORCHES!", "BURN, TORCHES, CLEAR AND BRIGHT!"},
}
STRINGS.CITY_PIG_GUARD_TALK_FIGHT = {
	DEFAULT = {"I STAB AT THEE!", "HAVE AT THEE!", "AWAY, CUR! AWAY!"},
}
STRINGS.CITY_PIG_GUARD_TALK_GOHOME = {
	DEFAULT = {"STAND HO!", "WHOFORE IS THAT?", "WHATFORE THAT?", "WHAT HO!"},
}

CITY_PIG_TALK_REFUSE_PRICELESS_GIFT	= {
	DEFAULT = {"NO 'TIS PRICELESS!", "IT IS FOUND! MUST FIND QUEEN", "I CANNOT TAKE, BELONG TO ROYALTY"},
}						
														
STRINGS.CITY_PIG_GUARD_TALK_LOOKATWILSON = {
	DEFAULT = {"MAKE NOT TROUBLES", "WHOFORE GO'ST THERE?", "TRESPASS NOT!",},
}

STRINGS.CITY_PIG_GUARD_LIGHT_TORCH = {
	DEFAULT = {"ME LIGHT A FIERY TORCH", "TORCHES, TORCHES!", "CURFEW'S RUNGETH"},
}

STRINGS.CITY_PIG_TALK_REFUSE_GIFT = {
	DEFAULT = {"NO THANKS!"},                                   
}

STRINGS.CITY_PIG_TALK_REFUSE_GIFT_DELAY = {
	DEFAULT = {"NO THANKS!"},                                   
} 
                             
STRINGS.CITY_PIG_TALK_REFUSE_GIFT_DELAY_TOMORROW = {
	DEFAULT = {"COME'ST BACK ON THE MORROW"},                                   
}  
                                                              
STRINGS.CITY_PIG_TALK_RELIC_GIFT = {
	DEFAULT = {"TAKEST TO YON MUSEUM", "THE STY BE THE PLACE FOR IT"},
}

STRINGS.CITY_PIG_TALK_TAKE_GIFT = {
	DEFAULT = {"MANY THANKS"},                                   
}
STRINGS.CITY_PIG_TALK_GIVE_REWARD = {
	DEFAULT = {"A WORTHY JOB. TAKE THEE REWARD", "'TIS NOBLE JOB THEE DO", "A FINE JOB"},                                   
}

STRINGS.CITY_PIG_TALK_GIVE_TRINKET_REWARD = {
	DEFAULT = {"OH, HOW LOVELY! TAKE THIS GIFT"},                                   
}   
  
STRINGS.CITY_PIG_TALK_REFUSE_TRINKET_GIFT = {
	DEFAULT = {"NO MORE JUNK, THANK YOU"},                                   
}   
                        
STRINGS.CITY_PIG_TALK_GIVE_RELIC_REWARD = {
	DEFAULT = {"MOST EXCELLENT!", "IS'T TREASURE!", "FROM YON OLDEN TIMES!"},                                   
}   
                             
STRINGS.CITY_PIG_GUARD_TALK_ANGRY_PLAYER = {
	DEFAULT = {"HAS'T THEE RETURNED?!", "CUR! VILLAIN!", "OUT! FLEE!", "YOU A SEA OF TROUBLES!"},
}

STRINGS.CITY_PIG_TALK_ATTEMPT_TRADE = {
	DEFAULT = {"WHAT HATH THEE?", "THY WANTS'T TRADES?", "MAKE'ST THEE DEALS?"},
}

STRINGS.CITY_PIG_SHOPKEEPER_NOT_ENOUGH = {"THY LACKETH THE OINCS", "GET THEE MORE OINCS"}
STRINGS.CITY_PIG_SHOPKEEPER_DONT_HAVE = {"BRINGETH THEE ITEM", "THOU NEED'ST ITEM", "OINCS NOT SUFFICETH, ONLY ITEM"}
STRINGS.CITY_PIG_SHOPKEEPER_SALE = {"MY THANKS", "A FINE EXCHANGE", "MANY THANKS", "THOU GOOD UNPIG",}
STRINGS.CITY_PIG_SHOPKEEPER_ROBBED = {"WHOFORE HAST DONE THIS?!", "ROBBED! ROBBED! ROBBED!", "OH THE PIGANITY!", "REVENGE!",}
    
STRINGS.CITY_PIG_SHOPKEEPER_GREETING = {
	DEFAULT = {"WHAT SAY YOU, UNPIG?","THOU LOOK'ST FOR THINGS?","I HATH THEE WARES","BUY'ST THOU STUFFS TODAY?"},
	pigman_mayor_shopkeep = {"NEED'ST THOU A HOUSE?", "NEED'ST GUARD?", "WANT'ST THOU TO DWELL'ETH HERE?",},
	pigman_beautician = {"LOOKETH AT MINE MEDICINES", "THOU NEED'ST MEDICINES?", "NEED'ST THINGS FOR BOO-BOOS?"},
	pigman_mechanic = {"HAS'T THOU THINGS TO FIX?", "I FIXETH", "I FIXETH BROKEN THING", "YOU NEEDETH FIXINGS?"},
	pigman_miner = {"SELLETH ROCKS?", "I LIKETH ROCKS", "SELLEST ME THINE ROCKS",},
	pigman_collector = {"HAST THOU STRANGE THINGS?", "I DEALETH WITH THINGS O' STRANGENESS", "WANTS THOU STRANGE THINGS?"},
	pigman_banker = {"HAST THOU JEWELS?", "ME GIVETH OINCS FOR JEWELS", "ME LIKETH SPARKLY JEWELS"},
	pigman_florist = {"THOU NEEDS OF SEEDS?", "NEEDETH STUFFS FOR PLANTINGS?", "HAST THOU PLOP?", "HAST THOU PETALS?"},
	pigman_erudite = {"NEEDETH MAGIC THINGS?", "I SELL MAGIC THINGS?", "I SELLEST THINGS BAD DREAMS ARE MADE ON"},
	pigman_hatmaker = {"HATS? NEED'ST THOU HATS?", "NEEDST THING TO COVER THINE HEAD?", "BUY'ST THY HATS FROM ME"},
	pigman_professor = {"IN NEED'ST OF OLD THINGS?", "I LIKETH RELICS FROM YON TEMPLES", "NEED'ST THOU RELICS?",},
	pigman_hunter = {"IN NEED O' WEAPONS", "I SELL'ST SMASHY THINGS", "NEEDST THOU MURDERING THINGS?"},
}

STRINGS.CITY_PIG_SHOPKEEPER_CLOSING = {"IS'T THE TIME O' CLOSINGS","COME BACK ON THE 'MORROW","ME CLOSETH SHOP", "ADIEU, ADIEU, REMEMBER ME", "ME EXEUNT"}

STRINGS.NAMES.KYNO_PIGMAN_FLORIST = "Pig Florist"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_FLORIST = "Let's see if we can come to an arrangement."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_FLORIST = "She sells something I can burn."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_FLORIST = "Little pig is run flower shop."
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_FLORIST = "A rose's beauty is but temporary comfort."
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_FLORIST = "SELLER OF SMELLY HALTED LIFEFORMS"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_FLORIST = "She is the curator of the flower shop."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_FLORIST = "She has a fine appreciation for nature."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_FLORIST = "She tends to the flowers."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_FLORIST = "She maketh trade in Freya's things."
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_FLORIST = "Your flowers are so pretty!"
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_FLORIST = "I always wanted to grow flowers."
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_FLORIST = "I like that hat."
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_FLORIST = "Have Dirt Things?"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_FLORIST = "Let's make arrangements."
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_FLORIST = "Glurgh... Florist pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_FLORIST = "She takes care of the flowers."
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_FLORIST = "It takes time to grow a beautiful flower."

STRINGS.NAMES.KYNO_PIGMAN_ERUDITE = "Pig Erudite"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_ERUDITE = "What items of esoteria have you to sell?"
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_ERUDITE = "Any of this magic stuff burn things?"
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_ERUDITE = "You have magic stuff?"
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_ERUDITE = "No magic of yours will ease my sorrow."
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_ERUDITE = "SELLER OF NONLOGICAL MAGIC INSTRUMENTS"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_ERUDITE = "What cobalistic wares have you today?"
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_ERUDITE = "What do-hickeys you got to sell today?"
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_ERUDITE = "A gal after my own heart."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_ERUDITE = "Thoust deal in the black arts."
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_ERUDITE = "Wow! Can you show me any tricks?"
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_ERUDITE = "You sell magic stuff, right?"
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_ERUDITE = "Speak less than she knows."
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_ERUDITE = "Odd Twirly Tail"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_ERUDITE = "A few magical items might spice up a meal."
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_ERUDITE = "Glurgh... Magician pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_ERUDITE = "A purveyor of fine esoteric interests."
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_ERUDITE = "I don't need that kind of stuff."

STRINGS.NAMES.KYNO_PIGMAN_HATMAKER = "Pig Hatmaker"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_HATMAKER = "Hats off to you, hatmaker."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_HATMAKER = "That hat is ugly."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_HATMAKER = "You have hat worthy of Wolfgang head?"
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_HATMAKER = "Do you have any mourning veils?"
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_HATMAKER = "SELLER OF APPS FOR HEAD UNITS"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_HATMAKER = "Well, I certainly wouldn't have chosen that hat."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_HATMAKER = "You got any toques?"
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_HATMAKER = "I'm looking for something subtle, yet stylish."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_HATMAKER = "I prefer horned helms upon mine skull."
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_HATMAKER = "We like your hat!"
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_HATMAKER = "Cool hats!"
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_HATMAKER = "Do you get any hats for imps?"
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_HATMAKER = "Have Head Stuff?"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_HATMAKER = "What a fine hat you have!"
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_HATMAKER = "Glurgh... Hatmaker pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_HATMAKER = "That hat is a little strange."
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_HATMAKER = "Nice head accessory!"

STRINGS.NAMES.KYNO_PIGMAN_STOREOWNER = "Pig Shopkeep"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "Good day, shopkeep."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "I bet their life is super boring."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "Wolfgang is here to see wares!"
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "A life filled with endless mediocre service."
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "SELLER OF TANGIBLE GOODS"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "I had better dust off my bartering skills."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "Looks like the shopkeep."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "That's the shopkeep."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "Shopkeep, prepare to barter!"
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "Anything good for sale today?"
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "Anything good today?"
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "She sells things."
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "Likes Friend Hair"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "Greetings!"
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "Glurgh... Shopkeep pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "Someone who appreciates her town's landscaping."
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_STOREOWNER = "I got some time for trading."

STRINGS.NAMES.KYNO_PIGMAN_BANKER = "Pig Banker"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_BANKER = "The money man."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_BANKER = "Huh. Doesn't even manage money."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_BANKER = "Is like Wolfgang's piggie bank!"
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_BANKER = "Earthly wealth has no use in death."
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_BANKER = "PURVEYOR OF MONEY"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_BANKER = "He looks to be in charge of finances."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_BANKER = "I don't have any money."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_BANKER = "A distiguinshed fellow. Relatively speaking."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_BANKER = "Another beast of the coin!"
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_BANKER = "I like pigs when they don't try to attack us."
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_BANKER = "But can money buy you naps, banker man?"
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_BANKER = "He likes the money."
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_BANKER = "Likes Buying Stuff"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_BANKER = "I was never one for investiment."
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_BANKER = "Glurgh... Banker pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_BANKER = "He likes the shiny things."
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_BANKER = "Time is money!"

STRINGS.NAMES.KYNO_PIGMAN_COLLECTOR = "Pig Collector"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "Impress me."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "You look boring. What are you selling today?"
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "Is sell weird stuff."
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "Your curiosities are nothing compared to my Abigail."
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "PROVIDES WARES WHICH IGNORE ORDERLY CLASSIFICATION"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "I see you collect curiosities."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "What'cha got in here?"
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "You do have some interesting objects in here."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "Thost wonders are nought compared to Valhalla!"
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "Hi friend!"
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "Whoa, you got some cool stuff in here."
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "Full of treasures!"
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "Have Odd Stuff?"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "Do you have any rare delicacies for sale?"
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "Glurgh... Collector pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "Someone who appreciates the junk I find on my adventures."
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_COLLECTOR = "I've collected things when I was young."

STRINGS.NAMES.KYNO_PIGMAN_HUNTER = "Pig Hunter"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_HUNTER = "Do you have killing implements available here?"
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_HUNTER = "Fire is the best weapon."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_HUNTER = "Weapons make Wolfgang mightier."
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_HUNTER = "I see you have dedicated your life to destructive paraphernalia."
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_HUNTER = "SELLER OF KILLING MECHANISMS"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_HUNTER = "I suppose you enjoy killing things."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_HUNTER = "Don't try to sell me no axes. I ain't interested."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_HUNTER = "I would like to persue your deadliest weapons, please."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_HUNTER = "Ah! A pig after mine own heart!"
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_HUNTER = "There's a lot of weapons with him."
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_HUNTER = "Harsh. You got alot of weapons."
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_HUNTER = "I need a proper imp gear..."
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_HUNTER = "Wants Sharp Things"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_HUNTER = "I'm not a fan of your wares."
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_HUNTER = "Glurgh... Hunter pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_HUNTER = "Looks like someone who's been in a lot of fights."
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_HUNTER = "Fighting is a waste of time."

STRINGS.NAMES.KYNO_PIGMAN_MAYOR = "Mayor Truffleston"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_MAYOR = "I didn't vote for him."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_MAYOR = "Pigs have mayors?"
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_MAYOR = "Wolfgang think this important man."
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_MAYOR = "You busy yourself with trivial duties."
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_MAYOR = "REDUNDANT OCCUPANT OF A REDUNDANT PROTOCOL"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_MAYOR = "I should like to document a pig election."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_MAYOR = "Can't be all that much mayoring to do 'round here."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_MAYOR = "A man who understands the power of a tailored suit."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_MAYOR = "A chieftain in this pig clan."
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_MAYOR = "Hi Mr. Mayor!"
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_MAYOR = "I'm not much of an estabilishment girl."
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_MAYOR = "Too plump."
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_MAYOR = "Your Town?"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_MAYOR = "You know, you might benefit from a nice farmer's market here."
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_MAYOR = "Glurgh... It's the mayor of pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_MAYOR = "In all my adventures, I've never been able to escape bureaucracy."
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_MAYOR = "Ugh..."

STRINGS.NAMES.KYNO_PIGMAN_MECHANIC = "Pig Worker"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_MECHANIC = "Mr. Fix-it."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_MECHANIC = "He fixes machines."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_MECHANIC = "Little piggie fix things."
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_MECHANIC = "Can you mend my heart?"
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_MECHANIC = "A MECHANIC. THE NOBLEST PROFESSION"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_MECHANIC = "The community handyman, I believe."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_MECHANIC = "Never understood gizmos myself."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_MECHANIC = "That is no gentleman."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_MECHANIC = "A pig which repaireth many things."
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_MECHANIC = "He looks busy."
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_MECHANIC = "Hey, you any good at fixing portals?"
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_MECHANIC = "What snout eye he have."
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_MECHANIC = "Fix Things?"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_MECHANIC = "Not the fixings I'm used to, but handy nonetheles."
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_MECHANIC = "Glurgh... Worker pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_MECHANIC = "Swell. He can fix a house but not a portal."
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_MECHANIC = "It seems he's the fixer guy around here."

STRINGS.NAMES.KYNO_PIGMAN_PROFESSOR = "Pig Professor"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "How are you still alive?"
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "He knows a lot of old stuff."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "You have old stuff for Wolfgang?"
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "You'll be seeing Abigail soon."
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "OUTMODED SELLER OF OBSOLETE TECHNOLOGY"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "How refreshing to deal with a mature adult."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "Good day, sir."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "I better hurry this up, he looks like he could drop at any time."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "Do thoust have anything from the old country?"
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "Mom told me always to respect my elders."
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "Whoa, dude. You are old."
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "A grizzled one."
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "Wise Old Twirly Tail"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "You look like you've enjoyed many a fine meal."
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "Glurgh... Old pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "Professor?"
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_PROFESSOR = "Looks like his time is coming to an end."

STRINGS.NAMES.KYNO_PIGMAN_BEAUTICIAN = "Pig Beautician"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "What a beauty..."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "What a piece of work!"
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "Little pig make Wolfgang moustache nice?"
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "I care nothing for outer beauty."
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "PROVIDES NONFUNCTIONAL BEAUTIFICATION SERVICES"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "I have no interest in beauty products at my age."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "Go ahead, Lucy. Treat yourself."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "Such stunning beauty."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "Shieldmaidens have no use for thee."
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "You look nice today!"
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "You look great, ma'am!"
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "You look beautiful!"
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "Boo Boo Twirly Tail"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "Makeup is like garnish for the face."
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "Glurgh... fancy pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "A lady who likes her feathers."
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_BEAUTICIAN = "It takes time to make a good makeup."

STRINGS.NAMES.KYNO_PIGMAN_USHER = "Pig Usher"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_USHER = "Likes the sweet stuff."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_USHER = "How do you see through those glasses?"
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_USHER = "Hello, old piggie."
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_USHER = "Not long for this world."
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_USHER = "REQUIRES THE GOODS OF HIGH FRUCTOSE"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_USHER = "You may have all my sweets. I don't care for them."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_USHER = "What a sweet old pig."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_USHER = "A saccharine pig who likes his sweets."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_USHER = "Many his quests for sweet foods be fruitful."
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_USHER = "Hello sir. Nice to meet you."
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_USHER = "Looks like he could use a nap."
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_USHER = "He likes candies. Hyuyu!"
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_USHER = "Good Day, Twirly Tail"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_USHER = "Ah! Someone to appreciate my baking."
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_USHER = "Glurgh... Pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_USHER = "You seen to like candies, want some?"
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_USHER = "Looks like his time is coming to an end."

STRINGS.NAMES.KYNO_PIGMAN_FARMER = "Pig Farmer"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_FARMER = "I hope he doesn't farm pigs."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_FARMER = "I didn't know pigs did farm work."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_FARMER = "Pig is good little farmer."
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_FARMER = "A simple life for a simple creature."
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_FARMER = "DEALS IN FILTHY ORGANIC MATERIAL"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_FARMER = "A farm toiling pig."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_FARMER = "Someone's gotta do the farming."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_FARMER = "He smells of farming and hard labor."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_FARMER = "Yon time be better spent on the fruits of the hunt, pig!"
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_FARMER = "I hope the crops are doing well."
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_FARMER = "How are you?"
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_FARMER = "A fine farmer!"
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_FARMER = "Like Grass Friends"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_FARMER = "Doing good work, mom amie."
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_FARMER = "Glurgh... Farmer pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_FARMER = "A simple pig with simple desires."
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_FARMER = "Farming takes time."

STRINGS.NAMES.KYNO_PIGMAN_MINER = "Pig Miner"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_MINER = "How industrious."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_MINER = "Looks like a miner."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_MINER = "Wolfgang likes your mustache!"
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_MINER = "Do you dig your own tomb, sir?"
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_MINER = "CLOVEN-HOOVED FLESHLING THAT TOILS IN THE MINES"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_MINER = "These pigs extract resources from the earth."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_MINER = "A respectable profession."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_MINER = "He is absolutely covered in soot."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_MINER = "A beast which doth do Dwarfish labor."
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_MINER = "Hard day in the mines, mister?"
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_MINER = "You work hard too?"
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_MINER = "A landlubber!"
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_MINER = "Likes Rocks"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_MINER = "Be safe, mon amie."
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_MINER = "Glurgh... Miner pigfolk..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_MINER = "You like rocks? Just plain old everyday rocks? Okay..." 
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_MINER = "It's a miner pig."

STRINGS.NAMES.KYNO_PIGMAN_QUEEN = "Queen Malfalfa"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KYNO_PIGMAN_QUEEN = "She looks bossy."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.KYNO_PIGMAN_QUEEN = "Hey there, your majesty."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.KYNO_PIGMAN_QUEEN = "Wolfgang should curtsy?"
STRINGS.CHARACTERS.WENDY.DESCRIBE.KYNO_PIGMAN_QUEEN = "A queen of empty life."
STRINGS.CHARACTERS.WX78.DESCRIBE.KYNO_PIGMAN_QUEEN = "I AM YOUR MONARCH NOW"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.KYNO_PIGMAN_QUEEN = "She is the monarch who rules over this society."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.KYNO_PIGMAN_QUEEN = "We separated from the crown ages ago."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.KYNO_PIGMAN_QUEEN = "She does not smell particularly royal."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.KYNO_PIGMAN_QUEEN = "O, great lady!"
STRINGS.CHARACTERS.WEBBER.DESCRIBE.KYNO_PIGMAN_QUEEN = "She looks majestic."
STRINGS.CHARACTERS.WINONA.DESCRIBE.KYNO_PIGMAN_QUEEN = "Good day, your highness!"
STRINGS.CHARACTERS.WORTOX.DESCRIBE.KYNO_PIGMAN_QUEEN = "She's the queen of pigs."
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.KYNO_PIGMAN_QUEEN = "Fancy Twirly Tail"
STRINGS.CHARACTERS.WARLY.DESCRIBE.KYNO_PIGMAN_QUEEN = "What feasts she must see."
STRINGS.CHARACTERS.WURT.DESCRIBE.KYNO_PIGMAN_QUEEN = "Glurgh... Pigfolk queen..."
STRINGS.CHARACTERS.WALTER.DESCRIBE.KYNO_PIGMAN_QUEEN = "Walter and Woby at your service, majesty!"
STRINGS.CHARACTERS.WANDA.DESCRIBE.KYNO_PIGMAN_QUEEN = "The royal family are gone long ago."