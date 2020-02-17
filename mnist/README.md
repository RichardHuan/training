# SSY
# INSTALL 
## on host
# share with reinforcement
#docker upll nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
sudo nvidia-docker run -i -t  --ipc=host  --entrypoint "bash"   -v /root/ssy:/root/ssy  --name ssyMNIST   nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

## in docker
source /root/ssy/training/env.sh
apt-get update -o Acquire::https::developer.download.nvidia.com::Verify-Peer=false
apt-get install -y python-setuptools vim
apt-get install -y python-pip python3-pip virtualenv htop libcupti-dev
pip3 install virtualenv  virtualenvwrapper

pip3 install --upgrade pip
pip3 install --upgrade setuptools
pip3 install -r /root/ssy/training/mnist/requirements.txt

pip3 install --upgrade numpy scipy sklearn 
pip3 install "tensorflow-gpu==1.8"

ln -s /usr/lib/x86_64-linux-gnu/libcupti.so.7.5.18 /usr/lib/x86_64-linux-gnu/libcupti.so.9.0


# START
## on host
nvidia-docker start ssyMNIST
nvidia-docker exec -it ssyMNIST /bin/bash

## on docker
/root/ssy/training/mnist
source /root/ssy/training/env.sh

## run
CUDA_VISIBLE_DEVICES=6 python3 mnist_with_summaries_bf16.py
