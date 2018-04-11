# Multiple Linear Regression

# Importing the dataset
dataset = read.csv('50_Startups.csv')

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

# Fitting Multiple Linear Regression to the Training set
regressor = lm(formula = Profit ~.,
               data = training_set)

#***Important Notice****
#R implemented Dummy variables by itself AND avoided the dummy variable trap. (Only included State2 and State3 in the fit.)
# Residuals:
#   Min     1Q Median     3Q    Max 
# -33128  -4865      5   6098  18065 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)      4.965e+04  7.637e+03   6.501 1.94e-07 ***
#   R.D.Spend        7.986e-01  5.604e-02  14.251 6.70e-16 ***
#   Administration  -2.942e-02  5.828e-02  -0.505    0.617    
# Marketing.Spend  3.268e-02  2.127e-02   1.537    0.134    
# State2           1.213e+02  3.751e+03   0.032    0.974    
# State3           2.376e+02  4.127e+03   0.058    0.954    
# ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
 

# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)

# Pretty good results, but still the only thing we did, was eliminate the variables not statistically relevant to
# the result and end up with a linear regressor of the form ax+b.


# Fitting Multiple Linear Regression to the Training set Using Backward Compatibility.
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
               data = dataset)  #Notice we use the whole dataset instead of the training_set now. Not necessary really.

# Fitting Multiple Linear Regression to the Training set Using Backward Compatibility.
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend,
               data = dataset)
summary(regressor)

# Fitting Multiple Linear Regression to the Training set Using Backward Compatibility.
regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
               data = dataset)
summary(regressor)

# Fitting Multiple Linear Regression to the Training set Using Backward Compatibility.
regressor = lm(formula = Profit ~ R.D.Spend,
               data = dataset)
summary(regressor)


##AUTOMATIC BACKWARD ELIMINATION IMPLEMENTATION.

# backwardElimination <- function(x, sl) {
#   numVars = length(x)
#   for (i in c(1:numVars)){
#     regressor = lm(formula = Profit ~ ., data = x)
#     maxVar = max(coef(summary(regressor))[c(2:numVars), "Pr(>|t|)"])
#     if (maxVar > sl){
#       j = which(coef(summary(regressor))[c(2:numVars), "Pr(>|t|)"] == maxVar)
#       x = x[, -j]
#     }
#     numVars = numVars - 1
#   }
#   return(summary(regressor))
# }
# 
# SL = 0.05
# dataset = dataset[, c(1,2,3,4,5)]
# backwardElimination(training_set, SL)

