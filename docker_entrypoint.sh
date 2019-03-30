#! /bin/bash

# get env
if [ -z ${USER_ID} ]; then USER_ID=1000; fi
if [ -z ${GROUP_ID} ]; then GROUP_ID=1000; fi
if [ -z ${USER_NAME} ]; then USER_NAME="cts"; fi
if [ -z ${GROUP_NAME} ]; then GROUP_NAME="cts"; fi
if [ -z ${USER_PASSWD} ]; then USER_PASSWD="cts"; fi
if [ -z ${USER_HOME} ]; then USER_HOME="home/${USER_NAME}"; fi

# create group if not created
egrep "^${GROUP_NAME}:*:${GROUP_ID}:" /etc/group
if [ $? -ne 0 ]; then
    groupadd -g ${GROUP_ID} -r ${GROUP_NAME}
fi

# create user if not created
egrep "^${USER_NAME}:*:${USER_ID}:" /etc/passwd
if [ $? -ne 0 ]; then
    useradd -u ${USER_ID} --home-dir ${USER_HOME} -r -p ${USER_PASSWD} -g ${GROUP_NAME} ${USER_NAME}
    usermod -aG plugdev ${USER_NAME}
fi

# no sudo password for new user
echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# run
export HOME=${USER_HOME}
cd ${HOME}
exec sudo -E -u ${USER_NAME} bash
