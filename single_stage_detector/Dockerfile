FROM pytorch/pytorch:0.4_cuda9_cudnn7

# Set working directory
WORKDIR /mlperf
ENV http_proxy=http://172.17.0.1:3128
ENV https_proxy=https://172.17.0.1:3128

RUN apt-get update -o Acquire::https::developer.download.nvidia.com::Verify-Peer=false
RUN apt-get install -y python3-tk python-pip --fix-missing vim

# Necessary pip packages
RUN pip install --upgrade pip
RUN pip install Cython==0.28.4 \
                matplotlib==2.2.2
RUN python3 -m pip install pycocotools==2.0.0

# Copy SSD code
#WORKDIR /mlperf
#COPY . .
#RUN pip install -r requirements.txt
RUN pip install  \
  cycler==0.10.0 \
  kiwisolver==1.0.1 \
  matplotlib==2.2.2 \
  numpy==1.14.5 \
  Pillow==5.2.0 \
  pycocotools==2.0.0 \
  pyparsing==2.2.0 \
  python-dateutil==2.7.3 \
  pytz==2018.5 \
  six==1.11.0 \
  torch==0.4.0 \
  torchvision==0.2.1 \
  mlperf_compliance==0.0.7
  
WORKDIR /root/ssy
