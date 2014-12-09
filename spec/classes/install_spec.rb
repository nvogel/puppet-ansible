require 'spec_helper'

describe 'ansible::install' do

  context "When you install ansible with pip provider (default)" do

    os = ['Debian', 'RedHat']

    os.each do |osf|
      let(:facts) { {:osfamily => osf } }

      it 'ansible is present' do
        should contain_package('ansible').with(
            'ensure'   => 'present',
            'provider' => 'pip'
        )
      end
    end

  end

  context "When you install ansible with pip provider (default)" do

    let(:facts) { {:osfamily => 'Debian' } }

    it { should contain_package('python-yaml')}
    it { should contain_package('python-jinja2')}
    it { should contain_package('python-paramiko')}
    it { should contain_package('python-pkg-resources')}
    it { should contain_package('python-pip')}
    it { should contain_package('python-crypto')}
    it { should contain_package('python-httplib2')}

  end

  context "When you install ansible with a default provider and a version" do
    let(:params) { {:provider => 'default', :version => 'latest'}  }

    os = ['Debian', 'RedHat']

    os.each do |osf|
      let(:facts) { {:osfamily => osf } }

      it 'ansible is present' do
        should contain_package('ansible').with(
            'ensure'   => 'latest'
        )
      end
    end

  end

  context "When you install ansible with a default provider" do
    let(:params) { {:provider => 'default'} }

    os = ['Debian', 'RedHat']

    os.each do |osf|
      let(:facts) { {:osfamily => osf } }

      it 'ansible is present' do
        should contain_package('ansible').with(
            'ensure'   => 'present'
        )
      end
    end

  end

  context "When you install ansible with a specific version" do
    os = ['Debian', 'RedHat']
    let(:params) { {:version => '1.7.1'} }

    os.each do |osf|
      let(:facts) { {:osfamily => osf } }

      it 'ansible is present' do
        should contain_package('ansible').with(
            'ensure'   => '1.7.1',
            'provider' => 'pip'
        )
      end
    end

  end

end
