# minecraft Dockfile
FROM node:jessie
MAINTAINER Xixi Zhou<admin@zhouchenxi.cn>

# 安装库
RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list; \
apt-get -y update; \
apt install -y -t jessie-backports openjdk-8-jre-headless ca-certificates-java wget git; \
npm config set registry https://registry.npm.taobao.org; \
npm install n -g

RUN mkdir /data
WORKDIR /data

#安装MCSManager
RUN git clone https://github.com/Suwings/MCSManager.git mcsm
WORKDIR mcsm
RUN npm install --production

RUN mkdir /data/mcsm/server
VOLUME /data/mcsm/server

EXPOSE 25565
EXPOSE 23333
CMD [ "npm", "start" ]
