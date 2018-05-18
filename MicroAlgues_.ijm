macro "MicroAlgae Intensity Analysis"
{

Dir1 = getDirectory("Choose Source Directory");
ImageList =getFileList(Dir1);
Array.show(ImageList);
FileName =Dir1+ImageList[0];print(FileName);
run("Bio-Formats Macro Extensions");
Ext.setId(FileName);
Ext.fileGroupOption(FileName, must);
Ext.getSeriesCount(seriesCount); print(seriesCount);
//open only first channel (Dextran) for all series
for (i=0;i<seriesCount;i++) {
	Ext.setSeries(i);
	Ext.openImage("title", 0);
}

list = getList("image.titles");
  if (list.length==0)
     print("No image windows are open");
  else {
     print("Image windows:");
     for (i=0; i<list.length; i++) {
        print("   "+list[i]);
  }
 print("");

//Test images has to be 1024*1024, others are discarded, build stack of 1024 images
NewList = newArray(list.length);
setBatchMode("true");
for (i=0; i<list.length; i++) {
	selectWindow(list[i]);
	getDimensions(width, height, channels, slices, frames);
	if (width != 1024) {
		close();
	}
}
//Array.show(list);Array.show(NewList);
//
run("Images to Stack", "method=[Scale (largest)] name=DextranChannel title=[] use");
run("Set Scale...", "distance=1 known=0.18054 pixel=1 unit=micron");
setBatchMode("false");
//open only third channel (Membrane) for all series
for (i=0;i<seriesCount;i++) {
	Ext.setSeries(i);
	Ext.openImage("title", 2);
}
//buildStack of third channel
setBatchMode("true");
for (i=0; i<list.length; i++) {
	selectWindow(list[i]);
	getDimensions(width, height, channels, slices, frames);
	if (width != 1024) {
		close();
	}
}
run("Images to Stack", "method=[Scale (largest)] name=MembraneChannel title=[] use");
run("Set Scale...", "distance=1 known=0.18054 pixel=1 unit=micron");
setBatchMode("false");
//Primary SEGMENTATION Micro-Algae using membrane labelling
//duplicate for Segmentation
run("Duplicate...", "title=BackgroundCleanup duplicate");
//run("Duplicate...", "title=Segmentation duplicate");
run("Gaussian Blur...", "sigma=50 stack");
imageCalculator("Subtract create stack", "MembraneChannel","BackgroundCleanup");
close("BackgroundCleanup");
selectWindow("Result of MembraneChannel");rename("ForSegmentation");
run("Smooth", "stack");run("Smooth", "stack");
setThreshold(8, 255);
run("Set Measurements...", "area mean bounding fit shape stack display redirect=None decimal=3");
run("Analyze Particles...", "size=20-Infinity circularity=0.2-1.00 display add stack");
selectWindow("Results");Table.rename("Results","TableResultofSegmentation");

//Analysing Individual MicroAlgae
ROIcount =roiManager("count");
//init Final Table
run("Set Measurements...", "  redirect=None decimal=3");
roiManager("Select", 0);run("Measure");Table.rename("Results", "FinalTable");
for (i=0; i<ROIcount; i++){
	selectWindow("DextranChannel");run("Set Measurements...", "area mean display redirect=None decimal=3");
	roiManager("Select", i);
	run("Measure");//waitForUser("Pause");
	area1= getResult("Area",0);
	//print(area1);
	Radius = sqrt(area1/(3.14));
	print(Radius);//waitForUser("Pause");
	//run("Enlarge...", "enlarge=-"+Radius/10);
	//run("Make Band...", "band="+Radius/10);
	roiManager("Add");//waitForUser("Pause");
	for(j=1;j<10;j++){
    	roiManager("Select",ROIcount);
   		print(j,(10-j)/10,sqrt((10-j)/10)*Radius);//waitForUser("Pause");
   		Diff=Radius*(1-sqrt((10-j)/10));
    	run("Enlarge...", "enlarge=-"+Diff);
    	roiManager("Add");
    }
    Testcount = 0;
	for(k=1;k<10;k++){
		l = k+ROIcount-1;
		Selec =newArray(l,k+ROIcount);//waitForUser("Pause");
    	roiManager("Select",Selec);
		roiManager("XOR");
//if two ROIs are the same then XOR is null and no selection can be performed ==> macro fail
//test roiManaager XOR

print(k);	run("Measure"); area2= getResult("Area",k+Testcount);print(area2);//waitForUser("Pause");
		if (area2 >= 34178){
			print("XOR selection is null");
			//XOR selection is null
			roiManager("Select",l);
			Table.deleteRows(k, k);
			Testcount = Testcount-1;
		}
    	roiManager("Add");  
	}	
//Measure
	for(n=10+ROIcount;n<19+ROIcount;n++){
    	roiManager("Select",n);    
    	run("Measure");
	}
	roiManager("Select",9+ROIcount);    
	run("Measure");
	Label = getResultString("Label",0)+"_"+i+1; print(Label);
	IntensityArray = newArray(11);
	IntensityArray[0]=getResult("Mean",0);
	for (m=1;m<=10;m++){
		IntensityArray[m]=getResult("Mean",m+9);
	}
	Array.show(IntensityArray);waitForUser("Pause");
	Table.rename("Results","ResultsofsingleMicroAlgae"+i);run("Close");
//Results Table
	selectWindow("FinalTable");
	Table.rename("FinalTable","Results");
	setResult("Name", i, Label);
	//setResult("Intensity Border", i, IntensityArray[0]);
	ColumnTitle = "Average Intensity Algae";
	setResult(ColumnTitle, i, IntensityArray[0]);
	for (n=1;n<=10;n++){
	ColumnTitle = "Intensity Slice"+n;
	setResult(ColumnTitle, i, IntensityArray[n]);
	}
	Table.rename("Results","FinalTable");
//Delete Extra ROIS
	NewROIcount = roiManager("count");
	AllROIS=Array.getSequence(NewROIcount);
	SelectedROIS = Array.slice(AllROIS,ROIcount,NewROIcount);
	roiManager("Select", SelectedROIS);
	roiManager("Delete");
}

}
}
