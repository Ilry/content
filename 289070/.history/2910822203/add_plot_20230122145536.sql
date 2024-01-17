-- add_plot
-- Author: C.W.
-- DateCreated: 1/2/2023 12:06:38 AM
--------------------------------------------------------------
INSERT INTO CivicModifiers (CivicType, ModifierId) VALUES 
('CIVIC_CODE_OF_LAWS', 'add_gov_slot');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('add_gov_slot0', 'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', 0, 0, 0, NULL, 'ReqSet_human');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
('add_gov_slot0', 'GovernmentSlotType', 'SLOT_WILDCARD');
--------------------------------------------------------------
INSERT INTO CivicModifiers (CivicType, ModifierId) VALUES 
('CIVIC_CODE_OF_LAWS', 'add_gov_slot1');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('add_gov_slot1', 'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', 0, 0, 0, NULL, 'ReqSet_human');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
('add_gov_slot1', 'GovernmentSlotType', 'SLOT_WILDCARD');
--------------------------------------------------------------
INSERT INTO CivicModifiers (CivicType, ModifierId) VALUES 
('CIVIC_CODE_OF_LAWS', 'add_gov_slot2');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('add_gov_slot2', 'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', 0, 0, 0, NULL, 'ReqSet_human');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
('add_gov_slot2', 'GovernmentSlotType', 'SLOT_WILDCARD');
--------------------------------------------------------------
INSERT INTO CivicModifiers (CivicType, ModifierId) VALUES 
('CIVIC_CODE_OF_LAWS', 'add_gov_slot3');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('add_gov_slot3', 'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', 0, 0, 0, NULL, 'ReqSet_human');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
('add_gov_slot3', 'GovernmentSlotType', 'SLOT_WILDCARD');
--------------------------------------------------------------
INSERT INTO CivicModifiers (CivicType, ModifierId) VALUES 
('CIVIC_CODE_OF_LAWS', 'add_gov_slot4');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('add_gov_slot4', 'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', 0, 0, 0, NULL, 'ReqSet_human');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
('add_gov_slot4', 'GovernmentSlotType', 'SLOT_WILDCARD');
--------------------------------------------------------------
INSERT INTO CivicModifiers (CivicType, ModifierId) VALUES 
('CIVIC_CODE_OF_LAWS', 'add_gov_slot5');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('add_gov_slot5', 'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', 0, 0, 0, NULL, 'ReqSet_human');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
('add_gov_slot5', 'GovernmentSlotType', 'SLOT_WILDCARD');

--------------------------------------------------------------
INSERT INTO CivicModifiers (CivicType, ModifierId) VALUES 
('CIVIC_CODE_OF_LAWS', 'add_gov_slot6');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('add_gov_slot6', 'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', 0, 0, 0, NULL, 'ReqSet_human');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
('add_gov_slot6', 'GovernmentSlotType', 'SLOT_WILDCARD');
--------------------------------------------------------------
INSERT INTO CivicModifiers (CivicType, ModifierId) VALUES 
('CIVIC_CODE_OF_LAWS', 'add_gov_slot7');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('add_gov_slot7', 'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', 0, 0, 0, NULL, 'ReqSet_human');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
('add_gov_slot7', 'GovernmentSlotType', 'SLOT_WILDCARD');
--------------------------------------------------------------
INSERT INTO CivicModifiers (CivicType, ModifierId) VALUES 
('CIVIC_CODE_OF_LAWS', 'add_gov_slot8');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('add_gov_slot8', 'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', 0, 0, 0, NULL, 'ReqSet_human');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
('add_gov_slot8', 'GovernmentSlotType', 'SLOT_WILDCARD');

--------------------------------------------------------------
INSERT INTO CivicModifiers (CivicType, ModifierId) VALUES 
('CIVIC_CODE_OF_LAWS', 'add_gov_slot9');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('add_gov_slot9', 'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', 0, 0, 0, NULL, 'ReqSet_human');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
('add_gov_slot9', 'GovernmentSlotType', 'SLOT_WILDCARD');

-- RequirementSets

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES 
('ReqSet_human', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
('ReqSet_human', 'is_human');

-- Requirements

INSERT INTO Requirements (RequirementId, RequirementType) VALUES 
('is_human', 'REQUIREMENT_PLAYER_IS_HUMAN');
