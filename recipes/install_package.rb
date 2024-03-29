#
# Cookbook Name:: ant
# Recipe:: install_package
#
# Copyright 2012, Kyle Allan (<kallan@riotgames.com>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "java"

if platform?("centos","redhat","fedora","scientific","amazon","debian","ubuntu")

    case node.platform
    when "centos","redhat","fedora"
      include_recipe "jpackage"
    end

    ant_pkgs = value_for_platform(
      ["debian","ubuntu",] => {
        "default" => ["ant","ant-contrib","ivy"]
      },
      ["centos","redhat","fedora" ] => {
        "default" => ["ant","ant-contrib","ivy"]
      },
      "default" => ["ant","ant-contrib","ivy"]
    )

    ant_pkgs.each do |pkg|
      package pkg do
        action :install
      end
    end

elsif platform?("windows")

    ant_home = "#{node['ant']['apache_root']}\\#{node['ant']['ant_name']}"
    ant_path = "#{ant_home}\\bin"

    log "Unzipping ant"

    windows_zipfile "Unzip ant binaries" do
        path node['ant']['apache_root']
        source node['ant']['url']
        action :unzip
        not_if {::File.exists?(ant_path)}
    end

    env "ANT_HOME" do
        value ant_home
    end

    windows_path ant_path do
        action :add
    end
end
