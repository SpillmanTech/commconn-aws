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
  EOH
end

template '/usr/lib/systemd/system/activemq.service' do
  source 'activemq.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

bash "install activemq service" do
  user "root"
  cwd "/"
  code <<-EOH
    systemctl enable activemq.service
    systemctl start activemq.service
  EOH
end