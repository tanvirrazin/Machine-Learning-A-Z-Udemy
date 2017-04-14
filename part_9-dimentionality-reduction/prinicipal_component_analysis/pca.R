# PCA

# Importing the dataset
# ---------------------
dataset = read.csv('../../data_files/Wine.csv')

# Splitting the dataset into the Training set and Test set
# --------------------------------------------------------
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Customer_Segment, SplitRatio = 0.8)
training_set = subset(dataset, split==TRUE)
test_set = subset(dataset, split==FALSE)

# Feature scaling
# ---------------
training_set[, -14] = scale(training_set[, -14])
test_set[, -14] = scale(test_set[, -14])

# Applying PCA
# ------------
library(caret)
library(e1071)
pca = preProcess(x=training_set[-14], method='pca', pcaComp=2)
training_set = predict(pca, training_set)
training_set = training_set[c(2, 3, 1)]
test_set = predict(pca, test_set)
test_set = test_set[c(2, 3, 1)]

# Fitting SVM Classifier to training set
#---------------------------------------
# Create your own classifier here
library(e1071)
classifier = svm(formula=Customer_Segment ~ .,
                 data=training_set,
                 type='C-classification',
                 kernel='linear')

# Predicting the Test set results
#--------------------------------
y_pred = predict(classifier, newdata=test_set[-3])

# Making the Confusion Matrix
cm = table(test_set[, 3], y_pred)

# Visualizing the Training set results
#-------------------------------------
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1] + 1, by=0.01))
X2 = seq(min(set[, 2]) - 1, max(set[, 2] + 1, by=0.01))
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('PC1', 'PC2')
prob_set = predict(classifier, type='response', newdata=grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[, -3],
     main='SVM Classifier (Training Set)',
     xlab='Age', ylab='Estimated Salary',
     xlim=range(X1), ylim=range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add=TRUE)
points(grid_set, pch='.', col=ifelse(
    y_grid == 2, 'deepskyblue', ifelse(
        y_grid == 1, 'springgreen3', 'tomato'
    )
))
points(set, pch=21, bg=ifelse(
    set[, 3] == 2, 'blue3', ifelse(
        set[, 3] == 1, 'green4', 'red3'
    )
))

# Visualizing the Test set results
#---------------------------------
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1] + 1, by=0.01))
X2 = seq(min(set[, 2]) - 1, max(set[, 2] + 1, by=0.01))
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('PC1', 'PC2')
prob_set = predict(classifier, type='response', newdata=grid_set)
y_grid = ifelse(prob_set > 0.5, 1, 0)
plot(set[, -3],
     main='SVM Classifier (Test Set)',
     xlab='Age', ylab='Estimated Salary',
     xlim=range(X1), ylim=range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add=TRUE)
points(grid_set, pch='.', col=ifelse(
    y_grid == 2, 'deepskyblue', ifelse(
        y_grid == 1, 'springgreen3', 'tomato'
    )
))
points(set, pch=21, bg=ifelse(
    set[, 3] == 2, 'blue3', ifelse(
        set[, 3] == 1, 'green4', 'red3'
    )
))
