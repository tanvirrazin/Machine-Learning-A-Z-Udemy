# Importing the dataset
# ---------------------
dataset = read.csv('../../data_files/Position_Salaries.csv')
dataset = dataset[2:3]

# Fitting Regression to the dataset
# install.packages('e1071')
library(e1071)
regressor = svm(formula = Salary ~ ., data = dataset, type = 'eps-regression')

# Predicting a new result with SVR
y_pred = predict(regressor, data.frame(Level=6.5))

library(ggplot2)

# Build dataset to smoothly visualize pedicted graph in higher resolution
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)

# Visualizing the SVR results
ggplot() +
    geom_point(aes(x=dataset$Level, y=dataset$Salary), color='red') +
    geom_line(aes(x=x_grid, y=predict(regressor, newdata=data.frame(Level=x_grid))), color='blue') +
    ggtitle('Truth and Bluff (SVR)') +
    xlab('Level') +
    ylab('Salary')
