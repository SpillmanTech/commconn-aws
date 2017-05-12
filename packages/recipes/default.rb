#
# Cookbook Name:: activemq
# Recipe:: default
#
# Copyright 2017, Motorola
#
# All rights reserved - Do Not Redistribute

bash "install activemq" do
  user "root"
  cwd "/"
  code <<-EOH
    if [ ! -d /opt/activemq ]; then
      yum install epel-release -y
      yum clean all -y
      yum update -y
      yum install java-1.8.0-openjdk -y
      yum install wget -y
      echo "JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")" | sudo tee -a /etc/profile
      source /etc/profile
      wget https://archive.apache.org/dist/activemq/5.14.4/apache-activemq-5.14.4-bin.tar.gz
      tar -zxf /apache-activemq-5.14.4-bin.tar.gz -C /opt
      ln -s /opt/apache-activemq-5.14.4 /opt/activemq
      rm -f /apache-activemq-5.14.4-bin.tar.gz
    fi
  EOH
end

