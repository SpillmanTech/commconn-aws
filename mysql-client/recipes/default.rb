#
# Cookbook Name:: mysql-client
# Recipe:: default
#
# Copyright 2017, Motorola
#
# All rights reserved - Do Not Redistribute

bash "install mariadb which also installs the mysql CLI" do
  user "root"
  cwd "/"
  code <<-EOH
    yum -y install mariadb
  EOH
end
