library(ggplot2)
df = mtcars

# data & aesthetics
pl = ggplot(data = df, aes(x=wt,y=mpg))

# geometry
print(pl + geom_point())
# print(pl + geom_point(alpha=0.5,size=5))
print(pl + geom_point(aes(size=factor(cyl)))) # visualise another dimension, cyl by size on the scatterpoint in this case
print(pl + geom_point(aes(color=hp),size=5)) # visualise another dimension, hp by color on the scatterpoint in this case