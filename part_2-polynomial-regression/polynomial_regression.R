# Importing the dataset
# ---------------------
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

# Fitting Linear Regression to the dataset
lin_reg = lm(formula = Salary ~ ., data = dataset)

# Fitting Polynomial Regression to the dataset
dataset$Level2 = dataset$Level^2
poly_reg = lm(formula = Salary ~ ., data = dataset)


