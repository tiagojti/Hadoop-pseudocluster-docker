FROM oraclelinux:7.9

EXPOSE 50070 8088 9864

RUN yum update -y && yum install -y openssh-clients rsync wget curl net-tools nano openjdk-8-jdk openjdk-8-jre clean all
RUN ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa && cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys2 
ADD https://archive.apache.org/dist/hadoop/core/hadoop-3.2.1/hadoop-3.2.1.tar.gz /opt/
RUN tar -xzf /opt/hadoop-3.2.1.tar.gz -C /opt/ && rm -f /opt/hadoop-3.2.1.tar.gz

ADD https://archive.apache.org/dist/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz /opt/
RUN tar -xzf /opt/spark-2.4.4-bin-hadoop2.7.tgz -C /opt/ && rm -f /opt/spark-2.4.4-bin-hadoop2.7.tgz

COPY script_hadoop.sh /opt/
COPY conf /opt/conf
RUN chmod +x /opt/script_hadoop.sh
ENTRYPOINT [ "/opt/script_hadoop.sh" ]

