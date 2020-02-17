#!/bin/bash

set -e

SEED=$1

cd /root/ssy/training/translation/tensorflow

# TODO: Add SEED to process_data.py since this uses a random generator (future PR)
export PYTHONPATH=/root/ssy/training/translation/tensorflow/transformer:${PYTHONPATH}
# Add compliance to PYTHONPATH
# export PYTHONPATH=/mlperf/training/compliance:${PYTHONPATH}

python3 process_data.py --raw_dir /root/ssy/training/translation/raw_data --data_dir processed_data
