# Increments, rate of change, and instantaneous rate (Lecture 07/08)

library(mosaicCalc)
if (!interactive()) pdf(NULL)  # no Rplots.pdf when run via Rscript

# ---- Helper: increment table for a function and step h ----
increment_table <- function(x_fun, t_vals, h) {
  x      <- x_fun(t_vals)
  Delta1 <- x_fun(t_vals + h) - x_fun(t_vals)
  Delta1_shift  <- x_fun(t_vals + 2*h) - x_fun(t_vals + h)
  Delta2        <- Delta1_shift - Delta1
  Delta1_shift2 <- x_fun(t_vals + 3*h) - x_fun(t_vals + 2*h)
  Delta2_shift  <- Delta1_shift2 - Delta1_shift
  Delta3        <- Delta2_shift - Delta2
  rate   <- Delta1 / h
  data.frame(t = t_vals, x = x, Delta1, Delta2, Delta3, rate)
}

# ---- Helper: plot function with secant segments of length h ----
plot_function_with_segments <- function(x_fun, t_min, t_max, h, main = NULL, seg_col = "steelblue") {
  t_smooth <- seq(t_min, t_max, length.out = 300)
  t_seg    <- seq(t_min, t_max - h, by = h)
  if (length(t_seg) == 0) t_seg <- t_min
  y_lim <- range(c(x_fun(t_smooth), x_fun(t_seg), x_fun(t_seg + h)), na.rm = TRUE)
  title_str <- if (is.null(main)) bquote("h = " ~ .(h)) else main
  plot(t_smooth, x_fun(t_smooth), type = "n", xlab = "t", ylab = "x(t)", main = title_str, ylim = y_lim)
  # Alternate shading: every other h-interval
  usr <- par("usr")
  idx <- seq(1, length(t_seg), by = 2)
  if (length(idx) > 0)
    rect(t_seg[idx], usr[3], t_seg[idx] + h, usr[4], col = adjustcolor(seg_col, alpha.f = 0.2), border = NA)
  # Curve and secant segments
  lines(t_smooth, x_fun(t_smooth), lwd = 2, col = "black")
  segments(t_seg, x_fun(t_seg), t_seg + h, x_fun(t_seg + h), col = seg_col, lwd = 2)
  # Endpoints of each interval (start and end)
  points(c(t_seg, t_seg + h), c(x_fun(t_seg), x_fun(t_seg + h)), pch = 8, col = seg_col, cex = 1.1)
  legend("topleft", legend = c("x(t)", paste0("h = ", h)), col = c("black", seg_col), lwd = 2, bty = "n")
}

# ---- Example functions ----
x_sq   <- makeFun(t^2 ~ t)
x_cube <- makeFun(t^3 ~ t)
x_quad <- makeFun(0.5*t^2 + t ~ t)

# ---- Tables for h = 1 ----
increment_table(x_sq, seq(0, 6, by = 1), h = 1)
increment_table(x_cube, seq(0, 4, by = 1), h = 1)

# ---- Average rate as h gets smaller ----
rate_at_t <- function(x_fun, t, h) (x_fun(t + h) - x_fun(t)) / h
h_vals <- c(1, 0.5, 0.25, 0.1, 0.05, 0.01, 0.001)
data.frame(h = h_vals, avg_rate = sapply(h_vals, function(h) rate_at_t(x_sq, 3, h)))
data.frame(h = h_vals, avg_rate = sapply(h_vals, function(h) rate_at_t(x_cube, 2, h)))

# ---- Table for your choice of h ----
h_user <- 0.5
increment_table(x_sq, seq(0, 6, by = h_user), h = h_user)

# ---- Plots: change h (and title updates automatically) ----
h <- 1
plot_function_with_segments(x_sq, 0, 6, h = h, main = bquote(x(t) == t^2 ~ ",  h = " ~ .(h)))

h <- 0.5
plot_function_with_segments(x_sq, 0, 6, h = h, main = bquote(x(t) == t^2 ~ ",  h = " ~ .(h)))

h <- 0.2
plot_function_with_segments(x_sq, 0, 6, h = h, main = bquote(x(t) == t^2 ~ ",  h = " ~ .(h)))

par(mfrow = c(1, 2))
h <- 1
plot_function_with_segments(x_cube, 0, 4, h = h, main = bquote(x(t) == t^3 ~ ",  h = " ~ .(h)))
h <- 0.25
plot_function_with_segments(x_cube, 0, 4, h = h, main = bquote(x(t) == t^3 ~ ",  h = " ~ .(h)))
par(mfrow = c(1, 1))

# ---- Optional: compare to derivative (mosaicCalc) ----
xp_sq   <- D(x_sq(t) ~ t)
xp_cube <- D(x_cube(t) ~ t)
xp_sq(3)
xp_cube(2)
