```
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
```