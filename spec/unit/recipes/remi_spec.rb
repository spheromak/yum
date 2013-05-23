require 'spec_helper'

describe "yum::remi" do
  context("redhat 6.3") do
    let(:chef_run) do
      runner = ChefSpec::ChefRunner.new(
        platform: 'redhat',
        version: '6.3',
        log_level: :error,
        cookbook_path: $cookbook_path
      ) do |node|
      end
      Chef::Config.force_logger true
      runner.converge('recipe[yum::remi]')
    end

    it "includes the epel" do
      expect(chef_run).to include_recipe "yum::epel"
    end

    it "creates the yum key" do
      key = chef_run.yum_key "RPM-GPG-KEY-remi"
      expect(key.url).to eql "http://rpms.famillecollet.com/RPM-GPG-KEY-remi"
    end

    it "creates the remi repository" do
      repo = chef_run.yum_repository "remi"
      expect(repo.key).to eql "RPM-GPG-KEY-remi"
      expect(repo.mirrorlist).to eql "http://rpms.famillecollet.com/enterprise/6/remi/mirror"
      expect(repo.failovermethod).to eql "priority"
      expect(repo.includepkgs).to eql nil
      expect(repo.exclude).to eql nil
      expect(repo.action).to eql [:create]
    end
  end

  context("fedora 6.3") do
    let(:chef_run) do
      runner = ChefSpec::ChefRunner.new(
        log_level: :error,
        cookbook_path: $cookbook_path
      ) do |node|
        node.automatic_attrs['platform'] = "fedora"
        node.automatic_attrs['platform_version'] = "18"
      end
      Chef::Config.force_logger true
      runner.converge('recipe[yum::remi]')
    end

    it "includes the epel" do
      expect(chef_run).to include_recipe "yum::epel"
    end

    it "creates the yum key" do
      key = chef_run.yum_key "RPM-GPG-KEY-remi"
      expect(key.url).to eql "http://rpms.famillecollet.com/RPM-GPG-KEY-remi"
    end

    it "creates the remi repository" do
      repo = chef_run.yum_repository "remi"
      expect(repo.key).to eql "RPM-GPG-KEY-remi"
      expect(repo.mirrorlist).to eql "http://rpms.famillecollet.com/fedora/18/remi/mirror"
      expect(repo.failovermethod).to eql "priority"
      expect(repo.includepkgs).to eql nil
      expect(repo.exclude).to eql nil
      expect(repo.action).to eql [:create]
    end
  end
end
