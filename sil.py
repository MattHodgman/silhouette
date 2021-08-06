from silhouette import CELLID
from sklearn.metrics import silhouette_score
import pandas as pd
import sys

# params: (1) transformed feature table from MCMICRO (2) cluster labels

# constants
CELLID = 'CellID'
CLUSTER = 'Cluster'

# read input
X = pd.read_csv(sys.argv[1], index_col=CELLID) # get data
cluster_labels = pd.read_csv(sys.argv[2], index_col=CELLID)

# calculate average silhouette score
silhouette_avg = silhouette_score(X, cluster_labels[CLUSTER])

# write score to stdout
print(silhouette_avg)