import os

str = """<Atlas>
	<Texture filename="{0}"/>
	<Elements>
		<Element name="{1}" u1="0" u2="1" v1="0" v2="1"/>
	</Elements>
</Atlas>"""

print(str)

base = "./images/"

f = []
for (dirpath, dirnames, filenames) in os.walk(base):
	#print(dirpath) #current directory path
	#print(dirnames) #folders inside
	#print(filenames) #files inside
	
	for x in filenames:
		if x[-3:] == "png" or x[-3:] == "tex":
			p = os.path.join(os.path.normcase(dirpath), x[:-4] + ".xml")
			if os.path.exists(p) is False:
				f = open(p, "w")
				f.write(str.format(x[:-4] + ".tex", x[:-4] + ".tex"))
				f.close()
				print("Generated XML for:", p)
	break