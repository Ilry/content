import os

base = "./images/"

f = []
for (dirpath, dirnames, filenames) in os.walk(base):
	#print(dirpath) #current directory path
	#print(dirnames) #folders inside
	#print(filenames) #files inside
	
	print("@@@@@@", dirpath)
	
	for x in filenames:
		if x[-3:] == "png":
			f.append("\"" + x[:-4] + "\"")
	
	print(", ".join(f))
	f = []
	print("\n")

