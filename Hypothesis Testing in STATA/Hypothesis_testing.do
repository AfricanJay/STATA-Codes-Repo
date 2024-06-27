#created by Jennifer Onyeama, 
#Hypothesis testing with STATA

use "billion-prices.dta", clear

* Keeping data from the USA:
keep if COUNTRY == "USA" 

* Keeping products with regular prices:
keep if PRICETYPE == "Regular Price"

* Dropping products where online prices are sales:
drop if sale_online == 1

* Dropping three products with extreme prices:
drop if price > 590000

count /*6439 observations remained*/


*************** Descriptives
*calculate the average offline and online prices and their difference using macros and stored results:
  
summarize price /*Mean: 28.73*/
local offprice = r(mean)
summarize price_online /*Mean: 28.79*/
local onprice = r(mean)
display "The difference is:" `onprice' - `offprice'

*check the price difference in details
compare price price_online


* One-sample t-test
*us test whether the average offline price is equal to 30:
  
ttest price == 30
* According to the results, we cannot reject the null that the average offline price is 30.


*Paired t-test
* To know or test whether offline and online prices are equal:
  
ttest price_online == price
  
* Two-sample t-test

use "billion-prices.dta", clear
keep if COUNTRY == "JAPAN" | COUNTRY == "GERMANY"
keep if PRICETYPE == "Regular Price"
drop if sale_online == 1
count /*1044 observations remained*/

* Calculating price difference:
generate diff = price_online - price

* Testing:
ttest diff, by(COUNTRY)
* According to the results, rejecting the null is possible that the average offline and online price difference is equal in Japan and Germany.
