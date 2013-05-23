require 'spec_helper'

describe "yum::epel" do
  context "rhel 6" do
    let(:chef_run) do
      runner = ChefSpec::ChefRunner.new(
        platform: 'redhat',
        version: '6.3',
        log_level: :error,
        cookbook_path: $cookbook_path
      ) do |node|
      end
      Chef::Config.force_logger true
      runner.converge('recipe[yum::epel]')
    end

    it "creates the yum key" do
      key = chef_run.yum_key "RPM-GPG-KEY-EPEL-6"
      expect(key.url).to eql "http://download.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6"
    end

    it "creates the yum repository" do
      repo = chef_run.yum_repository "epel"
      expect(repo.key).to eql "RPM-GPG-KEY-EPEL-6"
      expect(repo.url).to eql ""
      expect(repo.mirrorlist).to eql "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch"
      expect(repo.includepkgs).to eql nil
      expect(repo.exclude).to eql nil
      expect(repo.action).to eql [:create]
    end
  end

  context "rhel 5" do
    let(:chef_run) do
      runner = ChefSpec::ChefRunner.new(
        platform: 'redhat',
        version: '5.8',
        log_level: :error,
        cookbook_path: $cookbook_path
      ) do |node|
      end
      Chef::Config.force_logger true
      runner.converge('recipe[yum::epel]')
    end

    it "creates the yum key" do
      key = chef_run.yum_key "RPM-GPG-KEY-EPEL"
      expect(key.url).to eql "http://download.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL"
    end

    it "creates the yum repository" do
      repo = chef_run.yum_repository "epel"
      expect(repo.key).to eql "RPM-GPG-KEY-EPEL"
      expect(repo.url).to eql ""
      expect(repo.mirrorlist).to eql "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-5&arch=$basearch"
      expect(repo.includepkgs).to eql nil
      expect(repo.exclude).to eql nil
      expect(repo.action).to eql [:create]
    end
  end

  context "amazon" do
    let(:chef_run) do
      runner = ChefSpec::ChefRunner.new(
        platform: 'amazon',
        version: '2012.09',
        log_level: :error,
        cookbook_path: $cookbook_path
      ) do |node|
      end
      Chef::Config.force_logger true
      runner.converge('recipe[yum::epel]')
    end

    it "creates the yum key" do
      key = chef_run.yum_key "RPM-GPG-KEY-EPEL-6"
      expect(key.url).to eql "http://download.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6"
    end

    it "creates the yum repository" do
      repo = chef_run.yum_repository "epel"
      expect(repo.key).to eql "RPM-GPG-KEY-EPEL-6"
      expect(repo.url).to eql ""
      expect(repo.mirrorlist).to eql "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch"
      expect(repo.includepkgs).to eql nil
      expect(repo.exclude).to eql nil
      expect(repo.action).to eql [:add, :update]
    end
  end

end
