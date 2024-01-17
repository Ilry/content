-- Built by Take your Time Generator at 23:19 23/08/2020
CREATE TABLE IF NOT EXISTS TakeYourTimeCostChanges (Type TEXT, Era INT, CostID INT, Value REAL, CalculatedPower1 REAL, CalculatedPower2 REAL);
INSERT INTO TakeYourTimeCostChanges VALUES
("Civic", 2, NULL, 1.2, 1.12, 1.056),
("Civic", 3, NULL, 1.4, 1.232, 1.106),
("Civic", 4, NULL, 1.6, 1.338, 1.151),
("Civic", 5, NULL, 1.8, 1.44, 1.193),
("Civic", 6, NULL, 2, 1.537, 1.231),
("Civic", 7, NULL, 2.3, 1.676, 1.284),
("Civic", 8, NULL, 2.6, 1.808, 1.332),
("Civic", 9, NULL, 2.9, 1.935, 1.376);

UPDATE Civics SET Cost = CASE (
	SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Civics.EraType LIMIT 1
)

-- Scaling Amounts for Each Era
WHEN 2 THEN Cost * 1.2	--Classical
WHEN 3 THEN Cost * 1.4	--Medieval
WHEN 4 THEN Cost * 1.6	--Renaissance
WHEN 5 THEN Cost * 1.8	--Industrial
WHEN 6 THEN Cost * 2	--Modern
WHEN 7 THEN Cost * 2.3	--Atomic
WHEN 8 THEN Cost * 2.6	--Information
WHEN 9 THEN Cost * 2.9	--Future

-- Fallback Scaling Formula for Unknown Eras
ELSE Cost * (0.0 + ((SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Civics.EraType LIMIT 1) * 0.32))
END

WHERE (SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Civics.EraType LIMIT 1) > 1;



CREATE TABLE IF NOT EXISTS CivicRandomCosts (Cost INT, CivicType TEXT); --Avoids errors with older versions of the game.

UPDATE CivicRandomCosts SET Cost = CASE (
	SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = (SELECT Civics.EraType FROM Civics WHERE Civics.CivicType = CivicRandomCosts.CivicType LIMIT 1) LIMIT 1
)

-- Scaling Amounts for Each Era
WHEN 2 THEN Cost * 1.2	--Classical
WHEN 3 THEN Cost * 1.4	--Medieval
WHEN 4 THEN Cost * 1.6	--Renaissance
WHEN 5 THEN Cost * 1.8	--Industrial
WHEN 6 THEN Cost * 2	--Modern
WHEN 7 THEN Cost * 2.3	--Atomic
WHEN 8 THEN Cost * 2.6	--Information
WHEN 9 THEN Cost * 2.9	--Future

-- Fallback Scaling Formula for Unknown Eras
ELSE Cost * (0.0 + ((SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = (SELECT Civics.EraType FROM Civics WHERE Civics.CivicType = CivicRandomCosts.CivicType LIMIT 1) LIMIT 1) * 0.32))
END

WHERE (SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = (SELECT Civics.EraType FROM Civics WHERE Civics.CivicType = CivicRandomCosts.CivicType LIMIT 1) LIMIT 1) > 1;