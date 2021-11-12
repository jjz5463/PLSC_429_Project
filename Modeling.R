# library
library(data.table)
library(ggplot2)
library(stringr)

# fread
df <- fread("/Users/jiachengzhu/Desktop/429Project/Data/processed/final.csv")

# distribution of outcome and gini
ggplot(df,aes(Gini_Coeff,VEP))+geom_point()

# difference between mean and median
df$skew <- df$mean - df$median

# difference between 25th and 75th percentile
df$interPer <- df$`75th_percentile` - df$`25th_percentile`

# distribution of outcome and difference
ggplot(df,aes(skew,VEP))+geom_point()

# null model
model0 <- lm(VEP ~ Gini_Coeff, data = df)
summary(model0)

# model1
model1 <- lm(VEP ~ Gini_Coeff + mean + median
             + one_percent + factor(Region) + skew 
             + interPer + `25th_percentile` + `75th_percentile`
             + `25th_percentile`*`75th_percentile`,data = df)
summary(model1)
