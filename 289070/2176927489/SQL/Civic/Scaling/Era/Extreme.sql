-- Built by Take your Time Generator at 23:19 23/08/2020
CREATE TABLE IF NOT EXISTS TakeYourTimeCostChanges (Type TEXT, Era INT, CostID INT, Value REAL, CalculatedPower1 REAL, CalculatedPower2 REAL);
INSERT INTO TakeYourTimeCostChanges VALUES
("Civic", 2, NULL, 1.3, 1.177, 1.082),
("Civic", 3, NULL, 1.7, 1.39, 1.173),
("Civic", 4, NULL, 2.2, 1.63, 1.267),
("Civic", 5, NULL, 2.6, 1.808, 1.332),
("Civic", 6, NULL, 3.2, 2.057, 1.418),
("Civic", 7, NULL, 4, 2.362, 1.516),
("Civic", 8, NULL, 4.6, 2.576, 1.581),
("Civic", 9, NULL, 5.5, 2.878, 1.668);

UPDATE Civics SET Cost = CASE (
	SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Civics.EraType LIMIT 1
)

-- Scaling Amounts for Each Era
WHEN 2 THEN Cost * 1.3	--Classical
WHEN 3 THEN Cost * 1.7	--Medieval
WHEN 4 THEN Cost * 2.2	--Renaissance
WHEN 5 THEN Cost * 2.6	--Industrial
WHEN 6 THEN Cost * 3.2	--Modern
WHEN 7 THEN Cost * 4	--Atomic
WHEN 8 THEN Cost * 4.6	--Information
WHEN 9 THEN Cost * 5.5	--Future

-- Fallback Scaling Formula for Unknown Eras
ELSE Cost * (-4.0 + ((SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Civics.EraType LIMIT 1) * 1.0))
END

WHERE (SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Civics.EraType LIMIT 1) > 1;



CREATE TABLE IF NOT EXISTS CivicRandomCosts (Cost INT, CivicType TEXT); --Avoids errors with older versions of the game.

UPDATE CivicRandomCosts SET Cost = CASE (
	SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = (SELECT Civics.EraType FROM Civics WHERE Civics.CivicType = CivicRandomCosts.CivicType LIMIT 1) LIMIT 1
)

-- Scaling Amounts for Each Era
WHEN 2 THEN Cost * 1.3	--Classical
WHEN 3 THEN Cost * 1.7	--Medieval
WHEN 4 THEN Cost * 2.2	--Renaissance
WHEN 5 THEN Cost * 2.6	--Industrial
WHEN 6 THEN Cost * 3.2	--Modern
WHEN 7 THEN Cost * 4	--Atomic
WHEN 8 THEN Cost * 4.6	--Information
WHEN 9 THEN Cost * 5.5	--Future

-- Fallback Scaling Formula for Unknown Eras
ELSE Cost * (-4.0 + ((SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = (SELECT Civics.EraType FROM Civics WHERE Civics.CivicType = CivicRandomCosts.CivicType LIMIT 1) LIMIT 1) * 1.0))
END

WHERE (SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = (SELECT Civics.EraType FROM Civics WHERE Civics.CivicType = CivicRandomCosts.CivicType LIMIT 1) LIMIT 1) > 1;