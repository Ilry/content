-- Built by Take your Time Generator at 23:19 23/08/2020
CREATE TABLE IF NOT EXISTS TakeYourTimeCostChanges (Type TEXT, Era INT, CostID INT, Value REAL, CalculatedPower1 REAL, CalculatedPower2 REAL);
INSERT INTO TakeYourTimeCostChanges VALUES ("Civic", NULL, NULL, 3.5, 2.174, 1.456);

UPDATE Civics SET Cost = Cost*3.5;
CREATE TABLE IF NOT EXISTS CivicRandomCosts (Cost INT, CivicType TEXT); --Avoids errors with older versions of the game.
UPDATE CivicRandomCosts SET Cost = Cost*3.5;
