library(ggplot2)

mtcars

str(mtcars)

# Change the point size, and shape
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point(size=2, shape=23)

ggplot(mtcars, aes(x = mpg, fill =factor(cyl))) + geom_histogram(binwidth = 5, col = "black") + ggtitle("Histogram of MPG")
