# To install and run the R console in Debian Linux:
# $ sudo apt install r-base
# $ R

# Single Regression

income.data <- read.csv("income.data.csv")
summary(income.data)

hist(income.data$happiness)

plot(happiness ~ income, data = income.data)


# Multiple Regression

heart.data <- read.csv("heart.data.csv")
summary(heart.data)

plot(heart.disease ~ biking, data=heart.data)

plot(heart.disease ~ smoking, data=heart.data)

income.happiness.lm <- lm(happiness ~ income, data = income.data)
summary(income.happiness.lm)
