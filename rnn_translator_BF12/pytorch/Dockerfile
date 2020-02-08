FROM pytorch/pytorch:0.4_cuda9_cudnn7

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV http_proxy=http://172.17.0.1:3128
ENV https_proxy=https://172.17.0.1:3128

#ADD . /workspace/pytorch
#RUN pip install -r /workspace/pytorch/requirements.txt
RUN pip install \
 sacrebleu==1.2.10 \
 numpy==1.14.2 \
 mlperf-compliance==0.0.4

WORKDIR /workspace/pytorch
