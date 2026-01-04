# ============================================================================
# Week 1 In-Class Exercise: R Basics and Pattern-Book Functions
# Calculus I - Functions, Computing & Pattern-Book Functions
# ============================================================================

# This script walks through:
# 1. Basic R features: Variables, functions, and data types
# 2. The mosaicCalc package: Creating and working with mathematical functions
# 3. Pattern-book functions: Defining and visualizing the nine basic functions
# 4. Function properties: Exploring domain, range, and behavior

# ============================================================================
# PART 1: R BASICS
# ============================================================================

# ----------------------------------------------------------------------------
# 1.1 Variables and Assignment
# ----------------------------------------------------------------------------

# In R, we use <- (or =) to assign values to variables
# Assign a number to a variable
x <- 5
x

# Assign text (a "string")
name <- "Calculus"
name

# Assign multiple values (a vector)
numbers <- c(1, 2, 3, 4, 5)
numbers

# Key point: In R, <- is the assignment operator. The = sign also works, 
# but <- is more traditional in R.

# ----------------------------------------------------------------------------
# 1.2 Basic Arithmetic
# ----------------------------------------------------------------------------

# R can do all the standard mathematical operations
3 + 2        # Addition
10 - 4       # Subtraction
3 * 4        # Multiplication (note: must use *)
15 / 3       # Division
2^3          # Exponentiation (use ^, not superscript)
sqrt(16)     # Square root
log(10)      # Natural logarithm (this is ln(10) in math notation)
exp(1)       # Exponential function (this is e^1)

# Important: In R, multiplication must always be indicated with *.
# You cannot write 3x; you must write 3*x.

# ----------------------------------------------------------------------------
# 1.3 Functions in R
# ----------------------------------------------------------------------------

# R has many built-in functions. Functions are called using parentheses:
abs(-5)                    # Absolute value
round(3.14159, 2)          # Round to 2 decimal places
max(c(1, 5, 3, 9))         # Maximum value
min(c(1, 5, 3, 9))         # Minimum value

# ----------------------------------------------------------------------------
# 1.4 Creating Sequences
# ----------------------------------------------------------------------------

# We often need sequences of numbers for plotting
seq(0, 10, by = 1)         # Create a sequence from 0 to 10
0:10                        # Shorthand: 0:10
seq(0, 10, by = 0.5)        # Sequence with different step size
seq(0, 10, length.out = 50) # Sequence with specific number of points

# ============================================================================
# PART 2: INSTALLING AND LOADING mosaicCalc
# ============================================================================

# ----------------------------------------------------------------------------
# 2.1 Install the Package (One Time Only)
# ----------------------------------------------------------------------------

# Run this once to install (uncomment if needed)
# install.packages("mosaicCalc")

# ----------------------------------------------------------------------------
# 2.2 Load the Package
# ----------------------------------------------------------------------------

# Every time you start R, you need to load the package
library(mosaicCalc)

# Key point: You must run library(mosaicCalc) at the start of every R 
# session where you want to use it.

# ============================================================================
# PART 3: CREATING MATHEMATICAL FUNCTIONS WITH makeFun()
# ============================================================================

# ----------------------------------------------------------------------------
# 3.1 Basic Function Creation
# ----------------------------------------------------------------------------

# The makeFun() function creates mathematical functions from formulas.
# The syntax uses a tilde (~)

# Create a simple linear function: f(x) = 2x + 3
f <- makeFun(2*x + 3 ~ x)
f

# Evaluate the function at x = 5
f(5)

# Evaluate at multiple points
f(c(0, 1, 2, 3, 4, 5))

# Key syntax: makeFun(formula ~ variable)
# - Left side of ~: the formula
# - Right side of ~: the input variable(s)

# ----------------------------------------------------------------------------
# 3.2 Functions with Parameters
# ----------------------------------------------------------------------------

# We can create functions with parameters
# Create a linear function with parameters: f(x) = mx + b
linear <- makeFun(m*x + b ~ x, m = 2, b = 3)
linear

# Evaluate with default parameters
linear(5)

# Override parameters
linear(5, m = 5, b = 1)

# ----------------------------------------------------------------------------
# 3.3 More Complex Functions
# ----------------------------------------------------------------------------

# Quadratic function: f(x) = x^2 + 2x + 1
quad <- makeFun(x^2 + 2*x + 1 ~ x)
quad(3)

# Exponential function: f(x) = e^(2x)
exp_func <- makeFun(exp(2*x) ~ x)
exp_func(1)  # Should be e^2 ≈ 7.389

# Logarithm function: f(x) = ln(x)
log_func <- makeFun(log(x) ~ x)
log_func(exp(1))  # Should be 1

# Important: 
# - Use exp() for e^x
# - Use log() for natural logarithm (ln)
# - Use log10() for base-10 logarithm

# ============================================================================
# PART 4: VISUALIZING FUNCTIONS WITH slice_plot()
# ============================================================================

# ----------------------------------------------------------------------------
# 4.1 Basic Plotting
# ----------------------------------------------------------------------------

# The slice_plot() function creates graphs of functions
f <- makeFun(2*x + 3 ~ x)
slice_plot(f(x) ~ x, domain(x = -5:5))

# ----------------------------------------------------------------------------
# 4.2 Plotting Pattern-Book Functions
# ----------------------------------------------------------------------------

# Let's plot each of the nine pattern-book functions

# Constant Function
constant <- makeFun(5 ~ x)
slice_plot(constant(x) ~ x, domain(x = -5:5))

# Line Function
line <- makeFun(2*x + 1 ~ x)
slice_plot(line(x) ~ x, domain(x = -5:5))

# Power Function - x^2
power2 <- makeFun(x^2 ~ x)
slice_plot(power2(x) ~ x, domain(x = -3:3))

# Power Function - x^3
power3 <- makeFun(x^3 ~ x)
slice_plot(power3(x) ~ x, domain(x = -3:3))

# Exponential Function - e^x (growth)
exp_growth <- makeFun(exp(x) ~ x)
slice_plot(exp_growth(x) ~ x, domain(x = -2:3))

# Exponential Function - e^(-x) (decay)
exp_decay <- makeFun(exp(-x) ~ x)
slice_plot(exp_decay(x) ~ x, domain(x = -2:3))

# Logarithm Function - ln(x) (remember domain is x > 0)
log_func <- makeFun(log(x) ~ x)
slice_plot(log_func(x) ~ x, domain(x = 0.1:5))

# Sinusoid Function - sin(x)
sinusoid <- makeFun(sin(x) ~ x)
slice_plot(sinusoid(x) ~ x, domain(x = 0:6.28))

# Sinusoid with amplitude, frequency, and vertical shift
# 3*sin(2*x) + 1
sinusoid2 <- makeFun(3*sin(2*x) + 1 ~ x)
slice_plot(sinusoid2(x) ~ x, domain(x = 0:6.28))

# Hump (Gaussian) Function - e^(-x^2)
hump <- makeFun(exp(-x^2) ~ x)
slice_plot(hump(x) ~ x, domain(x = -3:3))

# Sigmoid Function - 1/(1 + e^(-x))
sigmoid <- makeFun(1/(1 + exp(-x)) ~ x)
slice_plot(sigmoid(x) ~ x, domain(x = -5:5))

# Reciprocal Function - 1/x (remember to avoid x = 0)
reciprocal <- makeFun(1/x ~ x)
# Create domain that avoids zero
x_vals <- c(seq(-3, -0.1, 0.1), seq(0.1, 3, 0.1))
slice_plot(reciprocal(x) ~ x, domain(x = x_vals))

# ============================================================================
# PART 5: EXPLORING FUNCTION PROPERTIES
# ============================================================================

# ----------------------------------------------------------------------------
# 5.1 Domain and Range
# ----------------------------------------------------------------------------

# Create a function
f <- makeFun(x^2 ~ x)

# Evaluate at various points to understand range
f(c(-3, -2, -1, 0, 1, 2, 3))

# For the reciprocal, what happens near 0?
reciprocal <- makeFun(1/x ~ x)
reciprocal(c(0.1, 0.01, 0.001, -0.001, -0.01, -0.1))

# ----------------------------------------------------------------------------
# 5.2 Comparing Functions
# ----------------------------------------------------------------------------

# We can plot multiple functions on the same graph
# Compare exponential growth vs power function
exp_func <- makeFun(exp(x) ~ x)
power_func <- makeFun(x^2 ~ x)

# Plot both (using pipe operator %>%)
slice_plot(exp_func(x) ~ x, domain(x = 0:5), color = "blue") %>%
  slice_plot(power_func(x) ~ x, color = "red")

# Note: The %>% is called a "pipe" operator. It passes the result of the 
# left side to the right side.

# ----------------------------------------------------------------------------
# 5.3 Function Composition
# ----------------------------------------------------------------------------

# Create f(x) = x^2 and g(x) = x + 1
f <- makeFun(x^2 ~ x)
g <- makeFun(x + 1 ~ x)

# f(g(x)) = (x+1)^2
f(g(3))

# g(f(x)) = x^2 + 1
g(f(3))

# ============================================================================
# PART 6: INTERACTIVE EXPLORATION
# ============================================================================

# ----------------------------------------------------------------------------
# 6.1 Exploring Parameters
# ----------------------------------------------------------------------------

# Create a parameterized exponential: f(x) = a*e^(k*x)
exp_param <- makeFun(a*exp(k*x) ~ x, a = 1, k = 1)

# Try different values of k
slice_plot(exp_param(x, k = 0.5) ~ x, domain(x = 0:5), color = "blue") %>%
  slice_plot(exp_param(x, k = 1) ~ x, color = "red") %>%
  slice_plot(exp_param(x, k = 2) ~ x, color = "green")

# ----------------------------------------------------------------------------
# 6.2 Finding Function Values
# ----------------------------------------------------------------------------

# Create a function
f <- makeFun(x^3 - 3*x + 2 ~ x)

# Find f(0), f(1), f(2)
f(c(0, 1, 2))

# Plot and see where it crosses zero
slice_plot(f(x) ~ x, domain(x = -3:3))

# ============================================================================
# PART 7: PRACTICE EXERCISES
# ============================================================================

# Try these on your own:

# 1. Create and plot the function f(x) = 3x^2 - 2x + 1 over the domain [-2, 2]
#    (Solution below - try it yourself first!)
# f_practice <- makeFun(3*x^2 - 2*x + 1 ~ x)
# slice_plot(f_practice(x) ~ x, domain(x = -2:2))

# 2. Compare e^x and x^3 on the same plot. Which grows faster for large x?
#    (Hint: Use slice_plot with pipe operator)

# 3. Create a sinusoid with amplitude 2, period π, and vertical shift 1. Plot it.
#    (Hint: General form is A*sin(2*π*x/P) + C)

# 4. Explore the sigmoid function: What is σ(0)? What happens as x → ∞? As x → -∞?
#    (Try evaluating sigmoid at different values)

# 5. Create a function that combines two pattern-book functions 
#    (e.g., f(x) = e^(-x^2) + sin(x)) and plot it.

# ============================================================================
# PART 8: APPLIED EXAMPLES - REAL-WORLD PATTERN-BOOK FUNCTIONS
# ============================================================================

# Now let's see how pattern-book functions appear in real-world applications.
# This connects directly to the examples we saw in lecture!

# ----------------------------------------------------------------------------
# 8.1 Exponential Growth: Population/Disease Spread
# ----------------------------------------------------------------------------

# As we saw in lecture, exponential functions model growth when something
# increases at a rate proportional to its current size.
# Example: Early epidemic spread, population growth, compound interest

# Exponential growth: N(t) = N₀ * e^(r*t)
# where N₀ is initial amount, r is growth rate, t is time

# Model: Early COVID-19 spread (like the example in lecture)
# If cases double every 3 days, find the growth rate:
# 2 = e^(3*r)  =>  r = ln(2)/3 ≈ 0.231 per day

I0 <- 100       # Initial cases
r <- log(2)/3   # Growth rate (doubling every 3 days)
cases <- makeFun(I0 * exp(r * t) ~ t, I0 = 100, r = log(2)/3)

# Plot over 30 days
slice_plot(cases(t) ~ t, domain(t = 0:30))

# Evaluate at key times
cases(c(0, 3, 6, 9, 12, 15))  # Should double every 3 days

# Key property: Doubling time = ln(2)/r
doubling_time <- log(2) / r
doubling_time  # Should be approximately 3 days

# ----------------------------------------------------------------------------
# 8.2 Exponential Decay: Radioactive Decay
# ----------------------------------------------------------------------------

# Exponential decay: N(t) = N₀ * e^(-λ*t)
# where λ (lambda) is the decay rate

# Example: Radioactive material with half-life of 5 years
# Half-life T = ln(2)/λ, so λ = ln(2)/5

half_life <- 5  # years
lambda <- log(2) / half_life
N0 <- 100       # Initial amount (grams)

radioactive <- makeFun(N0 * exp(-lambda * t) ~ t, 
                       N0 = 100, lambda = log(2)/5)

# Plot over 20 years
slice_plot(radioactive(t) ~ t, domain(t = 0:20))

# Check: After 5 years (one half-life), should be 50 grams
radioactive(5)

# After 10 years (two half-lives), should be 25 grams
radioactive(10)

# ----------------------------------------------------------------------------
# 8.3 Sinusoid: Seasonal Temperature Variation
# ----------------------------------------------------------------------------

# Sinusoids model periodic phenomena, like seasonal patterns
# Example: Average daily temperature over a year

# Temperature model: T(t) = A*sin(2π*t/P) + C
# where A = amplitude, P = period (365 days), C = average temperature

avg_temp <- 70      # Average temperature (Fahrenheit)
amplitude <- 15     # Temperature variation
period <- 365       # Days in a year

temperature <- makeFun(avg_temp + amplitude * sin(2 * pi * t / period) ~ t,
                      avg_temp = 70, amplitude = 15, period = 365)

# Plot over one year
slice_plot(temperature(t) ~ t, domain(t = 0:365))

# Find temperature at different times of year
temperature(0)      # January 1
temperature(91)     # April 1 (spring)
temperature(182)    # July 1 (summer)
temperature(273)    # October 1 (fall)

# ----------------------------------------------------------------------------
# 8.4 Sigmoid: Logistic Growth (Population with Carrying Capacity)
# ----------------------------------------------------------------------------

# The sigmoid function models growth that starts fast but levels off
# Example: Population growth with limited resources

# Logistic growth: P(t) = K / (1 + A*e^(-r*t))
# where K = carrying capacity, r = growth rate, A = (K - P₀)/P₀

K <- 1000      # Carrying capacity (maximum population)
P0 <- 10       # Initial population
A <- (K - P0) / P0
r <- 0.1       # Growth rate

population <- makeFun(K / (1 + A * exp(-r * t)) ~ t,
                     K = 1000, A = (K - P0)/P0, r = 0.1)

# Plot over 100 time units
slice_plot(population(t) ~ t, domain(t = 0:100))

# Notice: Starts growing exponentially, then levels off at K = 1000
# This is the "S-curve" shape of the sigmoid!

# Compare exponential vs logistic growth
exp_growth <- makeFun(P0 * exp(r * t) ~ t, P0 = 10, r = 0.1)
slice_plot(exp_growth(t) ~ t, domain(t = 0:50), color = "red") %>%
  slice_plot(population(t) ~ t, domain(t = 0:50), color = "blue")

# Red (exponential) grows forever; Blue (logistic) levels off

# ----------------------------------------------------------------------------
# 8.5 Power Function: Scaling Laws
# ----------------------------------------------------------------------------

# Power functions model relationships where one quantity scales as a power
# of another. Example: Surface area scales as the square of length

# Surface area of a sphere: A = 4πr² (power function with exponent 2)
# Volume of a sphere: V = (4/3)πr³ (power function with exponent 3)

surface_area <- makeFun(4 * pi * r^2 ~ r)
volume <- makeFun((4/3) * pi * r^3 ~ r)

# Plot both (scaled for comparison)
slice_plot(surface_area(r) ~ r, domain(r = 0:5), color = "blue") %>%
  slice_plot(volume(r) ~ r, domain(r = 0:5), color = "red")

# Key insight: Volume grows faster than surface area (cubic vs quadratic)
# This is why larger animals have different proportions than smaller ones!

# ----------------------------------------------------------------------------
# 8.6 Reciprocal: Inverse Relationships
# ----------------------------------------------------------------------------

# Reciprocal functions model inverse relationships
# Example: Speed vs time for fixed distance: t = d/s = d * s^(-1)

distance <- 100  # miles
time_vs_speed <- makeFun(distance / s ~ s, distance = 100)

# Plot time as a function of speed
slice_plot(time_vs_speed(s) ~ s, domain(s = 10:100))

# Notice: As speed increases, time decreases (inverse relationship)
# This is the hyperbola shape of the reciprocal function!

# ----------------------------------------------------------------------------
# 8.7 Combining Functions: Real-World Models
# ----------------------------------------------------------------------------

# Many real-world phenomena combine multiple pattern-book functions
# Example: Temperature with daily and seasonal variation

# Daily temperature variation (sinusoid with 24-hour period)
# plus seasonal variation (sinusoid with 365-day period)

daily_temp <- makeFun(70 + 10*sin(2*pi*t/24) + 15*sin(2*pi*t/365) ~ t)

# Plot over 7 days
slice_plot(daily_temp(t) ~ t, domain(t = 0:7))

# This combines two sinusoids to model both daily and seasonal patterns!

# ============================================================================
# SUMMARY
# ============================================================================

# In this exercise, we've covered:
# - R basics: Variables, arithmetic, functions, sequences
# - mosaicCalc package: makeFun() for creating functions, slice_plot() for visualization
# - Pattern-book functions: All nine basic functions
# - Function properties: Domain, range, parameters, composition
# - Applied modeling: Using exponential, logistic, and sinusoid functions to model epidemics

# Key takeaways:
# - Use makeFun(formula ~ variable) to create functions
# - Use slice_plot() to visualize functions
# - Remember domain restrictions (e.g., ln(x) requires x > 0)
# - Parameters allow us to create families of functions
# - Pattern-book functions can be combined to model real-world phenomena

# Next steps: Practice creating and plotting functions. 
# Experiment with different parameters and see how they affect the graphs!
# Try modeling other phenomena: population growth, radioactive decay, 
# compound interest, oscillating systems, etc.

