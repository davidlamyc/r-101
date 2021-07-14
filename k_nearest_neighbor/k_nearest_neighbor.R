## Pros
# Simple
# Training is trivial
# Works with any number of classes
# Easy to add more data
# Few parameters - k, distance metric

## Cons
# High prediction costs (worse for large data sets)
# Not good with high dimension data
# Categorical features don't work well

# left out some installations
install.packages('ggplot2')
install.packages('ggtheme')
install.packages('dplyr')
install.packages('corrgram')
install.packages('corrplot')
install.packages('caTools')
install.packages('Amelia')
install.packages('ISLR')

library(ggplot2)
library(ggthemes)
library(dplyr)
library(corrgram)
library(corrplot)
library(caTools)
library(Amelia)
library(ISLR)

# About the data set - the y feature is whether people purchased insurance from Caravan

str(Caravan)
summary(Caravan$Purchase)

any(is.na(Caravan))

# standardise variable, so scale of variables do not bias results
var(Caravan[, 1]) # 165.0378
var(Caravan[, 2]) # 0.164

purchase = Caravan[,86]
standardized.Caravan = scale(Caravan[, -86])

var(standardized.Caravan[, 1]) # 1
var(standardized.Caravan[, 2]) # 1

test.index = 1:1000
test.data = standardized.Caravan[test.index,]
test.purchase = purchase[test.index]

train.data = standardized.Caravan[-test.index,]
train.purchase = purchase[-test.index]

# KNN model
library(class)

set.seed(101)

predicted.purchase = knn(train.data, test.data, train.purchase, k=1)

head(predicted.purchase)

# get model accuracy rate
misclass.error = mean(test.purchase != predicted.purchase)

print(misclass.error)

# choosing a k value (with elbow method)


