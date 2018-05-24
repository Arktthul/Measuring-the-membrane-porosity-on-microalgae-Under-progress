```
list = getList("window.titles"); 

     for (i=0; i<list.length; i++){ 
     winame = list[i]; 
     setBatchMode("true");
     	selectWindow(winame); 
     run("Close"); 
     setBatchMode("false");
     } 
```