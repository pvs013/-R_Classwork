getwd()
setwd()  # set working directory

statesInfo <- read.csv('stateData.csv')
subset(statesInfo, state.region ==1)

#dataset[rows,cols]
statesInfo[statesInfo$state.region == 1, ]
## same results


reddit <- read.csv('reddit.csv')
str(reddit)
table(reddit$employment.status)  ## show factors for a variable
summary(reddit)

levels(reddit$age.range)

qplot(data = reddit, x = age.range)
qplot(data = reddit, x = income.range)

## order the factors (age.range, income range)
reddit$age.range <- (factor(reddit$age.range, levels = c("Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above"), ordered = T))
reddit$age.range <- (ordered(reddit$age.range, levels = c("Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above")))

