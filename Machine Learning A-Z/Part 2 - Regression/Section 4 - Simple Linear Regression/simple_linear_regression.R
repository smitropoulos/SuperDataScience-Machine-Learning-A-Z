# Simple Linear Regression

# Importing the dataset
dataset = read.csv('Salary_Data.csv')

# Splitting the dataset into the Training set and Test set
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

# Fitting Simple Linear Regression to the Training set
regressor = lm(formula = Salary ~ YearsExperience,
               data = training_set)

# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)


# Visualising the Test set results
library(ggplot2)
ggplot() +
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
             colour = 'green') +  #training set points in green
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
             colour = 'red') +    #testing set points in green
  geom_point(aes(x = test_set$YearsExperience, y = y_pred),
             colour = 'orange') + #regression points in orange
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +  #regression line in blue
  ggtitle('Salary vs Experience\n') +
  xlab('Years of experience') +
  ylab('Salary')