// macro for going crazy going stupid and measuring angles at diff timepoints 
// during cytokinesis. this one is going to involve some touching on
// your end. 

run("Duplicate...")
setTool("angle");
getDimensions(w, h, channels, slices, frames);
waitForUser("Measure angles at 100% ingression", "remember to do the dn side first");
Stack.setFrame(frames * 0.75);
waitForUser("Measure angles at 75%", "remember to do the dn side first");

Stack.setFrame(frames * 0.5);
waitForUser("Measure angles at 50%", "remember to do the dn side first");
Stack.setFrame(frames * 0.25);
waitForUser("Measure angles at 25%", "remember to do the dn side first");
Stack.setFrame(1);
waitForUser("ur almost done", "slay now go to the first frame");
Stack.getPosition(channel, slice, frame);
n = roiManager("count");
for(i = 0; i < n; i++) {
	roiManager("select", i);
	roiManager("Measure");
}
String.copyResults;
waitForUser("things are about to reset", "triple check you've got everything before you hit okay my dude")
roiManager("reset");
selectWindow("Results");
run("Clear Results");