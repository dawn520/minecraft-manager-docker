# minecraft Dockfile
FROM library/ubuntu:16.04
MAINTAINER Xixi Zhou<admin@zhouchenxi.cn>


#
# Ubuntu with Oracle JDK 8
#

RUN \
  apt-get -y update && \
  apt-get -y install software-properties-common && \
  apt-get -y install --reinstall locales && \
  rm -rf /root/.cache && \
  apt-get purge -y $(apt-cache search '~c' | awk '{ print $2 }') && \
  apt-get -y autoremove && \
  apt-get -y autoclean && \
  apt-get -y clean all && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/apt && \
  rm -rf /tmp/*

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN \
  apt-get -y update && \
  apt-get -y install software-properties-common && \
  apt-get -y install --reinstall locales && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  add-apt-repository -y ppa:git-core/ppa && \
  apt-get -y update && \
  apt-get -y upgrade && \
  apt-get -y install curl wget unzip nano && \
  apt-get -y install git=1:2.20.* && \
  apt-get -y install oracle-java8-installer && \
  apt-get -y install oracle-java8-unlimited-jce-policy && \
  apt-get -y install oracle-java8-set-default && \
  rm -rf \
        ${JAVA_HOME}/*/javaws \
        ${JAVA_HOME}/*/jjs \
        ${JAVA_HOME}/*/keytool \
        ${JAVA_HOME}/*/orbd \
        ${JAVA_HOME}/*/pack200 \
        ${JAVA_HOME}/*/policytool \
        ${JAVA_HOME}/*/rmid \
        ${JAVA_HOME}/*/rmiregistry \
        ${JAVA_HOME}/*/servertool \
        ${JAVA_HOME}/*/tnameserv \
        ${JAVA_HOME}/*/unpack200 \
        ${JAVA_HOME}/*/*javafx* \
        ${JAVA_HOME}/*/*jfx* \
        ${JAVA_HOME}/*/amd64/libdecora_sse.so \
        ${JAVA_HOME}/*/amd64/libfxplugins.so \
        ${JAVA_HOME}/*/amd64/libglass.so \
        ${JAVA_HOME}/*/amd64/libgstreamer-lite.so \
        ${JAVA_HOME}/*/amd64/libjavafx*.so \
        ${JAVA_HOME}/*/amd64/libjfx*.so \
        ${JAVA_HOME}/*/amd64/libprism_*.so \
        ${JAVA_HOME}/*/deploy* \
        ${JAVA_HOME}/*/desktop \
        ${JAVA_HOME}/*/ext/jfxrt.jar \
        ${JAVA_HOME}/*/ext/nashorn.jar \
        ${JAVA_HOME}/*/javaws.jar \
        ${JAVA_HOME}/*/jfr \
        ${JAVA_HOME}/*/jfr.jar \
        ${JAVA_HOME}/*/missioncontrol \
        ${JAVA_HOME}/*/oblique-fonts \
        ${JAVA_HOME}/*/plugin.jar \
        ${JAVA_HOME}/*/visualvm \
        ${JAVA_HOME}/man \
        ${JAVA_HOME}/plugin \
        ${JAVA_HOME}/*.txt \
        ${JAVA_HOME}/*/*/javaws \
        ${JAVA_HOME}/*/*/jjs \
        ${JAVA_HOME}/*/*/keytool \
        ${JAVA_HOME}/*/*/orbd \
        ${JAVA_HOME}/*/*/pack200 \
        ${JAVA_HOME}/*/*/policytool \
        ${JAVA_HOME}/*/*/rmid \
        ${JAVA_HOME}/*/*/rmiregistry \
        ${JAVA_HOME}/*/*/servertool \
        ${JAVA_HOME}/*/*/tnameserv \
        ${JAVA_HOME}/*/*/unpack200 \
        ${JAVA_HOME}/*/*/*javafx* \
        ${JAVA_HOME}/*/*/*jfx* \
        ${JAVA_HOME}/*/*/amd64/libdecora_sse.so \
        ${JAVA_HOME}/*/*/amd64/libfxplugins.so \
        ${JAVA_HOME}/*/*/amd64/libglass.so \
        ${JAVA_HOME}/*/*/amd64/libgstreamer-lite.so \
        ${JAVA_HOME}/*/*/amd64/libjavafx*.so \
        ${JAVA_HOME}/*/*/amd64/libjfx*.so \
        ${JAVA_HOME}/*/*/amd64/libprism_*.so \
        ${JAVA_HOME}/*/*/deploy* \
        ${JAVA_HOME}/*/*/desktop \
        ${JAVA_HOME}/*/*/ext/jfxrt.jar \
        ${JAVA_HOME}/*/*/ext/nashorn.jar \
        ${JAVA_HOME}/*/*/javaws.jar \
        ${JAVA_HOME}/*/*/jfr \
        ${JAVA_HOME}/*/*/jfr \
        ${JAVA_HOME}/*/*/jfr.jar \
        ${JAVA_HOME}/*/*/missioncontrol \
        ${JAVA_HOME}/*/*/oblique-fonts \
        ${JAVA_HOME}/*/*/plugin.jar \
        ${JAVA_HOME}/*/*/visualvm \
        ${JAVA_HOME}/*/man \
        ${JAVA_HOME}/*/plugin \
        ${JAVA_HOME}/*.txt && \
        rm -rf /root/.cache && \
        apt-get purge -y $(apt-cache search '~c' | awk '{ print $2 }') && \
        apt-get -y autoremove && \
        apt-get -y autoclean && \
        apt-get -y clean all && \
        rm -rf /var/lib/apt/lists/* && \
        rm -rf /var/cache/apt && \
        rm -rf /var/cache/oracle-jdk8-installer && \
        rm -rf /tmp/*

# Define commonly used JAVA_HOME variable
# Add /srv/java and jdk on PATH variable
ENV JAVA_HOME=/srv/java/jdk \
    PATH=${PATH}:/srv/java/jdk/bin:/srv/java


# 安装node
RUN apt-get update && \
apt-get install -y nodejs && \
apt install -y nodejs-legacy && \
apt install -y npm 

# 安装git
RUN apt install -y -t git; \
npm config set registry https://registry.npm.taobao.org; \
npm install n -g; \
n stable

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
