# encoding: UTF-8

require_relative 'spec_helper'

describe 'sysstat::default' do
  let(:file) { chef_run.template '/etc/default/sysstat' }

  context 'ubuntu' do
    let(:runner) do
      ChefSpec::Runner.new UBUNTU_OPTS do |node|
        node.set['sysstat']['sa1_options'] = '-S DISK -S INT'
        node.set['sysstat']['sa2_options'] = '-A'
      end
    end
    let(:chef_run) { runner.converge(described_recipe) }

    it 'installs package' do
      expect(chef_run).to upgrade_package 'sysstat'
    end

    it 'starts service' do
      expect(chef_run).to start_service 'sysstat'
    end

    it 'enables service' do
      expect(chef_run).to enable_service 'sysstat'
    end

    it 'has proper owner' do
      expect(file.owner).to eq 'root'
      expect(file.group).to eq 'root'
    end

    it 'has proper modes' do
      expect(format('%o', file.mode)).to eq '644'
    end

    it 'is enabled' do
      expect(chef_run).to render_file(file.name)
        .with_content %Q(ENABLED="true")
    end

    it 'overrides sa1_options' do
      expect(chef_run).to render_file(file.name)
        .with_content %Q(SA1_OPTIONS="-S DISK -S INT")
    end

    it 'overrides sa2_options' do
      expect(chef_run).to render_file(file.name)
        .with_content %Q(SA2_OPTIONS="-A")
    end
  end

  context 'redhat' do
    let(:runner) { ChefSpec::Runner.new REDHAT_OPTS }
    let(:chef_run) { runner.converge(described_recipe) }

    it "doesn't create file" do
      expect(chef_run).not_to create_file file
    end
  end
end
