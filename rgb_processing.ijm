input_dir = getDirectory("Choose Source Directory");
output_dir = getDirectory("Choose Destination Directory");
file_list = getFileList(input_dir);
sep = "_";

//outer loop loops over the entire directory
for (i = 0; i < lengthOf(file_list); ++i) {
	file_name = file_list[i];
	if (endsWith(file_name, ".oif")){
		// inner loop goes through the entire process twice
		// to isolate frames 1 and 70
		open(input_dir + file_name);
		name = name_processor();
		run("Z Project...", "projection=[Max Intensity] all");
		for (j = 0; j < 2; ++j) {
			// u have to do this duplication manually sorry dogg 
			run("Duplicate...");
			run("Reverse");
			run("RGB Color");
			if (j == 0) {
					rename("frame01_" + name);
				}
			if (j == 1) {
					rename("frame70_" + name);
				}
			final_name = getTitle();
			print(final_name);
			saveAs("Tiff", output_dir + final_name + sep + ".tiff");
			close("frame*");
			close("*-1");
		}
	}
	close("*");

}


// Alex's files are in the format:
//[date][fluor1][fluor1][fluor2][condition][incubationtime][embryonumber]
// separated by underscores. (I had to massage this a bit to make it consistent.)
// however, some of this information is extraneous.
// so this bit of code processes the names to something a little 
// more reasonable for downstream work 

// note: File.nameWithoutExtension gets the name of the most 
// recently opened file ! if you're getting bugs, that's probably
// the cause 

/*
 * REQUIRES: File name is in the format described above.
 * MODIFIES: Nothing
 * EFFECTS: Splits the name of the file into pieces and
 * 			reconstructs it with only what I deem to be the 
 * 			necessary info about the file.  			
 */
function name_processor() {
	name = File.nameWithoutExtension;
	sep = "_";
	// create an array out of the filename
	name_array = split(name, "_");
	// rename the original image to [date]_[condition]_[embryoname]
	rename(
		name_array[0] + sep + name_array[4] + sep + name_array[6]
		);
	// store the name of this processed name in its own 
	// variable for returning
	name_processed = getTitle();
	// return the new file name. this can be stored in a variable in "main."
	return name_processed;
}