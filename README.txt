Instructions on setting up the webpages
===============================================

1. Open index.html

Note: 
     Make sure that a simple web server is running.
     If you're using a Windows machine that has Python 2.7 installed, simply run the 'RunServer.bat' and then click 'Open Server'

2. In the navigation pane you will see several tabs. Those are pulled to the left side are the visualizations that could be easily seen by simply clicking on them.
   The tabs that are pulled to the right are additional information along with the published matlab scripts.


Instructions on using the MATLAB scripts
===============================================


The Matlab scripts would require certain changes to accomodate one's needs and run on a particular machine. The necessary information has already been extracted and placed in the /data directory. Hence there is no need to run them


Instructions on setting up parse.cpp
===============================================
Parse.cpp is a simple tool that extracts a given matchid from the master_zones.csv file.
Compile by entering the Parse directory and executing 'make'. This makefile assumes you have the clang++ compiler, edit line 1 of Makefile if you want to use g++ instead (or mingw++ or whatever C++ compiler).

Usage:
	./parse <matchid> <path/to/master_zones.csv>
	This will extract all data from <matchid> to the file match_<matchid>.csv

Example:
	koray@herfjottur:~/src/Data-Visualization/Parse$ ./parse 569716737 ../../dv/DataVis-DotA/master-zones.csv
	Read 4616057 entries
	Match written to match_569716737.csv

