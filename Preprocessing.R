# library
library(data.table)

# load data
gini <- fread("/Users/jiachengzhu/Desktop/429Project/Data/Gini_Coeff.csv")
mean <- fread("/Users/jiachengzhu/Desktop/429Project/Data/Mean_Income.csv")
median <- fread("/Users/jiachengzhu/Desktop/429Project/Data/Median_Income.csv")
one_percent <- fread("/Users/jiachengzhu/Desktop/429Project/Data/One_Percent.csv")
region <- fread("/Users/jiachengzhu/Desktop/429Project/Data/regions.csv")
turnout <- fread("/Users/jiachengzhu/Desktop/429Project/Data/Turnout.csv")
percentile <- fread("/Users/jiachengzhu/Desktop/429Project/Data/percentile.csv")

# feature selection for income
gini <- gini[,c("State Abv","Gini_Coeff")]
mean <- mean[,c("State Abv","Average Income")]
median <- median[,c("State Abv","Median Household Income")]
one_percent <- one_percent[,c("State Abv","Top 1% Household Income")]

# merge income tables
income <- merge(gini,mean,by="State Abv")
income <- merge(income,median,by="State Abv")
income <- merge(income,one_percent,by="State Abv")

# feature selection for region
region <- region[,c("State Code","Region")]

# feature selection for turnout
turnout <- turnout[,c("State Abv","VEP Turnout Rate")]

# feature selection for percentile
percentile <- percentile[,c('State Abv','25th_percentile','75th_percentile')]

# merge everything
final <- merge(income,region,by.x="State Abv",by.y="State Code")
final <- merge(final,turnout,by="State Abv")
final <- merge(final,percentile,by="State Abv")

# renaming
setnames(final, "State Abv", "state")
setnames(final, "Average Income", "mean")
setnames(final, "Median Household Income", "median")
setnames(final, "Top 1% Household Income", "one_percent")
setnames(final, "VEP Turnout Rate", "VEP")

# change data types
final$mean <- substring(final$mean, 2)
final$mean <- str_replace_all(final$mean,",","")
final$mean <- as.numeric(final$mean)

final$median <- substring(final$median, 2)
final$median <- str_replace_all(final$median,",","")
final$median <- as.numeric(final$median)

final$one_percent <- substring(final$one_percent, 2)
final$one_percent <- str_replace_all(final$one_percent,",","")
final$one_percent <- as.numeric(final$one_percent)

final$VEP <- str_replace_all(final$VEP,"%","")
final$VEP <- as.numeric(final$VEP)
final$VEP <- final$VEP/100

# write pre-processed data
fwrite(final, "/Users/jiachengzhu/Desktop/429Project/Data/processed/final.csv")
