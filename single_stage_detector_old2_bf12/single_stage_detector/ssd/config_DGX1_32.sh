#!/bin/bash

## DL params
EXTRA_PARAMS=(
               --batch-size      "32"
             )

## System run parms
DGXNNODES=1
DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )
WALLTIME=24:00:00

## System config params
DGXNGPU=1
# SSY my g5500 have 14 cores
DGXSOCKETCORES=14
DGXNSOCKET=2
# SSY HT is on in my g5500
DGXHT=2 	# HT is on is 2, HT off is 1
DGXIBDEVICES=''
