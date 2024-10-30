#!/usr/bin/env bash     


LC_NUMERIC="C"
DATA_FILE=$1

#DISTANCE=$1	
#FIT_FILE=$2
#POTENTIAL_FILE="POTENTIALSTEP"
#POTENTIALS_FOLDER="/home/pohl/Desktop/LOWDIN/dependencies/bin/.lowdin2/lib/potentials"
#LOWDIN_FILE=$3
#LOWDIN_OUTPUT=$4
#DATA_RESULTS=$5
TEMPLATE_ONLY_P="/home/pohl/Desktop/PositronWork/Be_OCT28/template_posi.lowdin"
#TEMPLATE_USUAL_CALC="/home/pmorenor/Desktop/PositronWork/Be2_OCT17/template_usual.lowdin"




DIST={}

for i in $(seq 2 0.2 60); do
	DIST+=($i)
done 

STEP=0

for STEP in "${!DIST[@]}"; do

	echo -e "T$STEP \n"

	NEW_STEP=$((STEP + 7))

	echo "${DIST[$((STEP + 1))]}"



done

