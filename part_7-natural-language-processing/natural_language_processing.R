# Importing the dataset
dataset = read.delim('../data_files/Restaurant_Reviews.tsv', quote='', stringsAsFactors=FALSE)

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
