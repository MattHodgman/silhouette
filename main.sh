#!/bin/bash

data=$1 # a feature table from MCMICRO
mkdir docker_out # a special dir for docker output
echo "k,score" > scores.csv # init csv to hold output data

for k in {2..30} 
do 
    docker run --rm -v "$PWD":/data labsyspharm/mc-flowsom:1.1.1 python3 /app/cluster.py -i /data/$1 -o /data/docker_out/ -n $k # run flowsom in docker
    score="$(python3 sil.py docker_out/*-clean.csv docker_out/*-cells.csv)"
    echo "$k,$score" >> scores.csv
done