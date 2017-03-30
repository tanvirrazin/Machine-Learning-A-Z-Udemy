# Apriori

# Data pre-processing
library(arules)
dataset = read.csv('../../data_files/Market_Basket_Optimisation.csv', header=FALSE)
dataset = read.transactions('../../data_files/Market_Basket_Optimisation.csv', sep=',', rm.duplicates=TRUE)
summary(dataset)
itemFrequencyPlot(dataset, topN=100)

# Training Eclat on the dataset
rules = eclat(data=dataset, parameter=list(support=0.004, minlen=2))

# Visualizing the results
inspect(sort(rules, by='lift')[1:10])
