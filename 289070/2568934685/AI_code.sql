--***********************************************************
--AI++ = 
-- •Give computers better fighting ability ✅
-- •Make computers more personalized (drop weaker traits, strengthen stronger ones) ✅
--***********************************************************
--Lets start by making AI more agressive
UPDATE AiOperationDefs SET Priority=1 WHERE OperationName='Attack Enemy City' ; --AI is more likely to attack an unwalled city
UPDATE AiOperationDefs SET Priority=1 WHERE OperationName='Attack Walled City' ; --AI is more likely to attack an walled and better defended city

UPDATE AiOperationDefs SET MinOddsOfSuccess=0.1 WHERE OperationName='Attack Enemy City' ; --AI does not need a 100% victory chance to go to war
UPDATE AiOperationDefs SET MinOddsOfSuccess=0.2 WHERE OperationName='Attack Walled City' ;

UPDATE AiOperationDefs SET Priority=1 WHERE OperationName='Wartime Attack Enemy City' ;
UPDATE AiOperationDefs SET Priority=1 WHERE OperationName='Wartime Attack Walled City' ;

UPDATE AiOperationDefs SET MinOddsOfSuccess=0.1 WHERE OperationName='Wartime Attack Enemy City' ;
UPDATE AiOperationDefs SET MinOddsOfSuccess=0.2 WHERE OperationName='Wartime Attack Walled City' ;

UPDATE AiOperationDefs SET Priority=5 WHERE OperationName='Aid Ally' ; --Reducing all other less agressive traits
UPDATE AiOperationDefs SET Priority=3 WHERE OperationName='City Defense' ;
UPDATE AiOperationDefs SET Priority=3 WHERE OperationName='Civilian Builder Capture' ;
UPDATE AiOperationDefs SET Priority=2 WHERE OperationName='Naval Superiority' ;
UPDATE AiOperationDefs SET Priority=1 WHERE OperationName='Settle New City' ;

UPDATE AiOperationTeams SET InitialStrengthAdvantage=0.5 WHERE OperationName='Attack Enemy City' ; --Reducing the requirements for going to war
UPDATE AiOperationTeams SET OngoingStrengthAdvantage=1 WHERE OperationName='Attack Enemy City' ;
UPDATE AiOperationTeams SET InitialStrengthAdvantage=1 WHERE OperationName='Attack Walled City' ;
UPDATE AiOperationTeams SET OngoingStrengthAdvantage=2 WHERE OperationName='Attack Walled City' ;
UPDATE AiOperationTeams SET InitialStrengthAdvantage=0.5 WHERE OperationName='Wartime Attack Walled City' ;
UPDATE AiOperationTeams SET OngoingStrengthAdvantage=1 WHERE OperationName='Wartime Attack Walled City' ;
UPDATE AiOperationTeams SET InitialStrengthAdvantage=0 WHERE OperationName='Wartime Attack Enemy City' ;
UPDATE AiOperationTeams SET OngoingStrengthAdvantage=0.5 WHERE OperationName='Wartime Attack Enemy City' ;

UPDATE MajorStartingUnits SET Quantity=2 WHERE Era='ERA_ANCIENT' AND MinDifficulty='DIFFICULTY_EMPEROR' ;
UPDATE MajorStartingUnits SET Quantity=3 WHERE Era='ERA_CLASSICAL' AND MinDifficulty='DIFFICULTY_EMPEROR' ;
UPDATE MajorStartingUnits SET Quantity=4 WHERE Era='ERA_MEDIEVAL' AND MinDifficulty='DIFFICULTY_EMPEROR' ;
UPDATE MajorStartingUnits SET Quantity=5 WHERE Era='ERA_RENAISSANCE' AND MinDifficulty='DIFFICULTY_EMPEROR' ;
UPDATE MajorStartingUnits SET Quantity=6 WHERE Era='ERA_INDUSTRIAL' AND MinDifficulty='DIFFICULTY_EMPEROR' ;
UPDATE MajorStartingUnits SET Quantity=7 WHERE Era='ERA_MODERN' AND MinDifficulty='DIFFICULTY_EMPEROR' ;
UPDATE MajorStartingUnits SET Quantity=8 WHERE Era='ERA_ATOMIC' AND MinDifficulty='DIFFICULTY_EMPEROR' ;
UPDATE MajorStartingUnits SET Quantity=9 WHERE Era='ERA_INFORMATION' AND MinDifficulty='DIFFICULTY_EMPEROR' ;
UPDATE MajorStartingUnits SET Quantity=10 WHERE Era='ERA_FUTURE' AND MinDifficulty='DIFFICULTY_EMPEROR' ;

INSERT OR REPLACE INTO MajorStartingUnits
		(Unit, Era, District, Quantity, NotStartTile, OnDistrictCreated, AiOnly, MinDifficulty, DifficultyDelta)
VALUES	('UNIT_SETTLER', 'ERA_ANCIENT', 'DISTRICT_HOLY_SITE', 1, 0, 1, 1, 'DIFFICULTY_DEITY', 0.5),
		('UNIT_SETTLER', 'ERA_ANCIENT', 'DISTRICT_LAVRA', 1, 0, 1, 1, 'DIFFICULTY_DEITY', 0.5),
		('UNIT_SETTLER', 'ERA_ANCIENT', 'DISTRICT_CAMPUS', 1, 0, 1, 1, 'DIFFICULTY_IMMORTAL', 0.5),
--		('UNIT_SETTLER', 'ERA_ANCIENT', 'DISTRICT_OBSERVATORY', 1, 0, 1, 1, 'DIFFICULTY_IMMORTAL', 0.5),
		('UNIT_SETTLER', 'ERA_ANCIENT', 'DISTRICT_SEOWON', 1, 0, 1, 1, 'DIFFICULTY_IMMORTAL', 0.5),
		('UNIT_SETTLER', 'ERA_ANCIENT', 'DISTRICT_THEATER', 1, 0, 1, 1, 'DIFFICULTY_EMPEROR', 0.5),
		('UNIT_SETTLER', 'ERA_ANCIENT', 'DISTRICT_ACROPOLIS', 1, 0, 1, 1, 'DIFFICULTY_EMPEROR', 0.5),
		('UNIT_SETTLER', 'ERA_ANCIENT', 'DISTRICT_ENTERTAINMENT_COMPLEX', 1, 0, 1, 1, 'DIFFICULTY_KING', 0.5),
--		('UNIT_SETTLER', 'ERA_ANCIENT', 'DISTRICT_HIPPODROME', 1, 0, 1, 1, 'DIFFICULTY_KING', 0.5),
		('UNIT_SETTLER', 'ERA_ANCIENT', 'DISTRICT_STREET_CARNIVAL', 1, 0, 1, 1, 'DIFFICULTY_KING', 0.5),
		('UNIT_SETTLER', 'ERA_ANCIENT', 'DISTRICT_ENCAMPMENT', 1, 0, 1, 1, 'DIFFICULTY_PRINCE', 0.5);
--		('UNIT_SETTLER', 'ERA_ANCIENT', 'DISTRICT_THANH', 1, 0, 1, 1, 'DIFFICULTY_PRINCE', 0.5),

--Code for Traits:

INSERT OR REPLACE INTO AgendaTraits
		(AgendaType, TraitType) 
VALUES	('AGENDA_ALLY_OF_ENKIDU', 'TRAIT_AGENDA_ENJOYS_WAR'),
		('AGENDA_BIG_STICK_POLICY', 'TRAIT_AGENDA_PREFER_STANDING_ARMY'),
		('AGENDA_IRON_CROWN', 'TRAIT_AGENDA_PREFER_STANDING_ARMY'),
		('AGENDA_IRON_CROWN', 'TRAIT_AGENDA_PREFER_INDUSTRY'),
		('AGENDA_OPTIMUS_PRINCEPS', 'TRAIT_AGENDA_PREFER_INCOME'),
		('AGENDA_OPTIMUS_PRINCEPS', 'TRAIT_AGENDA_WITH_SHIELD'),
		('AGENDA_TLATOANI', 'TRAIT_AGENDA_PREFER_STANDING_ARMY'),
		('AGENDA_LAST_VIKING_KING', 'TRAIT_AGENDA_GREAT_WHITE_FLEET'),
		
		('AGENDA_SHORT_LIFE_GLORY', 'TRAIT_AGENDA_PREFER_STANDING_ARMY'),
		('AGENDA_SHORT_LIFE_GLORY', 'TRAIT_AGENDA_ENJOYS_WAR'),
--		Militaristic Ignore Favor:		
		('AGENDA_ALLY_OF_ENKIDU', 'TRAIT_AGENDA_PREFER_NOFAVOR'),
		('AGENDA_BIG_STICK_POLICY', 'TRAIT_AGENDA_PREFER_NOFAVOR'),
		('AGENDA_IRON_CROWN', 'TRAIT_AGENDA_PREFER_NOFAVOR'),
		('AGENDA_OPTIMUS_PRINCEPS', 'TRAIT_AGENDA_PREFER_NOFAVOR'),
		('AGENDA_TLATOANI', 'TRAIT_AGENDA_PREFER_NOFAVOR'),
		('AGENDA_LAST_VIKING_KING', 'TRAIT_AGENDA_PREFER_NOFAVOR'),
		('AGENDA_SHORT_LIFE_GLORY', 'TRAIT_AGENDA_PREFER_NOFAVOR'),
--		Militaristic Ignore Tourism:		
		('AGENDA_ALLY_OF_ENKIDU', 'TRAIT_AGENDA_PREFER_NOTOURISM'),
		('AGENDA_BIG_STICK_POLICY', 'TRAIT_AGENDA_PREFER_NOTOURISM'),
		('AGENDA_IRON_CROWN', 'TRAIT_AGENDA_PREFER_NOTOURISM'),
		('AGENDA_OPTIMUS_PRINCEPS', 'TRAIT_AGENDA_PREFER_NOTOURISM'),
		('AGENDA_TLATOANI', 'TRAIT_AGENDA_PREFER_NOTOURISM'),
		('AGENDA_LAST_VIKING_KING', 'TRAIT_AGENDA_PREFER_NOTOURISM'),
		('AGENDA_SHORT_LIFE_GLORY', 'TRAIT_AGENDA_PREFER_NOTOURISM'),
--		Militaristic Ignore Diplomatic Victory:		
		('AGENDA_ALLY_OF_ENKIDU', 'TRAIT_AGENDA_PREFER_NODIPLOVP'),
		('AGENDA_BIG_STICK_POLICY', 'TRAIT_AGENDA_PREFER_NODIPLOVP'),
		('AGENDA_IRON_CROWN', 'TRAIT_AGENDA_PREFER_NODIPLOVP'),
		('AGENDA_OPTIMUS_PRINCEPS', 'TRAIT_AGENDA_PREFER_NODIPLOVP'),
		('AGENDA_TLATOANI', 'TRAIT_AGENDA_PREFER_NODIPLOVP'),
		('AGENDA_LAST_VIKING_KING', 'TRAIT_AGENDA_PREFER_NODIPLOVP'),
		('AGENDA_SHORT_LIFE_GLORY', 'TRAIT_AGENDA_PREFER_NODIPLOVP');