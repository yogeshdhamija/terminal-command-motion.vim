FROM ubuntu:latest

RUN apt-get -y update
RUN apt -y install software-properties-common
RUN add-apt-repository ppa:jonathonf/vim
RUN apt-get -y update
RUN apt-get -y install vim
RUN apt-get -y install neovim

COPY . .

CMD set -x && pwd && ls && vim --version && nvim --version && ./test.sh
