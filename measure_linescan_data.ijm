number_of_rois = roiManager("count");
getDimensions(w, h, num_channels, sl, fr);
file_name = getTitle();

//print(file_name);


//loop over ROIs in ROI manager
for (i = 0; i < number_of_rois; i++) {
	selectWindow(file_name);
	roiManager("select", i);
	
	//loop over each channel in the image 
	for (j = 0; j < num_channels; j++) {
	 	get_line_scan_values();
		selectWindow(file_name);
		run("Next Slice [>]");		
		//close all windows that begin with the word "Plot"
		//otherwise my desktop looks brazy
		close("Plot*");
	}
	results = getInfo("log");
	String.copy(results);
	waitForUser("Do ur copy pasting");
	close("Log");
	setSlice(1);

}

/*
based off of Fiji's example code: 
https://imagej.net/ij/macros/examples/PlotGetValuesDemo.txt

1. do the plot profile function 
2. get the values
3. for each value, write it to the log window with a tab separating the values 
*/
function get_line_scan_values() {
  run("Plot Profile");
  Plot.getValues(x, y);
  for (i = 0; i < x.length; i++)
      print(x[i], "\t", y[i]);
}

