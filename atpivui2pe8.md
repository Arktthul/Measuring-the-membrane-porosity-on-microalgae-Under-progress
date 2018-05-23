```
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
	Table.rename("Results","ResultsofsingleMicroAlgae"+i);run("Close");
	
```