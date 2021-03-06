##########################
### BIOS 6623 Project 0
### Michaela Palumbo
### Data Checking and Descriptives
##########################

## IMPORTING DATA

dat <- read.csv("~/Documents/CU AMC Fall 2017/BIOS6623/Project0_dental_data.csv")
head(dat)

## DATA CHECKING
summary(dat)
str(dat)

## EXAMINING CONTINUOUS VARIABLES

# age
summary(dat$age)
mean(dat$age, na.rm = TRUE)
range(dat$age, na.rm = TRUE)
hist(dat$age, main = "Age")

# sites
summary(dat$sites)
mean(dat$sites)
range(dat$sites)
hist(dat$sites, main = "Number of Sites in Mouth")

# attachment - baseline (pre)
summary(dat$attachbase)
mean(dat$attachbase)
range(dat$attachbase)
hist(dat$attachbase)

# attachment - 1 year (post)
summary(dat$attach1year)
mean(dat$attach1year, na.rm = TRUE)
range(dat$attach1year, na.rm = TRUE)
hist(dat$attach1year)

# pocket depth - baseline (pre)
summary(dat$pdbase)
mean(dat$pdbase)
range(dat$pdbase)
hist(dat$pdbase)

# pocket depth - 1 year (post)
summary(dat$pd1year)
mean(dat$pd1year, na.rm = TRUE)
range(dat$pd1year, na.rm = TRUE)
hist(dat$pd1year)

## EXAMINING CATEGORICAL VARIABLES

# treatment group
dat$trtgroup <- factor(dat$trtgroup, levels = c(1, 2, 3, 4, 5),
                       labels = c("placebo", "control", "low", "med", "high"))
summary(dat$trtgroup)
str(dat$trtgroup)
attributes(dat$trtgroup)
table(dat$trtgroup)
dat$trtgroup <- relevel(dat$trtgroup, ref = 2) #re-leveling so control is reference instead of placebo

# sex
dat$sex <- factor(dat$sex, levels = c(1, 2), labels = c("male", "female"))
summary(dat$sex)
attributes(dat$sex)
table(dat$sex)

# race
summary(dat$race)
hist(dat$race)
dat$race <- factor(dat$race, levels = c(1, 2, 4, 5), 
                   labels = c("native american", "african american", "asian", "white"))
summary(dat$race)
attributes(dat$race)
table(dat$race)

# smoking status (smoker?)
summary(dat$smoker)
hist(dat$smoker)
dat$smoker <- factor(dat$smoker, levels = c(0, 1), labels = c("no", "yes"))
summary(dat$smoker)
attributes(dat$smoker)
table(dat$smoker)

# CREATING DIFFERENCE VARIABLES
dat$atdiff <- dat$attach1year - dat$attachbase

dat$pddiff <- dat$pd1year - dat$pdbase

# SEE IF THERE IS A PATTERN TO THE DROPOUT
dropout.rows <- which(is.na(dat$pd1year)) # gives the row numbers for the people that dropped out at 1year
dat.dropout <- dat[dropout.rows, ]
table(dat.dropout$trtgroup)
#useful plot showing trend of dropout across treatment groups
plot(dat.dropout$trtgroup, xlab = "treatment group", ylab = "# subjects missing at 1 year",
     main = "Trend in Participant Dropout Across Groups", 
     col = c("green", "blue", "red", "red", "red"))

#DATA WITH 27 dropouts removed
dat.nomissing <- dat[!is.na(dat$pd1year), ] #only 103 variables, lm drops these automatically


# Examine trends across groups
aggregate(pddiff ~ trtgroup, dat, mean)
aggregate(pddiff ~ trtgroup, dat, sd)
aggregate(atdiff ~ trtgroup, dat, mean)
aggregate(atdiff ~ trtgroup, dat, sd)


