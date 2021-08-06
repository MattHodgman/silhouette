#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.data = ''

// process fastpg {}
//     publishDir 'fastpg'
//     input:
//         path data
//     output:
//         path '*-cells.csv', emit: cells
//     script:
//         """
//         python3 /app/cluster.py -i ${data} -c
//         """
// }

// process scanpy {
//     publishDir 'scanpy'
//     input:
//         path data
//     output:
//         path '*-cells.csv', emit: cells
//     script: 
//         """
//         python3 /app/cluster.py -i ${data} -c
//         """
// }

process flowsom {
    publishDir 'flowsom_k'
    input:
        //path data
        val k
    output:
        path '*-cells.csv' optional true //, emit: cells
    exec:
    println "clusters: $k"
    // script:
    //     """
    //     python3 /app/cluster.py -i ${data} -c -n ${k}
    //     """
}

process test {
    input:
        tuple val(k) val(f)
    exec:
        println "clusters: $k   $f"
}


process testInputB {
    input:
        tuple file(x) file(y)

    output:
        stdout emit: resultB

    """
    echo '$x    $y'
    """
}


// process silhouette {

// }

workflow {

    B = Channel.from( [[file('a1'), file('a2')]], [[file('b1'), file('b2')]])
    testInputB(B)
    testInputB.out.resultB.subscribe { println "B: $it" }



    // x = channel.from( [ [5, params.data], [6, params.data], [7, params.data], [8, params.data], [9, params.data], ])
    // x.view()

    // test(x)




    // input data and list of cluster numbers
    // data = channel.from(params.data)
    // k = channel.from(5..10)
    // k.combine(data).view()

    // make method output file dir
    // file('./flowsom_k').mkdir()
    // file('./fastpg').mkdir()
    // file('./scanpy').mkdir()
    
    // cluster with different number of clusters

    // flowsom.out.cells.collect()

    // fastpg(data)
    // scanpy(data)
}