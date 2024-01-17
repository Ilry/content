-- improveGWFunc
-- Author: Hunter Pen
-- DateCreated: 7/19/2019 5:04:58 PM
--------------------------------------------------------------

-- Culture bomb.
INSERT INTO Modifiers(ModifierId, ModifierType) 
VALUES
('PEN_SGW_CULTURE_BOMB_TRIGGER_GREAT_WALL_MODIFIER', 'MODIFIER_PLAYER_ADD_CULTURE_BOMB_TRIGGER');

INSERT INTO ModifierArguments(ModifierId, Name, Value) 
VALUES
('PEN_SGW_CULTURE_BOMB_TRIGGER_GREAT_WALL_MODIFIER', 'ImprovementType', 'IMPROVEMENT_GREAT_WALL');

INSERT INTO ImprovementModifiers(ImprovementType, ModifierID) 
VALUES
('IMPROVEMENT_GREAT_WALL', 'PEN_SGW_CULTURE_BOMB_TRIGGER_GREAT_WALL_MODIFIER');

-- Removes Great Wall's "can only be built on the current border" restriction
-- and allows you to build Greate Wall in and outside of your borders
-- and increate house.
UPDATE Improvements SET 
BuildOnFrontier=0, Housing=1, TilesRequired=1, BuildInLine=0, CanBuildOutsideTerritory=1
WHERE ImprovementType='IMPROVEMENT_GREAT_WALL';

-- Ajdacent yields change.
UPDATE Adjacency_YieldChanges SET 
YieldChange=1, PrereqTech='TECH_MASONRY' 
WHERE ID='GreatWall_Culture';

UPDATE Adjacency_YieldChanges SET 
YieldChange=1
WHERE ID='GreatWall_Gold';

INSERT INTO Adjacency_YieldChanges
(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentImprovement, PrereqTech) 
VALUES
('PEN_SGW_GreatWall_Faith', 'Placeholder', 'YIELD_FAITH', 1, 1, 'IMPROVEMENT_GREAT_WALL', 'TECH_MASONRY'),
('PEN_SGW_GreatWall_Food', 'Placeholder', 'YIELD_FOOD', 1, 1, 'IMPROVEMENT_GREAT_WALL', 'TECH_MASONRY'),
('PEN_SGW_GreatWall_Production', 'Placeholder', 'YIELD_PRODUCTION', 1, 1, 'IMPROVEMENT_GREAT_WALL', 'TECH_MASONRY'),
('PEN_SGW_GreatWall_Science', 'Placeholder', 'YIELD_SCIENCE', 1, 1, 'IMPROVEMENT_GREAT_WALL', 'TECH_MASONRY');

INSERT INTO Improvement_Adjacencies(ImprovementType, YieldChangeId) 
VALUES
('IMPROVEMENT_GREAT_WALL', 'PEN_SGW_GreatWall_Faith'),
('IMPROVEMENT_GREAT_WALL', 'PEN_SGW_GreatWall_Food'),
('IMPROVEMENT_GREAT_WALL', 'PEN_SGW_GreatWall_Production'),
('IMPROVEMENT_GREAT_WALL', 'PEN_SGW_GreatWall_Science');

-- Yield change.
UPDATE Improvement_YieldChanges SET 
YieldChange=1 
WHERE ImprovementType='IMPROVEMENT_GREAT_WALL';

INSERT INTO Improvement_YieldChanges(ImprovementType, YieldType, YieldChange) 
VALUES
('IMPROVEMENT_GREAT_WALL', 'YIELD_FAITH', 1),
('IMPROVEMENT_GREAT_WALL', 'YIELD_FOOD', 1),
('IMPROVEMENT_GREAT_WALL', 'YIELD_PRODUCTION', 1),
('IMPROVEMENT_GREAT_WALL', 'YIELD_SCIENCE', 1);

-- Amenity.
INSERT INTO Modifiers(ModifierId, ModifierType) 
VALUES
('PEN_SGW_GREAT_WALL_AMENITY', 'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_AMENITY');

INSERT INTO ModifierArguments(ModifierId, Name, Value) 
VALUES
('PEN_SGW_GREAT_WALL_AMENITY', 'Amount', 1);

INSERT INTO ImprovementModifiers(ImprovementType, ModifierId) 
VALUES
('IMPROVEMENT_GREAT_WALL', 'PEN_SGW_GREAT_WALL_AMENITY');

-- Valid features and terrains.
INSERT INTO Improvement_ValidFeatures(ImprovementType, FeatureType) 
VALUES
('IMPROVEMENT_GREAT_WALL', 'FEATURE_FLOODPLAINS'),
('IMPROVEMENT_GREAT_WALL', 'FEATURE_JUNGLE'),
('IMPROVEMENT_GREAT_WALL', 'FEATURE_FOREST'),
('IMPROVEMENT_GREAT_WALL', 'FEATURE_OASIS'),
('IMPROVEMENT_GREAT_WALL', 'FEATURE_MARSH');
