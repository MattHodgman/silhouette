import matplotlib.pyplot as plt
import sys
import pandas as pd

# params: (1) scores.csv [k,score] (2) method name (name of output dir as well)

# load data
data = pd.read_csv(sys.argv[1])
title = sys.argv[2]

# plot
plt.scatter(x=data['k'], y=data['score'])
plt.title(title)
plt.xlabel('k')
plt.ylabel('avg silhouette score')
plt.savefig(f'{title}/{title}_scores.png')