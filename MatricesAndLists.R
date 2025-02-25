# Matrices and Lists
# 4 Feb 2025
# Noah WK Mattheis

# Matrix is an ATOMIC VECTOR that is organized into ROWS and COLUMNS
# Like an A.V., all elements must be of the same data type

# Starting with a vector
my_vec <- 1:12
m <- matrix(data = my_vec, nrow = 4) # When specifying, must specify either col or rows or both, and number of elements must be equally divisible by these values or R has a problem
print(m) # We get matrix of 4 rows, will values 1 through 12, going from 1 in top left and counting down the columns

m <- matrix(data = my_vec, ncol = 3)
print(m)

m <- matrix(data = my_vec, ncol = 3, byrow = TRUE) # Using byrow = TRUE, values fill from left to right instead of up to down - default set to FALSE
print(m)



# Lists are also Atomic Vectors but elements in list can be different, can hold different
# data types and different sizes of elements

my_list <- list(1:10,
                matrix(1:8, nrow = 4, byrow = TRUE),
                letters[1:3],
                pi) # 1st item is a vector of 1 through 10, 2nd item in list is a matrix, 3rd is a vector of letters, 4th is pi
str(my_list)
print(my_list) # The double bracket numbers are the positions of elements


# Accessing elements of a list
my_list[4] # returns list component/reference to the list, not the exact element
my_list[4] - 3 # Cannot subtract a number from a list

my_list[[4]] # using [[]] we can specify we actually want the element of the list, not just a reference/sublist of our original list
my_list[[4]] - 3

# Can make a list of lists too if one is curious or desires

# If a list has 10 elemenets it's like a train with 10 cars, the [[]] of 5 ([[5]]) gives us the content of the fifth car, while [c(4,5,6)] gives us a little train with cars 4,5, and 6

my_list[[2]] # Returns 2nd in list
my_list[[2]][4,1] # Returns 2nd item in list, which is a matrix, and using matrix rules, returning the value of the 4th row, 1st column of the matrix


# Like Atomic Vectors, Lists/List elements can have names!
# Naming list items as they are created

my_list2 <- list(tester=FALSE, little_m=matrix(1:9, nrow=3))
my_list2
my_list2$little_m[2,3] # Uses $ then name of list object, following name of list. Here we also specify location of matrix element we want

# Data Frames under the hood of R are like Lists, that is why $ usage here may seem familiar

my_list2$little_m

#Returning values/full row/full col of matrix
my_list2$little_m[2,] # Leaving the space after the comma empty tells R to return all columns of the 2nd row, since we specifed row 2
my_list2$little_m[,2] # Similar to above, all rows of column 2 this time
# Subsetting this way creates an AV as its type of return
my_list2$little_m[,] # returns full matrix, similar to my_list2$little_m
my_list2$little_m[]
my_list2$little_m[2] # With only a single number provided, R will revert the matrix and treat it like atomic vector and returns the 2nd element in the vector, converts by going down the columns then across rows <- important to know
my_list2$little_m[4]

my_list3 <- list(tester=FALSE, little_m=matrix(1:9, nrow=3, byrow = TRUE))
my_list3$little_m[2]

# The unlist function strings evertyhing back into a single AV; coercion is used if there are mixed data types
unrolled <- unlist(my_list2)
print(unrolled) # Remember from coercion hiearachy, BOOLEAN values get converted to 0 if FALSE, 1 if TRUE


# Most common use of List: Outpit from a linear model is a list

library(ggplot2)
y_var <-runif(10)
x_var <- runif(10)
my_model <- lm(y_var~x_var) # ~ means related to - y is a function of x
qplot(x=x_var, y=y_var)

# Look at output in my_model
print(my_model) # Returns basic formula info for linear model
print(summary(my_model)) # Returns a lot more info for linear model, summary function is based

# Do not copy the values off the screen for other variables - bad practice!!!!

str(summary(my_model)) # looks gross ya, but has good info, but luckily summary is normally a list, so treat it as such
summary(my_model)$coefficients
summary(my_model)$coefficients["x_var","Pr(>|t|)"] # Want element located at x_var and Pr(>|t|)

# Using unlist instead
summary(my_model)$coefficients[2,4]
summary(my_model)$coefficients[[2,4]]

u <- unlist(summary(my_model))
u

my_slope <- u$coefficients2
my_pval <- u$coefficients8
my_slope
my_pval

# All in all, a lot of times using STATS Functions in R will return Lists, so learn to use them for data retrieval and manipulation
# Data Frames are special Lists :D
# The AVs that make up Data Frames are of equal length

# Building up first data frame
# Hypothetical low nitrogren high nitrogen conc
var_a <- 1:12
var_b <- rep(c("Con", "LowN", "HighN"), each = 4)
var_c <- runif(12)
d_frame <- data.frame(var_a, var_b, var_c) # Instead of list function we use data.frame. Here you may notice some R inconsistency where older functions use periods and newer ones do not
print(d_frame)
str(d_frame)


# newData <- data.frame(list(varA=13,varB="HighN",varC=0.668),stringsAsFactors=FALSE)
new_data <- list(var_a=13,var_b="HighN",var_c=0.668)
print(new_data)
str(new_data)

# now bind them
d_frame <- rbind(d_frame,new_data)
str(d_frame)
tail(d_rame)


# adding another column is a little easier

#newVar <- data.frame(varD=runif(13))
new_var <- runif(13)
d_frame <- cbind(d_frame,new_var)
head(d_frame)

# create a matrix and data frame with same structures
z_mat <- matrix(data=1:30,ncol=3,byrow=TRUE)
z_dframe <- as.data.frame(z_mat) # coerce it

str(z_mat)    # an atomic vector with 2 dimensions
str(z_dframe) # note horizontal layout of variabes!

head(z_dframe) # note automatic variable names
head(z_mat) # note identical layout

# element referencing is the same in both
z_mat[3,3]
z_dframe[3,3]

# so is column referencing

z_mat[,3]
z_dframe[,3]
z_dframe$V3 # note use of $ and named variable column
# and row referencing
z_mat[3,]
z_dframe[3,] # note variable names and row number shown

# what happens if we reference only one dimension?

z_mat[2] # takes the second element of atomic vector (column fill)
z_dframe[2] # takes second atomic vector (= column) from list
z_dframe["V2"]
z_dframe$V2

# Eliminating Missing Values

# use complete.cases with atomic vector
zd <- runif(10)
zd[c(5,7)] <- NA
print(zd)

complete.cases(zd)

zd[complete.cases(zd)] # clean them out

which(!complete.cases(zd)) # find NA slots

# use with a matrix

m <- matrix(1:20,nrow=5)
m[1,1] <- NA
m[5,4] <- NA
print(m)

m[complete.cases(m),]

# now get complete cases for only certain columns!
m[complete.cases(m[,c(1,2)]),] # drops row 1
m[complete.cases(m[,c(2,3)]),] # no drops
m[complete.cases(m[,c(3,4)]),] # drops row 4
m[complete.cases(m[,c(1,4)]),] # drops 1&4


# Techniques for assignment and subsetting of matrices

# same principle applied to both dimensions of a matrix
m <- matrix(data=1:12,nrow=3)
dimnames(m) <- list(paste("Species",LETTERS[1:nrow(m)],sep=""),paste("Site",1:ncol(m),sep=""))
print(m)

# subsetting based on elements
m[1:2,3:4]
# same subsetting based on character strings (but no negative elements)
m[c("SpeciesA","SpeciesB"), c("Site3","Site4")]

# use blanks before or after comma to indicate full rows or columns
m[1:2, ]

m[ ,3:4]

# use logicals for more complex subsetting

# e.g. select all columns for which the totals are > 15

# first try this logical
colSums(m) > 15
m[ , colSums(m) > 15]


# e.g. select all rows for which the row total is 22
m[rowSums(m)==22, ]

# note == for logical equal and != for logical NOT equal
m[rowSums(m)!=22, ]

# e.g., choose all rows for which numbers for site 1 are less than 3
# AND choose all columns for which the numbers for species A are less than 5

# first, try out this logical for rows
m[ ,"Site1"]<3

# add this in and select with all columns
m[m[ ,"Site1"]<3, ]

# and try this logical for columns
m["SpeciesA", ]<5

# add this in and select with all rows
m[ ,m["SpeciesA", ]<5]

# now combine both
m[m[ ,"Site1"]<3,m["SpeciesA", ]<5]

# and compare with full m
print(m)


# caution! simple subscripting to a vector changes the data type!
z <- m[1, ]
print(z)
str(z)

# to keep this as a matrix, must add the drop=FALSE option

z2 <- m[1, ,drop=FALSE]
print(z2)
str(z2)

# caution #2, always use both dimensions, or you will select a single matrix element

m2 <- matrix(data=runif(9),nrow=3)
print(m2)
m2[2, ]

# but now this will just pull the second element
m2[2]

# probably should specify row and column indicators
m2[2,1]
# also use logicals for assignments, not just subsetting
m2[m2>0.6] <- NA
print(m2)


# A few changes for working with data frames:

data <-read.csv(file="antcountydata.csv",header=TRUE,sep=",")
str(data)

# the data frame is a list of vectors, so it is set up like a matrix
data[3,2]

# you can specify just the column names

data_names <- data[c("state","county")]
str(dataNames)

# or in matrix style
data_names <- data[ ,c("county", "ecoregion")]
str(data_names)


# as before, with matrices, selecting only a single column changes it
# from a data frame to a vector
data_names <- data[ ,"county"]
str(data_names)


# Importing Data Frames into R

# R skips # lines in data sheets like excel sheets or csv
# Allows us to comment middle of data set and good for Meta Data in data sheets
# We want the column headers as well
# 2 things should be same in data frames - good notes for research
# 1st column should be ID number - allows for unique identifier for each row
# Have last column be notes - detailed info for that particular row - does not need to always be propagated or filled in
# Also good to store data sets in private github repositories

# Code for reading in from a .csv file if data is in the same project
# if not in project need to give it a path name
my.data <- read.table(file="ToyData.csv",
                      header = TRUE,
                      sep = ",", # This is declaring the delimeter
                      comment.char = "#") # tells R to ignore # lines in .csv file
# Sometime this may mess up, make sure you have returned/have ending at end of data
# ^ Wow, terrible explanation, but if you dont see a spare line when viewing data in R, it might mess up

# Inspecting data
str(my.data)

# Adding a column
my.data$new.var <- runif(4)
head(my.data)
write.table(x = my.data,
            file = "SampleOutputFile.csv",
            sep = ",")

# Now that we have done this, note to the wise, do not do this
# we don't want a lot of .csv's, writing to csv can get messy
# Instead we can use saveRDS <- compressible file only read in R

saveRDS(my.data,
        file = "my_data.RDS") #.RDS not required but good for clarity when reading code
# Now that it is saved as an RDS we need to restore it
restored_my.data <- readRDS("my_data.RDS")
str(restored_my.data)
