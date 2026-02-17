# ============================================================================
# Lecture 14: Multivariable Optimization
# Calculus I - Critical points, gradient descent, portfolio & neural net examples
# ============================================================================
#
# Run this script step-by-step in RStudio. Each section builds on the previous.
# No output functions (cat/print); results appear when you run each line.
#
# For Part 3 (portfolio): install.packages("tidyquant")  # fetches ETF data from Yahoo
#
# ============================================================================
# SETUP
# ============================================================================

library(mosaicCalc)
library(numDeriv)
library(dplyr)
library(tidyr)
if (!interactive()) pdf(NULL)  # avoid Rplots.pdf when run via Rscript


# ============================================================================
# PART 1: CRITICAL POINTS AND FIRST-ORDER CONDITIONS
# ============================================================================

# ----------------------------------------------------------------------------
# 1.1 Finding critical points: solve grad f = 0
# ----------------------------------------------------------------------------

# f(x,y) = x^2 + y^2 - 2x - 4y + 5
# Gradient: (2x-2, 2y-4) = 0  =>  x=1, y=2
f_quad <- function(v) {
  v[1]^2 + v[2]^2 - 2*v[1] - 4*v[2] + 5
}

# Check: gradient at (1, 2) should be (0, 0)
grad(f_quad, c(1, 2))

# Value at the critical point
f_quad(c(1, 2))

# ----------------------------------------------------------------------------
# 1.2 Using optim() to find minima (numerical)
# ----------------------------------------------------------------------------

# optim minimizes by default; we use "Nelder-Mead" (no gradients) or "BFGS"
opt_result <- optim(par = c(0, 0), fn = f_quad, method = "BFGS")
opt_result$par
opt_result$value

# ============================================================================
# PART 2: SECOND-ORDER CONDITIONS AND HESSIAN
# ============================================================================

# ----------------------------------------------------------------------------
# 2.1 Hessian and second derivative test
# ----------------------------------------------------------------------------
# For f(x,y): D = f_xx*f_yy - f_xy^2
# D > 0, f_xx > 0 => local min
# D > 0, f_xx < 0 => local max
# D < 0 => saddle

H <- hessian(f_quad, c(1, 2))
H

# D = determinant
D_val <- det(H)
D_val

# f_xx (top-left)
H[1, 1]

# Since D > 0 and f_xx > 0: local minimum

# ----------------------------------------------------------------------------
# 2.2 Example with saddle: f(x,y) = x^2 - y^2
# ----------------------------------------------------------------------------

f_saddle <- function(v) v[1]^2 - v[2]^2

# Critical point at (0, 0)
grad(f_saddle, c(0, 0))

# Hessian at (0, 0)
hessian(f_saddle, c(0, 0))

# D = 2*(-2) - 0 = -4 < 0 => saddle point

# ----------------------------------------------------------------------------
# 2.3 Visualize: contour plot with critical point
# ----------------------------------------------------------------------------

f_quad_plot <- makeFun(x^2 + y^2 - 2*x - 4*y + 5 ~ x & y)
contour_plot(f_quad_plot(x, y) ~ x & y, domain(x = -1:3, y = 0:5))

# Add the minimum point
contour_plot(f_quad_plot(x, y) ~ x & y, domain(x = -1:3, y = 0:5)) %>%
  gf_point(2 ~ 1, color = "red", size = 4)

# ============================================================================
# PART 3: PORTFOLIO OPTIMIZATION (ETF data)
# ============================================================================
# Requires: install.packages("tidyquant")
# Downloads real ETF returns from Yahoo Finance and finds mean-variance optimal portfolio
# ----------------------------------------------------------------------------

options(xts.warn_dplyr_breaks_lag = FALSE)  # suppress dplyr/xts conflict warning
library(tidyquant)

# ----------------------------------------------------------------------------
# 3.1 Download ETF price data from Yahoo Finance
# ----------------------------------------------------------------------------
# SPY = S&P 500, QQQ = Nasdaq, IWM = Russell 2000, EEM = Emerging markets,
# BND = Bonds, VNQ = Real estate, GLD = Gold

etf_symbols <- c("SPY", "QQQ", "IWM", "EEM", "BND", "VNQ", "GLD")

# Get ~5 years of daily data (adjust from/to if needed)
etf_prices <- tq_get(etf_symbols, get = "stock.prices", from = "2019-01-01")

# ----------------------------------------------------------------------------
# 3.2 Compute daily returns
# ----------------------------------------------------------------------------

etf_returns <- etf_prices %>%
  group_by(symbol) %>%
  tq_transmute(select = adjusted, mutate_fun = periodReturn, period = "daily", col_rename = "ret") %>%
  ungroup()

# Reshape to wide format: one column per ETF
returns_wide <- etf_returns %>%
  pivot_wider(names_from = symbol, values_from = ret) %>%
  na.omit()

# ----------------------------------------------------------------------------
# 3.3 Mean returns and covariance matrix
# ----------------------------------------------------------------------------

returns_mat <- as.matrix(returns_wide[, names(returns_wide) != "date"])
mu <- colMeans(returns_mat)
Sigma <- cov(returns_mat)

# Annualize (approx 252 trading days)
mu_ann <- mu * 252
Sigma_ann <- Sigma * 252

# ----------------------------------------------------------------------------
# 3.4 Mean-variance objective
# ----------------------------------------------------------------------------
# Maximize: w'mu - lambda * w'Sigma w
# Subject to: sum(w) = 1, w >= 0
# We use a penalty for sum(w) != 1 and box constraints w >= 0

lambda <- 2
n_assets <- length(mu_ann)

portfolio_obj_n <- function(w) {
  w <- w / sum(w)  # normalize to sum to 1
  ret <- sum(w * mu_ann)
  var <- as.numeric(t(w) %*% Sigma_ann %*% w)
  -(ret - lambda * var)
}

# Initial guess: equal weight
w0 <- rep(1 / n_assets, n_assets)

# Optimize (L-BFGS-B allows lower bounds)
opt_port <- optim(par = w0, fn = portfolio_obj_n, method = "L-BFGS-B",
                  lower = rep(0.001, n_assets), upper = rep(1, n_assets))

# Normalize optimal weights
w_opt <- opt_port$par / sum(opt_port$par)
names(w_opt) <- names(mu_ann)

w_opt

# Portfolio expected return and volatility (annualized)
port_ret <- sum(w_opt * mu_ann)
port_vol <- sqrt(as.numeric(t(w_opt) %*% Sigma_ann %*% w_opt))

port_ret
port_vol

# ----------------------------------------------------------------------------
# 3.5 Efficient frontier: vary lambda
# ----------------------------------------------------------------------------

lambdas <- c(0.5, 1, 2, 5, 10)
frontier <- sapply(lambdas, function(lam) {
  obj <- function(w) {
    w <- w / sum(w)
    ret <- sum(w * mu_ann)
    var <- as.numeric(t(w) %*% Sigma_ann %*% w)
    -(ret - lam * var)
  }
  opt <- optim(par = w0, fn = obj, method = "L-BFGS-B",
               lower = rep(0.001, n_assets), upper = rep(1, n_assets))
  w <- opt$par / sum(opt$par)
  c(ret = sum(w * mu_ann), vol = sqrt(t(w) %*% Sigma_ann %*% w))
})

# Plot: risk-return tradeoff
plot(frontier["vol", ], frontier["ret", ], type = "b", pch = 19,
     xlab = "Annual volatility", ylab = "Annual expected return",
     main = "Efficient frontier (varying risk aversion)")

# Individual ETFs for comparison
points(sqrt(diag(Sigma_ann)), mu_ann, col = "gray", pch = 4)
text(sqrt(diag(Sigma_ann)), mu_ann, labels = names(mu_ann), pos = 4, cex = 0.8)

# ============================================================================
# PART 4: GRADIENT DESCENT
# ============================================================================

# ----------------------------------------------------------------------------
# 4.1 Manual gradient descent implementation
# ----------------------------------------------------------------------------

gradient_descent <- function(f, x0, alpha = 0.1, n_iter = 50) {
  x <- x0
  history <- matrix(NA, nrow = n_iter + 1, ncol = length(x0))
  history[1, ] <- x
  for (i in 1:n_iter) {
    g <- grad(f, x)
    x <- x - alpha * g
    history[i + 1, ] <- x
  }
  list(par = x, value = f(x), history = history)
}

# Minimize f(x,y) = x^2 + y^2 starting at (3, 4)
f_sq_vec <- function(v) v[1]^2 + v[2]^2
gd_result <- gradient_descent(f_sq_vec, x0 = c(3, 4), alpha = 0.2, n_iter = 30)

gd_result$par
gd_result$value

# Path of gradient descent
gd_result$history[1:5, ]

# ----------------------------------------------------------------------------
# 4.2 Visualize gradient descent path
# ----------------------------------------------------------------------------

f_sq <- makeFun(x^2 + y^2 ~ x & y)
path <- as.data.frame(gd_result$history)
names(path) <- c("x", "y")

contour_plot(f_sq(x, y) ~ x & y, domain(x = -1:4, y = -1:5)) %>%
  gf_path(y ~ x, data = path, color = "red") %>%
  gf_point(y ~ x, data = path[1, , drop = FALSE], color = "green", size = 4) %>%
  gf_point(y ~ x, data = path[nrow(path), , drop = FALSE], color = "blue", size = 4)
# Green = start, blue = end, red path = gradient descent trajectory

# ============================================================================
# PART 5: NEURAL NETWORK OPTIMIZATION
# ============================================================================

# ----------------------------------------------------------------------------
# 5.1 Single neuron: y_hat = sigmoid(w*x + b)
# ----------------------------------------------------------------------------

sigmoid <- function(z) 1 / (1 + exp(-z))

# MSE loss for one data point (x, y)
loss_one <- function(theta, x, y) {
  w <- theta[1]
  b <- theta[2]
  y_hat <- sigmoid(w * x + b)
  0.5 * (y_hat - y)^2
}

# Gradient of loss (from lecture)
loss_grad <- function(theta, x, y) {
  w <- theta[1]
  b <- theta[2]
  z <- w * x + b
  y_hat <- sigmoid(z)
  dL_dz <- (y_hat - y) * y_hat * (1 - y_hat)
  c(dL_dz * x, dL_dz)
}

# ----------------------------------------------------------------------------
# 5.2 Gradient descent for one data point
# ----------------------------------------------------------------------------

x_data <- 2
y_data <- 1
theta <- c(0.5, 0)
alpha <- 0.5
n_iter <- 20

for (i in 1:n_iter) {
  g <- loss_grad(theta, x_data, y_data)
  theta <- theta - alpha * g
}

theta
sigmoid(theta[1] * x_data + theta[2])

# ----------------------------------------------------------------------------
# 5.3 Multiple data points: batch gradient descent
# ----------------------------------------------------------------------------

# Data: (x, y) pairs
X <- c(1, 2, 3)
Y <- c(0, 1, 1)

# Loss: mean of squared errors
loss_batch <- function(theta) {
  y_hat <- sigmoid(theta[1] * X + theta[2])
  mean(0.5 * (y_hat - Y)^2)
}

# Gradient (mean of per-point gradients)
loss_batch_grad <- function(theta) {
  grads <- sapply(seq_along(X), function(i) loss_grad(theta, X[i], Y[i]))
  rowSums(grads) / length(X)
}

# Optimize
opt_nn <- optim(par = c(0, 0), fn = loss_batch, gr = loss_batch_grad, method = "BFGS")
opt_nn$par
opt_nn$value

# Predictions
sigmoid(opt_nn$par[1] * X + opt_nn$par[2])

# ----------------------------------------------------------------------------
# 5.4 Visualize: loss surface for (w, b)
# ----------------------------------------------------------------------------

loss_surface <- function(v) {
  w <- v[1]
  b <- v[2]
  y_hat <- sigmoid(w * X + b)
  mean(0.5 * (y_hat - Y)^2)
}

# Contour of loss
grid_w <- seq(-2, 4, by = 0.1)
grid_b <- seq(-2, 2, by = 0.1)
loss_vals <- outer(grid_w, grid_b, Vectorize(function(w, b) loss_surface(c(w, b))))

contour(grid_w, grid_b, loss_vals, xlab = "w", ylab = "b", main = "MSE loss surface")
points(opt_nn$par[1], opt_nn$par[2], pch = 19, col = "red", cex = 1.5)
