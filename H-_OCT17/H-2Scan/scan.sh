#!/bin/bash

list=(0.02 0.04 0.06 0.08 0.10 0.12 0.14 0.16 0.18 0.20 0.22 0.24 0.26 0.28 0.30 0.32 0.34 0.36 0.38 0.40 0.42 0.44 0.46 0.48 0.50 0.52 0.54 0.56 0.58 0.60 0.62 0.64 0.66 0.68 0.70 0.72 0.74 0.76 0.78 0.80 0.82 0.84 0.86 0.88 0.90 0.92 0.94 0.96 0.98 1.00 1.02 1.04 1.06 1.08 1.10 1.12 1.14 1.16 1.18 1.20 1.22 1.24 1.26 1.28 1.30 1.32 1.34 1.36 1.38 1.40 1.42 1.44 1.46 1.48 1.50 1.52 1.54 1.56 1.58 1.60 1.62 1.64 1.66 1.68 1.70 1.72 1.74 1.76 1.78 1.80 1.82 1.84 1.86 1.88 1.90 1.92 1.94 1.96 1.98 2.00 3.00 4.00 5.00 6.00 7.00 8.00 9.00 10.00 20.00 30.00 40.00 50.00 100.00 200.00 300.00 400.00 500.00 600.00 700.00 800.00 900.00 1000.00)

for i in "${!list[@]}"; do
    cd $i
    value="${list[$i]}"
    fixedvalue=-1.38081522 #interaccion nucleo-e en calculo inicial
    fixedvalue2=-0.4869627 #energia total del calculo inicial 
    sed -i "6s/.*/        H dirac 0.0 0.0 $value/" $i.lowdin #en sexta fila va el dirac que se mueve
    #echo "Position: $i, Value: $value"
    lowdin2 -i $i.lowdin
    energy=$(awk '/TOTAL ENERGY =/ {print $4}' $i.out)    
    energy2=$(awk '/Total Q\/Fixed energy/ {print $5}' $i.out)
    diff=$(echo "scale=8; $energy2 - $fixedvalue" | bc)
    diff2=$(echo "scale=8; $energy - $fixedvalue2" | bc)
    cd ../
    echo "$value $energy $diff $diff2"  >> result3.txt
done

