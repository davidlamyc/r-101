# left out some installations
install.packages('ggplot2')
install.packages('ggtheme')
install.packages('dplyr')
install.packages('corrgram')
install.packages('corrplot')
install.packages('caTools')

library(ggplot2)
library(ggthemes)
library(dplyr)
library(corrgram)
library(corrplot)
library(caTools)

# assumes the working directory is 'r-101'
current.dir = getwd()
full.path = paste(getwd(), 'linear_regression/student-mat.csv', sep="/", collapse=NULL)

df = read.csv(full.path, sep=';')

# check for empty values
any(is.na(df))

# filter to grab numerical columns
num.cols = sapply(df, is.numeric)

cor.data = cor(df[, num.cols])

# exploratory analysis
print(cor.data)

corrplot(cor.data, method='color')

# corrgram without configs
corrgram(df)

# corrgram with configs
corrgram(df, order=TRUE, lower.panel = panel.shade, upper.panel = panel.pie, text.panel = panel.txt)

# look at the distribution of G3
ggplot(df, aes(x=G3)) + geom_histogram(bins=20, alpha=0.5, fill='blue')

# linear regression
set.seed(101)

# Split sample
# any column is ok for first argument

# 70% training data, 30% test data
sample = sample.split(df$G3, SplitRatio = 0.7)

train = subset(df, sample == TRUE)
test = subset(df, sample == FALSE)

# linear regression model
# model = lm(y ~ x1 + x2, data) # example
model = lm(G3 ~ ., data = train)

# use all features in the data set
# model = lm(y ~ ., data)

# intepret the model
print(summary(model))

# residuals - different between data points and model results
res = residuals(model)
res = as.data.frame(res)
head(res)

# normally distributed residuals is desirable
ggplot(res, aes(res)) + geom_histogram(fill='blue', alpha=0.5)

# get residual plots
plot(model)

# Predictions
G3.predictions = predict(model, test)

results = cbind(G3.predictions, test$G3)
colnames(results) = c('predicted', 'actual')
results = as.data.frame(results)
print(head(results))

# take care of negative values (on test scores)
to_zero = function(x) {
  if (x < 0) {
    return(0)
  } else {
    return(x)
  }
}

# apply zero function
results$predicted = sapply(results$predicted, to_zero)

# mean squared error
mse = mean((results$actual - results$predicted) ^ 2)

print('MSE')
print(mse)

# rmse
print('square root of MSE')
print(mse ^ 0.5)

SSE = sum((results$predicted - results$actual) ^ 2)
SST = sum((mean(df$G3) - results$actual) ^ 2)

R2 = 1 - SSE/SST
print('R2')
print(R2)


