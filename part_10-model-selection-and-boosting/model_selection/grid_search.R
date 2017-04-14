# Importing the dataset
# ---------------------
dataset = read.csv('../../data_files/Social_Network_Ads.csv')
dataset = dataset[, 3:5]

# Splitting the dataset into the Training set and Test set
# --------------------------------------------------------
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set = subset(dataset, split==TRUE)
test_set = subset(dataset, split==FALSE)

# Feature scaling
# ---------------
training_set[, 1:2] = scale(training_set[, 1:2])
test_set[, 1:2] = scale(test_set[, 1:2])

# Fitting Classifier to training set
#---------------------------------------------
library(e1071)
classifier = svm(formula=Purchased ~ .,
                 data=training_set,
                 type='C-classification',
                 kernel='radial')

# Predicting the Test set results
#--------------------------------
y_pred = predict(classifier, newdata=test_set[-3])

# Making the Confusion Matrix
cm = table(test_set[, 3], y_pred)

# Applying k-Fold Cross Validation
library(caret)
folds = createFolds(training_set$Purchased, k=10)
cv = lapply(folds, function(x) {
    training_fold = training_set[-x, ]
    test_fold = training_set[x, ]
    classifier = svm(formula=Purchased ~ .,
                     data=training_fold,
                     type='C-classification',
                     kernel='radial')
    y_pred = predict(classifier, newdata=test_fold[-3])
    cm = table(test_fold[, 3], y_pred)
    accuracy = (cm[1, 1] + cm[2, 2]) / (cm[1, 1] + cm[2, 2] + cm[1, 2] + cm[2, 1])
    return(accuracy)
})
accuracy = mean(as.numeric(cv))

# Applying Grid Search to find the best parameters
library(caret)
classifier = train(form=Purchased ~ ., data=training_set, method='svmRadial')
classifier$bestTune
