require 'spec_helper'

describe "yum::ius" do
  let(:chef_run) do
    runner = ChefSpec::ChefRunner.new(
      platform: 'redhat',
      version: '6.3',
      log_level: :error,
      cookbook_path: $cookbook_path
    ) do |node|
      node.automatic_attrs['kernel']['machine'] = "x86_64"
    end
    Chef::Config.force_logger true
    runner.converge('recipe[yum::repoforge]')
  end

  it "includes epel" do
    expect(chef_run).to include_recipe("yum::epel")
  end

  it "grabs the rpmforge-release rpm" do
    expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm").with(
      :source => "http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm")
  end

  it "installs the rpmforge-release rpm" do
    rpm = chef_run.rpm_package "rpmforge-release"
    expect(rpm.source).to eql("#{Chef::Config[:file_cache_path]}/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm")
  end

  it "cleans up the repoforge-release rpm" do
    expect(chef_run).to delete_file "#{Chef::Config[:file_cache_path]}/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm"
  end
end

