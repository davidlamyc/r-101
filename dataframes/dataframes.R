# dataframes

state.x77
USPersonalExpenditure
women

data()

# create a dataframes
days = c('Mon','Tue','Wed','Thur','Fri')
temp = c(22.2,23,34,25.6,31)
rain = c(T,T,F,F,T)
df = data.frame(days,temp,rain)
df

str(df)
dim(df)
summary(df)
