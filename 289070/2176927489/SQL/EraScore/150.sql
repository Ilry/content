-- Built by Take your Time Generator at 23:19 23/08/2020
UPDATE GlobalParameters SET Value = Value*1.5 WHERE Name = 'DARK_AGE_SCORE_BASE_THRESHOLD';
UPDATE GlobalParameters SET Value = Value*1.5 WHERE Name = 'GOLDEN_AGE_SCORE_BASE_THRESHOLD';
UPDATE GlobalParameters SET Value = Value*1.5 WHERE Name = 'THRESHOLD_SHIFT_PER_PAST_DARK_AGE';
UPDATE GlobalParameters SET Value = Value*1.5 WHERE Name = 'THRESHOLD_SHIFT_PER_PAST_GOLDEN_AGE';