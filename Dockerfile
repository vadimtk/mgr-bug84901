FROM centos:7
ENV PACKAGE_URL https://repo.mysql.com/yum/mysql-5.7-community/docker/x86_64/mysql-community-server-minimal-5.7.19-1.el7.x86_64.rpm

# Install server
RUN rpmkeys --import http://repo.mysql.com/RPM-GPG-KEY-mysql \
  && yum install -y $PACKAGE_URL \
  && yum install -y libpwquality \
  && rm -rf /var/cache/yum/*
RUN mkdir /docker-entrypoint-initdb.d

VOLUME /var/lib/mysql
ADD node.cnf /etc/my.cnf

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306 33060
CMD ["mysqld"]
