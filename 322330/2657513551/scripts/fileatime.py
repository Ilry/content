from pathlib import Path
from datetime import datetime
cloudsave = Path.home()/"Documents/Klei/DoNotStarveTogether/857197446/CloudSaves"

temp = []

def formattime(t):
	# return datetime.fromtimestamp(t).strftime("%Y-%m-%d %H:%M:%S")
	return datetime.fromtimestamp(t).strftime("%m-%d %H:%M:%S")

for folder in cloudsave.iterdir():
	if folder.is_dir():
		m = folder/"Master.zip"
		c = folder/"Caves.zip"
		if m.is_file() and c.is_file():
			m = m.stat().st_atime
			c = c.stat().st_atime
			temp.append([
				max(m, c), # sort value
				folder.stem,
				m,
				c,
			])

temp.sort(reverse = True)

for _, folder, m, c in temp:
	print(f"{folder} Master: {formattime(m)} Caves: {formattime(c)}")
