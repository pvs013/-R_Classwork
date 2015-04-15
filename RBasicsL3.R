list.files()
library(ggplot2)
pf <- read.csv('./data/pseudo_facebook.tsv', sep = '\t')
## read.delim()   would also work

names(pf)
qplot(x = dob_day, data = pf) +
    scale_x_discrete(breaks=1:31) +
    facet_wrap(~dob_month, ncol=3)

# histogram of friend count
qplot(x = friend_count, data = pf)
# this is called long tail data

#limiting the axis data
qplot(x = friend_count, data = pf, xlim = c(0,1000))   ## limits to 1000
qplot(x = friend_count, data = pf) + scale_x_continuous(limits = c(0,1000))

# bin width
qplot(x = friend_count, data = pf, binwidth = 25) +
    scale_x_continuous(limits = c(0,1000), breaks = seq(0,1000, 50))

##  friends by gender
qplot(x = friend_count, data = pf, binwidth = 25) + 
    scale_x_continuous(limits = c(0, 1000), breaks = seq(0, 1000, 50)) +
    facet_wrap(~gender)

##  friends by gender   - remove NA
qplot(x = friend_count, data = subset(pf, !is.na(gender)), binwidth = 25) + 
    scale_x_continuous(limits = c(0, 1000), breaks = seq(0, 1000, 50)) +
    facet_wrap(~gender)

table(pf$gender)
by(pf$friend_count, pf$gender, summary)

## add tenure, and color/fill
qplot(x=tenure, data=pf, binwidth = 30,
      color = I('black'), fill = I('#099DD9'))

## tenure in years
qplot(x=tenure/365, data=pf, binwidth = .25,
      color = I('black'), fill = I('#099DD9')) +
    scale_x_continuous(breaks = seq(1, 7, 1), limits = c(0,7))  ## adjusts x axis

## improving labels, verses the defaults
##  xlab and ylab
qplot(x=tenure/365, data=pf, binwidth = .25,
      xlab = 'Number of years using facebook',
      ylab = 'Number of users in sample',
      color = I('black'), fill = I('#099DD9')) +
    scale_x_continuous(breaks = seq(1, 7, 1), limits = c(0,7))  ## adjusts x axis

## histogram of facebook users by ages
qplot(x=age, data=pf, binwidth = 1,
      xlab = 'Age of users',
      ylab = 'Number of users in sample',
      color = I('black'), fill = I('#099DD9')) +
    scale_x_continuous(breaks = seq(0,120,5) , limits = c(0,120))  ## adjusts x axis

## Transforming Data ... tailed data or "over-dispersed
##   log base 2 or log base 10
summary(pf$friend_count)
summary(log10(pf$friend_count + 1))
summary(sqrt(pf$friend_count))

## use Scales and create multiple plots on one page 
##  - use gridExtra package
library(gridExtra)
g1 <- qplot(x = friend_count, data = pf) 
g2 <- qplot(x = log10(friend_count+1), data = pf) 
g3 <- qplot(x = sqrt(friend_count), data = pf) 
grid.arrange(g1, g2, g3, ncol=1)

Alternative solution
g1 <- ggplot(aes(x=friend_count), data=pf) + geom_histogram()
g2 <- g1 + scale_x_log10()
g3 <- g1 + scal_x_sqrt()
grid.arrange(g1,g2,g3, ncol=1)
