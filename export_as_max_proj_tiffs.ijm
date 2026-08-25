input_dir = getDirectory("Choose Source Directory");
output_dir = getDirectory("Now, choose destination directory");
file_list = getFileList(input_dir);
sep = "_";


for (i = 0; i < lengthOf(file_list); ++i) {
	file_name = file_list[i];
//	sub = 1;
	if (endsWith(file_name, ".oir")) {
		open(input_dir + File.separator + file_list[i]);
		run("Z Project...", "projection=[Max Intensity] all");
		//run("Duplicate...", "duplicate frames=1");
		selectImage("MAX_" + file_name);
		saveAs("tiff", output_dir + File.separator + file_name);
		close("*");

		}
	}	
}