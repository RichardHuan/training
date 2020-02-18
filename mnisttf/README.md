# SSY
# INSTALL 
## on host
# share with reinforcement
docker pull  nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
nvidia-docker run -it  --ipc=host  --entrypoint "bash"   -v /root/ssy:/root/ssy  --name ssyMNISTTF   nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
docker pull  nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
nvidia-docker run -it  --ipc=host  --entrypoint "bash"   -v /root/ssy:/root/ssy  --name ssyMNISTTF2   nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
docker pull tensorflow/tensorflow:1.12.0-devel-gpu-py3
nvidia-docker run -it  --ipc=host  --entrypoint "bash"   -v /root/ssy:/root/ssy  --name ssyMNISTTF3    tensorflow/tensorflow:1.12.0-devel-gpu-py3

# buld docker bert
docker build . -t tfbase



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

# to build tensorflow v1.15.0 in docker
# install required 
apt install -y python3-dev python3-pip
pip install -U --user pip six numpy wheel setuptools mock 'future>=0.17.1'
pip install -U --user keras_applications --no-deps
pip install -U --user keras_preprocessing --no-deps

# install bazel
# this avoid bazel too many argement problem 
wget https://github.com/bazelbuild/bazel/releases/download/0.24.1/bazel-0.24.1-installer-linux-x86_64.sh
chmod a+x /root/ssy/training/bazel-0.24.1-installer-linux-x86_64.sh
/root/ssy/training/bazel-0.24.1-installer-linux-x86_64.sh

# check out tf 1.15.2
cd /root/ssy/tensorflow_1.15.2/
git clone https://github.com/tensorflow/tensorflow
cd tensorflow
git checkout v1.15.2

# remember to use python3 instead of python
# more option is here
# https://www.tensorflow.org/install/source
./configure
source ~/ssy/script/gitscr/disableVerify.sh
bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
# above command may met with http_archive url can not be download through https
# I just wget --no-check-certificate them to dstdir
# and add --distdir=dstdir
bazel build --config=opt --distdir=dstdir //tensorflow/tools/pip_package:build_pip_package

# build pip packet
./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

# install
pip install /tmp/tensorflow_pkg/tensorflow-1.15.2-cp35-cp35m-linux_x86_64.whl

## run
CUDA_VISIBLE_DEVICES=6 python3 mnist_with_summaries_bf16.py
