require 'spec_helper'

describe 'ansible::playbooks' do

  context 'When you add the playbooks class' do
    let(:facts) { {:osfamily => 'Debian' } }

    it 'a /etc/ansible directory is created' do
      should contain_file('/etc/ansible').with(
        'ensure'  => 'directory',
        'path'    => '/etc/ansible',
        'owner'   => 'ansible',
        'group'   => 'ansible',
        'mode'    => '0750',
        'require' => 'User[ansible]'
     )
    end

  end

end
