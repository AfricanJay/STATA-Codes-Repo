**Still working with the dataset from the previous file "datawrangling.do"

browse
  
^^this just lets you explore the dataset. 

  /* Observations (in this case, the hotels) are stored in the rows.Variables (-hotel_id-, -country- etc.) are stored in the columns.

	 Black color means that the values are numerical (numbers).
	* Red means that values are stored as strings. Sometimes, a numerical can be black, meaning that it is stored
 as a string, eg the rating column. You will learn how to do this later
	In fact a third color can also appear: blue, which means numerical content with some labels.*/

  describe

  ^^^^this command is used to simply have a quick overview of the dataset. shows us the number of observations, 
 /* variables, and other important info. 
 You can see some pieces of information about the variables. The most important ones are the following: name, storage type, labels, etc

  Sorting and arranging the data
**You can very easily sort your dataset using the variables

*** Suppose that we would like to see the hotels sorted by their user ratings, so:
sort rating
*** Check the browse window. Or, you can also type 'describe', and check the bottom of the table.

*** If we would like to sort in a descending order, we should type
gsort- rating
*** Check again the browse window.

*** We are focusing on -rating- now, so why not moving it to the first column?
order rating
*** Check the browse window again, and as you can see that -rating- is in the first column.

*** Note: We can use more than one variable as well with 'sort', 'gsort-', and 'order'.
