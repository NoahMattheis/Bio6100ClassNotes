# Noah Mattheis
# Atomic Vectors
# Introduction to R Scripts
# 28, Jan, 2025

# Using the Assignment Operator
x <- 5 # Preferred way of variable assignment
y = 4 # Also true but not used except in function defaults
y = y + 1.1
print(y)
y <- y + 1.1
print(y)


# Variable Names
z <- 3
plantHeight <- 10 # Option - 'camelCaseFormatting'
plant.height <- 4.2 # Avoid periods in names, think of methods/functions, still works in R
plant_height <- 3.3 # Optimal 'snake_case_formating', apparently easiest to read
. <- 5.5 # Reserve period as a generic temporary variable
print(.)


# Using the Combine Function
z <- c(3.2, 5, 5, 6) # c-function means combine or concatenate
print(z)
typeof(z) # Prints out variable storage type
is.numeric(z) # is functions return TRUE or FALSE


# Functions within Functions
# c() always "flattens" to an atomic vector
z <- c(c(3,4), c(5,6))
print(z)

# Creating character string variables as well, single or double quotes used
z <- c("perch", "bass", 'trout')
print(z)
typeof(z)

# Using both with internal quote
z <- c("This is only 'one' character string", 'a second')
print(z)
typeof(z)
is.character(z)

# Logical variables/functions
# Boolean, not with quotes, all caps
z <- c(TRUE, TRUE, TRUE)
# avoid abreviations T, F which do work
print(z)
typeof(z)
is.logical(z)
is.integer(z)



# Vectors
# Every vector has type associated with it
z <- c(1.1, 1.2, 3, 4)
typeof(z)
is.numeric(z)
z <- as.character(z) # coercing R to turn variable into certain type, need to specify/declare it onto a variable
print(z)
typeof(z)
# First property, type
# Second property, length
length(z) # gives number of elements
length(a) # Should give error as this variable has not been defined or initiated


# Names for individual elements insides Atomic Variable
z <- runif(5)
#optional attribute not initally assigned
names(z)
print(z)

# add names later after variable is created
z <- runif(5)
names(z) <- c("chow", "pug", "beagle", "greyhound", "akita")
print(z)

# Recalling a particular element in a vector/matrix, starts at 1, or call on name directly if it is there
print(z[2])
print(z["pug"])

# Building vector with names at same-time/beginning of variable declaration
z2 <- c(gold=3.3, silver = 10, lead = 2)
print(z2)

# Reset Names
names(z2) <- NULL
print(z2)

# Names added for select elements, do not need to be distinct names
names(z2) <- c("copper", "zinc")
print(z2)

# NA Values for missing data, R knows how to handle NA
z <- c(3.2, 3.3, NA) # NA is missing value
typeof(z)
length(z)
typeof(z[3]) # Even though value is missing, NA is still a double
print(z)

# NA can have different types
z1 <- NA
typeof(z1)


print(z)
is.na(z) # Logical operator to find missing values
mean(z)  # won't work because of missing value/NA
is.na(z) # evaluate to find missing values
!is.na(z) # Use ! for NOT missing values or NOT function
mean(!is.na(z)) # Wrong answer based on TRUE FALSE i.e. the TRUE and FALSE get converted to 1 and 0 respectfully, which is why we get 0.667 as (1 + 1 + 0)/3 = 0.667
mean(z[!is.na(z)]) # Correct indexing for mean to calculate and exclude the missing variables


# Common variables to see when doing calculations
# NaN, -Inf, and Inf from division
z <- 0/0 #NaN
typeof(z)
print(z)
z <- 1/0 # Inf
print(z)
z <- -1/0 # -Inf
print(z)


# NULL is an object that is nothing (paradox Ceasar-chan)
# a reserved word in R
z <- NULL
typeof(z)
length(z)
is.null(z) # only operation that works on NULL

# Property 1
# Variable Coercion - used when variables have different data types
# R operates on a hierarchy of values
# Logical -> Integer -> Double -> Character with Characters at the top and logical at bottom
# So if I have a logical mixed with character, will be converted to character
# This is why a lot of the time we do column titles and column info separately
a <- c(2, 2.0)
print(a)
typeof(a) # Technically integer coerced to double
b <- c("purple", "green")
typeof(b)
print(b)

d <- c(a,b)
print(d)
typeof(d)

# Mistakes in numerical variables convert to strings
# Useful when working with logical variables
a <- runif(10)
print(a)


# Comparsion Operators yield Logical Results
a > 0.5 # Asking R, is a > 0.5, and since a is a list it will return when this is TRUE or FALSE

# Doing previous statement using variable coercion
# How many elements are greater than 0.5?
sum(a > 0.5) # coercing TRUE and FALSE into integers of 1 and 0 then doing the math

# What proportion of the vector elements are greater than 0.5
mean(a > 0.5)

# Breakdown the result
. <- a > 0.5
print(.)
. <- as.integer(.)
print(.)
print(sum(.))
print(mean(.))

mean(rnorm(100000) > 2)


# Property 2 - Vectorization
# Adding a constant to vector
z <- c(10, 20, 30)
z + 1 # action added to each number in vector

# What happens when vectors are added?
y <- c(1,2,3)
z + y # Like with matrix work, element by element operation when adding vectors

z^2 # squares each element in the vector, element by element


# What happens when vectors are not the same length?
# Property 3 - Recycling
z <- c(10,20,30)
x <- c(1,2)
z + x # Recycles first element of x to add to last element of z
y <- c(10,20,30,40)
y + x # Recycles first element for pos 3, then recycles second element for pos 4

