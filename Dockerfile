FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="Europe/Stockholm"

RUN apt-get update -y && apt-get install iputils-ping traceroute iperf3 -y

COPY . /opt/scripts
RUN chmod +x /opt/scripts/*
ENV PATH="$PATH:/opt/scripts/"