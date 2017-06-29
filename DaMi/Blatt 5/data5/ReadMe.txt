Task 1:

Just run the SOM/KMEANS via
python SOM.py / python KMEANS.py 
or via IDLE/ipython. 
Hint on the coding environment: you can use spyder, IDLE, or ipython as well. At least spyder should be available on all machines under Ubuntu. If you want to run the scripts plain from command line, you may want to uncomment the last line in the SOM.py/KMEANS.py to avoid the closing of the program and this way the closing of the plots.


Task 2:
Analogously with GA.py.


------
Data sets:

<dataset>.dat, for box, sphere, triangle, clusters, and capitals contain coordinates in 2D euclidean space.

Box, sphere and triangle form the respective geometric form.
Clusters is unstructured arbitrary data.
Capitals contains the coordinates of European cities roughly in the geographic coordinate system.
In capitalnames.dat a third variable is included, providing the label for the respective city.


------
hints on gnuplot:

For people, interested in the command-line usage of Gnuplot:
Comments about gnuplot. All given data files can be plotted with gnuplot. The SOM program also writes
the learnt weights (centroids) like data into a file out.dat. Furthermore, the links between the centroids are
drawn by gnuplot commands produced in the file out.gnu.
In the shell of gnuplot, the most important commands are plot, which is for 2D, and splot, which is for
3D. A command may look like this:
splot "sphere.dat" with dots, "out.dat" with points
Gnuplot commands, which are written by the SOM program into a the file out.gnu can be loaded as:
load "out.gnu"
This plots the connecting lines between neighboring SOM units.
For the TSP problem, visualisation of the data with labels can be done via:
unset key
plot "capitalsnames.dat" with labels
Gnuplot under the operating system Windows: The homepage of gnuplot is www.gnuplot.info. From
there you can get via SourceForge the file gp460win32.zip. Unzip this file, and in the sub-directory
gnuplotnbinary you find the executable wgnuplot.exe. Execute this and you have it running. In gnu-
plot you can print the current working directory via pwd, and you can change to the directory of your data
like in the following example:
cd "C:/Users/YourName/Desktop/DAMI/SOM data/"