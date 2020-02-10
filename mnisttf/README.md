# SSY
# INSTALL 
## on host
# share with reinforcement
#docker upll nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
sudo nvidia-docker run -i -t  --ipc=host  --entrypoint "bash"   -v /root/ssy/training/mnist/:/research/mnist  --name ssyMNIST   nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

## in docker
export http_proxy=http://172.17.0.1:3128
export https_proxy=https://172.17.0.1:3128
apt-get update -o Acquire::https::developer.download.nvidia.com::Verify-Peer=false
source /research/mnist/env.sh
apt-get install -y python-setuptools vim
apt-get install -y python-pip python3-pip virtualenv htop
pip3 install virtualenv  virtualenvwrapper

pip3 install --upgrade pip
pip3 install --upgrade setuptools
pip3 install -r /research/mnist/requirements.txt

pip3 install --upgrade numpy scipy sklearn tf-nightly-gpu
pip3 install "tensorflow-gpu==1.8"


# START
## on host
nvidia-docker start ssyMNIST
nvidia-docker exec -it ssyMNIST /bin/bash

## on docker
cd /research/mnist
source env.sh

## run
CUDA_VISIBLE_DEVICES=6 python3 mnist_with_summaries_bf16.py
