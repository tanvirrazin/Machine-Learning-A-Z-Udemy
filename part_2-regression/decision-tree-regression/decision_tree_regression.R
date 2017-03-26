# Importing the dataset
# ---------------------
dataset = read.csv('../../data_files/Position_Salaries.csv')
dataset = dataset[2:3]

# Fitting Decision Tree Regression to the dataset
library(rpart)
regressor = rpart(formula = Salary ~ ., data = dataset, control = rpart.control(minsplit = 1))

# Predicting a new result with Decision Tree Regression
y_pred = predict(regressor, data.frame(Level=6.5))

library(ggplot2)

# Build dataset to smoothly visualize pedicted graph in higher resolution
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)

# Visualizing the Decision Tree Regression results
ggplot() +
    geom_point(aes(x=dataset$Level, y=dataset$Salary), color='red') +
    geom_line(aes(x=x_grid, y=predict(regressor, newdata=data.frame(Level=x_grid))), color='blue') +
    ggtitle('Truth and Bluff (Decision Tree)') +
    xlab('Level') +
    ylab('Salary')
