# Apriori

# Data pre-processing
library(arules)
dataset = read.csv('../../data_files/Market_Basket_Optimisation.csv', header=FALSE)
dataset = read.transactions('../../data_files/Market_Basket_Optimisation.csv', sep=',', rm.duplicates=TRUE)
summary(dataset)
itemFrequencyPlot(dataset, topN=100)

# Training Apriori on the dataset
rules = apriori(data=dataset, parameter=list(support=0.004, confidence=0.2))

# Visualizing the results
inspect(sort(rules, by='lift')[1:10])
