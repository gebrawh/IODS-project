# Arjen Gebraad
# 07.02.2017
# Data wrangling part for exercise 3 using UCI Machine Learning Repository, Student Alcohol consumption data

#3 read data into R

math <- read.csv("student-mat.csv", header = TRUE, sep = ";")
por <- read.csv("student-por.csv", header = TRUE, sep = ";")

str(math)
dim(math)

str(por)
dim(por)

#4 join the two datasets

library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

# Explore the structure and dimensions of the joined data.
str(math_por)
dim(math_por)


#5 ombine the 'duplicated' answers in the joined data

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

#6 create new columns 'alc_use' and'high_use' 

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

#7 make sure everything is in order, Save the joined and modified data set to the 'data' folder

glimpse(alc)

write.csv(alc, file = "alc.csv")

