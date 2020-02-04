FROM pytorch/pytorch:1.0.1-cuda10.0-cudnn7-runtime

# Set working directory
WORKDIR /mlperf
ENV http_proxy=http://172.17.0.1:3128
ENV https_proxy=https://172.17.0.1:3128

RUN apt-get update && \
    apt-get install -y python3-tk python-pip

# Necessary pip packages
RUN pip install --upgrade pip
RUN pip install Cython==0.28.4 \
                matplotlib==2.2.2
RUN python3 -m pip install pycocotools==2.0.0

# Copy SSD code
WORKDIR /mlperf
COPY . .
RUN pip install -r requirements.txt

WORKDIR /mlperf/ssd
