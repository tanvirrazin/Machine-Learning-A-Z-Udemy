# K-means clustering

# Importing the mall dataset
dataset <- read.csv('../../data_files/Mall_customers.csv')
X <- dataset[4:5]

# Using Elbow Method to find the optimal number of clusters
set.seed(6)
wcss <- vector()
for (i in 1:10) wcss[i] <- sum(kmeans(X, i)$withinss)
plot(1:10, wcss, type="b", main=paste('Clusters of clients'), xlab="Number of clusters", ylab="WCSS")

# Applying k-means to the mall dataset
set.seed(29)
kmeans <- kmeans(X, 5, iter.max=300, nstart=10)

# Visualizing the clusters
library(cluster)
clusplot(X,
        kmeans,
        lines=0,
        shade=TRUE,
        color=TRUE,
        labels=2,
        plotchar=FALSE,
        span=TRUE,
        main=paste('Clusters of clients'),
        xlab="Annual Income",
        ylab="Spending Score")
