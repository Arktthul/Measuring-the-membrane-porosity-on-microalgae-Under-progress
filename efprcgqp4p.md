
\begin{lstlisting)
Dir1 = getDirectory("Choose Source Directory");
ImageList =getFileList(Dir1);
Array.show(ImageList);
FileName =Dir1+ImageList[0];print(FileName);
run("Bio-Formats Macro Extensions");
Ext.setId(FileName);
Ext.fileGroupOption(FileName, must);
Ext.getSeriesCount(seriesCount); print(seriesCount);
for (i=0;i<seriesCount;i++) {
	Ext.setSeries(i);
	Ext.openImage("title", 0);
}
run("Images to Stack", "method=[Scale (largest)] name=DextranChannel title=[] use");
run("Set Scale...", "distance=1 known=0.18054 pixel=1 unit=micron");
for (i=0;i<seriesCount;i++) {
	Ext.setSeries(i);
	Ext.openImage("title", 2);
}
run("Images to Stack", "method=[Scale (largest)] name=MembraneChannel title=[] use");
run("Set Scale...", "distance=1 known=0.18054 pixel=1 unit=micron");
\end{lstlisting}