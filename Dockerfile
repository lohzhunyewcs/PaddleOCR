FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu16.04
ENV FORCE_CUDA="1"

# FROM paddlepaddle/paddle:latest-dev-cuda10.2-cudnn7-gcc82
# FROM paddlepaddle/paddle:2.0.1-gpu-cuda10.2-cudnn7

FROM python:3.8.8

RUN pip3 install --upgrade pip

# If you have cuda9 or cuda10 installed on your machine, please run the following command to install
# RUN python3 -m pip install paddlepaddle-gpu==2.0.0 -i https://mirror.baidu.com/pypi/simple
RUN python3 -m pip install paddlepaddle-gpu -i https://mirror.baidu.com/pypi/simple



WORKDIR /usr/src/app
COPY ./ ./

RUN pip3 install -r requirements.txt

# ENTRYPOINT ['python3', '-m', 'paddle.distributed.launch', '--gpus', "'0,1'", '', 'tools/train.py', '-c', 'configs/rec/srcn_ic.yml']

# # RUN apt-get update && apt-get upgrade
# RUN curl -O https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
# RUN bash Anaconda3-5.2.0-Linux-x86_64.sh
# RUN source ~/.bashrc && conda install environment.yml
# CMD source activate recognition && sh scripts/stn_att_rec.sh


# FROM continuumio/miniconda3
# ENV PYTHONBUFFERED="1"
# ENV PYTHONUNBUFFERED="1"
# WORKDIR /usr/src/app
# COPY ./ ./
# RUN conda env create -f environment.yml

# # ENV PATH="/opt/conda/envs/recognition/bin:${PATH}"
# # RUN /bin/bash -c "conda activate recognition"

# # ENTRYPOINT [ "bash ", "scripts/stn_att_rec.sh" ]

# # Make RUN commands use the new environment:
# SHELL ["conda", "run", "-n", "recognition", "/bin/bash", "-c"]

# # The code to run when container is started:
# ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "recognition", "sh", "scripts/stn_att_rec.sh"]

