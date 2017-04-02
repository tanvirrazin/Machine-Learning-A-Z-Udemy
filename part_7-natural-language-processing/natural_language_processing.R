# Importing the dataset
dataset_original = read.delim('../data_files/Restaurant_Reviews.tsv', quote='', stringsAsFactors=FALSE)

# Cleaning the texts
library(tm)
library(SnowballC)
corpus = VCorpus(VectorSource(dataset$Review))  # Making corpus
corpus = tm_map(corpus, content_transformer(tolower))   # Making Lower-case
corpus = tm_map(corpus, removeNumbers)  # Removing numbers
corpus = tm_map(corpus, removePunctuation)  # Removing Punctuation
corpus = tm_map(corpus, removeWords, stopwords())  # Removing stopwords (i.e. this, that, are etc.)
corpus = tm_map(corpus, stemDocument)   # Stemming words
corpus = tm_map(corpus, stripWhitespace)   # Stripping white-spaces

# Creating the Bag of Words model
dtm = DocumentTermMatrix(corpus)
dtm = removeSparseTerms(dtm, 0.999)
dataset = as.data.frame(as.matrix(dtm))
dataset$Liked = dataset_original$Liked

# Encoding the target feature as factor
dataset$Liked = factor(dataset$Liked, levels = c(0, 1))

# Splitting the dataset into the Training set and Test set
# --------------------------------------------------------
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Liked, SplitRatio = 0.8)
training_set = subset(dataset, split==TRUE)
test_set = subset(dataset, split==FALSE)

# Fitting Classifier to training set
#---------------------------------------------
# Create your own classifier here
library(randomForest)
classifier = randomForest(x = training_set[-692],
                          y = training_set$Liked,
                          ntree = 10)

# Predicting the Test set results
#--------------------------------
y_pred = predict(classifier, newdata=test_set[-692])

# Making the Confusion Matrix
cm = table(test_set[, 692], y_pred)
