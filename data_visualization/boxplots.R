library(ggplot2)

df = mtcars

pl = ggplot(df,aes(x=factor(cyl),y=mpg))

print(pl + geom_boxplot(fill='blue'))
