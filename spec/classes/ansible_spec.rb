require 'spec_helper'

describe 'ansible' do

  context "When you add an ansible class without parameters" do
    let(:facts) { {:osfamily => 'Debian' } }
    it { should contain_class('ansible::master') }
    it { should_not  contain_class('ansible::node') }
  end

  context "When you add an ansible class on an non debian os" do
    let(:facts) { {:osfamily => 'NonDebian' } }
    it do
        expect {
            should contain_class('ansible::master')
        }.to raise_error(Puppet::Error, /Unsupported platform/)
    end
  end

  context "When you add an ansible master with a master parameter " do
    let(:facts) { {:osfamily => 'Debian' } }
    let(:params) { {:ensure  => 'master', :master => 'master.fqdn.tld'} } 
    it { should_not  contain_class('ansible::master') }
    it { should_not  contain_class('ansible::node') }
  end

  context "When you add an ansible node with a master parameter " do
    let(:facts) { {:osfamily => 'Debian' } }
    let(:params) { {:ensure  => 'node', :master => 'master.fqdn.tld'} } 
    it { should_not  contain_class('ansible::master') }
    it { should  contain_class('ansible::node') }
  end

  context "When you add an ansible node with an invalid master parameter " do
    let(:facts) { {:osfamily => 'Debian' } }
    let(:params) { {:ensure  => 'node', :master => 1337 } } 
    it { should_not  contain_class('ansible::master') }
    it { should_not  contain_class('ansible::node') }
  end

end
