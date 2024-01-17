-- ===========================================================================
--  GreatestCities
--  Author: Technoluddite
--  20210508: Created
-- ===========================================================================

--== DON'T CHANGE ANYTHING BELOW THIS LINE!! ==--


-- just to make versioning easier
INSERT INTO GlobalParameters (Name, Value) VALUES ('AKGC_VERSION_MAJOR', '1');
INSERT INTO GlobalParameters (Name, Value) VALUES ('AKGC_VERSION_MINOR', '3');

-- ReportsList Loader
INSERT OR REPLACE INTO RLLReports (ReportType, ButtonLabel, LuaEvent, StackID, SortOrder, RequiresXP1) VALUES
('REPORT_AKGC_GREATESTCITIES', 'LOC_AKGC_CITIES_BUTTON', 'ReportsList_OpenGreatestCities', 'GlobalReportsStack', 520, 0);
