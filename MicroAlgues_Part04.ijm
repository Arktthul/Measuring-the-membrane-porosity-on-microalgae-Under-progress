ROIcount =roiManager("count");
//init Final Table
run("Set Measurements...", "  redirect=None decimal=3");
roiManager("Select", 0);run("Measure");Table.rename("Results", "FinalTable");