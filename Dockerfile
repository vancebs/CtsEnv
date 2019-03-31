FROM ubuntu:16.04
MAINTAINER Vancebs <vancebs@qq.com>

# install tools
RUN apt-get update
RUN apt-get install -y openjdk-8-jre adb fastboot python python-pip python-virtualenv
RUN apt-get install -y usbutils
RUN apt-get install -y sudo

# copy aapt
COPY misc/aapt /usr/local/bin/aapt
COPY misc/aapt2 /usr/local/bin/aapt2
COPY misc/libc++.so /usr/local/lib64/libc++.so
RUN chmod a+x /usr/local/bin/aapt
RUN chmod a+x /usr/local/bin/aapt2

# entrypoint
COPY docker_entrypoint.sh /root/docker_entrypoint.sh
RUN chmod a+x /root/docker_entrypoint.sh
ENTRYPOINT ["/root/docker_entrypoint.sh"]

