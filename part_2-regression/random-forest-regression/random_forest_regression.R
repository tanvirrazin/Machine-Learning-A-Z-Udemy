# Importing the dataset
# ---------------------
dataset = read.csv('../../data_files/Position_Salaries.csv')
dataset = dataset[2:3]

# Fitting Regression to the dataset
# install.packages('randomForest')
library(randomForest)
set.seed(1234)
regressor = randomForest(x=dataset[1],
						 y=dataset$Salary,
						 ntree=500)

# Predicting a new result with Polynomial Regression
y_pred = predict(regressor, data.frame(Level=6.5))

library(ggplot2)

# Build dataset to smoothly visualize pedicted graph in higher resolution
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)

# Visualizing the Polynomial Regression results
ggplot() +
    geom_point(aes(x=dataset$Level, y=dataset$Salary), color='red') +
    geom_line(aes(x=x_grid, y=predict(regressor, newdata=data.frame(Level=x_grid))), color='blue') +
    ggtitle('Truth and Bluff (Random Forest Regression Model)') +
    xlab('Level') +
    ylab('Salary')
