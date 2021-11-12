# library
library(data.table)
library(ggplot2)
library(stringr)

# fread
df <- fread("/Users/jiachengzhu/Desktop/429Project/Data/processed/final.csv")

# distribution of outcome and gini
ggplot(df,aes(Gini_Coeff,VEP))+geom_point()+geom_smooth(method = lm) + 
  labs(title = "Plot 1: Voter Turnout and Gini")

# difference between mean and median
df$Skew <- df$mean - df$median

# distribution of outcome and skew
ggplot(df,aes(Skew,VEP))+geom_point() + geom_smooth(method = lm) + 
  labs(title = "Plot 2: Voter Turnout and Skewness")

# difference between 25th and 75th percentile
df$interPer <- abs(df$`75th_percentile` - df$`25th_percentile`)

# distribution of outcome and Inter-percentile range
ggplot(df,aes(interPer,VEP))+geom_point() + geom_smooth(method = lm) + 
  labs(title = "Plot 3: Voter Turnout and Inter-Percentile Range")

# null model
model0 <- lm(VEP ~ Gini_Coeff, data = df)
summary(model0)

# model1
model1 <- lm(VEP ~ Gini_Coeff #+ mean + median
             + one_percent + factor(Region) + Skew
             + interPer,data = df)
summary(model1)
