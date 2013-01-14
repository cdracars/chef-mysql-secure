#
# Cookbook Name:: mysql-secure
# Recipe:: default
#
# Copyright 2012, Dracars Designs
#
# All rights reserved - Do Not Redistribute
#

include_recipe "mysql::server"

execute "remove test database" do
  command "mysql -u root -p#{node['mysql']['server_root_password']} -e \"DROP DATABASE test;\""
  only_if { File.exists?(node['mysql']['data_dir'] + '/test') }
end

execute "stop root access from all but localhost" do
  command "mysql -u root -p#{node['mysql']['server_root_password']} -e \"DELETE FROM mysql.user WHERE User='root' AND Host!='localhost';\""
end

execute "remove blank users" do
  command "mysql -u root -p#{node['mysql']['server_root_password']} -e \"DELETE FROM mysql.user WHERE User='';\""
end


execute "flush privileges" do
  command "mysql -u root -p#{node['mysql']['server_root_password']} -e \"Flush PRIVILEGES;\""
end
