Instructions on setting up the webpages
===============================================


Instructions on using the MATLAB scripts
===============================================


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

