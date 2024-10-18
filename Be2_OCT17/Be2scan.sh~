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
TEMPLATE_ONLY_P="/home/pmorenor/Desktop/PositronWork/H-_OCT17/H-2Scan/only_positron_H2.lowdin"
TEMPLATE_USUAL_CALC="/home/pmorenor/Desktop/PositronWork/H-_OCT17/H-2Scan/template_usual.lowdin"



DIST={}

for i in $(seq 2 0.2 60); do
	DIST+=($i)
done 

STEP=0

for STEP in "${!DIST[@]}"; do

	echo -e "P$STEP \n"
	
	LOWDIN_FILE_POSI="only_posi_$STEP.lowdin"
	LOWDIN_OUTPUT_POSI="only_posi_$STEP.out"
	
	LOWDIN_FILE_USUAL="usual_$STEP.lowdin"
	LOWDIN_OUTPUT_USUAL="usual_$STEP.out"
	
	echo -e "Editing LOWDIN files \n"
	sed "11s|POTENTIALCHANGE|"P$STEP"|g" $TEMPLATE_ONLY_P > $LOWDIN_FILE_POSI
	
	sed "6s|POS|"${DIST[$STEP]}"|g" $TEMPLATE_USUAL_CALC > $LOWDIN_FILE_USUAL
	sed -i "7s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_USUAL
	sed -i "8s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_USUAL
	
	echo -e "Running LOWDIN calculations \n"

	lowdin2 -i $LOWDIN_FILE_POSI
	lowdin2 -i $LOWDIN_FILE_USUAL
	
	echo -e "Extracting PA \n"
	ENERGY_ONLY_POSI=$(awk '/Eigenvalues for: POSITRON/ {getline; getline; getline; print $2}' $LOWDIN_OUTPUT_POSI)
	ENERGY_USUAL=$(awk '/Eigenvalues for: POSITRON/ {getline; getline; getline; print $2}' $LOWDIN_OUTPUT_USUAL) 
	echo -e "$ENERGY_ONLY_POSI \t $ENERGY_USUAL \n"

	echo "${DIST[$STEP]} $ENERGY_ONLY_POSI $ENERGY_USUAL" >> $DATA_FILE 


#for i in "${!DIST[@]}"; do
#	echo "${DIST[$i]}"
done
