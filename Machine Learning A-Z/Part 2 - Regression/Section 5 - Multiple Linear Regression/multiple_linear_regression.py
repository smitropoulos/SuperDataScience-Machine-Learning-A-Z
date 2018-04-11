# Multiple Linear Regression

# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Importing the dataset
dataset = pd.read_csv('50_Startups.csv')
X = dataset.iloc[:, :-1].values
y = dataset.iloc[:, 4].values

# Encoding categorical data
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelencoder = LabelEncoder()
X[:, 3] = labelencoder.fit_transform(X[:, 3])
onehotencoder = OneHotEncoder(categorical_features = [3])
X = onehotencoder.fit_transform(X).toarray()

# Avoiding the Dummy Variable Trap *THIS IS AUTOMATICALLY DONE BY THE REGRESSOR BTW*
X = X[:, 1:] #Removing the first column of the X array. Refer to Multiple linear regression step 5


# Splitting the dataset into the Training set and Test set
from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)

# Feature Scaling Is automatically applied from a library. Not needed

# Fitting Multiple Linear Regression to the Training set
#Same thing as the previous example. Only difference is that there are more dependent variables.
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, y_train)

# Predicting the Test set results
y_pred = regressor.predict(X_test)

"""
So far there seems to be a large linear relationship between the test and pred Y values.
Although some variables may not be statistically relevant. This is where the backward elimination process comes in

"""

#Backward Compatibility start
import statsmodels.formula.api as sm




