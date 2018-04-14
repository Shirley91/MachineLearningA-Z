# Regression

# Multiple linear regression

# Importing the dataset
dataset = read.csv("/Users/yaru/Dropbox/DataScience/Machine Learning A-Z Template Folder/Part 2 - Regression/Section 5 - Multiple Linear Regression/50_Startups.csv")

# Encoding categorical data
dataset$State = factor(dataset$State,
                         levels = c('New York', 'California', 'Florida'),
                         labels = c(1, 2, 3))

# Splitting the dataset into the Training set and Test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Multiple linear regression to the Trainning set
regressor = lm(formula = Profit ~ ., 
               data = training_set)
# . means all the indenpended varibles: R.D.Spend,Administation,Marketing.Speed,State
summary(regressor)          

# Predicting the test set results
y_pred = predict(regressor,newdata=test_set)

# Building the optimal model with backward elimination
regressor = lm (formula = Profit ~ R.D.Spend+Administration+Marketing.Spend+State,
                data = dataset)
summary(regressor) 

regressor = lm (formula = Profit ~ R.D.Spend+Administration+Marketing.Spend,
                data = dataset)
summary(regressor)

regressor = lm (formula = Profit ~ R.D.Spend+Marketing.Spend,
                data = dataset)
summary(regressor)

regressor = lm (formula = Profit ~ R.D.Spend,
                data = dataset)
summary(regressor)
