require 'spec_helper'

describe "yum::ius" do
  let(:chef_run) do
    runner = ChefSpec::ChefRunner.new(
      platform: 'redhat',
      version: '6.3',
      log_level: :error,
      cookbook_path: $cookbook_path
    ) do |node|
    end
    Chef::Config.force_logger true
    runner.converge('recipe[yum::ius]')
  end

  it "includes epel" do
    expect(chef_run).to include_recipe("yum::epel")
  end

  it "installs epel-release package" do
    expect(chef_run).to install_package("epel-release")
  end

  it "grabs the ius-release rpm" do
    expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/ius-release-1.0-11.ius.el6.noarch.rpm").with(
      :source => "http://dl.iuscommunity.org/pub/ius/stable/Redhat/6/i386/ius-release-1.0-11.ius.el6.noarch.rpm")
  end

  it "installs the ius-release rpm" do
    rpm = chef_run.rpm_package "ius-release"
    expect(rpm.source).to eql("#{Chef::Config[:file_cache_path]}/ius-release-1.0-11.ius.el6.noarch.rpm")
  end

  it "cleans up the ius-release rpm" do
    expect(chef_run).to delete_file("#{Chef::Config[:file_cache_path]}/ius-release-1.0-11.ius.el6.noarch.rpm")
  end
end

