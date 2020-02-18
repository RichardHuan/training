FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
ENV http_proxy=http://172.17.0.1:3128
ENV https_proxy=https://172.17.0.1:3128

RUN apt-get update -o Acquire::https::developer.download.nvidia.com::Verify-Peer=false
RUN apt install -y vim  python-setuptools  python-pip python3-pip virtualenv htop  libcupti-dev unzip git
RUN ln -s /usr/lib/x86_64-linux-gnu/libcupti.so.7.5.18 /usr/lib/x86_64-linux-gnu/libcupti.so.10.0

RUN pip3 install -y --upgrade pip
RUN pip3 install -y --upgrade setuptools
RUN pip3 install -y numpy scipy sklearn
RUN pip3 install -y "tensorflow-gpu==1.15.0"

ENTRYPOINT ["/bin/bash"]

