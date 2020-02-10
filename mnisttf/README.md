# SSY
# INSTALL 
## on host
# share with reinforcement
#docker upll nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
nvidia-docker run -it  --ipc=host  --entrypoint "bash"   -v /root/ssy:/root/ssy  --name ssyMNISTTF   nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

## in docker
source /root/ssy/training/env.sh
source /root/ssy/training/update_install.sh


# START
## on host
nvidia-docker start ssyMNISTTF
nvidia-docker exec -it ssyMNISTTF /bin/bash

## on docker
cd /root/ssy/training/mnisttf/
source /root/ssy/training/env.sh

## run
CUDA_VISIBLE_DEVICES=6 python3 mnist_with_summaries_bf16.py
