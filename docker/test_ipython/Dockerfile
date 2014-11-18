# created based on ipython/ipython
FROM ubuntu:14.04

MAINTAINER Gavin Noronha <gavinln@hotmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Python binary dependencies, developer tools
RUN apt-get update && apt-get install -y -q \
    build-essential \
    python \
    python-zmq \
    python-dev \
    python-pip

RUN pip install "ipython[notebook]"
#RUN pip install numpy
#RUN pip install pandas

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

ADD notebook.sh /
RUN chmod u+x /notebook.sh

# create a directory for the notebooks
RUN mkdir /notebook-dir

CMD ["/notebook.sh"]
