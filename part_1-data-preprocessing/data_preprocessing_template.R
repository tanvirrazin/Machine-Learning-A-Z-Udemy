# Importing the dataset
# ---------------------
dataset = read.csv('../data_files/Data.csv')
# dataset = dataset[, 2:3]

# Taking care of the missing data
# -------------------------------
dataset$Age = ifelse(is.na(dataset$Age),
					 ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),
					 dataset$Age)

dataset$Salary = ifelse(is.na(dataset$Salary),
						ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
						dataset$Salary)

# Encoding categorical data
# -------------------------
dataset$Country = factor(dataset$Country,
						 levels = c('France', 'Spain', 'Germany'),
						 labels = c(1, 2, 3))
dataset$Purchased = factor(dataset$Purchased,
						 levels = c('No', 'Yes'),
						 labels = c(0, 1))

# Splitting the dataset into the Training set and Test set
# --------------------------------------------------------
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set = subset(dataset, split==TRUE)
test_set = subset(dataset, split==FALSE)

# Feature scaling
# ---------------
training_set[, 2:3] = scale(training_set[, 2:3])
test_set[, 2:3] = scale(test_set[, 2:3])
