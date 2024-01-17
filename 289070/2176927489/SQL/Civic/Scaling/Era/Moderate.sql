-- Built by Take your Time Generator at 23:19 23/08/2020
CREATE TABLE IF NOT EXISTS TakeYourTimeCostChanges (Type TEXT, Era INT, CostID INT, Value REAL, CalculatedPower1 REAL, CalculatedPower2 REAL);
INSERT INTO TakeYourTimeCostChanges VALUES
("Civic", 2, NULL, 1.1, 1.061, 1.029),
("Civic", 3, NULL, 1.2, 1.12, 1.056),
("Civic", 4, NULL, 1.35, 1.205, 1.094),
("Civic", 5, NULL, 1.45, 1.259, 1.118),
("Civic", 6, NULL, 1.58, 1.328, 1.147),
("Civic", 7, NULL, 1.7, 1.39, 1.173),
("Civic", 8, NULL, 1.8, 1.44, 1.193),
("Civic", 9, NULL, 1.9, 1.489, 1.212);

UPDATE Civics SET Cost = CASE (
	SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Civics.EraType LIMIT 1
)

-- Scaling Amounts for Each Era
WHEN 2 THEN Cost * 1.1	--Classical
WHEN 3 THEN Cost * 1.2	--Medieval
WHEN 4 THEN Cost * 1.35	--Renaissance
WHEN 5 THEN Cost * 1.45	--Industrial
WHEN 6 THEN Cost * 1.58	--Modern
WHEN 7 THEN Cost * 1.7	--Atomic
WHEN 8 THEN Cost * 1.8	--Information
WHEN 9 THEN Cost * 1.9	--Future

-- Fallback Scaling Formula for Unknown Eras
ELSE Cost * (0.6 + ((SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Civics.EraType LIMIT 1) * 0.14))
END

WHERE (SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Civics.EraType LIMIT 1) > 1;



CREATE TABLE IF NOT EXISTS CivicRandomCosts (Cost INT, CivicType TEXT); --Avoids errors with older versions of the game.

UPDATE CivicRandomCosts SET Cost = CASE (
	SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = (SELECT Civics.EraType FROM Civics WHERE Civics.CivicType = CivicRandomCosts.CivicType LIMIT 1) LIMIT 1
)

-- Scaling Amounts for Each Era
WHEN 2 THEN Cost * 1.1	--Classical
WHEN 3 THEN Cost * 1.2	--Medieval
WHEN 4 THEN Cost * 1.35	--Renaissance
WHEN 5 THEN Cost * 1.45	--Industrial
WHEN 6 THEN Cost * 1.58	--Modern
WHEN 7 THEN Cost * 1.7	--Atomic
WHEN 8 THEN Cost * 1.8	--Information
WHEN 9 THEN Cost * 1.9	--Future

-- Fallback Scaling Formula for Unknown Eras
ELSE Cost * (0.6 + ((SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = (SELECT Civics.EraType FROM Civics WHERE Civics.CivicType = CivicRandomCosts.CivicType LIMIT 1) LIMIT 1) * 0.14))
END

WHERE (SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = (SELECT Civics.EraType FROM Civics WHERE Civics.CivicType = CivicRandomCosts.CivicType LIMIT 1) LIMIT 1) > 1;