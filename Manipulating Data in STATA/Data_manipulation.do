
use "wms_da_textbook-xsec.dta", clear

* Generating the year of born of the firms is a simple mathematical operation:
generate born_year = wave - firmage

* Generating a new variable that measures the number of employees in thousands:
generate emp_firm_th = emp_firm/1000
	 
* Generating the natural logarithm of -emp_firm-:
generate lnemp = ln(emp_firm)

* Generating a new variable that contains the closest integer to -management-:
generate roundmanagement = round(management)

egen mean_management = mean(management)

calculating the average of the -aa_1-, -aa_2-, -aa_3- and -aa_4- variables for each observation:
egen mean_aa_1_4 = rowmean(aa_1 aa_2 aa_3 aa_4)

*calculate the average for all the aa_ variables using a wild card:
egen mean_aa_all = rowmean(aa_*)

* create a new variable containing the number of nonmissing values in varlist (again, with another wild card):

egen nrnomiss = rownonmiss(sic - target)

generate usa = 1 if country == "United States"

* Generating a new variable that contains the mode of -country- for the firms that have more than 1000 employees
egen x = mode(country) if emp_firm>1000 & emp_firm!=.

bysort country: egen cmean_manag = mean(management)

* Calculating the standard deviation of the management score for all country-industry subsamples:
bysort country sic: egen sd_manag = sd(management)

* Mathematical operations
replace mean_aa_all = 1 /*All the values of -mean_aa_all- will be 1.*/

* The if condition:
replace usa = 0 if usa == . /*Recoding missings to zeros, so we have a dummy now.*/

* Functions can be used:
replace mean_management = round(mean_management)

* Can be used for string:
replace country = "USA" if country == "United States"

*** 'recode' is only for numerical variables, and most frequently used for recoding categorical variables.

tabulate aa_1, missing /*The variable contains 0s and 1s, and one missing. Let us replace the missing with the number 2.*/
recode aa_1 (. = 2) /*We should define a rule in parentheses and the variable(s) to apply the rule for.*/

* The rule can be applied to more variables:
recode aa_2 aa_3 aa_4 (. = 2)

* More rules can also be applied:
recode aa_5 aa_6 (0 = 5) (1 = 6)

* More complex rules can also be applied:
recode aa_7 aa_8 (0 1 = 10) (. = 999)

* We can keep the original variable, and apply the rule(s) during generating a new one:
recode sic (. = 999), generate(sic_nomissing)

* You should avoid defining a lot of rules simultaneously (it could be confusing),...
*... although the 'test' option can show whether rules are ever invoked or that rules overlap.
recode aa_10 (0/5 = 100) (1 = 999), test

* generate two variables to convert:
generate uk_str = "1" if country == "Great Britain"
replace uk_str = "0" if uk_str==""
generate uk_str_other = uk_str
replace uk_str_other = "non-uk" in 1

* Take a look at these two variables and the -country- variable:
browse country uk_str uk_str_other

*covert -uk_str-, while keeping the original variable:
destring uk_str, generate(uk)

* replace it using the 'replace' option:
destring uk_str, replace

* Destring works only if all the values can be converted. Remember that uk_str_other contains a true string value...
* ... in row 1, so Stata cannot convert it:
destring uk_str_other, replace

*use the 'force' option to force the conversion /*non-convertible values are replaced by missings*/:
destring uk_str_other, replace force

tabulate competition, miss /*Four different string values and one missing.*/
tabulate compet_numer, miss /*The same as the previous at first sight. Let us see it without the labels.*/
tabulate compet_numer, miss nolabel /*So, we have numbers 1, 2, 3, and 4, labelled according to the original string values.*/

*** using 'encode' in case of numerical content stored as string could make fatal problems. Check the following:
generate number = "0" in 1/6
replace number = "5" in 7/15
replace number = "99" in 16/20
encode number, gen(num_number)
list number num_number in 1/20
list number num_number in 1/20, nolabel
