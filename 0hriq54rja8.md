```
\begin{lstlisting) 
	selectWindow("FinalTable");
	Table.rename("FinalTable","Results");
	setResult("Name", i, Label);
	ColumnTitle = "Average Intensity Algae";
	setResult(ColumnTitle, i, IntensityArray[0]);
	for (n=1;n<=10;n++){
	ColumnTitle = "Intensity Slice"+n;
	setResult(ColumnTitle, i, IntensityArray[n]);
	}
	Table.rename("Results","FinalTable");
\end{lstlisting}
```