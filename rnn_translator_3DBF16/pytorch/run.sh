#!/bin/bash

set -e

DATASET_DIR='/root/ssy/dataset/rnn_translator/data'
RESULTS_DIR='gnmt_wmt16'

SEED=${1:-"1"}
TARGET=${2:-"21.80"}

# run training
python3 -m multiproc train.py \
  --save ${RESULTS_DIR} \
  --dataset-dir ${DATASET_DIR} \
  --seed $SEED \
  --target-bleu $TARGET \
  --epochs 20 \
  --batch-size 128
