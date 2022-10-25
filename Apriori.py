import numpy as np
import pandas as pd
from apyori import apriori

store_data = pd.read_csv('store_data.csv', header=None)  
print("Dataset :-\n", store_data)
print("\nShape of Dataset :", store_data.shape)
records = []
for i in range(0, 10):
  records.append([str(store_data.values[i,j]) for j in range(0, 6)])
association_rules = apriori(records, min_support=0.5, min_confidence=0.9, min_lift=1.3, min_length=2)
association_results = list(association_rules)
print("\nNumber of Association Results :", len(association_results))
print("\n" + str(association_results))
