FROM 		centos:7

RUN		yum update -y && \
		yum install -y epel-release && \
		yum install -y iproute python-setuptools hostname inotify-tools yum-utils which jq && \
		yum clean all && \
		easy_install supervisor


RUN		yum update -y && \ 
		yum install -y vsftpd wget tar bzip2 unzip

RUN		yum install -y sudo nano httpd

RUN 		echo 'alias ls="ls --color"' >> ~/.bashrc \
		&& echo 'alias ll="ls -lh"' >> ~/.bashrc \
		&& echo 'alias la="ls -lha"' >> ~/.bashrc

RUN		yum clean all && rm -rf /tmp/yum*

ENV		USER=www
ENV		PASSWORD=iaw


ADD		container-files /

RUN		sed -ri "s/www/${USER}/g" /etc/supervisord.conf && \
		sed -ri "s/iaw/${PASSWORD}/g" /etc/supervisord.conf


VOLUME		["/data"]

EXPOSE		9001 20 21 80


ENTRYPOINT	["/config/bootstrap.sh"]
