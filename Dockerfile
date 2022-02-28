FROM ubuntu
WORKDIR /export
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y build-essential python3 python3-pip python3-numpy python3-matplotlib python3-dev python3-setuptools time swig vim nano 
ENTRYPOINT /usr/bin/bash

