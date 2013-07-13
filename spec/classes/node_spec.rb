require 'spec_helper'

describe 'ansible::node' do

  context 'When you add an ansible::node class' do
    let(:params) { {:master => 'host.fqdn.tld'} }

    it { should include_class('ansible::user') }
  end

  context 'When you add an ansible::node class without master parameter' do

    it do
      expect {
        should contain_class('ansible::user')
      }.to raise_error(Puppet::Error, /master parameter must be set/)
    end

  end

end
