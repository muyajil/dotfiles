FROM ubuntu:18.04

RUN apt update
RUN apt install -y sudo wget curl lsb-release python3-dev git-core pkg-config
RUN apt install -y gnupg gnupg1 gnupg2

ADD install.sh install.sh
ADD bash_prompt.sh bash_prompt.sh

RUN ./install.sh