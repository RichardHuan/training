#/bin/bash

RANDOM_SEED=$1
QUALITY=$2
set -e

# Register the model as a source root
export PYTHONPATH="$(pwd):${PYTHONPATH}"

MODEL_DIR="/tmp/resnet_imagenet_${RANDOM_SEED}"
# SSY
# avoid resume running
rm -rf $MODEL_DIR

# this is for 1 gpu
python3 official/resnet/imagenet_main.py $RANDOM_SEED --data_dir /imn/  \
  --model_dir $MODEL_DIR --train_epochs 10000 --stop_threshold $QUALITY --batch_size 64 \
  --version 1 --resnet_size 50 --epochs_between_evals 4

# this is 2 gpu, need to scale batch_size to 128
#python3 official/resnet/imagenet_main.py $RANDOM_SEED --data_dir /imn/  \
#  --model_dir $MODEL_DIR --train_epochs 10000 --stop_threshold $QUALITY \
#  --version 1 --resnet_size 50 --epochs_between_evals 4 \
#  --batch_size 128 --num_gpus 2

# To run on 8xV100s, instead run:
#python3 official/resnet/imagenet_main.py $RANDOM_SEED --data_dir /imn/imagenet/combined/ \
#   --model_dir $MODEL_DIR --train_epochs 10000 --stop_threshold $QUALITY --batch_size 1024 \
#   --version 1 --resnet_size 50 --dtype fp16 --num_gpus 8 \
#   --epochs_between_evals 4
