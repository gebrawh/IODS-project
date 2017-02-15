# Arjen Gebraad
# 14.02.2017
# Data wrangling using Human development" and "Gender inequality" data

# Read the "Human development" and "Gender inequality" datas into R. 
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables.
str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

# rename the variables
colnames(hd) <- c("HDI_rank", "country", "HDI", "life_exp", "edu_exp", "edu_mean", "GNI", "GNI_minus_HDI_rank")
colnames(gii) <- c("GII_rank", "country", "GII", "maternal_mortality", "adolescent_birth", "parliament_repr", "edu2_F", "edu2_M", "labour_F", "labour_M")

# define a new column in gii edu2_ratio
gii <- mutate(gii, edu2_ratio = edu2_F / edu2_M)

# define a new column in gii labour_ratio
gii <- mutate(gii, labour_ratio = labour_F / labour_M)

# join the two datasets by country
library(dplyr)
human <- inner_join(hd, gii, by = "country")

# make sure everything is in order, Save the joined and modified data set to the 'data' folder

glimpse(human)

write.csv(human, file = "human.csv")
