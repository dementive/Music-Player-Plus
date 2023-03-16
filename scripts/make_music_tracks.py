import os

for dirpath, dirnames, filenames in os.walk("../music/dementive_roman_music"):
	for filename in [f for f in filenames if f.endswith(".mp3")]:
	    try:
	    	file_path = os.path.join(dirpath, filename)
	    	file_path = file_path.replace("../music/dementive_roman_music\\", "file:/music/dementive_roman_music/").replace("\\", "/")
	    	name = "roman_" + filename.replace(".mp3", "").replace(" ", "_s")
	    	print(f"{name} = {{\n\tname = \"{name}_name\"\n\tmusic = \"{file_path}\"\n\tpause_factor = 25\n\tmood = yes\n\tcan_be_interrupted = yes\n}}")
	    except:
	        OSError(f"Unable to parse file! Is it valid?")
