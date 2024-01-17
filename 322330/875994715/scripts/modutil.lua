function AddPrefab(file) table.insert(PrefabFiles, file) end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

local containers = require "containers"

AllContainers = containers.params

function AddContainer(name, params, overrides)
	if overrides == nil then
		AllContainers[name] = AllContainers[params] or params
	else
		AllContainers[name] = deepcopy(AllContainers[params])
		Tykvesh.Merge(AllContainers[name], overrides)
	end
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, #AllContainers[name].widget.slotpos)
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

local fx = require "fx"

function AddEffect(name, params)
	params.name = name
	table.insert(fx, params)
end