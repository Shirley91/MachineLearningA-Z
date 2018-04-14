#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jan 17 22:47:20 2018

@author: yaru
"""
#data-preprocessing
# Importing the libraries
# three essential libraries
# numpy: mathematics
# matplotlib.pyplot: make plot
# pandas: report and manage dataset
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#Importing the dataset
dataset = pd.read_csv('Data.csv')
X = dataset.iloc[:, :-1].values
Y = dataset.iloc[:, 3].values

#Missing data
#give mean value to the missing data
from sklearn.preprocessing import Imputer
imputer = Imputer(missing_values = 'NaN',strategy = 'mean',axis = 0)
imputer = imputer.fit(X[:,1:3]) #upper bond included
X[:,1:3] = imputer.transform(X[:,1:3])

#Encoding categorical data
#LabelEncoder only use to data with order or not
#OneHotEncoder transform to dummy
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelencoder_X = LabelEncoder()
X[:,0] = labelencoder_X.fit_transform(X[:,0])
onehotencoder = OneHotEncoder(categorical_features = [0])
X = onehotencoder.fit_transform(X).toarray()
labelencoder_Y = LabelEncoder()
Y = labelencoder_Y.fit_transform(Y)

# Training set and Test set
from sklearn.cross_validation import train_test_split
# generally, test size ranges from 02 to 0.3, sometimes 0.4
X_train,X_test,Y_train,Y_test = train_test_split(X, Y, test_size = 0.2,random_state = 0)

# Feature scaling
from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test)


