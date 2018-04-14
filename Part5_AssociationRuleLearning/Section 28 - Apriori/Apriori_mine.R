# Apriori

# data preprosessing
# install.packages('arules')
library(arules) 
# dataset = read.csv('Market_Basket_Optimisation.csv', header = F)
dataset = read.transactions('Market_Basket_Optimisation.csv', sep = ',', rm.duplicates = T)
summary(dataset)
itemFrequencyPlot(dataset, topN = 100)

# training Apriori on the dataset
# min support 3*7/7500, 3 times a day for one week, total is 7500
# min confidence default value 0.8 showed no rules then 0.8/2=0.4 then 0.4/2=0.2 to get more rules
rules = apriori(data = dataset, parameter = list(support = 0.003, confidence = 0.2))

# visualising the results
inspect(sort(rules, by = 'lift')[1:10])
