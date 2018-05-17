```
for (i=0; i<ROIcount; i++){
	selectWindow("DextranChannel");run("Set Measurements...", "area mean display redirect=None decimal=3");
	roiManager("Select", i);
	run("Measure");
	area1= getResult("Area",0);
	//print(area1);
	Radius = sqrt(area1/(3.14));
	print(Radius);
	//run("Enlarge...", "enlarge=-"+Radius/10);
	//run("Make Band...", "band="+Radius/10);
	roiManager("Add");
	for(j=1;j<10;j++){
    	roiManager("Select",ROIcount);
   		print(j,(10-j)/10,sqrt((10-j)/10)*Radius);
   		Diff=Radius*(1-sqrt((10-j)/10));
    	run("Enlarge...", "enlarge=-"+Diff);
    	roiManager("Add");
    }
```