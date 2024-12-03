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
#TEMPLATE_ONLY_P="/home/pohl/Desktop/PositronWork/Be_OCT28/template_posi.lowdin"
TEMPLATE_USUAL_CALC="/home/pohl/Desktop/PositronWork/NobleGasesDimers/Xenon/template_usual.lowdin"




DIST={}

for i in $(seq 2 2 60); do
	DIST+=($i)
done 

STEP=0

for STEP in "${!DIST[@]}"; do

	echo -e "T$STEP \n"

    	NEW_STEP=$((STEP + 7))


	#LOWDIN_FILE_POSI="only_posi_$STEP.lowdin"
	#LOWDIN_OUTPUT_POSI="only_posi_$STEP.out"
	
	LOWDIN_FILE_USUAL="usual_$STEP.lowdin"
	LOWDIN_OUTPUT_USUAL="usual_$STEP.out"
	
	echo -e "Editing LOWDIN files \n"
	#sed "12s|POTENTIALCHANGE|XE$STEP|g" $TEMPLATE_ONLY_P > $LOWDIN_FILE_POSI
	#sed -i "4s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_POSI 
	#sed -i "6s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_POSI
	
	sed "6s|POS|"${DIST[$STEP]}"|g" $TEMPLATE_USUAL_CALC > $LOWDIN_FILE_USUAL
	sed -i "7s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_USUAL
	sed -i "8s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_USUAL
	sed -i "17s|POTENTIALCHANGE|XE$STEP|g" $LOWDIN_FILE_USUAL

	echo -e "Running LOWDIN calculations \n"

	#lowdin2 -i $LOWDIN_FILE_POSI
	lowdin2 -i $LOWDIN_FILE_USUAL
	
	echo -e "Extracting PA \n"
	#ENERGY_ONLY_POSI=$(awk '/Eigenvalues for: POSITRON/ {getline; getline; getline; print $2}' $LOWDIN_OUTPUT_POSI)
	ENERGY_USUAL=$(awk '/Eigenvalues for: POSITRON/ {getline; getline; getline; print $2}' $LOWDIN_OUTPUT_USUAL) 
	#echo -e "$ENERGY_ONLY_POSI \n"
	echo -e "${DIST[$STEP]} \t $ENERGY_USUAL \n"

	echo "${DIST[$STEP]} $ENERGY_USUAL"  >> $DATA_FILE 

done

