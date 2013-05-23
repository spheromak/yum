require 'spec_helper'

describe "yum::default" do
  let(:chef_run) do
    runner = ChefSpec::ChefRunner.new(
      platform: 'redhat',
      version: '6.3',
      log_level: :error,
      cookbook_path: $cookbook_path
    ) do |node|
    end
    Chef::Config.force_logger true
    runner.converge('recipe[yum::default]')
  end
end
