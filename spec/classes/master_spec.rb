require 'spec_helper'

describe 'ansible::master' do

  context "When you add an ansible::master class" do
    let(:facts) { {:osfamily => 'Debian' } }

    it { should contain_class('ansible::user') }

    it '' do
      should contain_file('/etc/ssh/ssh_known_hosts').with(
        'ensure'  => 'file',
        'path'    => '/etc/ssh/ssh_known_hosts',
        'mode'    => '0644'
      )
    end

  end

end
