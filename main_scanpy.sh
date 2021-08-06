#!/bin/bash

data=$1 # a feature table from MCMICRO
data_t=$2 # same feature table but transformed
mkdir scanpy # a special dir for docker output
echo "k,score" > scanpy/scores.csv # init csv to hold output data

# loop through k values and calculate clustering silhouette scores (in this case, k=number of nearest neighbors)
for k in {10,20,40,80,160,320,640,1280,2560} 
do 
    echo "clustering with k=$k"
    docker run --rm -v "$PWD":/data labsyspharm/mc-scanpy:1.1.2 python3 /app/cluster.py -i /data/$data -o /data/scanpy/ -k $k # run fastpg in docker
    # x="$(wc -l < scanpy/*-clusters.csv)" # get number of lines in clusters file
    # x="$(($x-1))" # get number of clusters
    score="$(python3 sil.py $data_t scanpy/*-cells.csv)" # calculate and capture avg silhouette score
    echo "$k,$score" >> scanpy/scores.csv # write score and k to csv
done

# plot results
echo "plotting results"
python3 plot.py scanpy/scores.csv scanpy