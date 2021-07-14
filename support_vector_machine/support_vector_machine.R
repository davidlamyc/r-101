install.packages('e1071')

library(ISLR)
library(e1071)

iris

model = svm(Species ~ ., data = iris)
summary(model)

pred.values = predict(model, iris[1:4])

table(pred.values,iris[,5])

tune.results = tune(svm, train.x = iris[1:4], train.y = iris[,5], kernel='radial', ranges=list(cost=c(0.1,1,10),gamma=c(0.5,1,2)))

table(pred.values,iris[,5])
