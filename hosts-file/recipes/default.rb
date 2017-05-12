#
# Cookbook Name:: hosts-file
# Recipe:: default
#
# Copyright 2017, Motorola
#
# All rights reserved - Do Not Redistribute

instance = search("aws_opsworks_instance", "self:true").first
instance_hostname = instance["hostname"]
instance_ipaddress = instance["private_ip"]

template '/etc/hosts' do
  source 'hosts-file.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables ({
      :instance_hostname => instance_hostname,
      :instance_ipaddress => instance_ipaddress
    })
end
