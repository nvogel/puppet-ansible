require 'spec_helper'

describe 'ansible::master' do

  context "When you add an ansible::master class" do
    let(:facts) { {:osfamily => 'Debian' } }

    it { should contain_class('ansible::user') }
    it { should contain_class('ansible::install') }
    it { should contain_class('ansible::params') }

    it '' do
      should contain_file('/etc/ssh/ssh_known_hosts').with(
        'ensure'  => 'file',
        'path'    => '/etc/ssh/ssh_known_hosts',
        'mode'    => '0644'
      )
    end

  end

  context "When you add an ansible::master class with the manual provider" do
    let(:facts) { {:osfamily => 'Debian' } }
    let(:params) { {:provider  => 'manual'} } 
    it { should_not  contain_class('ansible::install') }
  end

  context "When you add an ansible::master class with the default provider" do
    let(:facts) { {:osfamily => 'Debian' } }
    let(:params) { {:provider  => 'default'} } 

    it 'ansible is present and installed via apt' do
      should contain_class('ansible::install').with(
          'provider' => 'default'
      )
    end
  end

  context "When you add an ansible::master class with non supported provider" do
    let(:facts) { {:osfamily => 'Debian' } }
    let(:params) { {:provider  => 'anonsupportedprovider'} } 
    it do
        expect {
            should contain_class('ansible::install')
        }.to raise_error(Puppet::Error, /Unsupported provider/)
    end
  end

end
