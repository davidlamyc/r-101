install.packages('dplyr')
install.packages('nycflights13')

library(dplyr)
library(nycflights13)

head(flights)

# make sure dplyr is imported, else base functions are used

# filter
head(filter(flights, month==11, day==3))

# slice
slice(flights, 1:10)

# arrange - ascending by default
head(arrange(flights, year, month, day, desc(air_time)))

# select
head(select(flights, carrier, arr_time))

# rename - rename columns
rename(flights, airline_carrier = carrier)

# distinct - select the distinct values in a column or table
distinct(select(flights, carrier))

# mutate - add new columns that are functions of existing columns
head(mutate(flights, new_col = arr_delay - dep_delay))

# transmute - if you only want new columns return, which are functions of old columns
head(transmute(flights, transmute_col = arr_delay - dep_delay))

# summarise - should mostly be getting just one row with the aggregated data
summarise(flights, avg_air_time=mean(air_time,na.rm = TRUE)) # mean of air time
summarise(flights, total_time=sum(air_time,na.rm=TRUE)) # sum of air time

# sample_n and sample_frac - get a sample of rows
sample_n(flights,10)
sample_frac(flights,0.1)

# pipe operators
df = mtcars
result = df %>% filter(mpg>20) %>% sample_n(size=5) %>% arrange(desc(mpg))
result
