#
# Cookbook Name:: salt-minion
# Recipe:: default
#
# Copyright 2017, Motorola
#
# All rights reserved - Do Not Redistribute

instance = search("aws_opsworks_instance", "self:true").first
instance_hostname = instance["hostname"]

template '/etc/yum.repos.d/saltstack-repo.repo' do
  source 'saltstack_repo.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

bash "install salt-minion" do
  user "root"
  cwd "/"
  code <<-EOH
    yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm
    yum clean expire-cache
    yum -y install salt-minion
  EOH
end

bash "add zabbix repo" do
  user "root"
  cwd "/"
  code <<-EOH
    rpm -Uvh --replacepkgs http://repo.zabbix.com/zabbix/3.0/rhel/7/x86_64/zabbix-release-3.0-1.el7.noarch.rpm
  EOH
end

template '/etc/salt/minion_id' do
  source 'minion_id.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables ({ :instance_hostname => instance_hostname })
end

template '/etc/salt/minion' do
  source 'minion.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

bash "install salt-minion" do
  user "root"
  cwd "/"
  code <<-EOH
    systemctl restart salt-minion
  EOH
end
