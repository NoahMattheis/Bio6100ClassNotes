# Going over Loops/For Loops/ While Loops
# NWKM
# 2/18/2025

# For Loops can be slow in R, especially when using functions like cbind in a loop
# R is a language that doesn't need to rely on them too much
# So why do we use them? Comfort, ease of transfer to other languages, sometimes easier to read, and sometimes laziness


# BASIC ANATOMY OF FOR LOOP
# for (var in seq) { start of for loop
#
#   body of for loop
#
# } end of for loop

# Good rule of thumb - Use i, j, or k for the var of loop
# This way, we know if we are using these counter variables, we know we are in a loop
# Common etiquette across other languages as well, like Java and Python

# General way to set up for loops
for (i in 1:5) { # initializes loop will iterate 5 times
  cat("stuck in a loop", "\n") # First will print/concatenate this line
  cat(3 + 2, "\n") # then will do this arithmetic
  cat(runif(1), "\n") # then will create a rand unif number
} # Loop will run 5 times, as we specified, before it is finished

# For loops can also iniate/reassign values
z <- 0
for (i in 1:5) { # initializes loop will iterate 5 times
  z <- z + i
  print(z)
}

# For loop with iterations based on vector length
my_dogs <- c('chow', 'puggle', 'pug', 'st bernard', 'husky') # Creates vector of strings
for (i in 1:length(my_dogs)) { # i will iterate first slot of vector to end of vector
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}

# Using NULL, showing length of this vector
my_bad_dogs <- NULL
for (i in 1:length(my_bad_dogs)) {
  cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")
} # Code has 2 print outs, because we declared it to run at 1, but NULL is = 0, so it counts back to 0

# Same as first for loop with my_dogs
for (i in seq_along(my_dogs)) { #seq_along creates sequence following length of vector
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}

# Prints out nothing, compared to 2 print outs
for (i in seq_along(my_bad_dogs)) {
  cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")
}

# Using seq_len for loop range
zz <- 5
for (i in seq_len(zz)) {
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}

for (i in length(my_dogs)) {
  my_dogs[i] <- toupper(my_dogs[i])
  cat("i =", i, "my_dogs =", my_dogs[i], "\n")
}

my_dogs <- tolower(my_dogs)
my_dogs <- toupper(my_dogs)
my_dogs


my_dat <- runif(1)
for (i in 2:10) {
  temp <- runif(1)
  my_dat <- c(my_dat, temp)
  cat("loop number =", i, "vector_element =", my_dat[i], "\n")
}
length(my_dat)


# Don't write a loop if operation can be vectorized

# Just a reminder of division
16/5
16 %% 5
16 %/% 5 # returns how many times following number can divide into first number


# What if we want to only work with odd-numbered elements?
# %% is used to return remainder after division
# Using i %% 2==0, were saying if the remainder equals 0, i.e. is divisible by 2
# we skip it using 'next',which takes us back to beginning of loop
z <- 1:20
for(i in 1:length(z)) {
  if(i %% 2==0) next
  print(i)
}

# Same loop but now returning even numbers
z <- 1:20
for(i in 1:length(z)) {
  if(i %% 2==1) next
  print(i)
}

# Using != will skip if division DOES NOT EQUAL 0
z <- 1:20
for(i in 1:length(z)) {
  if(i %% 2!=0) next
  print(i)
}

# Do we need a loop for this in R?
# NO
# Returning all odd elements with no loop
z <- 1:20
zsub <- z[z %% 2 != 0] # Give me elements of z that are not divisible by 2
length(zsub)
zsub

z <- 1:20
zsub <- z[z %% 2 == 0] # Give me elements of z that are divisible by 2
length(zsub)
zsub

# TIP: Always look for vectorizing shortcuts to avoid loops if possible

# But now, back to loops :D

for (i in seq_along(zsub)) {
  cat("i =", i,"zub[i] " ,zsub[i], "\n")
}

# Using the break function now in for loops to stop loops
# Random walk example in next code
# Using double for loop - loop de loop
# for test matrices, want them modularly sized and avoid square matrices if possible
# So first, looping over rows
m <- matrix(round(runif(20), digits = 2), nrow =5)
# looping over rows
for (i in 1:nrow(m)) { #could use for (i in seq_len(nrow(m)))
  m[i,] <- m[i,] + 1
}
print(m)

# now looping over columns <- switched i with j, this will help with syntax and code reading
for (j in 1:ncol(m)) { #could use for (i in seq_len(ncol(m)))
  m[,j] <- m[,j] + 1
}
print(m)

# Now building a double for-loop, or nested for-loop
m <- matrix(round(runif(20), digits = 2), nrow =5)
for (i in 1:nrow(m)) {
  for (k in 1:ncol(m)) {
    m[i,j] <- m[i,j] + i + j # taking number and adding values to it

  } # end of j loop
} # end of i loop
print(m)


# Creating function to sweep over parameters <- from ecology
# Function: Species area curve <- S = cA^z
# Creates power function relationship for S and A
# input:  A is a vector of island areas
#         c is the intercept constant
#         z is the slope constant
# output: S is a vector of species richness values
#
#
# ----------------------------------------------------------

species_area_curve <- function(A=1:5000, c = 0.5, z = 0.26) {
  S <- c*(A^z)
  return(S)
}
# Using head function, returns first 6 elements
head(species_area_curve())

# Creating Second function for plotting
#
# function: species_area_plot
# plot species area curves with parameter values
# input: A = vector of areas
#        c = single value for c parameter
#        z = single value for z paremeter
#
# output: smoothed curve with parameters in graph
# -----------------------------------------------
# Also examples of using functions within functions

species_area_plot <- function(A=1:5000, c = 0.5, z = 0.26) {
  plot(x = A, species_area_curve(A,c,z),
       type = "l",
       xlab = "Island Area",
       ylab = "S",
       ylim=c(0,2500))
  mtext(paste("c =", c, "z = ", z), cex = 0.7) # This code will put z and c values on top of graphs when called
  # return()

}
species_area_plot()

# global vairables <- often called at beginning of code
c_pars <- c(100, 150, 175)
z_pars <- c(0.10, 0.16, 0.26, 0.3)
par(mfrow=c(3,4)) # mfrow calls to graphics display, unique to base R graphics
# This will be in a matrix structure and uses our previous function
for (i in seq_along(c_pars)) { # will jump over c_pars values
  for (j in seq_along(z_pars)) { # will jump over z_pars values
    species_area_plot(c=c_pars[i], z=z_pars[j]) # should in total make 12 passes through this and get a grid of 12 plots
  }
}

# Comparing For and While loops
# looping with for
# This is a good example of calculating something of unspecified length
# break will stop when end point is reached
cut_point <- 0.1
z <- NA
ran_data <- runif(100)
for (i in seq_along(ran_data)) {
  z <- ran_data[i]
  if (z < cut_point) break
}
print(z)
print(i)

# Similar to other languages, we will do a while loop
# looping with while
# in this example, we need to create a counter number, in this case cycle_number
cut_point <- 0.1
z <- NA
cycle_number <- 0
# if z = NA OR z is greater than or equal to cut_point, which is 0.1
# loop will continue to run
# loop will stop when z is less than the cut_point or is NA
# instead of printing out loop number, since we do not have one, we print out cycle_number
# Though, while loops are generally bad practice - for loops are generally better form
# Worst part of while loop - unsure if it will ever end - I.E. it could never meet criteria then go on forever - no good
# for example, if cut_point is something so low like 0.00001, it could run for a while
# no pun intended
while (is.na(z) | z >= cut_point) {
  z <- runif(1)
  cycle_number <- cycle_number + 1

}
print(z)
print(cycle_number)

# Now using the repeat function
# looping with repeat

z <- NA
cycle_number <- 0

repeat {
  z <- runif(1)
  cycle_number <- cycle_number + 1

  if (z <= cut_point) break
}
print(z)
print(cycle_number)

# add code for cycle number
# try setting limit to 0.001

#


# Expand grid function
# using c_pars and z_pars from earlier, lines 206 and 207
expand.grid(c_pars,z_pars)
# ^ This function automatically sets up variables and pairs up unique combination of the two inputted values
# c_pars is 3, z_pars is 4, so it gives us a data frame of 12 unique combinations

df <- expand.grid(x = c_pars, y = z_pars) # x can be replaced with column/variable name for first value, y can be replaced for second value and so on
# can be down with more than 2 values
df2 <- expand.grid(x = c_pars, y = z_pars, z = c_pars*2) # now 36 values, 3*4*3 = 36
df2
head(df) # Returns first 6 rows
str(df) # You can see, the structure of df is a data.frame
df


##################################################
# function: sa_output
# Summary stats for species-area power function
# input: vector of predicted species richness (right now random numeric value)
# output: list of max-min called sum_stats, coefficient of variation
#-------------------------------------------------
sa_output <- function(S=runif(10)) {

  sum_stats <- list(s_gain=max(S)-min(S),s_cv=sd(S)/mean(S)) # list of  first: max value of s - min of s,
  # then taking the standard deviation of s divided by the mean of s for second list value

  return(sum_stats)
}
sa_output() # list is 2 values

# Build program body with a single loop through
# the parameters in modelFrame

# Global variables, area vector, c_pars again, and z_pars
area <- 1:5000
c_pars <- c(100,150,175)
z_pars <- c(0.10, 0.16, 0.26, 0.3)

# set up model/data frame using expand.grid
model_frame <- expand.grid(c=c_pars,z=z_pars)
model_frame$s_gain <- NA # adding column called s_gain with values NA
model_frame$s_cv <- NA # adding column called s_cv with values NA
print(model_frame)


# cycle through model calculations - using multiple functions
# starting from 1 to number of rows from model_frame - in our case, 12 rows
# Replacing the values of NA from model_frame with our calculated values from
# our created functions
# Notice, by using our functions and expand.grid we made this one_dimensional looping
# keeps values associated with appropriate rows
for (i in 1:nrow(model_frame)) {

  # generate S vector
  # calling upon species_area_curve from earlier and creating a temp value
  # Using area vector from earlier which is 1 to 5000
  # model_frame[i,1] will take row i, col 1, which is our c_par, c
  # model_frame[i,2] will take row i, col 2, which is our z_par, z
  temp1 <- species_area_curve(A=area,
                              c=model_frame[i,1],
                              z=model_frame[i,2])
  # calculate output stats using our first temp value, creating a second temp value
  # temp2 <- sa_output(temp1) < could use temp2 but uneccessary
  # model_frame[i,c(3,4)] <- temp2
  # temp 2 is a list, and then were passing this list into a model_frame which we need   # to do since were passing in multiple columns into a data frame
  # pass results to columns in data frame
  model_frame[i,c(3,4)] <- sa_output(temp1)

}
print(model_frame)






# Parameter Sweeping Redux using ggplot to graph the data

# First, global variables for loops for data
area <- 1:5 #keep this very small initially
c_pars <- c(100,150,175)
z_pars <- c(0.10, 0.16, 0.26, 0.3)

# set up model frame, this time with col S that has values NA and we have col A
# model_frame will be 5 * 3 * 4 = 60 rows/combinations large
model_frame <- expand.grid(c=c_pars,z=z_pars,A=area)
model_frame$S <- NA
model_frame

# 2 dimensional for loop through the parameters and fill column S with SA function values
for (i in 1:length(c_pars)) {
  for (j in 1:length(z_pars)) {
    model_frame[model_frame$c==c_pars[i] & model_frame$z==z_pars[j],"S"] <-   species_area_curve(A=area,c=c_pars[i],z=z_pars[j])
  }
}
model_frame

# 1 dimensional for loop that assigns values of species_area_curve function to col S of model_frame, where the parameters for the function are the corresponding rows
# should be same values
# Real power of expand.grid <- goes through 3 columns for 1 row in one call
# Don't have to loop over parameters
for (i in 1:nrow(model_frame)) {
  model_frame[i,"S"] <- species_area_curve(A=model_frame$A[i],
                                           c=model_frame$c[i],
                                           z=model_frame$z[i])
}
print(model_frame) # check by printing a data frame with limited parameter values

# Now graphing this with ggplot, first - call upon ggplot2 - notice we dont need for-loops for this <- Abusing R's vectorization
library(ggplot2)

# assigning plot of data of model_frame to p1 then adding comparison/graph details using geom_line
# returns 12 graphs in one image
# geom_line <- geometric/image ggplot will make, in this case a line with:
# x axis is area (1,2,3,4,5), y value/axis is s (what we calculated)
# using facet_grid, our graphs are set up to show graphs for each c and z combination
# Therefore, 12 graphs
# don't need $ for referencing data.col names as we specified data in our p1 variable
p1 <- ggplot(data=model_frame)
p1 + geom_line(mapping= aes(x=A,y=S)) +
  facet_grid(c~z)

# returns 3 graphs, each graph has 4 lines (values from z) for each c, giving us 3 graphs
# Grouped by c values
# notice the change in facet_grid, now it is saying all z values for each c
p2 <- p1
p2 + geom_line(mapping=aes(x=A,y=S,group=z)) +
  facet_grid(.~c)

# returns 4 graphs, each graph has 3 lines (values from c) for each z, giving us 4 graphs
# Grouped by z values
# notice the change in facet_grid, now it is saying all c values for each z
p3 <- p1
p3 + geom_line(mapping=aes(x=A,y=S,group=c)) +
  facet_grid(z~.)
