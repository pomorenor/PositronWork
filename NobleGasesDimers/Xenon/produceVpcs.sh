#!/usr/bin/env bash

LC_NUMERIC="C"
FITTING_SCRIPT_TEMPLATE="/home/pohl/Desktop/PositronWork/NobleGasesDimers/Xenon/test-becke-au-pot.py"
POTENTIALS_FOLDER="/home/pohl/Desktop/LOWDIN/dependencies/bin/.lowdin2/lib/potentials"

DIST={}

for i in $(seq 2 2 60); do
	DIST+=($i)
done

STEP=0

for STEP in "${!DIST[@]}"; do

	echo -e "XE$STEP \n"

	POTENTIAL_NAME="XE$STEP"
	POTENTIAL_FIT_FILE="$POTENTIAL_NAME.py"

	sed "51s|POS|"${DIST[$STEP]}"|g" $FITTING_SCRIPT_TEMPLATE > $POTENTIAL_FIT_FILE

	echo "Fitting potential at distance ${DIST[$STEP]}"
	python3 $POTENTIAL_FIT_FILE $POTENTIAL_NAME
	mv "$POTENTIAL_NAME.POT0" $POTENTIAL_NAME
	mv $POTENTIAL_NAME $POTENTIALS_FOLDER
done
