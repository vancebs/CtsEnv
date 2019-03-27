FROM ubuntu:16.04
MAINTAINER Vancebs <vancebs@qq.com>

# install tools
RUN apt-get update
RUN apt-get install -y openjdk-8-jre adb fastboot python python-pip python-virtualenv

# copy aapt
COPY misc/aapt /usr/local/bin/aapt
COPY misc/aapt2 /usr/local/bin/aapt2
RUN chmod 777 /usr/local/bin/aapt
RUN chmod 777 /usr/local/bin/aapt2

# add device rule
RUN echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"05c6\", MODE=\"0666\", GROUP=\"plugdev\"" | sudo tee -a /etc/udev/rules.d/51-andorid.rules

# sudo usermod -aG plugdev $LOGNAME
# sudo service udev restart
