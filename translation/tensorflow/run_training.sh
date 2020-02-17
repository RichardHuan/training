#!/bin/bash

set -e

SEED=$1
QUALITY=$2

cd /root/ssy/training/translation/tensorflow

export PYTHONPATH=/root/ssy/training/translation/tensorflow/transformer:${PYTHONPATH}
# Add compliance to PYTHONPATH
# export PYTHONPATH=/mlperf/training/compliance:${PYTHONPATH}

python3 transformer/transformer_main.py --random_seed=${SEED} --data_dir=processed_data/ --model_dir=model --params=big --bleu_threshold ${QUALITY} --bleu_source=newstest2014.en --bleu_ref=newstest2014.de
