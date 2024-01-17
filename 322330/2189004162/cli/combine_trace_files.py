import json
import os

base_path = "C:/Users/Penguin/Documents/Klei/DoNotStarveTogether/"

files = []
for i in range(1, 100):
	pth = base_path + "profile_{num:03}.json".format(num=i)
	#print(pth)
	if os.path.exists(pth):
		files.append(pth)
	else:
		print("Max profile:", i)
		break

with open(base_path + "profile.json", "r") as f:
	main_json = json.load(f)

for pth in files:
	print("Appending file", pth)
	with open(pth, "r") as f:
		data = json.load(f)
	
	for x in data["traceEvents"]:
		main_json["traceEvents"].append(x)
		
		if x["name"][0:8] == "Insight:":
			#print(x)
			#print(x["args"])
			# ph: B is begin and E is end?
			if x["ph"] == "B":
				x["args"]["src_file"] = "insight:" + x["name"][8:]
			#print(x)
		
		
	
with open(base_path + "profile_yay.json", "w") as f:
	json.dump(main_json, f)