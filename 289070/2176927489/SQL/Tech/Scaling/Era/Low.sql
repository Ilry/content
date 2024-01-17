-- Built by Take your Time Generator at 23:19 23/08/2020
CREATE TABLE IF NOT EXISTS TakeYourTimeCostChanges (Type TEXT, Era INT, CostID INT, Value REAL, CalculatedPower1 REAL, CalculatedPower2 REAL);
INSERT INTO TakeYourTimeCostChanges VALUES
("Tech", 2, NULL, 1.1, 1.061, 1.029),
("Tech", 3, NULL, 1.15, 1.091, 1.043),
("Tech", 4, NULL, 1.2, 1.12, 1.056),
("Tech", 5, NULL, 1.25, 1.148, 1.069),
("Tech", 6, NULL, 1.3, 1.177, 1.082),
("Tech", 7, NULL, 1.38, 1.221, 1.101),
("Tech", 8, NULL, 1.45, 1.259, 1.118),
("Tech", 9, NULL, 1.5, 1.286, 1.129);

UPDATE Technologies SET Cost = CASE (
	SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Technologies.EraType LIMIT 1
)

-- Scaling Amounts for Each Era
WHEN 2 THEN Cost * 1.1	--Classical
WHEN 3 THEN Cost * 1.15	--Medieval
WHEN 4 THEN Cost * 1.2	--Renaissance
WHEN 5 THEN Cost * 1.25	--Industrial
WHEN 6 THEN Cost * 1.3	--Modern
WHEN 7 THEN Cost * 1.38	--Atomic
WHEN 8 THEN Cost * 1.45	--Information
WHEN 9 THEN Cost * 1.5	--Future

-- Fallback Scaling Formula for Unknown Eras
ELSE Cost * (0.6 + ((SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Technologies.EraType LIMIT 1) * 0.1))
END

WHERE (SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = Technologies.EraType LIMIT 1) > 1;



CREATE TABLE IF NOT EXISTS TechnologyRandomCosts (Cost INT, TechnologyType TEXT); --Avoids errors with older versions of the game.

UPDATE TechnologyRandomCosts SET Cost = CASE (
	SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = (SELECT Technologies.EraType FROM Technologies WHERE Technologies.TechnologyType = TechnologyRandomCosts.TechnologyType LIMIT 1) LIMIT 1
)

-- Scaling Amounts for Each Era
WHEN 2 THEN Cost * 1.1	--Classical
WHEN 3 THEN Cost * 1.15	--Medieval
WHEN 4 THEN Cost * 1.2	--Renaissance
WHEN 5 THEN Cost * 1.25	--Industrial
WHEN 6 THEN Cost * 1.3	--Modern
WHEN 7 THEN Cost * 1.38	--Atomic
WHEN 8 THEN Cost * 1.45	--Information
WHEN 9 THEN Cost * 1.5	--Future

-- Fallback Scaling Formula for Unknown Eras
ELSE Cost * (0.6 + ((SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = (SELECT Technologies.EraType FROM Technologies WHERE Technologies.TechnologyType = TechnologyRandomCosts.TechnologyType LIMIT 1) LIMIT 1) * 0.1))
END

WHERE (SELECT ChronologyIndex FROM Eras WHERE Eras.EraType = (SELECT Technologies.EraType FROM Technologies WHERE Technologies.TechnologyType = TechnologyRandomCosts.TechnologyType LIMIT 1) LIMIT 1) > 1;