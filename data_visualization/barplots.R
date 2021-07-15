library(ggplot2)

df = mpg

pl = ggplot(df,aes(x=class))

print(pl + geom_bar(color='blue', fill='blue'))
print(pl + geom_bar(aes(fill=drv))) # count of cars by class, broken down by drv

