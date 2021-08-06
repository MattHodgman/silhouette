#!/bin/bash

data=$1 # a feature table from MCMICRO
data_t=$2 # same feature table but transformed
mkdir fastpg # a special dir for docker output
echo "k,score" > fastpg/scores.csv # init csv to hold output data

# loop through k values and calculate clustering silhouette scores (in this case, k=number of nearest neighbors)
for k in {10,20,40,80,160,320,640,1280,2560} 
do 
    echo "clustering with k=$k"
    docker run --rm -v "$PWD":/data labsyspharm/mc-fastpg:1.2.2 python3 /app/cluster.py -i /data/$data -o /data/fastpg/ -k $k # run fastpg in docker
    # x="$(wc -l < fastpg/*-clusters.csv)" # get number of lines in clusters file
    # x="$(($x-1))" # get number of clusters
    score="$(python3 sil.py $data_t fastpg/*-cells.csv)" # calculate and capture avg silhouette score
    echo "$k,$score" >> fastpg/scores.csv # write score and k to csv
done

# plot results
echo "plotting results"
python3 plot.py fastpg/scores.csv fastpg