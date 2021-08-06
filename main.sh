#!/bin/bash

data=$1 # a feature table from MCMICRO
data_t=$2 # same feature table but transformed
mkdir docker_out # a special dir for docker output
echo "k,score" > scores.csv # init csv to hold output data

# loop through k values and calculate clustering silhouette scores
for k in {2..20} 
do 
    echo "clustering with k=$k"
    docker run --rm -v "$PWD":/data labsyspharm/mc-flowsom:1.1.1 python3 /app/cluster.py -i /data/$data -o /data/docker_out/ -n $k # run flowsom in docker
    score="$(python3 sil.py $data_t docker_out/*-cells.csv)"
    echo "$k,$score" >> scores.csv
done

# plot results
python3 plot.py scores.csv