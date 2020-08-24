FROM debian:stable-20200803

## Install pgloader
RUN apt-get update && apt-get install -y pgloader sqlite3

## Some utilities
RUN apt-get update -y && \
    apt-get install -y build-essential libfuse-dev libcurl4-openssl-dev libxml2-dev pkg-config libssl-dev mime-support automake libtool wget tar git unzip
RUN apt-get install lsb-release -y  && apt-get install zip -y && apt-get install vim -y && apt-get install cron rsyslog -y

## Install AWS CLI
RUN apt-get update && \
    apt-get install -y \
        python3 \
        python3-pip \
        python3-setuptools \
        groff \
        less \
    && pip3 install --upgrade pip \
    && apt-get clean

RUN pip3 --no-cache-dir install --upgrade awscli

## Install S3 Fuse
RUN rm -rf /usr/src/s3fs-fuse
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse/ /usr/src/s3fs-fuse
WORKDIR /usr/src/s3fs-fuse 
RUN ./autogen.sh && ./configure && make && make install

## Create folder
WORKDIR /var/www
RUN mkdir s3

## Set the directory where you want to mount your s3 bucket
ENV S3_MOUNT_DIRECTORY=/var/www/s3

## change workdir to /
WORKDIR /

## Entry Point
ADD start-script.sh /start-script.sh
RUN chmod 755 /start-script.sh 
CMD ["sh", "-c", "./start-script.sh ; "]