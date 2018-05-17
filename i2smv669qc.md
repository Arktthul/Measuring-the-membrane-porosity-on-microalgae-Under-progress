```
NewROIcount = roiManager("count");
AllROIS=Array.getSequence(NewROIcount);
SelectedROIS = Array.slice(AllROIS,ROIcount,NewROIcount);
	roiManager("Select", SelectedROIS);
	roiManager("Delete");

```