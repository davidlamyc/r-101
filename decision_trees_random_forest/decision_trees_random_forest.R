# decision tree

install.packages('rpart')
install.packages('rpart.plot')

library(rpart)
library(rpart.plot)
library(gam)

tree = rpart(Kyphosis ~ ., method='class', data=kyphosis)

printcp(tree)

plot(tree, uniform = T, main = 'Kyphosis Tree')

text(tree, use.n = T, all =T)

prp(tree)

# random forests
install.packages('randomForest')

library(randomForest)

rf.model = randomForest(Kyphosis ~ ., data=kyphosis)

print(rf.model)
