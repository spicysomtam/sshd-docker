FROM debian:jessie-slim
LABEL maintainer="alastair@alastair-munro.com" \
  description="sshd based image for development. sshd running keeps the docker container running."
RUN apt-get update --fix-missing && \
  apt-get -y -q upgrade  && \
  apt-get install -y lsb-release grep openssh-server locales net-tools vim lsof cron && \
  mkdir /var/run/sshd && \
  echo 'root:root' | chpasswd && \
  sed -i 's/PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

