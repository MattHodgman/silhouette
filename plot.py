import matplotlib.pyplot as plt
import sys
import pandas as pd

# params: (1) scores.csv [k,score]

# load data
data = pd.read_csv(sys.argv[1])

# plot
plt.scatter(x=data['k'], y=data['score'])
plt.xlabel('k')
plt.ylabel('avg silhouette score')
plt.show()