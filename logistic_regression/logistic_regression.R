# left out some installations
install.packages('ggplot2')
install.packages('ggtheme')
install.packages('dplyr')
install.packages('corrgram')
install.packages('corrplot')
install.packages('caTools')
install.packages('Amelia')

library(ggplot2)
library(ggthemes)
library(dplyr)
library(corrgram)
library(corrplot)
library(caTools)
library(Amelia)

# assumes the working directory is 'r-101'
current.dir = getwd()
full.path = paste(getwd(), 'logistic_regression/adult_sal.csv', sep="/", collapse=NULL)
adult = read.csv(full.path)

print(head(adult))

# remove unneccessary X with dplyr
adult = select(adult, -X)

table(adult$type_employer)

## Data cleaning

# Combine employer types
unemp = function(job) {
  job = as.character(job)
  if (job == 'Never-worked' |  job == 'Without-pay') {
    return('Unemployed')
  } else if (job == 'Self-emp-inc' | job == 'Self-emp-not-inc') {
    return('self-emp')
  } else if (job == 'Local-gov' | job == 'State-gov') {
    return('SL-gov')
  }else {
    return(job)
  }
}

adult$type_employer = sapply(adult$type_employer, unemp)
print(table(adult$type_employer))

# Combine marital status
group_marital = function(mar) {
  mar = as.character(mar)
  
  if (mar == 'Separated' | mar == 'Divorced' | mar == 'Widowed') {
    return('Not-Married')
  } else if (mar == 'Never-married') {
    return(mar)
  } else {
    return('Married')
  }
}

adult$marital = sapply(adult$marital, group_marital)

print(table(adult$marital))

# Combine country
print(table(adult$country))

Asia = c('China','Hong','India','Iran','Cambodia','Japan','Laos','Philippines','Vietnam','Taiwan','Thailand')

North.America = c('Canada','United-States','Puerto-Rico')

Europe = c('England','France','Germany','Greece','Holand-Netherlands','Hungary','Ireland','Italy','Poland','Portugal','Scotland','Yugoslavia')

Latin.and.South.America = c('Columbia','Cuba','Dominican-Republic','Ecuador','El-Salvador','Guatemala','Haiti','Honduras','Mexico','Nicaragua','Outlying-US(Guam-USVI-etc)','Peru','Jamaica','Trinadad&Tobago')

Other = c('South')

group_country = function(ctry) {
  if (ctry %in% Asia) {
    return('Asia')
  } else if (ctry %in% North.America) {
    return('North.America')
  } else if (ctry %in% Europe) {
    return('Europe')
  } else if (ctry %in% Latin.and.South.America) {
    return('Latin.and.South.America')
  } else {
    return('Other')
  }
}

adult$country = sapply(adult$country, group_country)
print(table(adult$country))

print(str(adult))

# clean missing data
adult[adult=='?'] = NA

print(table(adult$type_employer))

# factor
adult$type_employer = sapply(adult$type_employer, factor)
adult$country = sapply(adult$country, factor)
adult$marital = sapply(adult$marital, factor)

# missing values map
# missmap(adult)
missmap(adult, y.at=c(1), y.labels=c(''),col=c('yellow','black'))

# drop data with missing data points
adult = na.omit(adult)
missmap(adult, y.at=c(1), y.labels=c(''),col=c('yellow','black')) # check missingness again

# exploratory analysis
ggplot(adult, aes(age)) + geom_histogram(aes(fill=income), color='black', binwidth=1) + theme_bw()

ggplot(adult, aes(hr_per_week)) + geom_histogram() + theme_bw()

# rename country to rename region
adult = rename(adult, region = country)

# factorise y
adult$income <- sapply(adult$income,factor)

pl = ggplot(adult, aes(region)) + geom_bar(aes(fill=income), color='black') + theme_bw()

# logistic regression (classification model)

# train test split
set.seed(101)

sample = sample.split(adult$income, SplitRatio = 0.7)

train = subset(adult,sample==T)

test = subset(adult,sample==F)

model = glm(income ~ ., family = binomial(link = 'logit'), data = train)

summary(model)

new.step.model = step(model)

test$predicted.income = predict(model, newdata = test, type = 'response')

# create confusion matrix
table(test$income, test$predicted.income > 0.5)

# accuracy
acc = (6372+1423)/(6372+548+872+1423)
acc

# recall
6732/(6732+548)

# precision
6732/(6374+872)
