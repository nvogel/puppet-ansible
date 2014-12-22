require 'spec_helper'

describe 'ansible::node' do

  context 'When you add an ansible::node class' do
    let(:facts) { {:osfamily => 'Debian' } }
    let(:params) { {:master => 'host.fqdn.tld'} }

    it { should contain_class('ansible::params') }

    it { should contain_class('ansible::node').with(
      'master' => 'host.fqdn.tld'
    )}

    it { should contain_class('ansible::user').with(
      'sudo' => 'enable'
    )}

  end

  context 'When you add an ansible::node class without master parameter' do
    let(:facts) { {:osfamily => 'Debian' } }

    it do
      expect {
        should contain_class('ansible::user')
      }.to raise_error(Puppet::Error, /master parameter must be set/)
    end

  end

end
