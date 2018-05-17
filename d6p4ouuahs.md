```
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
```