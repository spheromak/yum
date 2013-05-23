require 'spec_helper'

describe "yum::elrepo" do
  let(:chef_run) do
    runner = ChefSpec::ChefRunner.new(
      platform: 'redhat',
      version: '6.3',
      log_level: :error,
      cookbook_path: $cookbook_path
    ) do |node|
    end
    Chef::Config.force_logger true
    runner.converge('recipe[yum::elrepo]')
  end

  it "creates the yum key" do
    key = chef_run.yum_key "RPM-GPG-KEY-elrepo.org"
    expect(key.url).to eql "http://elrepo.org/RPM-GPG-KEY-elrepo.org"
  end

  it "creates the yum repository" do
    repo = chef_run.yum_repository "elrepo"
    expect(repo.key).to eql "RPM-GPG-KEY-elrepo.org"
    expect(repo.mirrorlist).to eql "http://elrepo.org/mirrors-elrepo.el6"
    expect(repo.includepkgs).to eql nil
    expect(repo.exclude).to eql nil
    expect(repo.action).to eql [:create]
  end
end
