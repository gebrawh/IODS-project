# Arjen Gebraad 30.01.2017
# Exercise 2 data wrangling

# data wrangling 2

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header=TRUE)

str(lrn14)
dim(lrn14)

# lrn2014 has 183 objects with 60 variables with mostly 5 levels, there are also variables for age, attitude, points and gender

# data wrangling 3

library(dplyr)

lrn14.analysis <- select(lrn14,one_of(c("Age","Attitude","Points","gender")))

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")


# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14.analysis$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14.analysis$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14.analysis$stra <- rowMeans(strategic_columns)

lrn14.analysis <- filter(lrn14.analysis, Points > 0)

# data wrangling 4

write.table(lrn14.analysis, file = "data/lrn2014.txt")
lrn2014 <- read.table("data/lrn2014.txt", header = TRUE)
str(lrn2014)
head(lrn2014)




