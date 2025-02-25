# Working with Functions in R and creating user-defined Functions
# Noah WK Mattheis
# Feb 11 2025

# Examples of built in functions
# 3 pieces - Name, followed by (), and finally input into function

sum(3,2) # Name - sum, (), input is 3 and 2
3 + 2 # an opetation, but technically a function
'+'(3,2) # also a function

y <- 3
print(y)
'<-'(y,4)
print(y)
y

sd # if you use only the name of function, itll show the code
sd(c(3,2)) #concatenating the numbers into a vector for input to function
sd() # Calls function with default parameters, some work this way some do not


# User-defined functions and anatomy of them
# Recommend naming function a verb as it does something
functionName <- function(parX = defaultX,
                         parY = defaultY,
                         parZ = defaultZ) {
# Need open left bracket to define that following code is internal to this function
# This function will look for 3 inputs from the user, in this code we have defined these parameters to have default values if user does not supply values
# Think of methods in object oriented coding

# Now we are in Body of the function, lines of R code go here
# Can also call other functions within a function, create new functions, and create new variables with variable names that only live and work inside the function <- again, think of methods, good for needs of function

defaultX = 1
defaultY = 1
defaultZ = 1

z = defaultX+defaultY+defaultZ/3

return(z) # Needed for function to tell R what will be returned after function has ran
  # Could also be a lsit

}  # Specifies to R end of function code

# Prints body of function
functionName

functionName()

# Strategy for functions are to keep em simple and short - one function for one task
# Better to use multiple functions to get job done then one large function
# Too complex? Break it up
# Also good idea to provide default values for all function <- makes it easier to test
# Maybe make the defaults random to test different value, or static if you have idea of how it should work

# Function example with header notes/comments

###############################################
# FUNCTION: HardyWeinberg
# input: an allele freq p (0,1)
# ouput: p and the freq of the 3 genotypes -> AA, AB, and BB <- Vector
# ---------------------------------------------
HardyWeinberg <- function(p=runif(1)) {
  q <- 1 -p
  fAA <- p^2
  fAB <- p*q*2
  fBB <- q^2
  vec_out <- signif(c(p = p,
                      AA = fAA,
                      AB = fAB,
                      BB = fBB), digits = 3) # signif and digits are controlling significant figures and number of sig figs shown
  return(vec_out)
}

# Examples of different Outputs of Function created
HardyWeinberg

HardyWeinberg()

HardyWeinberg(0.5)

pp <- 0.66
HardyWeinberg(p=pp)
HardyWeinberg(pp)

HardyWeinberg(-0.1)

# Making a function using if statements included <- for error checks
# Good if function can only work between certain values or to catch other values and convert them for function use

###############################################
# FUNCTION: HardyWeinberg2
# input: an allele freq p (0,1)
# ouput: p and the freq of the 3 genotypes -> AA, AB, and BB <- Vector
# ---------------------------------------------
HardyWeinberg2 <- function(p=runif(1)) {
  if (p > 1.0 | p < 0) {
      return("Function failure: p must be 0 <= x <= 1")
  } # Our error check statement using if structure
   q <- 1 -p
  fAA <- p^2
  fAB <- p*q*2
  fBB <- q^2
  vec_out <- signif(c(p = p,
                      AA = fAA,
                      AB = fAB,
                      BB = fBB), digits = 3) # signif and digits are controlling significant figures and number of sig figs shown
  return(vec_out)
}

HardyWeinberg2(1.1)
HardyWeinberg2(-0.1)
HardyWeinberg2(0.5)

# Similar function, but for error catch were replacing return with stop
# This way if error happens - stop the code and return value declared

###############################################
# FUNCTION: HardyWeinberg3
# input: an allele freq p (0,1)
# ouput: p and the freq of the 3 genotypes -> AA, AB, and BB <- Vector
# ---------------------------------------------
HardyWeinberg3 <- function(p=runif(1)) {
  if (p > 1.0 | p < 0) {
    stop("Function failure: p must be 0 <= x <= 1")
  } # Our error check statement using if structure
  q <- 1 -p
  fAA <- p^2
  fAB <- p*q*2
  fBB <- q^2
  vec_out <- signif(c(p = p,
                      AA = fAA,
                      AB = fAB,
                      BB = fBB), digits = 3) # signif and digits are controlling significant figures and number of sig figs shown
  return(vec_out)
}

HardyWeinberg3()
HardyWeinberg3(1.1)

# Can also save function values as variables
z <- HardyWeinberg()
zz <- HardyWeinberg2(1.1)
zzz <- HardyWeinberg3(1.1)

z
zz
zzz
