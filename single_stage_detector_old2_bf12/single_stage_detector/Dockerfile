FROM pytorch/pytorch:1.0.1-cuda10.0-cudnn7-runtime

# Set working directory
WORKDIR /mlperf/ssd
ENV http_proxy=http://172.17.0.1:3128
ENV https_proxy=https://172.17.0.1:3128
RUN apt-get update && \
    apt-get install -y  python-pip && \
    apt-get install -y python3-tk --fix-missing && \
    apt-get install -y numactl

RUN pip install --upgrade pip

# Necessary pip packages
COPY requirements.txt requirements.txt
RUN pip install Cython
RUN pip install -r requirements.txt
RUN python3 -m pip install pycocotools==2.0.0

# Copy SSD code
COPY ssd .
