import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import scipy.cluster.hierarchy as shc
from scipy.spatial.distance import squareform, pdist

#X-axis of point
x = [0.40,0.22,0.35,0.26,0.08,0.45]

#Y-axis of point
y = [0.53,0.38,0.32,0.19,0.41,0.30]

point = ['P1','P2','P3','P4','P5','P6']
data = pd.DataFrame({'Point':point, 'x':np.round(x,2), 'y':np.round(y,2)})
data = data.set_index('Point')

#Printing all points
print(data)
print('\n\n')

#Plotting the points
plt.figure(figsize=(8,5))
plt.scatter(data['x'], data['y'], c='r', marker='*')
plt.xlabel('X-axis',fontsize=14,color='darkred')
plt.ylabel('Y-axis',fontsize=14,color='darkred')
plt.title('Plotting of Points',fontsize=16,color='purple')

for j in data.itertuples():
    plt.annotate(j.Index, (j.x, j.y), fontsize=15)
    dist = pd.DataFrame(squareform(pdist(data[['x','y']]), 'euclidean'),
    columns=data.index.values, index=data.index.values)

#Displaying the dendrogram
plt.figure(figsize=(12,5))
plt.title("Dendrogram with Single Linkage",fontsize=18,color='purple')
dend = shc.dendrogram(shc.linkage(data[['x', 'y']], method='single'), labels=data.index)