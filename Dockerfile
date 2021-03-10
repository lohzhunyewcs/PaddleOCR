FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu16.04
ENV FORCE_CUDA="1"

# ENV DEBIAN_FRONTEND noninteractive
# RUN apt-get update && \
#      apt-get -y install gcc mono-mcs && \
#      rm -rf /var/lib/apt/lists/*

# RUN  apt-get update -y && \
#      apt-get upgrade -y && \
#      apt-get dist-upgrade -y && \
#      apt-get -y autoremove && \
#      apt-get clean
# FROM python:3.8.8-slim
FROM python:3.8.8

RUN pip3 install --upgrade pip

# # If you have cuda9 or cuda10 installed on your machine, please run the following command to install
# # RUN python3 -m pip install paddlepaddle-gpu==2.0.0 -i https://mirror.baidu.com/pypi/simple
RUN python3 -m pip install paddlepaddle-gpu -i https://mirror.baidu.com/pypi/simple

# FROM continuumio/miniconda3
# RUN python -m pip install paddlepaddle-gpu -i https://mirror.baidu.com/pypi/simple



WORKDIR /usr/src/app
COPY ./ ./

RUN pip install -r requirements.txt
