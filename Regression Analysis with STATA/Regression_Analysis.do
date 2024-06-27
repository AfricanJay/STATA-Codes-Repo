#Created by Jennifer Onyeama
#Regression Analysis 1.0
  #Well commented code base


use "hotels-vienna.dta", clear


**The research question is whether there is an association between price and distance from the city center. So fix the level of significance at 5%. 


*Linear regression

* Retaining accommodations from Vienna:
keep if city_actual == "Vienna"

* Retaining hotels:
keep if accommodation_type == "Hotel"

* Retaining hotels with 3, 3.5, or 4 stars:
keep if stars == 3 | stars == 3.5 | stars == 4

* Dropping a hotel with extremely high price:
  
summarize price, detail
drop if price == 1012

count /*207 observations remained*/


*correlation
  
pwcorr price distance /*The coeff is: -0.3963.*/

* indicate the significance of the coeff with a star using the 'star' option:
pwcorr price distance, star(0.05) /*It is significant.*/

* Or display the level of significance itself:
pwcorr price distance, sig

*** Panother command for calculating correlation coefficients: 'correlate'
  
     * 'correlate' displays correlation matrix or covariance matrix.
	 * 'pwcorr' displays pairwise correlation coefficients.

	 
* linear regression using the 'regress' command: regress depvar [indepvars] [if] [in] [weight] [, options]
  
regress price distance
  
*count the number of obs included in the regression we ran before... 

count if e(sample)

predict price_hat /*A new variable was generated that contains the fitted values.*/

*calculate the residuals:
  
predict res, residuals

*calculate residuals also manually using the predicted values:
generate res_manual = price - price_hat

* check the help for details:
  
help regress_postestimation 


*Including qualitative variables in the regression models
  **investigate whether the -rating- matters, but we will use a qualitative rating variable, so first let us generate it:

summarize rating, detail
generate rating_quali = "low" if rating <= 3.5
replace rating_quali = "moderate" if rating > 3.5 & rating < 4.5
replace rating_quali = "high" if rating >= 4.5
tabulate rating_quali, missing
  
* need a quantified version of this variable, so encode it:
  
encode rating_quali, gen(rating_quali_num)
	 
* 1) Generating the dummies and the include them in the regression model

tabulate rating_quali, gen(drating_quali)

regress price distance drating_quali*
  
regress price distance i.rating_quali_num

* show the reference category in the output table:
  
set showbaselevels on
regress price distance i.rating_quali_num

*set the reference category (let it be the moderate rating, coded as 2)...
  
regress price distance b2.rating_quali_num


*Including interaction terms in the regression models

tab offer_cat, missing

* Ia string variable, so encode it:

encode offer_cat, gen(offer_cat_num)

* The interaction:
regress price distance rating_quali_num##offer_cat_num

* 2) Categorical by continuous interactions

regress price distance rating_quali_num##c.stars

* 3) Continuous by continuous interactions
regress price distance c.rating##c.stars /*We use the original -rating- variable here.*/

*************** Robust standard errors

regress price distance, vce(robust)


*************** The lowess non-parametric regression

lowess price distance , bwidth(0.8)
