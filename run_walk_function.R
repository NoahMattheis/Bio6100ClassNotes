# Random walk example
# NWKM
# 2/20/2025
#
# FUNCTION: ran_walk
# stochastic random walk
# input: times = number of time steps
#         n1 = initial population size (= n[1])
#         lambda = finite rate of increase
#         noise_sd = sd of a normal distribution with mean 0
# output: vector n with population size > 0
#         until extinction, then NA
#
# if lamda = 1.0, there will be no change in time step
# if lamda = 1.1, there will be a 10% increase each time step
# if lamda = 0.98, there will be a 2% decrease each time step
#
# if lamda is > 1, we have a living organism
#
# with stochastic, each time step can be up or down, but on average
# will be 0 due to normal distribution
# will keep track of what happens until we hit 0
# in terms of real population, thats extinction <- this is where break comes into play
# ------------------------------------------------------------------------------------


library(ggplot2)
ran_walk <- function(times=100,
                     n1=50,
                     lamda = 1.00,
                     noise_sd = 10) {
  n <- rep(NA, times) # create output vector
  n[1] <- n1 # initial population size
  noise <- rnorm(n = times, mean = 0, sd = noise_sd) # create noise vector
  # on average, noise should be 0 but some will be pos and some will be neg
  for(i in 1:(times-1)) {
    n[i+1] <- lamda*n[i] + noise[i]
   if(n[i + 1] <= 0) {
      n[i + 1] <- NA
      cat("Population extinction at time", i+1, "\n")
      break
    }
  }
  return(n)
}

# Testing ran_walk() function
# This function is an example of something that needs to be done in a for-loop
# do we want stop instead of break?
ran_walk()

# Using qplot <- but it was deprecated in 3.4.0 so be careful
qplot(x = 1:100, y=ran_walk(), geom="line")
# The NAs help us keep x-axis at 100

# Now, time for test cases - o boy
qplot(x = 1:100, y=ran_walk(noise_sd=0), geom="line")
# Checking our math, we see setting noise to 0 we get no change
# i.e. population stays stable

# now testing growth
qplot(x = 1:100, y=ran_walk(noise_sd = 0, lamda = 1.1), geom="line")
# As we see, exponential growth, now lets see decay
qplot(x = 1:100, y=ran_walk(noise_sd = 0, lamda = 0.98), geom="line")

# Pure white noise
qplot(x = 1:100, y=rnorm(n = 100, mean = 50), geom="line")

# Could use round() function to keep integers
# for sexual reproduction, what if all same sex? use unisexExtinct == runif(1) <= 2*(0.5)^n
# environmental noise not random walk -- add rnorm(0,1)
# measurement error -- add rnorm(0,1) for 0's w/o extinction

