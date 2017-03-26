# Importing the dataset
# ---------------------
dataset = read.csv('../../data_files/Salary_Data.csv')
# dataset = dataset[, 2:3]

# Splitting the dataset into the Training set and Test set
# --------------------------------------------------------
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
training_set = subset(dataset, split==TRUE)
test_set = subset(dataset, split==FALSE)

# Fitting Simple Linear Regression on the Training set
regressor = lm(formula = Salary ~ YearsExperience,
               data = training_set)

# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)

# Visualising the Training set results
library(ggplot2)
ggplot() +
    geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
               colour = 'red') +
    geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
              colour = 'blue') +
    ggtitle('Salary vs Experience (Training set)') +
    xlab('Years of Experience') +
    ylab('Salary')

# Visualising the Test set results
ggplot() +
    geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
               colour = 'red') +
    geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
              colour = 'blue') +
    ggtitle('Salary vs Experience (Test set)') +
    xlab('Years of Experience') +
    ylab('Salary')
