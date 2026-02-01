function preprocessing() {
	run("Z Project...", "projection=[Sum Slices] all");
	run("Subtract Background...", "rolling=50 stack");
	run("Enhance Contrast", "saturated=0.35");
	} 

function make_roi() {
	run("Specify...", "width=5 height=5 x=0 y=0 slice=1 oval constrain scaled");
	}
	
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

file_name = File.nameWithoutExtension;
print(file_name);

preprocessing();
waitForUser("Duplicate what you need to",
			"Don't forget to click the hyperstack option!");
print(file_name);
run("Split Channels");
print(file_name);
selectImage("C1-" + "SUM_" + file_name + "-1.oir");
roi_condenser();
selectImage("C2-" + "SUM_" + file_name + "-1.oir");
roi_condenser();
selectImage("C3-" + "SUM_" + file_name + "-1.oir");
roi_condenser();

waitForUser("Break");