require 'spec_helper'

describe 'ansible::params' do

  context "When you add an ansible class on an non debian os" do
    let(:facts) { {:osfamily => 'NonDebian' } }
    it do
        expect {
            should contain_class('ansible::params')
        }.to raise_error(Puppet::Error, /Unsupported platform/)
    end
  end

end
