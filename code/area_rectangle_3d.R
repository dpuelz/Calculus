# 3D plot: Area of a rectangle A = length × width

if (!interactive()) pdf(NULL)

# Grid: length and width from 0 to 5
len <- seq(0, 5, length.out = 40)
wid <- seq(0, 5, length.out = 40)
# Area matrix
area <- outer(len, wid, function(l, w) l * w)

# 3D surface (base R)
persp(len, wid, area,
      theta = 65, phi = 0, expand = 0.6,
      col = "lightblue", border = "gray40",
      xlab = "Length", ylab = "Width", zlab = "Area",
      main = "Area of a rectangle:  A = length × width")
