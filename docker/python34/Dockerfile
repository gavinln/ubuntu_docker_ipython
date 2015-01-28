# run using the following command
# sudo fig run scraper bash
FROM ubuntu:14.04

MAINTAINER Gavin Noronha <gavinln@hotmail.com>

RUN apt-get update
RUN apt-get install -y python3-pip
# following are required for GoogleScraper
RUN apt-get install -y libxml2-dev libxslt1-dev lib32z1-dev
RUN pip3 install GoogleScraper






