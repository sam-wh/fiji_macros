// TO MAKE THIS WORK
// open the ROI manager and the macro first
// then and only then do you open the image.
// the macro will remind you if you do not. 

// pulls out all of the little "making it not ugly" shit 
function preprocessing() {
	run("Z Project...", "projection=[Sum Slices] all");
	run("Subtract Background...", "rolling=50 stack");
	run("Enhance Contrast", "saturated=0.35");
	} 

// makes a 5uM circular ROI
function make_roi() {
	run("Specify...", "width=5 height=5 x=0 y=0 slice=1 oval constrain scaled");
	}
	
// this function is where you do the measurements.
function roi_condenser() {
	make_roi();
	waitForUser("Okay now measure",
				"Be careful about the ROI!");
	String.copyResults;
	waitForUser("Don't click this button",
				"until you've done all your copy-pasting");
	n = Table.size;
	Table.deleteRows(0, n);
}

//File.name etc. gets the name of the most recent file OPENED
// if anything else is opened before the image this won't work
file_name = File.nameWithoutExtension;
print(file_name);
len = roiManager("count");
getDimensions(width, height, channels, slices, frames);
print(len);

waitForUser("Before you start:", 
"Measurements set?\nFile to process most recent opened?")
preprocessing();

// this bit of the code loops through the rois in the roi manager 
// and runs the code on each individual ROI
// I am not explaining this well and could possibly turn all that repeated 
// code into another function lmfao. 
for (i = 0; i < len; ++i) {
	roiManager("select", i);
	waitForUser("Duplicate what you need to",
				"Don't forget to click the hyperstack option!");
	run("Split Channels");
	selectImage("C1-" + "SUM_" + file_name + "-1.oir");
	roi_condenser();
	selectImage("C2-" + "SUM_" + file_name + "-1.oir");
	roi_condenser();
	selectImage("C3-" + "SUM_" + file_name + "-1.oir");
	roi_condenser();
	waitForUser("Finished?");
	close("C*");
}

waitForUser("Finished for real?");
close("*");
