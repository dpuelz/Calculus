# ============================================================================
# Gradient Descent: Worked Examples
# Calculus I - Companion to lecture16_gradient_descent.tex
# ============================================================================
#
# Part 1: Nontrivial 2-variable function f(x,y) = x^2 + 2xy + 2y^2 - 6x - 8y + 10
# Part 2: Least squares with one predictor (intercept + slope)
# Part 3: Multimodal surface with interactive 3D visualization
#
# Run this script step-by-step in RStudio.
# For Part 1.2 visualization: install.packages("mosaicCalc")
# For Part 3 (3D interactive): install.packages("rgl")
# ============================================================================

library(numDeriv)
library(dplyr)

# ============================================================================
# PART 1: MULTIVARIABLE FUNCTION
# ============================================================================
# f(x,y) = x^2 + 2xy + 2y^2 - 6x - 8y + 10
# Gradient: (2x + 2y - 6, 2x + 4y - 8)
# Critical point (analytic): (2, 1)
# ============================================================================

f_xy <- function(v) {
  x <- v[1]
  y <- v[2]
  x^2 + 2*x*y + 2*y^2 - 6*x - 8*y + 10
}

# Analytical gradient (for reference)
grad_f_analytical <- function(v) {
  x <- v[1]
  y <- v[2]
  c(2*x + 2*y - 6, 2*x + 4*y - 8)
}

# Check gradient at (0, 0)
grad_f_analytical(c(0, 0))

# Numerical check via numDeriv
grad(f_xy, c(0, 0))

# ----------------------------------------------------------------------------
# 1.1 Gradient descent implementation
# ----------------------------------------------------------------------------

gradient_descent <- function(f, grad_f, x0, alpha = 0.2, n_iter = 25, tol = 1e-6) {
  x <- x0
  history <- matrix(NA, nrow = n_iter + 1, ncol = length(x0))
  history[1, ] <- x
  for (i in 1:n_iter) {
    g <- grad_f(x)
    if (sqrt(sum(g^2)) < tol) break
    x <- x - alpha * g
    history[i + 1, ] <- x
  }
  list(par = x, value = f(x), history = na.omit(history))
}

# Run gradient descent from (0, 0)
gd1 <- gradient_descent(f_xy, grad_f_analytical, x0 = c(0, 0), alpha = 0.2, n_iter = 25)

gd1$par
gd1$value

# Compare to analytic solution (2, 1)
gd1$par - c(2, 1)

# First few iterations (match the notes)
gd1$history[1:5, ]

# ----------------------------------------------------------------------------
# 1.2 Visualize the path
# ----------------------------------------------------------------------------

# Base R contour plot
path_df <- as.data.frame(gd1$history)
names(path_df) <- c("x", "y")

grid_x <- seq(-1, 4, by = 0.1)
grid_y <- seq(-1, 4, by = 0.1)
f_vals <- outer(grid_x, grid_y, Vectorize(function(x, y) f_xy(c(x, y))))

contour(grid_x, grid_y, f_vals, xlab = "x", ylab = "y", main = "f(x,y) and gradient descent path")
lines(path_df$x, path_df$y, col = "red", lwd = 2)
points(path_df$x[1], path_df$y[1], pch = 19, col = "green", cex = 1.5)
points(2, 1, pch = 19, col = "blue", cex = 1.5)
# Green = start, blue = minimum (2, 1), red = path

# ============================================================================
# PART 2: LEAST SQUARES (ONE PREDICTOR)
# ============================================================================
# Model: y_i = beta_0 + beta_1 * x_i
# Loss: L = sum (y_i - beta_0 - beta_1 * x_i)^2
# Gradient: dL/db0 = -2 * sum(e_i),  dL/db1 = -2 * sum(e_i * x_i)
#          where e_i = y_i - beta_0 - beta_1 * x_i
# ============================================================================

# Data: (1,2), (2,3), (3,5)
x_data <- c(1, 2, 3)
y_data <- c(2, 3, 5)
plot(x_data,y_data,pch=19,cex=2)

# ----------------------------------------------------------------------------
# 2.1 Loss and gradient functions
# ----------------------------------------------------------------------------

sse <- function(beta, x, y) {
  y_hat <- beta[1] + beta[2] * x
  sum((y - y_hat)^2)
}

sse_grad <- function(beta, x, y) {
  e <- y - (beta[1] + beta[2] * x)
  c(-2 * sum(e), -2 * sum(e * x))
}

# ----------------------------------------------------------------------------
# 2.2 Gradient descent for least squares
# ----------------------------------------------------------------------------

beta0 <- c(-3, -3)
alpha <- 0.001
n_iter <- 500

history_ls <- matrix(NA, nrow = n_iter + 1, ncol = 2)
history_ls[1, ] <- beta0

for (i in 1:n_iter) {
  g <- sse_grad(beta0, x_data, y_data)
  beta0 <- beta0 - alpha * g
  history_ls[i + 1, ] <- beta0
}

# Final estimates
beta0

# Compare to lm() (closed-form OLS)
lm(y_data ~ x_data)$coefficients

# ----------------------------------------------------------------------------
# 2.3 First iteration (match the notes)
# ----------------------------------------------------------------------------
# At (0, 0): e = (2, 3, 5), sum(e) = 10, sum(e*x) = 2+6+15 = 23
# grad = (-20, -46)
# New = (0,0) - 0.1*(-20, -46) = (2, 4.6)

sse_grad(c(0, 0), x_data, y_data)
history_ls[2, ]

# ----------------------------------------------------------------------------
# 2.4 Plot: data, OLS line, and gradient descent path
# ----------------------------------------------------------------------------

plot(x_data, y_data, pch = 19, xlim = c(0, 4), ylim = c(0, 6),
     xlab = "x", ylab = "y", main = "Least squares: gradient descent vs OLS")

# OLS line
abline(lm(y_data ~ x_data), col = "blue", lwd = 2)

# Gradient descent fit
abline(beta0[1], beta0[2], col = "red", lty = 2, lwd = 2)

legend("topleft", legend = c("OLS", "Gradient descent"), col = c("blue", "red"),
       lty = c(1, 2), lwd = 2)

# ----------------------------------------------------------------------------
# 2.5 Contour plot of SSE surface (optional)
# ----------------------------------------------------------------------------

grid_b0 <- seq(-5, 5, by = 0.05)
grid_b1 <- seq(-5, 5, by = 0.05)
sse_vals <- outer(grid_b0, grid_b1, Vectorize(function(b0, b1) sse(c(b0, b1), x_data, y_data)))

contour(grid_b0, grid_b1, sse_vals, xlab = expression(beta[0]), ylab = expression(beta[1]),
        main = "SSE surface and gradient descent path")
path_ls <- as.data.frame(history_ls)
names(path_ls) <- c("b0", "b1")
lines(path_ls$b0, path_ls$b1, col = "red", lwd = 2)
points(path_ls$b0[1], path_ls$b1[1], pch = 19, col = "green", cex = 1.5)
points(path_ls$b0[nrow(path_ls)], path_ls$b1[nrow(path_ls)], pch = 19, col = "blue", cex = 1.5)

# ============================================================================
# PART 3: MULTIMODAL SURFACE WITH INTERACTIVE 3D VISUALIZATION
# ============================================================================
# Rastrigin-like function: many local minima, global minimum at (0, 0)
# f(x,y) = 20 + x^2 + y^2 - 10*cos(2*pi*x) - 10*cos(2*pi*y)
# Gradient descent can get stuck in local minima depending on starting point!
#
# Requires: install.packages("rgl")
# ============================================================================

if (requireNamespace("rgl", quietly = TRUE)) {

  # Rastrigin function (scaled for nicer visualization)
  rastrigin <- function(v) {
    x <- v[1]
    y <- v[2]
    20 + x^2 + y^2 - 10*cos(2*pi*x) - 10*cos(2*pi*y)
  }

  # Analytical gradient
  rastrigin_grad <- function(v) {
    x <- v[1]
    y <- v[2]
    c(2*x + 20*pi*sin(2*pi*x),
      2*y + 20*pi*sin(2*pi*y))
  }

  # Run gradient descent from multiple starting points
  starts <- list(
    c(0.5, 0.5),   # near global min
    c(2, 2),       # may converge to local min
    c(-1.5, 1.5),  # different basin
    c(3, 0)        # far from origin
  )

  paths <- list()
  for (i in seq_along(starts)) {
    gd <- gradient_descent(rastrigin, rastrigin_grad, x0 = starts[[i]],
                           alpha = 0.02, n_iter = 100)
    paths[[i]] <- gd$history
  }

  # ----------------------------------------------------------------------------
  # 3.1 Interactive 3D surface with gradient descent paths
  # ----------------------------------------------------------------------------

  grid_x <- seq(-4, 4, length.out = 80)
  grid_y <- seq(-4, 4, length.out = 80)
  z_surf <- outer(grid_x, grid_y, Vectorize(function(x, y) rastrigin(c(x, y))))

  # Cap z for cleaner visualization (Rastrigin can get large)
  z_cap <- pmin(z_surf, 80)

  rgl::open3d()
  rgl::surface3d(grid_x, grid_y, z_cap, color = "lightblue", alpha = 0.8)


  # Add gradient descent paths as 3D lines
  colors <- c("red", "darkgreen", "orange", "purple")
  for (i in seq_along(paths)) {
    p <- paths[[i]]
    z_path <- apply(p, 1, function(v) min(rastrigin(v), 80))
    rgl::lines3d(p[, 1], p[, 2], z_path, col = colors[i], lwd = 3)
    rgl::points3d(p[1, 1], p[1, 2], z_path[1], col = "green", size = 8)
    rgl::points3d(p[nrow(p), 1], p[nrow(p), 2], z_path[length(z_path)],
                  col = "blue", size = 8)
  }

  rgl::axes3d()
  rgl::title3d(xlab = "x", ylab = "y", zlab = "f(x,y)")
  rgl::rgl.bg(color = "white")

  # Try rotating the view: click and drag. Or use rgl::rglwidget() for HTML export.
  # message("Rotate the 3D plot by clicking and dragging. Zoom with scroll wheel.")

} else {
  message("Install 'rgl' for interactive 3D: install.packages('rgl')")
}
