# ============================================================================
# Gradient Descent: Worked Examples
# Calculus I - Companion to lecture16_gradient_descent.tex
# ============================================================================
#
# Part 1: Nontrivial 2-variable function f(x,y) = x^2 + 2xy + 2y^2 - 6x - 8y + 10
# Part 2: Least squares with one predictor (intercept + slope)
# Part 3: Multimodal surface with interactive 3D visualization
# Part 4: Stochastic gradient descent on least squares (larger data, mini-batches)
#
# Run this script step-by-step in RStudio.
# Packages: numDeriv, dplyr, plotly
# ============================================================================

library(numDeriv)
library(dplyr)
library(plotly)

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
# Two functions, each with 3 gradient descent paths.
# Rotate: click and drag. Zoom: scroll.
# ============================================================================

# --- Function 1: f(x,y) = (x^2 + y^2)/2 - 2*cos(x) - 2*cos(y) ---
# Global min at (0,0). Local minima elsewhere. Paths can get stuck.
f1 <- function(v) {
  x <- v[1]; y <- v[2]
  (x^2 + y^2)/2 - 2*cos(x) - 2*cos(y)
}
f1_grad <- function(v) {
  x <- v[1]; y <- v[2]
  c(x + 2*sin(x), y + 2*sin(y))
}

starts1 <- list(c(1, 1), c(2.5, 2.5), c(-2.5, 2.5))
paths1 <- lapply(starts1, function(s) {
  gradient_descent(f1, f1_grad, x0 = s, alpha = 0.02, n_iter = 100)$history
})

grid_x <- seq(-4, 4, length.out = 60)
grid_y <- seq(-4, 4, length.out = 60)
z1 <- outer(grid_x, grid_y, Vectorize(function(x, y) f1(c(x, y))))
z1_cap <- pmin(z1, 15)

p1 <- plot_ly(x = grid_x, y = grid_y, z = z1_cap, type = "surface",
              colorscale = "Blues", opacity = 0.9, showscale = TRUE)
colors <- c("red", "blue", "orange")
for (i in 1:3) {
  pt <- paths1[[i]]
  z_path <- pmin(apply(pt, 1, f1), 15)
  p1 <- p1 %>% add_trace(x = pt[, 1], y = pt[, 2], z = z_path,
                         type = "scatter3d", mode = "lines+markers",
                         name = paste0("Start ", round(starts1[[i]][1], 1), ", ", round(starts1[[i]][2], 1)),
                         line = list(color = colors[i], width = 4),
                         marker = list(size = 4))
}
p1 <- p1 %>% layout(
  title = "f(x,y) = (x^2 + y^2)/2 - 2*cos(x) - 2*cos(y)",
  scene = list(
    xaxis = list(title = "x"),
    yaxis = list(title = "y"),
    zaxis = list(title = "f(x,y)")
  )
)
p1

# --- Function 2: f(x,y) = (x² - 4)² + (y² - 4)² ---
# Four global minima at (±2, ±2). Paths converge to different minima.
f2 <- function(v) {
  x <- v[1]; y <- v[2]
  (x^2 - 4)^2 + (y^2 - 4)^2
}
f2_grad <- function(v) {
  x <- v[1]; y <- v[2]
  c(4*x*(x^2 - 4), 4*y*(y^2 - 4))
}

starts2 <- list(c(1, 1), c(3.5, -1.5), c(-3.5, 1.5))
paths2 <- lapply(starts2, function(s) {
  gradient_descent(f2, f2_grad, x0 = s, alpha = 0.003, n_iter = 500)$history
})

grid_x2 <- seq(-4, 4, length.out = 60)
grid_y2 <- seq(-4, 4, length.out = 60)
z2 <- outer(grid_x2, grid_y2, Vectorize(function(x, y) f2(c(x, y))))
z2_cap <- pmin(z2, 50)

p2 <- plot_ly(x = grid_x2, y = grid_y2, z = z2_cap, type = "surface",
              colorscale = "Greens", opacity = 0.9, showscale = TRUE)
for (i in 1:3) {
  pt <- paths2[[i]]
  z_path <- pmin(apply(pt, 1, f2), 50)
  p2 <- p2 %>% add_trace(x = pt[, 1], y = pt[, 2], z = z_path,
                         type = "scatter3d", mode = "lines+markers",
                         name = paste0("Start ", round(starts2[[i]][1], 1), ", ", round(starts2[[i]][2], 1)),
                         line = list(color = colors[i], width = 4),
                         marker = list(size = 4))
}
p2 <- p2 %>% layout(
  title = "f(x,y) = (x^2 - 4)^2 + (y^2 - 4)^2",
  scene = list(
    xaxis = list(title = "x"),
    yaxis = list(title = "y"),
    zaxis = list(title = "f(x,y)")
  )
)
p2

# ============================================================================
# PART 4: STOCHASTIC GRADIENT DESCENT (LEAST SQUARES)
# ============================================================================
# Larger simulated dataset. SGD uses small random batches each iteration.
# Loss: L(b0, b1) = sum((y_i - b0 - b1*x_i)^2)
# Same 3D surface style as Part 3.
# ============================================================================

set.seed(42)
n_sim <- 200
x_sim <- runif(n_sim, 0, 5)
y_sim <- 1.5 + 0.8 * x_sim + rnorm(n_sim, sd = 0.5)

sse_sim <- function(beta, x, y) {
  y_hat <- beta[1] + beta[2] * x
  sum((y - y_hat)^2)
}

sse_grad_batch <- function(beta, x, y) {
  e <- y - (beta[1] + beta[2] * x)
  c(-2 * sum(e), -2 * sum(e * x))
}

# Stochastic gradient descent: each step uses a random mini-batch
batch_size <- 2
n_epochs <- 50
alpha_sgd <- 0.0003
beta_sgd <- c(-5, 5)
history_sgd <- matrix(NA, nrow = n_epochs * ceiling(n_sim / batch_size) + 1, ncol = 2)
history_sgd[1, ] <- beta_sgd
row <- 1

for (epoch in 1:n_epochs) {
  idx <- sample(n_sim)
  for (i in seq(1, n_sim, by = batch_size)) {
    batch_idx <- idx[i:min(i + batch_size - 1, n_sim)]
    x_batch <- x_sim[batch_idx]
    y_batch <- y_sim[batch_idx]
    g <- sse_grad_batch(beta_sgd, x_batch, y_batch)
    beta_sgd <- beta_sgd - alpha_sgd * g
    row <- row + 1
    history_sgd[row, ] <- beta_sgd
  }
}
history_sgd <- na.omit(history_sgd)

# OLS solution for reference
coef(lm(y_sim ~ x_sim))

# 3D surface: SSE as function of (b0, b1)
ols_coef <- coef(lm(y_sim ~ x_sim))
grid_b0 <- seq(max(0, ols_coef[1] - 1.5), ols_coef[1] + 1.5, length.out = 80)
grid_b1 <- seq(0, ols_coef[2] + 0.6, length.out = 80)
sse_surf <- outer(grid_b0, grid_b1, Vectorize(function(b0, b1) sse_sim(c(b0, b1), x_sim, y_sim)))
z_sgd <- apply(history_sgd, 1, function(b) sse_sim(b, x_sim, y_sim))

# Cap z so the bowl curvature is visible (avoids flat plateau at high SSE)
z_cap <- min(max(z_sgd) * 2.5, quantile(sse_surf, 0.95))
sse_cap <- pmin(sse_surf, z_cap)

p3 <- plot_ly(x = grid_b0, y = grid_b1, z = sse_cap, type = "surface",
              colorscale = "Viridis", opacity = 0.95, showscale = TRUE,
              contours = list(z = list(show = TRUE, usecolormap = FALSE,
                highlightcolor = "white", project = list(z = TRUE))))
p3 <- p3 %>% add_trace(x = history_sgd[, 1], y = history_sgd[, 2],
                       z = pmin(z_sgd, z_cap),
                       type = "scatter3d", mode = "lines+markers",
                       name = "SGD path",
                       line = list(color = "darkblue", width = 3),
                       marker = list(size = 2))
p3 <- p3 %>% layout(
  title = "L(b0,b1) = sum((y_i - b0 - b1*x_i)^2)  [Stochastic gradient descent]",
  scene = list(
    xaxis = list(title = "b0 (intercept)"),
    yaxis = list(title = "b1 (slope)"),
    zaxis = list(title = "SSE"),
    camera = list(eye = list(x = 1.4, y = 1.4, z = 1.1))
  )
)
p3
