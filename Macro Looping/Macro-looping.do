#Created by Jennifer Onyeama. Macro-looping with STATA
#Well-commented practice code base

use "wms_da_textbook-xsec.dta", clear

*** A macro is a string of characters, called the macroname, that stands for another string of characters, ...
*** ... called the macro contents. Everywhere a macro name appears in a command, ...
*** ... the macro contents are substituted for the macro name. Macros can be local or global.

* 1) Define a local macro called i, containing the number 30, and then use it in an if condition:
local i = 30
count if sic == `i'

* 2) Define a local macro called number, containing the number 10, and then use it to produce a new variable:
local number = 10
generate fifteen = `number'+5

* 3) Define a local macro called varlist, containing some variable names, and then use it to produce some descriptives:
local varlist = "management operations monitor target"
summarize `varlist', detail


* 1) Define a global macro called j, containing the number 20, and then use it in an if condition:
global j = 20
count if sic == $j
* As a useful practice try to execute the two commands first together, then one by one.

* 2) Define a global macro called x, containing the word newvar, and then use it to produce a new variable:
global x = "newvar"
generate $x = 100

local h = $j + 20
generate forty = `h'

*** 2a) The 'forvalues' loop
* Example 1: Calculating some descriptives of -management- for each -wave-:


tabulate wave /*Running from 2004 to 2015, containing each year.*/
forvalues i = 2004(1)2015 {
	summarize management if wave == `i', detail
}

* Example 2: Renaming the -perf1-, -perf2-, ... variables to -performance_1, performance_2, etc.:
forvalues i = 1(1)10 {
	rename perf`i' performance_`i'
}

*** 2b) The 'foreach' loop

foreach i of numlist 20 21 25(1)30 36 39  {
	summarize management if sic == `i'
}

* Looping over a list of existing variables:
foreach j of varlist firmid wave cty management degree_m degree_nm {
	codebook `j'
}

*Looping over the elements of a global macro:
global k = "2005 2006 2010 2012"
foreach m of global k {
	tabulate country if wave == `m'
}


foreach n in us ar br ca {
	summarize management if cty == "`n'"
}

forvalues i = 20(1)39 {
	summarize management if sic == `i', detail
}


	display "Summary statistics of -management- for sic code `i':"
	summarize management if sic == `i', detail
}

