# created based on ipython/ipython
FROM ubuntu:14.04

MAINTAINER Gavin Noronha <gavinln@hotmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Python binary dependencies, developer tools
RUN apt-get update && apt-get install -y -q \
    build-essential \
    wget \
    python \
    python-dev \
    python-pip

VOLUME /notebooks

WORKDIR /msodbc

RUN mkdir -p /msodbc

# extract Microsoft ODBC driver
COPY driver_files/msodbcsql-11.0.2270.0.tar.gz /msodbc/
RUN tar xvzf /msodbc/msodbcsql-11.0.2270.0.tar.gz -C /msodbc

# setup Unix ODBC Driver Manager
WORKDIR /msodbc/msodbcsql-11.0.2270.0
COPY driver_files/unixODBC-2.3.0.tar.gz /msodbc/msodbcsql-11.0.2270.0/
COPY driver_files/ubuntu_build_dm.sh /msodbc/msodbcsql-11.0.2270.0/
RUN chmod +x ubuntu_build_dm.sh
RUN ./ubuntu_build_dm.sh --accept-warning --download-url=file://unixODBC-2.3.0.tar.gz

# install Unix ODBC driver manager
RUN cd `find /tmp -name unixODBC-2.3.0` \
    && make install

WORKDIR /msodbc/msodbcsql-11.0.2270.0
COPY driver_files/ubuntu_install.sh /msodbc/msodbcsql-11.0.2270.0/
RUN chmod +x ubuntu_install.sh
#RUN ./ubuntu_install.sh install --accept-license

EXPOSE 8888

