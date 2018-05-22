run("Smooth", "stack");run("Smooth", "stack");
setThreshold(8, 255);
run("Set Measurements...", "area mean bounding fit shape stack display redirect=None decimal=3");
run("Analyze Particles...", "size=20-Infinity circularity=0.2-1.00 display add stack");
selectWindow("Results");Table.rename("Results","TableResultofSegmentation");