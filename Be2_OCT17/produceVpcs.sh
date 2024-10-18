#!/usr/bin/env bash

LC_NUMERIC="C"
FITTING_SCRIPT_TEMPLATE="/home/pmorenor/Desktop/PositronWork/Be2_OCT17/test-becke-au-pot.py"
POTENTIALS_FOLDER="/home/pmorenor/Desktop/LOWDIN/dependencies/bin/.lowdin2/lib/potentials"

DIST={}

for i in $(seq 1 0.1 30); do
	DIST+=($i)
done

STEP=0

for STEP in "${!DIST[@]}"; do

	echo -e "VPC$STEP \n"

	POTENTIAL_NAME="VPC$STEP"
	POTENTIAL_FIT_FILE="$POTENTIAL_NAME.py"

	sed "51s|POS|"${DIST[$STEP]}"|g" $FITTING_SCRIPT_TEMPLATE > $POTENTIAL_FIT_FILE

	echo "Fitting potential at distance ${DIST[$STEP]}"
	python3 $POTENTIAL_FIT_FILE $POTENTIAL_NAME
	mv "$POTENTIAL_NAME.POT0" $POTENTIAL_NAME
	mv $POTENTIAL_NAME $POTENTIALS_FOLDER
done
