-- Built by Take your Time Generator at 23:19 23/08/2020
CREATE TABLE IF NOT EXISTS TakeYourTimeCostChanges (Type TEXT, Era INT, CostID INT, Value REAL, CalculatedPower1 REAL, CalculatedPower2 REAL);
INSERT INTO TakeYourTimeCostChanges VALUES ("Civic", NULL, NULL, 8, 3.63, 1.866);

UPDATE Civics SET Cost = Cost*8;
CREATE TABLE IF NOT EXISTS CivicRandomCosts (Cost INT, CivicType TEXT); --Avoids errors with older versions of the game.
UPDATE CivicRandomCosts SET Cost = Cost*8;
