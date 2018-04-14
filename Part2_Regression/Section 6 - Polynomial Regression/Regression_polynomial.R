# Regression

# Polynomial regression

# Importing the dataset
dataset = read.csv("/Users/yaru/Dropbox/DataScience/Machine Learning A-Z Template Folder/Part 2 - Regression/Section 6 - Polynomial Regression/Position_Salaries.csv")
dataset = dataset[2:3]

# Linear regression to the dataset
lin_reg = lm(formula = Salary ~ Level, 
             data = dataset)
summary(lin_reg)  

# Polynomial linear regression to the dataset
dataset$Level2 = dataset$Level^2
dataset$Level3 = dataset$Level^3
dataset$Level4 = dataset$Level^4
poly_reg = lm(formula = Salary ~ ., 
               data = dataset)
summary(poly_reg)          

# Visualising the linear regression results
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             color = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(lin_reg, newdata = dataset)),
            color = 'blue') +
  ggtitle('Truth or Bluff (linear regression)') +
  xlab('Level') +
  ylab('Salary')

# Visualising the polynomial regression results
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             color = 'red') +
  geom_line(aes(x = x_grid, y = predict(poly_reg, newdata = data.frame(Level = x_grid,
                                                                       Level2 = x_grid^2,
                                                                       Level3 = x_grid^3,
                                                                       Level4 = x_grid^4))),
            color = 'blue') +
  ggtitle('Truth or Bluff (polynomial regression)') +
  xlab('Level') +
  ylab('Salary')

# Predicting a new result with linear regression
y_pred = predict(lin_reg, data.frame(Level = 6.5))

# Predicting a new result with polynomial regression
y_pred = predict(poly_reg, data.frame(Level = 6.5,
                                      Level2 = 6.5^2,
                                      Level3 = 6.5^3,
                                      Level4 = 6.5^4))