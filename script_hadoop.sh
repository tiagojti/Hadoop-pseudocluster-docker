#!/bin/sh

# Iniciando o SSH
/etc/init.d/ssh start

# Configurando Diretórios JAVA para facilitar a instalação
mkdir /usr/java
ln -s /usr/lib/jvm/java-1.8.0-openjdk-amd64 /usr/java/latest

# Linkando o hadoop para facilidade em configurações
ln -s /root/hadoop-3.2.1 /opt/hadoop

# Passando alguns parâmetros iniciais para o start do serviço
echo 'export JAVA_HOME="/usr/java/latest"' >> /opt/hadoop/etc/hadoop/hadoop-env.sh
echo 'export HDFS_NAMENODE_USER="root"' >> /opt/hadoop/etc/hadoop/hadoop-env.sh
echo 'export HDFS_NAMENODE_GROUP="root"' >> /opt/hadoop/etc/hadoop/hadoop-env.sh
echo 'export HDFS_DATANODE_USER="root"' >> /opt/hadoop/etc/hadoop/hadoop-env.sh
echo 'export HDFS_SECONDARYNAMENODE_USER="root"' >> /opt/hadoop/etc/hadoop/hadoop-env.sh
echo 'export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop' >> /opt/hadoop/etc/hadoop/hadoop-env.sh
echo 'export YARN_NODEMANAGER_USER="root"' >> /opt/hadoop/etc/hadoop/yarn-env.sh
echo 'export YARN_RESOURCEMANAGER_USER="root"' >> /opt/hadoop/etc/hadoop/yarn-env.sh

# Copiando os arquivos para os serviços
cp /root/conf/core-site.xml /opt/hadoop/etc/hadoop/
cp /root/conf/hdfs-site.xml /opt/hadoop/etc/hadoop/
cp /root/conf/mapred-site.xml /opt/hadoop/etc/hadoop/
cp /root/conf/yarn-site.xml /opt/hadoop/etc/hadoop/

# Formatando o NameNode e iniciando o serviço HDFS e YARN
/opt/hadoop/bin/hdfs namenode -format
/opt/hadoop/sbin/start-dfs.sh
/opt/hadoop/sbin/start-yarn.sh

# Iniciando sessão (ao iniciar a imagem, o último comando é para deixar você dentro do servidor, aonde você poderá começar a brincadeira)
/bin/bash