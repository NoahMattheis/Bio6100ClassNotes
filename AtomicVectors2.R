# Atomic Vectors 2
# Jan 30 2025
# Noah WK Mattheis

#Create an empty vector, specify mode and length)
z <- vector(mode='numeric', length=0)
print(z)

# Adding elements to vector
# Not recommended way to build a vector, its slow
# DYNAMIC SIZING IS SLOW, poor memory management
z <- c(z,5)
print(z)

# Number before comma - what you want in the vector
# Number after comma - number of elements specified
z <- rep(0,100)
# Returns first 6 elements
head(z)


# Be careful of doing this as zero can have multiple meanings depending on function
# Did we put it in or did function = 0?
# Instead use NA Values
z <-rep(NA, 100)
head(z)

# But what type is NA?
typeof(z)

# Direct assignment of vector location and value
z[1] <- 'Washington'
head(z)
typeof(z)

# Notice it now coerces the type of z and NA to be character, due to data hierarchy

typeof(z[3])



# Creating Large vectors

# Initiate a vector of random values, 0 to 1
my_vector <- runif(100)
# Returns last six elements of vector
tail(my_vector)

# paste will paste the name given to given vector/location
# seq - make a sequence starting at 1 and going to length of specified vector
# this way the code is general enough to work with other vectors
# This line will give a new vector names my_names that will have SpeciesX in each cell
# Where X = 1 through length of vector
# Sep will separate text with given character, here we give no space so it is SpeciesX and not Species X
my_names <- paste('Species', seq(1:length(my_vector)), sep='')
# Combines vectors, matching it pos1 to pos1
names(my_vector) <- my_names
head(my_names)
head(my_vector)
str(my_vector)



# rep for repeating elements
rep(0.5,6) # give the element (or vector) and number of times to repeat
rep(x = 0.5, times = 6) # Same as above with argument names
rep(times = 6, x = 0.5) # Order does not matter
my_vec <- c(1,2,3) # Concatanate 1, 2, and 3 to a new vector called my_vec
rep(x = my_vec, times  = 2) # Applies to entire vector, repeats vector twice
rep(x = my_vec, each = 2) # Repeat each element in vector individually
rep(x = my_vec, times = my_vec) # Repeats the elements matching pair wise
# So pos1 will be repeated pos1 times, pos2 will be repeated pos2 times, and pos3 will
# be repeated pos3 times
rep(x = my_vec, each = my_vec) # Gives warning message, uses the first element of each
# So in this case, first element of my_vec is 1, so it is reading it as each = 1
# times can be multiple numbers, each can only and exclusively be a single number


# Using the seq function for number sequences
seq(from = 2, to = 4) # set limits for integer sequence
2:4 # equivalent to seq function w/o the words
`:`(2,4) # also works same way
seq(from=2, to=4, by=0.5) # Changing count/steps in seq from 1 to 0.5
seq(from=2, to=4, by=0.67) # will do its best to fit length but not go over end limit
x <- seq(from=2, to=4, length=7) # Sometimes easier to specify number of elements
print(x) # will count equal number between elements based on length
my_vec <- 1:length(x) # commonly used but actually slow, but also easier to read
print(my_vec)
seq_along(my_vec) # faster for models and big data!
# seq_along will take vector and provide integer value going length of sequence
seq_len(5) # faster comp time than 1:5


# Random number generator, ahhh good ol rando data sets, reminds me of UMD
# For future self, include how to set a seed too
# Our boys rnorm and runif, meaning random normal distribution or random uniform distribution
# These are continuous with real number boundaries
runif(5) # displays five rando uni numbers between 0 and 1
runif(n=3, min=100, max=101) # three rando uni values between 100 and 101
runif(n=4,
      min=50,
      max = 100) # R is good at reading splits using commas between new lines
  # ^^^^ Useful for other things like GGPlot ^^^^^

rnorm(6) # six rando norm numbers with mean = 0 and standard deviation = 1
rnorm(n=5, mean = 100, sd = 30) # five rando norm numbers, mean = 100, standard deviation = 30


# Exploring sampling distributions by sampling and plotting
# GGPlot likes DataFrame types of data
library(ggplot2) # Do this at start of code normally
z <- runif(1000) # default uniform (0,1)
qplot(x=z) # Will plot a column chart showing distribution of values from z
z <- rnorm(1000) #default normal (0,1)
qplot(x = z) # Will plot a column chart showing distribution of values from z

z <- rnorm(10)
qplot(x=z)

z <- rnorm(100000)
qplot(x = z) # Pretty much showing law of normality with large numbers


# Using sample to draw random values into existing vector
long_vec <- seq_len(10) # gives me a seq from 1 to 10 in a vector
typeof(long_vec)
str(long_vec) # Will give info of vector, like type and length and elements

sample(x=long_vec) # with no other params, reorders the vector
sample(x=long_vec, size =3) # will return three values from the vector long_vec, no replacement here
# Now keep in mind, are we sample WITH or WITHOUT Replacement?
sample(x=long_vec, size = 11) # Returns error, can do without replacement with a size greater than our given options
sample(x=long_vec, size = 16, replace = TRUE) # generates duplicates and more elements then in given vector due to the size argument, with replacement
# replace is default set to false


# Right now when we sample, everything is given equal consideration for sample/replace
# There is a way to give some more "weights" to certain values, making them more likely to appear
# Weights cannot be zero or negative, have to be positive
my_weights <- c(rep(20,5), rep(100,5)) # create a set of non-zero positive weights
# integer or real
print(my_weights) # will give weights more towards higher values by our example
# If weights had identical values, it would be same chance no weight
sample(x=long_vec, replace = TRUE, prob=my_weights) # Sampling with replacement and weights
sample(x=long_vec, replace = FALSE, prob=my_weights) # Sampling without replacement and with weights
sample(x=long_vec, replace=TRUE, prob=long_vec) # the vector elements themselves will determine probability
# I.E. 10 should show up 10 times more likely than 1, 7 will be 7 times more likely


# IMPORTANT SKILL ALERT
# Subsetting an atomic vector <- based skill
z <- c(3.1, 9.2, 1.3, 0.4, 7.5)

# Positive index values
z[c(2,3)] # indicate variable z, brackets represent were looking at elements, and here we have a vector saying we want the second and third element

# Negative index values
z[-c(2,3)] # Return everything but values in the second and third positions


# Create a vector of logical elements to select conditions
z[z<3] # returns values of z that are less than 3, will go one at a time

# Will provide same thing, but tester is a vector of boolean type with TRUE and FALSE at specific locations
tester <- z<3
print(tester)
z[tester]

which(z<3) # returns which positions of vector where statment z < 3 is true

z[which(z<3)] # returns same as z[z<3] but sometimes will be diff

z[-(length(z):(length(z)-2))] # negative of 5 to 3, so we get elements in pos 1 and 2
# The negative at the beginning means work from the end and strip out from end

# Assigns names for each element in vector, can return specific elements by name
names(z) <- letters[1:5]
print(z)
z[c("b","c")]

## Logical Symbols and Operators
# < Less Than
# > Greatert Than
# <= LT or Equal To
# >= GT or Equal To
# == Equal To (Boolean)
# ! Not
# & and (Atomic Vectors)
# | Or (Atomic Vectors) -- Think of Logical reasoning for these, TRUE if one is true
# xor (X,Y) -- works if one of the statements is true, like logical reasoning, but not BOTH - exclusively one can be true

x <- 1:5
y <- c(1:3,7,7)

# Results will be vector of Booleans - True or False values
x == 2
x != 2
x == y
x != y

# Will return TRUE if both conditions are true, FALSE if not for and
x == 1 & y == 7
x == 5 & y == 7
x == 1 | y == 7
x == 3 | y == 3
xor(x == 3, y == 3)
xor(x == 1, y == 4)

# common errors that can happen
# = vs. ==
z2 <- 5
z2 == 4 | 6 # Gives wrong answer, comes back TRUE
z2 == 4 | z2 == 6 # Complete and proper boolean statement on each side of comparison


# Subscripting with missing values
z <- runif(10) # simple integer sequence
print(z)
set.seed(90)
z <- runif(10) # simple integer sequence, setting seed before calling it will make it call the same numbers everytime - good for repeatable research
print(z)

z < 0.5 # creates logical vector
z[z < 0.5] # use as index call, discards FALSE elements and returns TRUE ones
which(z < 0.5) # Gives position/locations of the TRUE elements
z[which(z < 0.5)] # same result as line 224

zD <- c(z, NA, NA) # Contaminate data with NA
print(zD)
zD[zD < 0.5] # NA values carried along
zD[which(zD < 0.5)] # NA Values Dropped
