FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu16.04


WORKDIR /research

RUN apt-get update

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    git \
    python \
    python-pip


ENV HOME /research
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
# SSY to find the installed cuda
ENV PATH /usr/local/cuda/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64:$LD_LIBRARY_PATH


RUN apt-get install -y python-setuptools

RUN apt-get install -y python-pip python3-pip virtualenv htop vim
#RUN pip3 install --upgrade numpy scipy sklearn tf-nightly-gpu
RUN pip3 install --upgrade numpy scipy sklearn 
# SSY to install tf 1.15 only after update pip3
RUN pip3 install --upgrade pip
# from here on I need to run python3 -m pip install xx
# tf 1.14 have follow error
# convolutional.Conv2D AssertionError: Bad argument number for Name: 3, expect 4
# I fix it with tf 1.15
RUN python3 -m pip  install tensorflow-gpu==1.15.0


# Mount data into the docker
ADD . /research/resnet


WORKDIR /research/resnet
# SSY add mlperf_compliance==0.0.6
RUN python3 -m pip  install -r official/requirements.txt


ENTRYPOINT ["/bin/bash"]

