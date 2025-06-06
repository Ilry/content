--===========================================================================================================================================================================--
-- Author: GrayPockets
-- Create date: 2024-02-28
-- Description: Adds support for City Lights mod.
--==========================================================================================================================================================================--
/* CITY LIGHTS */
--==========================================================================================================================================================================--

--===============================================================================================================================================================================--
/* SECTION 1: DISTRICT */
--===============================================================================================================================================================================--

		-- Arsenals give adjacency bonuses to Rural Districts

		INSERT INTO "District_Adjacencies"
			(	"DistrictType",					"YieldChangeID"		)
		VALUES
			(	'DISTRICT_COREX_GYOSON',		'RurCom_ARSENAL'	),
			(	'DISTRICT_COREX_TROYU',			'RurCom_ARSENAL'	),
			(	'DISTRICT_COREX_FRONTIER_TOWN',	'RurCom_ARSENAL'	),
			(	'DISTRICT_COREX_TSIKHE',		'RurCom_ARSENAL'	);
