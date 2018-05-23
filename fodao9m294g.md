```
\begin{lstlisting) 
run("Duplicate...", "title=BackgroundCleanup duplicate");
run("Gaussian Blur...", "sigma=50 stack");
imageCalculator("Subtract create stack", "MembraneChannel","BackgroundCleanup");
close("BackgroundCleanup");
selectWindow("Result of MembraneChannel");rename("ForSegmentation");
\end{lstlisting}
```