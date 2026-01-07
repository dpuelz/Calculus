# ============================================================================
# Introduction to Functions via Computation
# Calculus I - Functions, Computing & Pattern-Book Functions
# ============================================================================

# This script teaches functions through computational exploration:
# 1. What is a function? (with many examples and visualizations)
# 2. Domain and range (finding them computationally)
# 3. Nonfunctions (what makes something NOT a function)
# 4. Pattern-book functions (the nine basic functions)
# 5. Real-world applications

# NOTE: See intro_to_R.R for R basics if needed.

# ============================================================================
# SETUP
# ============================================================================

library(mosaicCalc)  # For creating and visualizing functions

# ============================================================================
# PART 1: WHAT IS A FUNCTION?
# ============================================================================

# ----------------------------------------------------------------------------
# 1.1 The Core Idea: One Input → One Output
# ----------------------------------------------------------------------------

# A function is a rule that assigns to each input EXACTLY ONE output.
# For every x, there is exactly one y = f(x)

# Example 1: Simple linear function
f <- makeFun(2*x + 3 ~ x)
f(0)   # f(0) = 3
f(1)   # f(1) = 5
f(2)   # f(2) = 7
f(-5)  # f(-5) = -7

# Visualize it:
slice_plot(f(x) ~ x, domain(x = -5:5))

# Example 2: Quadratic function
g <- makeFun(x^2 - 2*x + 1 ~ x)
g(0)   # g(0) = 1
g(1)   # g(1) = 0
g(2)   # g(2) = 1
g(3)   # g(3) = 4

# Visualize it:
slice_plot(g(x) ~ x, domain(x = -2:4))

# Example 3: Exponential function
h <- makeFun(2^x ~ x)
h(0)   # h(0) = 1
h(1)   # h(1) = 2
h(2)   # h(2) = 4
h(3)   # h(3) = 8

# Visualize it:
slice_plot(h(x) ~ x, domain(x = -2:4))

# Example 4: Multiple inputs at once
inputs <- c(-2, -1, 0, 1, 2, 3)
data.frame(input = inputs, 
           f_output = f(inputs),
           g_output = g(inputs),
           h_output = h(inputs))

# Key observation: Each input produces exactly ONE output. This is what
# makes these functions!

# ----------------------------------------------------------------------------
# 1.2 More Function Examples with Visualizations
# ----------------------------------------------------------------------------

# Example 5: Absolute value function
abs_func <- makeFun(abs(x) ~ x)
abs_func(-3)  # 3
abs_func(3)   # 3
slice_plot(abs_func(x) ~ x, domain(x = -5:5))

# Example 6: Sine function
sin_func <- makeFun(sin(x) ~ x)
sin_func(0)      # 0
sin_func(pi/2)   # 1
sin_func(pi)     # 0
slice_plot(sin_func(x) ~ x, domain(x = 0:2*pi))

# Example 7: Logarithm function
log_func <- makeFun(log(x) ~ x)
log_func(1)      # 0
log_func(exp(1)) # 1
log_func(10)     # ≈ 2.303
slice_plot(log_func(x) ~ x, domain(x = 0.1:10))

# Example 8: Rational function
rational <- makeFun((x^2 - 1)/(x - 1) ~ x)
rational(0)  # 1
rational(2)  # 3
rational(3)  # 4
slice_plot(rational(x) ~ x, domain(x = -3:3))

# ============================================================================
# PART 2: DOMAIN AND RANGE
# ============================================================================

# ----------------------------------------------------------------------------
# 2.1 What is the Domain?
# ----------------------------------------------------------------------------

# The DOMAIN is the set of all valid INPUT values (x-values).

# Example 1: f(x) = x² (domain: all real numbers)
f_square <- makeFun(x^2 ~ x)
f_square(-10)  # Works
f_square(0)    # Works
f_square(10)   # Works
slice_plot(f_square(x) ~ x, domain(x = -5:5))
# Domain: All real numbers (-∞, ∞)

# Example 2: f(x) = 1/x (domain: all reals except 0)
f_reciprocal <- makeFun(1/x ~ x)
f_reciprocal(1)    # Works: 1
f_reciprocal(2)    # Works: 0.5
# f_reciprocal(0)  # ERROR! Division by zero

# What happens as we approach 0?
f_reciprocal(c(0.1, 0.01, 0.001))      # Gets very large!
f_reciprocal(c(-0.1, -0.01, -0.001))   # Gets very negative!

# Visualize (plot in two parts to avoid x = 0):
slice_plot(f_reciprocal(x) ~ x, domain(x = -3:-0.1)) %>%
  slice_plot(f_reciprocal(x) ~ x, domain(x = 0.1:3))
# Domain: All real numbers EXCEPT 0, written as (-∞, 0) ∪ (0, ∞)

# Example 3: f(x) = √x (domain: non-negative numbers)
f_sqrt <- makeFun(sqrt(x) ~ x)
f_sqrt(0)     # Works: 0
f_sqrt(1)     # Works: 1
f_sqrt(4)     # Works: 2
# f_sqrt(-1)  # ERROR! (in real numbers)

slice_plot(f_sqrt(x) ~ x, domain(x = 0:10))
# Domain: [0, ∞) - all non-negative real numbers

# Example 4: f(x) = ln(x) (domain: positive numbers)
f_log <- makeFun(log(x) ~ x)
f_log(1)      # Works: 0
f_log(exp(1)) # Works: 1
# f_log(0)    # ERROR!
# f_log(-1)   # ERROR!

slice_plot(f_log(x) ~ x, domain(x = 0.1:10))
# Domain: (0, ∞) - all positive real numbers

# Example 5: f(x) = 1/(x² - 4) (domain: all reals except ±2)
f_rational <- makeFun(1/(x^2 - 4) ~ x)
f_rational(0)   # Works: -0.25
f_rational(1)   # Works: -0.333...
# f_rational(2)  # ERROR! Division by zero
# f_rational(-2) # ERROR! Division by zero

slice_plot(f_rational(x) ~ x, domain(x = -3:-2.1)) %>%
  slice_plot(f_rational(x) ~ x, domain(x = -1.9:1.9)) %>%
  slice_plot(f_rational(x) ~ x, domain(x = 2.1:3))
# Domain: All real numbers EXCEPT x = 2 and x = -2

# ----------------------------------------------------------------------------
# 2.2 What is the Range?
# ----------------------------------------------------------------------------

# The RANGE is the set of all possible OUTPUT values (y-values).

# Example 1: f(x) = x²
# Evaluate at many points to find range:
x_test <- seq(-5, 5, by = 0.1)
y_test <- f_square(x_test)
min(y_test)  # Minimum: 0
max(y_test)  # Maximum: 25
slice_plot(f_square(x) ~ x, domain(x = -5:5))
# Range: [0, ∞) - all non-negative numbers

# Example 2: f(x) = 2x + 3 (linear)
f_linear <- makeFun(2*x + 3 ~ x)
x_test <- seq(-10, 10, by = 0.1)
y_test <- f_linear(x_test)
min(y_test)  # Minimum: -17
max(y_test)  # Maximum: 23
slice_plot(f_linear(x) ~ x, domain(x = -10:10))
# Range: (-∞, ∞) - all real numbers

# Example 3: f(x) = e^x
f_exp <- makeFun(exp(x) ~ x)
x_test <- seq(-5, 5, by = 0.1)
y_test <- f_exp(x_test)
min(y_test)  # Minimum: very close to 0 (but never 0!)
max(y_test)  # Maximum: e^5 ≈ 148.4
slice_plot(f_exp(x) ~ x, domain(x = -5:5))
# Range: (0, ∞) - all positive numbers

# Example 4: f(x) = sin(x)
f_sin <- makeFun(sin(x) ~ x)
x_test <- seq(0, 2*pi, by = 0.01)
y_test <- f_sin(x_test)
min(y_test)  # Minimum: -1
max(y_test)  # Maximum: 1
slice_plot(f_sin(x) ~ x, domain(x = 0:2*pi))
# Range: [-1, 1] - all values between -1 and 1

# Example 5: f(x) = 1/(1 + x²)
f_bounded <- makeFun(1/(1 + x^2) ~ x)
x_test <- seq(-10, 10, by = 0.1)
y_test <- f_bounded(x_test)
min(y_test)  # Minimum: approaches 0
max(y_test)  # Maximum: 1 (at x = 0)
slice_plot(f_bounded(x) ~ x, domain(x = -10:10))
# Range: (0, 1] - all values between 0 and 1 (0 never reached, 1 is)

# ============================================================================
# PART 3: NONFUNCTIONS - WHAT IS NOT A FUNCTION?
# ============================================================================

# ----------------------------------------------------------------------------
# 3.1 The Vertical Line Test
# ----------------------------------------------------------------------------

# A relation is NOT a function if there exists an input that produces
# MORE THAN ONE output. Graphically: a vertical line intersects the graph
# at more than one point.

# Example 1: A circle (NOT a function!)
# The equation x² + y² = 1 describes a circle.
# For x = 0, we get y = ±1 (TWO outputs!)

# We can't plot x² + y² = 1 directly, but we can plot both branches:
circle_top <- makeFun(sqrt(1 - x^2) ~ x)
circle_bottom <- makeFun(-sqrt(1 - x^2) ~ x)

# Plot both branches (domain must be [-1, 1] for real values):
slice_plot(circle_top(x) ~ x, domain(x = -1:1), color = "blue") %>%
  slice_plot(circle_bottom(x) ~ x, domain(x = -1:1), color = "red")

# Notice: For x = 0, we have y = 1 (blue) AND y = -1 (red)
# This violates the "one input → one output" rule!

# Example 2: y = ±√x (NOT a function)
# For x = 4, we get y = 2 AND y = -2 (TWO outputs!)

sqrt_pos <- makeFun(sqrt(x) ~ x)
sqrt_neg <- makeFun(-sqrt(x) ~ x)

slice_plot(sqrt_pos(x) ~ x, domain(x = 0:10), color = "blue") %>%
  slice_plot(sqrt_neg(x) ~ x, domain(x = 0:10), color = "red")

# However, y = √x (just the positive branch) IS a function:
slice_plot(sqrt_pos(x) ~ x, domain(x = 0:10))
# This works because each x gives exactly one output.

# Example 3: A relation with duplicate x-values
# The relation {(1, 2), (2, 3), (1, 4)} is NOT a function
# because x = 1 appears twice with different y values (2 and 4).

not_a_function <- data.frame(
  x = c(1, 2, 1),
  y = c(2, 3, 4)
)
not_a_function
# Notice: x = 1 appears twice with different y values!

# In contrast, this IS a function:
is_a_function <- data.frame(
  x = c(1, 2, 3),
  y = c(2, 3, 4)
)
is_a_function
# Each x appears exactly once.

# ----------------------------------------------------------------------------
# 3.2 Testing if Something is a Function
# ----------------------------------------------------------------------------

# Computational test: Check if any input appears with multiple outputs
test_if_function <- function(x_values, y_values) {
  relation <- data.frame(x = x_values, y = y_values)
  for (x_val in unique(x_values)) {
    y_for_x <- relation$y[relation$x == x_val]
    if (length(unique(y_for_x)) > 1) {
      return(paste("NOT a function: x =", x_val, "has multiple y values:", 
                   paste(unique(y_for_x), collapse = ", ")))
    }
  }
  return("This IS a function!")
}

# Test with a function:
test_if_function(c(1, 2, 3, 4), c(2, 4, 6, 8))

# Test with a non-function:
test_if_function(c(1, 2, 1, 3), c(2, 4, 5, 6))

# ============================================================================
# PART 4: PATTERN-BOOK FUNCTIONS
# ============================================================================

# The nine fundamental pattern-book functions that appear everywhere in math!

# ----------------------------------------------------------------------------
# 4.1 Constant Function: f(x) = c
# ----------------------------------------------------------------------------

constant <- makeFun(5 ~ x)
constant(0)  # 5
constant(10) # 5
slice_plot(constant(x) ~ x, domain(x = -5:5))

# ----------------------------------------------------------------------------
# 4.2 Linear Function: f(x) = mx + b
# ----------------------------------------------------------------------------

linear <- makeFun(2*x + 1 ~ x)
linear(0)  # 1
linear(1)  # 3
slice_plot(linear(x) ~ x, domain(x = -5:5))

# ----------------------------------------------------------------------------
# 4.3 Power Function: f(x) = x^n
# ----------------------------------------------------------------------------

# Quadratic: x²
power2 <- makeFun(x^2 ~ x)
slice_plot(power2(x) ~ x, domain(x = -3:3))

# Cubic: x³
power3 <- makeFun(x^3 ~ x)
slice_plot(power3(x) ~ x, domain(x = -3:3))

# Compare them:
slice_plot(power2(x) ~ x, domain(x = -3:3), color = "blue") %>%
  slice_plot(power3(x) ~ x, domain(x = -3:3), color = "red")

# ----------------------------------------------------------------------------
# 4.4 Exponential Function: f(x) = a^x
# ----------------------------------------------------------------------------

# Growth: e^x
exp_growth <- makeFun(exp(x) ~ x)
slice_plot(exp_growth(x) ~ x, domain(x = -2:3))

# Decay: e^(-x)
exp_decay <- makeFun(exp(-x) ~ x)
slice_plot(exp_decay(x) ~ x, domain(x = -2:3))

# Compare:
slice_plot(exp_growth(x) ~ x, domain(x = -2:3), color = "blue") %>%
  slice_plot(exp_decay(x) ~ x, domain(x = -2:3), color = "red")

# ----------------------------------------------------------------------------
# 4.5 Logarithm Function: f(x) = log(x)
# ----------------------------------------------------------------------------

log_func <- makeFun(log(x) ~ x)
log_func(1)      # 0
log_func(exp(1)) # 1
slice_plot(log_func(x) ~ x, domain(x = 0.1:5))

# ----------------------------------------------------------------------------
# 4.6 Sinusoid Function: f(x) = sin(x) or cos(x)
# ----------------------------------------------------------------------------

sinusoid <- makeFun(sin(x) ~ x)
slice_plot(sinusoid(x) ~ x, domain(x = 0:2*pi))

# With parameters: A*sin(ω*x) + C
sinusoid2 <- makeFun(3*sin(2*x) + 1 ~ x)
slice_plot(sinusoid2(x) ~ x, domain(x = 0:2*pi))

# ----------------------------------------------------------------------------
# 4.7 Gaussian (Hump) Function: f(x) = e^(-x²)
# ----------------------------------------------------------------------------

hump <- makeFun(exp(-x^2) ~ x)
hump(0)   # 1 (maximum)
hump(1)   # ≈ 0.368
slice_plot(hump(x) ~ x, domain(x = -3:3))

# ----------------------------------------------------------------------------
# 4.8 Sigmoid Function: f(x) = 1/(1 + e^(-x))
# ----------------------------------------------------------------------------

sigmoid <- makeFun(1/(1 + exp(-x)) ~ x)
sigmoid(0)   # 0.5
sigmoid(-5)  # ≈ 0.007 (close to 0)
sigmoid(5)   # ≈ 0.993 (close to 1)
slice_plot(sigmoid(x) ~ x, domain(x = -5:5))

# ----------------------------------------------------------------------------
# 4.9 Reciprocal Function: f(x) = 1/x
# ----------------------------------------------------------------------------

reciprocal <- makeFun(1/x ~ x)
slice_plot(reciprocal(x) ~ x, domain(x = -3:-0.1)) %>%
  slice_plot(reciprocal(x) ~ x, domain(x = 0.1:3))

# ============================================================================
# PART 5: FUNCTION COMPOSITION AND COMBINATIONS
# ============================================================================

# ----------------------------------------------------------------------------
# 5.1 Function Composition
# ----------------------------------------------------------------------------

# Create f(x) = x² and g(x) = x + 1
f <- makeFun(x^2 ~ x)
g <- makeFun(x + 1 ~ x)

# f(g(x)) = (x+1)²
f(g(3))  # f(g(3)) = f(4) = 16

# g(f(x)) = x² + 1
g(f(3))  # g(f(3)) = g(9) = 10

# Visualize composition:
composed <- makeFun((x + 1)^2 ~ x)
slice_plot(f(x) ~ x, domain(x = -3:3), color = "blue") %>%
  slice_plot(g(x) ~ x, domain(x = -3:3), color = "green") %>%
  slice_plot(composed(x) ~ x, domain(x = -3:3), color = "red")

# ----------------------------------------------------------------------------
# 5.2 Combining Functions
# ----------------------------------------------------------------------------

# Linear combination: f(x) = 2*sin(x) + 3*cos(x)
combined <- makeFun(2*sin(x) + 3*cos(x) ~ x)
slice_plot(combined(x) ~ x, domain(x = 0:2*pi))

# Product: f(x) = e^(-x) * sin(x) (damped oscillation)
damped <- makeFun(exp(-x) * sin(x) ~ x)
slice_plot(damped(x) ~ x, domain(x = 0:10))

# ============================================================================
# PART 6: REAL-WORLD APPLICATIONS
# ============================================================================

# ----------------------------------------------------------------------------
# 6.1 Exponential Growth: Population/Disease Spread
# ----------------------------------------------------------------------------

# Model: N(t) = N₀ * e^(r*t)
# Early COVID-19 spread: cases double every 3 days
I0 <- 100
r <- log(2)/3  # Growth rate
cases <- makeFun(I0 * exp(r * t) ~ t, I0 = 100, r = log(2)/3)

slice_plot(cases(t) ~ t, domain(t = 0:30))
cases(c(0, 3, 6, 9, 12))  # Should double every 3 days

# ----------------------------------------------------------------------------
# 6.2 Exponential Decay: Radioactive Decay
# ----------------------------------------------------------------------------

# Model: N(t) = N₀ * e^(-λ*t)
# Half-life of 5 years
half_life <- 5
lambda <- log(2) / half_life
radioactive <- makeFun(100 * exp(-lambda * t) ~ t, lambda = log(2)/5)

slice_plot(radioactive(t) ~ t, domain(t = 0:20))
radioactive(5)   # Should be 50 (half-life)
radioactive(10) # Should be 25 (two half-lives)

# ----------------------------------------------------------------------------
# 6.3 Sinusoid: Seasonal Temperature
# ----------------------------------------------------------------------------

# Model: T(t) = A*sin(2π*t/P) + C
temperature <- makeFun(70 + 15 * sin(2 * pi * t / 365) ~ t)

slice_plot(temperature(t) ~ t, domain(t = 0:365))
temperature(0)   # January 1
temperature(91)  # April 1
temperature(182) # July 1

# ----------------------------------------------------------------------------
# 6.4 Sigmoid: Logistic Growth
# ----------------------------------------------------------------------------

# Model: P(t) = K / (1 + A*e^(-r*t))
K <- 1000  # Carrying capacity
P0 <- 10
A <- (K - P0) / P0
population <- makeFun(K / (1 + A * exp(-0.1 * t)) ~ t, K = 1000, A = 99)

slice_plot(population(t) ~ t, domain(t = 0:100))

# Compare with exponential growth:
exp_growth <- makeFun(P0 * exp(0.1 * t) ~ t, P0 = 10)
slice_plot(exp_growth(t) ~ t, domain(t = 0:50), color = "red") %>%
  slice_plot(population(t) ~ t, domain(t = 0:50), color = "blue")

# ----------------------------------------------------------------------------
# 6.5 Power Function: Scaling Laws
# ----------------------------------------------------------------------------

# Surface area of sphere: A = 4πr²
# Volume of sphere: V = (4/3)πr³
surface_area <- makeFun(4 * pi * r^2 ~ r)
volume <- makeFun((4/3) * pi * r^3 ~ r)

slice_plot(surface_area(r) ~ r, domain(r = 0:5), color = "blue") %>%
  slice_plot(volume(r) ~ r, domain(r = 0:5), color = "red")

# ============================================================================
# SUMMARY
# ============================================================================

# Key concepts learned:
# 1. Function: One input → exactly one output
# 2. Domain: All valid input values
# 3. Range: All possible output values
# 4. Nonfunction: Relation where one input can give multiple outputs
# 5. Pattern-book functions: Nine fundamental function types
# 6. Functions can be composed and combined
# 7. Functions model real-world phenomena

# Computational tools:
# - makeFun(formula ~ variable) to create functions
# - slice_plot() to visualize functions
# - Evaluate functions at specific points to understand behavior
# - Explore domain by testing different inputs
# - Explore range by evaluating at many points

# Next steps: Practice creating and visualizing functions!
# Experiment with different parameters and see how they affect the graphs.
