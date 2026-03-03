# ============================================================================
# Lecture 13: Partial Derivatives and Gradients
# Calculus I - Multivariable functions, partial derivatives, gradient
# ============================================================================
#
# Run this script step-by-step in RStudio. Each section builds on the previous.
# No output functions (cat/print); results appear when you run each line.
#
# ============================================================================
# SETUP
# ============================================================================

library(mosaicCalc)
library(numDeriv)
if (!interactive()) pdf(NULL)  # avoid Rplots.pdf when run via Rscript

# ============================================================================
# PART 1: FUNCTIONS OF SEVERAL VARIABLES
# ============================================================================

# ----------------------------------------------------------------------------
# 1.1 Defining multivariable functions
# ----------------------------------------------------------------------------

# f(x, y) = x^2 + y^2 (squared distance from origin)
f_sq_dist <- makeFun(x^2 + y^2 ~ x & y)

# Evaluate at a point
f_sq_dist(1, 1)
f_sq_dist(3, 4)

# f(x, y) = x*y (area of rectangle)
f_area <- makeFun(x * y ~ x & y)
f_area(2, 5)

# f(x, y) = exp(-(x^2 + y^2)) (2D Gaussian)
f_gaussian <- makeFun(exp(-(x^2 + y^2)) ~ x & y)
f_gaussian(0, 0)
f_gaussian(1, 0)

# ----------------------------------------------------------------------------
# 1.2 Visualizing: contour plot and 3D surface
# ----------------------------------------------------------------------------

# Contour plot: level curves f(x,y) = constant
contour_plot(f_sq_dist(x, y) ~ x & y, domain(x = -3:3, y = -3:3))

# Contour plot of the Gaussian
contour_plot(f_gaussian(x, y) ~ x & y, domain(x = -2:2, y = -2:2))

# ============================================================================
# PART 2: PARTIAL DERIVATIVES (numerical)
# ----------------------------------------------------------------------------
# numDeriv::grad expects a function f(x) where x is a VECTOR.
# For f(x,y), we use x = c(x, y). So we need wrapper functions.
# ============================================================================

# ----------------------------------------------------------------------------
# 2.1 Wrapper: f(x,y) as f_vec(c(x,y))
# ----------------------------------------------------------------------------

# f(x,y) = x^2 + y^2
f_sq_vec <- function(v) {
  v[1]^2 + v[2]^2
}

f_sq_vec(c(1, 1))
f_sq_vec(c(3, 4))

# f(x,y) = x^2*y + 3*x*y^2 (from lecture)
f_quad_vec <- function(v) {
  x <- v[1]
  y <- v[2]
  x^2 * y + 3 * x * y^2
}

f_quad_vec(c(1, 2))

# ----------------------------------------------------------------------------
# 2.2 Numerical partial derivatives via grad()
# ----------------------------------------------------------------------------
# grad(f, x) returns the gradient (df/dx1, df/dx2, ...) at point x

# At (1, 1) for f(x,y) = x^2 + y^2:
# Exact: fx = 2x = 2, fy = 2y = 2, so gradient = (2, 2)
grad(f_sq_vec, c(1, -1))

# At (1, 2) for f(x,y) = x^2*y + 3*x*y^2:
# Exact: fx = 2xy + 3y^2 = 4 + 12 = 16, fy = x^2 + 6xy = 1 + 12 = 13
grad(f_quad_vec, c(1, 2))

# ----------------------------------------------------------------------------
# 2.3 Gaussian: f(x,y) = exp(-(x^2 + y^2))
# ----------------------------------------------------------------------------

f_gauss_vec <- function(v) {
  exp(-(v[1]^2 + v[2]^2))
}

# At (1, 0): exact fx = -2x*exp(-(x^2+y^2)) = -2*exp(-1), fy = 0
grad(f_gauss_vec, c(1, 0))

# At (0, 0): gradient = (0, 0) (peak of the bell)
grad(f_gauss_vec, c(0, 0))

# ============================================================================
# PART 3: THE GRADIENT
# ----------------------------------------------------------------------------
# The gradient is the vector of all first partial derivatives.
# It points in the direction of steepest ascent.
# ============================================================================

# ----------------------------------------------------------------------------
# 3.1 Gradient at several points
# ----------------------------------------------------------------------------

# f(x,y) = x^2 + y^2: gradient = (2x, 2y), points away from origin
grad(f_sq_vec, c(1, 1))
grad(f_sq_vec, c(-1, 2))
grad(f_sq_vec, c(0, 0))

# ----------------------------------------------------------------------------
# 3.2 Gradient field overlay on contour plot (mosaicCalc)
# ----------------------------------------------------------------------------

# Vector field of the gradient: for f(x,y)=x^2+y^2, grad = (2x, 2y)
# Format: (horizontal_component, vertical_component) at each (x,y)
vectorfield_plot(x ~ 2*x, y ~ 2*y, bounds(x = -20:20, y = -20:20))

# Overlay on contour plot (combine layers)
contour_plot(f_sq_dist(x, y) ~ x & y, domain(x = -2:2, y = -2:2)) %>%
  vectorfield_plot(x ~ 2*x, y ~ 2*y, bounds(x = -2:2, y = -2:2))

# Gaussian: grad = (-2x*exp(-(x^2+y^2)), -2y*exp(-(x^2+y^2)))
# (points toward origin, uphill toward the peak)
contour_plot(f_gaussian(x, y) ~ x & y, domain(x = -1.5:1.5, y = -1.5:1.5)) %>%
  vectorfield_plot(x ~ -2*x*exp(-(x^2+y^2)), y ~ -2*y*exp(-(x^2+y^2)),
                  bounds(x = -1.5:1.5, y = -1.5:1.5))

# ============================================================================
# PART 4: DIRECTIONAL DERIVATIVES
# ----------------------------------------------------------------------------
# The directional derivative = grad(f) "dot" u
# Dot product: (a1, a2) . (b1, b2) = a1*b1 + a2*b2  (multiply components, add)
# In R: sum(grad * u) does the dot product
# ============================================================================

# Directional derivative in direction u (unit vector) at point x
directional_deriv <- function(f, x, u) {
  g <- grad(f, x)
  sum(g * u)
}


x = c(1,1)
trys = 1000000
DD = rep(NA,trys)
ustore = list()
for(i in 1:trys){
  u = rnorm(2)
  u = u/(sqrt(sum(u^2)))
  DD[i] = directional_deriv(f_sq_vec,x,u)
  ustore[[i]] = u
}
imax = which.max(DD)
ustore[[imax]]





# f(x,y) = x^2 + y^2 at (1,1)
# Direction of steepest ascent: u = grad/|grad| = (1,1)/sqrt(2)
u_steepest <- c(1, 1) / sqrt(2)
directional_deriv(f_sq_vec, c(1, 1), u_steepest)

# Compare to |grad| = sqrt(8) = 2*sqrt(2) ≈ 2.83
sqrt(sum(grad(f_sq_vec, c(1, 1))^2))

# Direction (1, 0): should equal partial df/dx = 2
directional_deriv(f_sq_vec, c(1, 1), c(1, 0))

# ============================================================================
# PART 5: HIGHER-ORDER PARTIALS AND HESSIAN
# ----------------------------------------------------------------------------
# hessian(f, x) returns the matrix of second partial derivatives.
# ============================================================================

# Hessian of f(x,y) = x^2 + y^2 at (1, 1)
# Exact: f_xx=2, f_yy=2, f_xy=f_yx=0
hessian(f_sq_vec, c(1, 1))

# Hessian of f(x,y) = x^2*y + 3*x*y^2 at (1, 2)
# Exact: f_xx=2y=4, f_yy=6x=6, f_xy=2x+6y=14
hessian(f_quad_vec, c(1, 2))

# Clairaut: mixed partials equal
H <- hessian(f_quad_vec, c(1, 2))
H[1, 2]
H[2, 1]

# ============================================================================
# PART 6: COBB-DOUGLAS PRODUCTION (economics example)
# ----------------------------------------------------------------------------
# f(L, K) = L^alpha * K^(1-alpha)
# ============================================================================

alpha <- 0.6
f_cobb <- makeFun(L^alpha * K^(1 - alpha) ~ L & K, alpha = 0.6)

f_cobb_vec <- function(v) {
  v[1]^alpha * v[2]^(1 - alpha)
}

# At L=100, K=50
f_cobb(100, 50)
grad(f_cobb_vec, c(100, 50))

# Marginal product of labor (partial w.r.t. L) and capital (partial w.r.t. K)
grad(f_cobb_vec, c(100, 50))

# ============================================================================
# PART 7: TEMPERATURE FIELD (from lecture Exercise 4)
# ----------------------------------------------------------------------------
# T(x,y) = 100 * exp(-(x^2 + y^2)/4)
# ============================================================================

f_temp_vec <- function(v) {
  100 * exp(-(v[1]^2 + v[2]^2) / 4)
}

# At (1, 1): direction of fastest temperature increase?
grad(f_temp_vec, c(1, 1))

# Magnitude: rate of increase in that direction
sqrt(sum(grad(f_temp_vec, c(1, 1))^2))

# Contour plot
f_temp <- makeFun(100 * exp(-(x^2 + y^2)/4) ~ x & y)
contour_plot(f_temp(x, y) ~ x & y, domain(x = -3:3, y = -3:3))
