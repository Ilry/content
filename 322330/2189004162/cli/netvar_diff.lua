xprint = print

function load_netvars(path)
	local f = io.open(path)
	
	local data = {}
	local current = nil

	while true do
		local line = f:read("*line")
		if not line then
			break
		end

		-- GUID:100070 NetworkId:17506 NetvarCount:6 Prefab:scorchedground6
		if line:sub(1,4) == "GUID" then
			local GUID, networkId, netvarCount, prefab = line:match("GUID:(%d+) NetworkId:(%d+) NetvarCount:(%d+) Prefab:([%w_.?-]+)")
			GUID, networkId, netvarCount = tonumber(GUID), tonumber(networkId), tonumber(netvarCount)
			assert(GUID and networkId and netvarCount, "WTF")
			current = {
				networkId = networkId,
				netvarCount = netvarCount,
				netvars = {}
			}

			data[networkId] = current
		else
			local idx, name, namehash, event, eventhash = line:match("%[(%d+)%] ([^%s]+) %((%d+)%)%s*([%w%d%[%]_.-]+) %((%d+)%)")
			if idx then
				table.insert(current.netvars, {idx=idx, name=name, namehash=namehash, event=event, eventhash=eventhash})
			else
				print("Unable to process line?")
				print(line)
			end
		end
	end

	f:close()

	return data
end

function table.contains(table, element)
    if table == nil then return false end

    for _, value in pairs(table) do
        if value == element then
          return true
        end
    end
    return false
end

--client_data = load_netvars("C:/Users/Penguin/Downloads/netvars_client.txt")
--server_data = load_netvars("C:/Users/Penguin/Downloads/netvars_server_1.txt")

client_data = load_netvars("D:/Steam/steamapps/common/Don't Starve Together/data/netvars_client.txt")
server_data = load_netvars("D:/Steam/steamapps/common/Don't Starve Together/data/netvars_server_1.txt")



local record = client_data[37735]
local server_state = server_data[37735]

local client_netvar_names = {}
local hashes = {}
for i, client_netvar in pairs(record.netvars) do
	client_netvar_names[#client_netvar_names+1] = client_netvar.name
	hashes[#hashes+1] = {client_netvar.event, client_netvar.eventhash}
end

local server_netvar_names = {}
for i, server_netvar in pairs(server_state.netvars) do
	server_netvar_names[#server_netvar_names+1] = server_netvar.name
end

-----

table.sort(hashes, function(a, b) return a[2] < b[2] end)

for i,v in ipairs(hashes) do
	print(i, v[1], v[2])
end

local a, b = client_netvar_names, server_netvar_names
local mode = "client"
if #server_netvar_names > #client_netvar_names then
	a, b = server_netvar_names, client_netvar_names
	mode = "server"
end






for i,v in pairs(server_netvar_names) do
	if not table.contains(client_netvar_names, v) then
		print("MISSING ON CLIENT:", v)
	end
end

for i,v in pairs(client_netvar_names) do
	if not table.contains(server_netvar_names, v) then
		print("MISSING ON SERVER:", v)
	end
end