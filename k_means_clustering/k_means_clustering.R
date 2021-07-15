library(ISLR)

library(ggplot2)
library(cluster)

iris

pl = ggplot(iris,aes(Petal.Length,Petal.Width, color=Species))
print(pl + geom_point(size=4))

set.seed(101)

irisCluster = kmeans(iris[,1:4],3,nstart=20)

print(irisCluster)

# will not have labels to cross check in real life
table(irisCluster$cluster, iris$Species)

clusplot(iris, irisCluster$cluster, color = T, shade = T, labels = 0, lines = 0)
