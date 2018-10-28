import pandas as pd
from sklearn import preprocessing
from sklearn import base as skBase
from sklearn.model_selection import GridSearchCV
import numpy as np
from sklearn.neighbors import KDTree

class MultiRegressor(skBase.BaseEstimator):

    def __init__(self, estimator,cv_parms):
        self.estimator = estimator
        self.scaler = preprocessing.StandardScaler()
        self.cv_parms = cv_parms
        self.best_parameters_=[]
        
    def fit(self,X,y):
        X_t = self.scaler.fit_transform(X)
        n, m = y.shape
        self.estimators_=[]
        for i in range(m):
            grid = GridSearchCV(self.estimator, self.cv_parms,cv=10,scoring='neg_mean_squared_error')
            grid.fit(X_t, y.ix[:, i])
            self.estimators_.append(grid)
            self.best_parameters_.append(grid.best_params_)
        return self

    def predict(self,X):
        X_t = self.scaler.transform(X)
        res = [est.predict(X_t)[:, np.newaxis] for est in self.estimators_]
        return np.hstack(res)


