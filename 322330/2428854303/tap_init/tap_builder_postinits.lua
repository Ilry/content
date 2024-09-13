local _G 		= GLOBAL
local require 	= _G.require

local function BuilderPostinit(self)
	function self:MakeRecipeAtPoint(recipe, pt, rot, skin)
		if not self.inst.components.inventory:IsOpenedBy(self.inst) then
			return -- NOTES(JBK): The inventory was hidden by gameplay do not allow crafting.
		end

		if recipe.product == "mangrovetree_short" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_wreck_1" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_wreck_2" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_wreck_3" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_wreck_4" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_seaweed" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_brain_rock" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_rock_coral_1" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_rock_coral_2" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_rock_coral_3" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_redbarrel" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_bermudatriangle" 		and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_ballphinhouse" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_octopusking" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_luggagechest" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_fishinhole" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_buoy" 					and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_sea_chiminea" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_seayard" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_extractor" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_musselfarm" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_fishfarm" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_sealab" 					and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_krakenchest" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_waterchest" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_watercrate" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_tarpit" 					and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_seastack" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_saltstack" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_wobster_den" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_moon_wobster_den" 		and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_sea_grass" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_sea_reeds" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_volcano" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_lilypad" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_lotusplant" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_whalebubbles" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_whale_blue" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_whale_white" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_jellyfish" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_jellyfish_rainbow" 		and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_kraken" 					and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_kraken_tentacle" 		and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_wilbur_sleeping" 		and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_bioluminescence" 		and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_knightboat" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_bishopboat" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_rookboat" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_seataro_planted" 		and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_slow_hydrofarmplot" 		and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_fast_hydrofarmplot" 		and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_slow_hydrofarmmeat" 		and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_fast_hydrofarmmeat" 		and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_watercress_planted" 		and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_whirlpool" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_sea_cocoon" 				and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_sea_cocoon_1" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_sea_cocoon_2" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_sea_cocoon_3" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_watertree_root" 			and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end
		if recipe.product == "kyno_seastrider_nest_water"	and recipe.placer ~= nil and self:IsBuildBuffered(recipe.name) then self:MakeRecipe(recipe, pt, rot, skin) end

		if recipe.placer ~= nil and
			self:KnowsRecipe(recipe) and
			self:IsBuildBuffered(recipe.name) and
			_G.TheWorld.Map:CanDeployRecipeAtPoint(pt, recipe, rot) then
			self:MakeRecipe(recipe, pt, rot, skin)
		end
	end
end

AddComponentPostInit("builder", BuilderPostinit)

local function BuilderReplicaPostinit(self)
	function self:CanBuildAtPoint(pt, recipe, rot)
		local ex, ey, ez = pt:Get()
		local position0 = _G.TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(ex,   ey, ez))
		local position1 = _G.TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(ex,   ey, ez+2))
		local position2 = _G.TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(ex,   ey, ez-2))
		local position3 = _G.TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(ex+2, ey, ez))
		local position4 = _G.TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(ex-2, ey, ez))
	
		if recipe.product == "mangrovetree_short" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_wreck_1" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_wreck_2" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_wreck_3" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_wreck_4" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_seaweed" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_brain_rock" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_rock_coral_1" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_rock_coral_2" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_rock_coral_3" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_redbarrel" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_bermudatriangle" 		and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_ballphinhouse" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_octopusking" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_luggagechest" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_fishinhole" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_buoy" 					and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_sea_chiminea" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_seayard" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_extractor" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_musselfarm" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_fishfarm" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_sealab" 					and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_krakenchest" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_waterchest" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_watercrate" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_tarpit" 					and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_seastack" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_saltstack" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_wobster_den" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_moon_wobster_den" 		and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_sea_grass" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_sea_reeds" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_volcano" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_lilypad" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_lotusplant" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_whalebubbles" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_whale_blue" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_whale_white" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_jellyfish" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_jellyfish_rainbow" 		and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_kraken" 					and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_kraken_tentacle" 		and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_wilbur_sleeping" 		and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_bioluminescence" 		and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_knightboat" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_bishopboat" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_rookboat" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_seataro_planted" 		and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_slow_hydrofarmplot" 		and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_fast_hydrofarmplot" 		and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_slow_hydrofarmmeat" 		and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_fast_hydrofarmmeat" 		and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_watercress_planted" 		and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_whirlpool" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_sea_cocoon" 				and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_sea_cocoon_1" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_sea_cocoon_2" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 
		if recipe.product == "kyno_sea_cocoon_3" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end
		if recipe.product == "kyno_watertree_root" 			and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 	
		if recipe.product == "kyno_seastrider_nest_water"	and (position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL_SHORE or position0 == _G.WORLD_TILES.OCEAN_BRINEPOOL or position0 == _G.WORLD_TILES.OCEAN_ROUGH or position0 == _G.WORLD_TILES.OCEAN_SWELL or position0 == _G.WORLD_TILES.OCEAN_COASTAL or position0 == _G.WORLD_TILES.OCEAN_HAZARDOUS) then return true end 	
	
		if recipe.product == "mangrovetree_short" 			then return false end
		if recipe.product == "kyno_wreck_1" 				then return false end
		if recipe.product == "kyno_wreck_2" 				then return false end
		if recipe.product == "kyno_wreck_3" 				then return false end
		if recipe.product == "kyno_wreck_4"					then return false end
		if recipe.product == "kyno_seaweed" 				then return false end
		if recipe.product == "kyno_brain_rock" 				then return false end
		if recipe.product == "kyno_rock_coral_1" 			then return false end
		if recipe.product == "kyno_rock_coral_2" 			then return false end
		if recipe.product == "kyno_rock_coral_3" 			then return false end
		if recipe.product == "kyno_redbarrel" 				then return false end
		if recipe.product == "kyno_bermudatriangle" 		then return false end
		if recipe.product == "kyno_ballphinhouse" 			then return false end
		if recipe.product == "kyno_octopusking" 			then return false end
		if recipe.product == "kyno_luggagechest" 			then return false end
		if recipe.product == "kyno_fishinhole" 				then return false end
		if recipe.product == "kyno_buoy" 					then return false end
		if recipe.product == "kyno_sea_chiminea" 			then return false end
		if recipe.product == "kyno_seayard" 				then return false end
		if recipe.product == "kyno_extractor"				then return false end
		if recipe.product == "kyno_musselfarm" 				then return false end
		if recipe.product == "kyno_fishfarm" 				then return false end
		if recipe.product == "kyno_sealab" 					then return false end
		if recipe.product == "kyno_krakenchest" 			then return false end
		if recipe.product == "kyno_waterchest" 				then return false end
		if recipe.product == "kyno_watercrate" 				then return false end
		if recipe.product == "kyno_tarpit" 					then return false end
		if recipe.product == "kyno_seastack" 				then return false end
		if recipe.product == "kyno_saltstack" 				then return false end
		if recipe.product == "kyno_wobster_den" 			then return false end
		if recipe.product == "kyno_moon_wobster_den" 		then return false end
		if recipe.product == "kyno_sea_grass" 				then return false end
		if recipe.product == "kyno_sea_reeds" 				then return false end
		if recipe.product == "kyno_volcano" 				then return false end
		if recipe.product == "kyno_lilypad" 				then return false end
		if recipe.product == "kyno_lotusplant" 				then return false end
		if recipe.product == "kyno_whalebubbles" 			then return false end
		if recipe.product == "kyno_whale_blue" 				then return false end
		if recipe.product == "kyno_whale_white" 			then return false end
		if recipe.product == "kyno_jellyfish" 				then return false end
		if recipe.product == "kyno_jellyfish_rainbow" 		then return false end
		if recipe.product == "kyno_kraken" 					then return false end
		if recipe.product == "kyno_kraken_tentacle" 		then return false end
		if recipe.product == "kyno_wilbur_sleeping" 		then return false end
		if recipe.product == "kyno_bioluminescence" 		then return false end
		if recipe.product == "kyno_knightboat" 				then return false end
		if recipe.product == "kyno_bishopboat" 				then return false end
		if recipe.product == "kyno_rookboat" 				then return false end
		if recipe.product == "kyno_seataro_planted" 		then return false end
		if recipe.product == "kyno_slow_hydrofarmplot" 		then return false end
		if recipe.product == "kyno_fast_hydrofarmplot" 		then return false end
		if recipe.product == "kyno_slow_hydrofarmmeat" 		then return false end
		if recipe.product == "kyno_fast_hydrofarmmeat" 		then return false end
		if recipe.product == "kyno_watercress_planted" 		then return false end
		if recipe.product == "kyno_whirlpool" 				then return false end
		if recipe.product == "kyno_sea_cocoon" 				then return false end
		if recipe.product == "kyno_sea_cocoon_1" 			then return false end
		if recipe.product == "kyno_sea_cocoon_2" 			then return false end
		if recipe.product == "kyno_sea_cocoon_3" 			then return false end
		if recipe.product == "kyno_watertree_root" 			then return false end
		if recipe.product == "kyno_seastrider_nest_water"	then return false end

		return _G.TheWorld.Map:CanDeployRecipeAtPoint(pt, recipe, rot)
	end
end

AddComponentPostInit("builder_replica", BuilderReplicaPostinit)