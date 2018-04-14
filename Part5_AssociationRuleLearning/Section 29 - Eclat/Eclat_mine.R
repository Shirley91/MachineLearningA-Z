# Eclat

# data preprosessing
# install.packages('arules')
library(arules) 
# dataset = read.csv('Market_Basket_Optimisation.csv', header = F)
dataset = read.transactions('Market_Basket_Optimisation.csv', sep = ',', rm.duplicates = T)
summary(dataset)
itemFrequencyPlot(dataset, topN = 10)

# training Eclat on the dataset
# min support 4*7/7500, 4 times a day for one week, total is 7500
rules = eclat(data = dataset, parameter = list(support = 0.004, minlen = 2))

# visualising the results
inspect(sort(rules, by = 'support')[1:10])
