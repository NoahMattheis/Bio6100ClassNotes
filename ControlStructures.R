# Control Structures 1
# NWKM
# 2/18/2025

# Simple inequalities
5 > 3
5 < 3
5 >= 5
5 <= 5
5 == 3
5 != 3

# use & for AND
FALSE & FALSE
FALSE & TRUE
TRUE & TRUE
5 > 3 & 1!=2
1==2 & 1!=2

# use | for OR
FALSE | FALSE
FALSE | TRUE
TRUE | TRUE
1==2 | 1!=2

# works with vectors

1:5 > 3

a <- 1:10
b <- 10:1

a > 4 & b > 4

# use "long form" to evaluate left to write until a the first true/false is evaluated

# evaluates all elements and gives a vector of results
a < 4 & b > 4

# evaluates until the first logical result is created
a < 4 && b > 4

# similar format for "long form" for OR

# vector result
a < 4 | b > 4

# single result
a < 4 || b > 4


# xor for exclusive or testing of vectors
# works for (TRUE FALSE) but not (FALSE FALSE) or (TRUE TRUE)
xor(FALSE,FALSE)
xor(FALSE,TRUE)
xor(TRUE,TRUE)
a <- c(0,0,1)
b <- c(0,1,1)
xor(a,b)

# compare with a | b
# works for (TRUE FALSE) or (TRUE TRUE)
a | b

# if (condition) {expression1}

# if (condition) {expression1} else {expression2}

# if (condition1) {expression1} else
# if (condition2) {expression2} else

# note that final unspecified else captures rest of the (unspecified) conditions
# else statement must appear on the same line as the expression
# typically enclose multiple statements in brackets {} for compound expression


z <- signif(runif(1),digits=2)
print(z)
z > 0.5
if (z > 0.5) cat(z, "is a bigger than average number","\n")

if (z > 0.8) cat(z,"is a large number","\n") else
  if (z < 0.2) cat(z,"is a small number","\n") else
  {cat(z,"is a number of typical size","\n")
    cat("z^2 =",z^2,"\n")}

# if statement requires a single logical value. With a vector,
# it will assign TRUE/FALSE based on very first element only.

z <- 1:10

# this does not do anything
if (z > 7) print(z)

# probably not what you want
if (length(z) > 7) print(z)

# use subsetting!
print(z[z < 7])

# ifelse(test,yes,no)

# test is an object that can be coerced to a logical yes/no
# yes return values for true elements of test
# no return vales for false elements of test

# Hypothetical
# Suppose we have an insect population in which each female lays, on average, 10.2 eggs, following a Poisson distribution with λ=10.2
# However, there is a 35% chance of parasitism, in which case no eggs are laid. Here is the distribution of eggs laid for 1000 individuals:

tester <- runif(1000) # start with random uniform elements
eggs <- ifelse(tester>0.35,rpois(n=1000,lambda=10.2),0) # Using ifelse, the values greater than 0.35 will be given a random poison distribution, while those not > 0.35 will be assigned the value 0
hist(eggs)


# Suppose we have a vector of p values (say from a simulation), and we want to create a vector to highlight the significant ones for plotting purposes.

pVals <- runif(1000)
z <- ifelse(pVals<=0.025,"lowerTail","nonSig")
z[pVals>=0.975] <- "upperTail"
table(z)

# Cleaner way to do this: saves time in calculations
z1 <- rep("nonSig",1000)
z1[pVals<=0.025] <- "lowerTail"
z1[pVals>=0.975] <- "upperTail"
table(z1)


