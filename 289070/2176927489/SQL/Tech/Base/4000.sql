-- Built by Take your Time Generator at 23:19 23/08/2020
CREATE TABLE IF NOT EXISTS TakeYourTimeCostChanges (Type TEXT, Era INT, CostID INT, Value REAL, CalculatedPower1 REAL, CalculatedPower2 REAL);
INSERT INTO TakeYourTimeCostChanges VALUES ("Tech", NULL, NULL, 40, 9.846, 3.024);

UPDATE Technologies SET Cost = Cost*40;
CREATE TABLE IF NOT EXISTS TechnologyRandomCosts (Cost INT, TechnologyType TEXT); --Avoids errors with older versions of the game.
UPDATE TechnologyRandomCosts SET Cost = Cost*40;
