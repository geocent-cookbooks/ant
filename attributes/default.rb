case platform
#when "centos","redhat","fedora","scientific","amazon","debian","ubuntu"
when "windows"
    default['ant']['apache_root'] = 'C:\\Program Files\\Apache Software Foundation'
    default['ant']['url'] = "http://apache.mirrors.tds.net//ant/binaries/apache-ant-1.8.4-bin.zip"
    default['ant']['ant_name'] = "apache-ant-1.8.4"
end
