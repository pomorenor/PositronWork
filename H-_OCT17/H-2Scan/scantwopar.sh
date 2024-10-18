#!/usr/bin/env bash     


LC_NUMERIC="C"
DISTANCE=$1	
FIT_FILE=$2
POTENTIAL_FILE="POTENTIALSTEP"
POTENTIALS_FOLDER="/home/pohl/Desktop/LOWDIN/dependencies/bin/.lowdin2/lib/potentials"
LOWDIN_FILE=$3
LOWDIN_OUTPUT=$4
DATA_RESULTS=$5
PLANTILLA="/home/pohl/Desktop/PositronicMolecules/Code/plantilla.lowdin"
FIT_PLANTILLA="/home/pohl/Desktop/PositronicMolecules/Code/FitPotentialPlantilla.py"

for i in $(seq 0 0.01 50); do 
	STEP=$(echo "$DISTANCE + $i" | bc)
	INTE=$(echo "$i*10" | bc)
	INTEGER=$(printf "%.0f" $INTE)

	echo -e "writing $STEP to file \n"
	sed -i "51s|OSO|"$STEP"|g" $2  

	awk 'NR==51' $FIT_FILE
	python3 $FIT_FILE $POTENTIAL_FILE  

	echo -e "\n"
	echo -e "Renaming potential to $POTENTIAL_FILE \n"
	mv $POTENTIAL_FILE".POT0" $POTENTIAL_FILE 	

	echo -e "Moving potential to Lowdin's potentials folder \n"
	mv $POTENTIAL_FILE $POTENTIALS_FOLDER

	echo -e "Restoring fit file \n"
	# sed -i "51s|"$STEP"|OSO|g" $2
	cp $FIT_PLANTILLA $2

	echo -e "Potential located in $POTENTIAL_FILE \n"

	echo "Editing lowdin file \n"
	sed -i "s|OSO|"$STEP"|g" $LOWDIN_FILE
	sed -i "s|POSITRONPOT|$POTENTIAL_FILE|g" $LOWDIN_FILE 

	echo -e "Running lowdin calculation \n"

	lowdin2 -i $LOWDIN_FILE

	echo -e "Restoring lowdin input \n"
	cp $PLANTILLA $LOWDIN_FILE
	
	#sed -i "s|$POTENTIAL_FILE|POSITRONPOT|g" $LOWDIN_FILE


	echo -e "Extracting PA \n"
	ENERGY=$(awk '/Eigenvalues for: POSITRON/ {getline; getline; getline; print $2}' $LOWDIN_OUTPUT) 
	echo -e "$ENERGY \n"
	echo "$STEP $ENERGY" >> $5
done
