#Created by Jennifer Onyeama
#To present regression results in different ways
#Well-commended code base

use "cps-earnings.dta", clear

* Keeping employees with a graduate degree:
keep if grade92 >= 44

* Keeping employees of age 24 to 65:
keep if age >= 24 & age <= 65

* Keeping employees who reported at least 20 hours as their usual weekly time worked:
keep if uhours >= 20

count /*Number of observations is: 18241*/


* Variable production

generate hwage = (earnwke/uhour)
label variable hwage "hourly wage"

generate lnhwage = ln(hwage)
label variable lnhwage "ln(hourly wage)"

generate female = 0 if sex == 1
replace female = 1 if sex == 2
label define fem 0 "male" 1 "female"
label values female fem


*Running regressions
  
* Specification 1:
regress lnhwage female

* Specification 2:
regress lnhwage female age

* Specification 3:
regress age female

* Specification +1:
regress hwage age


* Graphical representation of regression results
  
*plot the observations using a scatter and fit a linear regression line:
graph twoway (scatter hwage age) (lfit hwage age)

* A confidence interval using the 'lfitci' command:
graph twoway (scatter hwage age) (lfitci hwage age)

*** 1b) Plotting coefficients

ssc install coefplot

regress lnhwage female age
coefplot

* using The 'estout' package
  
* Step 0: since it is a user-written command, it should be installed first (if it has not been so far):

ssc install estout

* Step 1: previous stored results (if any) should be cleared from the memory:
eststo clear

* Step 2: the regressions should be run and stored:

eststo: regress lnhwage female /*stored as est1*/
eststo: regress lnhwage female age /*stored as est2*/
eststo: regress age female /*stored as est3*/
eststo: regress hwage age /*stored as est4*/

* Step 3: results should be displayed:
estout est1 est2 est3 est4

* Some formatting 
  
estout est1 est2 est3 est4, cells(b(star fmt(3)) se(par fmt(3))) stats(r2 N) legend

* give names (using the 'title' option) to the models and display them (using the 'label' option later):

eststo clear
eststo, title("lnhwage"): regress lnhwage female /*stored as est1*/
eststo, title("lnhwage"): regress lnhwage female age /*stored as est2*/
eststo, title("age"): regress age female /*stored as est3*/
eststo, title("hwage"): regress hwage age /*stored as est4*/

estout est1 est2 est3 est4, label /*Check the result!*/

*** 2b) The 'outreg2' command

ssc install outreg2

* running a regression, then export the results to a .txt file:

regress lnhwage female
outreg2 using "results" /*Check the new file in your default folder.*/

* continue with some important options and running more sepcifications:
  
regress lnhwage female
outreg2 using "results", replace bdec(3) /*Overwriting the existing file, and displaying coeffs (b) with 3 decimals.*/

regress lnhwage female age
outreg2 using "results", append bdec(3) /*Appending new results to the existing file.*/

regress age female
outreg2 using "results", append bdec(3) excel /*Creating an Excel file.*/
