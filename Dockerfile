# FROM python:3.8.8

# RUN pip3 install --upgrade pip
FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu16.04
ENV FORCE_CUDA="1"

RUN  apt-get update -y && \
     apt-get upgrade -y && \
     apt-get dist-upgrade -y && \
     apt-get -y autoremove && \
     apt-get clean

ARG PYTHON_VERSION=3.8.8

RUN apt-get update && apt-get install -y --no-install-recommends --no-install-suggests \
          python${PYTHON_VERSION} \
          python3-pip \
          python${PYTHON_VERSION}-dev \
# Change default python
     && cd /usr/bin \
     && ln -sf python${PYTHON_VERSION}         python3 \
     && ln -sf python${PYTHON_VERSION}m        python3m \
     && ln -sf python${PYTHON_VERSION}-config  python3-config \
     && ln -sf python${PYTHON_VERSION}m-config python3m-config \
     && ln -sf python3                         /usr/bin/python \
# Update pip and add common packages
     && python -m pip install --upgrade pip \
     && python -m pip install --upgrade \
          setuptools \
          wheel \
          six \
# Cleanup
     && apt-get clean \
     && rm -rf $HOME/.cache/pip

# # If you have cuda9 or cuda10 installed on your machine, please run the following command to install
# # RUN python3 -m pip install paddlepaddle-gpu==2.0.0 -i https://mirror.baidu.com/pypi/simple
RUN python3 -m pip install paddlepaddle-gpu -i https://mirror.baidu.com/pypi/simple

# FROM continuumio/miniconda3
# RUN python -m pip install paddlepaddle-gpu -i https://mirror.baidu.com/pypi/simple



WORKDIR /usr/src/app
COPY ./ ./

RUN pip install -r requirements.txt

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

