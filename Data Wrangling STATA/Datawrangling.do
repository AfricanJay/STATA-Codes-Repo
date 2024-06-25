LECTURE 03: DATA Wrangling Practice.
CREATED BY: Jennifer Onyeama

*Data wrangling or data munging is the is the process of converting raw data into a usable form. 
This data wrangling is unavoidable, in fact desirable: it makes the data analyst know the data, and also helps avoiding false results. 
The top 10 data wrangling commands in STATA are:

*log, browse, describe, sort, order, isid, duplicates, codebook, label, and note.

**Download your datafile into a folder of your choice, preferably C:\data\, and then load it. you can load the directory first.

 cd "C:\data\"

^^^permanently opens the directory where your files are

use "hotels-vienna.dta"

^^loads your actual dataset

use "hotels-vienna.dta", clear

^^clears out any previous datasets already loaded

use "C:\data\hotels-vienna.dta"

^^^can also load your dataset if you didn't open the directory with cd



/*Logging: A log file records everything on the output window, both the input and the output. The difference between a log file
and a do file is that a do file only shows the input. The log file saves itself automatically as a 
s Stata Markup and Control Language (.smcl) which is a stata output data format. You can also chose to save it as a .txt.*/

log using mylog
*^^^^Automatically creates a .smcl log file called 'mylog*

log using mylog, text

^^^^Saves the log file as a text file that can be viewed with a text editor

log using mylog2, name(mylog2)

^^^^opens a subset of another log while the main mylog is still open

log using mylog3, name(mylog3)

^^^^opens yet another subset underneath mylog2

log close mylog3

^^^^close mylog3

log close mylog2

^^^^close mylog2 

log close mylog

^^^^^this will throw back an error. the main log will not close if you mention the variable name

log close

^^^^^closes mylog main. When handling the main log, do not mention the variable name of the log file

log on 

^^^temporarily turns on the log

log off 

^^temporarily turns off the log, while log close shuts it permanently

quietly log using myfile

^^^^starts logging without the messages

set logtype smcl  //or text

^^sets the defaults log type as smcl

set logmsg on //or off

^^sets the default log message display as on or off

