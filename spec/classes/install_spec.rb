require 'spec_helper'

describe 'ansible::install' do

  context "When you install ansible with pip provider (default)" do
    let(:facts) { {:osfamily => 'Debian' } }

    it { should contain_package('python-yaml')}
    it { should contain_package('python-jinja2')}
    it { should contain_package('python-paramiko')}
    it { should contain_package('python-markupsafe')}
    it { should contain_package('python-pip')}
    it { should contain_package('python-crypto')}

    it 'ansible is present' do
      should contain_package('ansible').with(
          'ensure'   => 'present',
          'provider' => 'pip'
      )
    end

  end

  context "When you install ansible with an apt provider" do
    let(:facts) { {:osfamily => 'Debian' } }
    let(:params) { {:provider => 'apt'} }

    it { should_not contain_package('python-yaml')}
    it { should_not contain_package('python-jinja2')}
    it { should_not contain_package('python-paramiko')}
    it { should_not contain_package('python-markupsafe')}
    it { should_not contain_package('python-pip')}
    it { should_not contain_package('python-crypto')}

    it 'ansible is present' do
      should contain_package('ansible').with(
          'ensure'   => 'present',
          'provider' => 'apt'
      )
    end

  end

  context "When you install ansible with a specific version" do
    let(:facts) { {:osfamily => 'Debian' } }
    let(:params) { {:version => '1.7.1'} }

    it 'ansible is present' do
      should contain_package('ansible').with(
          'ensure'   => '1.7.1',
          'provider' => 'pip'
      )
    end

  end

end
