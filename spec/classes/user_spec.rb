require 'spec_helper'

describe 'ansible::user' do

  context 'When you add an ansible::user class' do
    let(:facts) { {:osfamily => 'Debian' } }

    it 'an ansible user is created' do
      should contain_user('ansible').with(
        'ensure'     => 'present',
        'name'       => 'ansible',
        'shell'      => '/bin/bash',
        'managehome' => 'true',
        'password'   => '*NP*'
      )
    end

    it 'a /home/ansible/.ssh directory is created' do
      should contain_file('/home/ansible/.ssh').with(
        'ensure'  => 'directory',
        'path'    => '/home/ansible/.ssh',
        'owner'   => 'ansible',
        'group'   => 'ansible',
        'mode'    => '0700',
        'notify'  => 'Exec[home_ansible_ssh_keygen]',
        'require' => 'User[ansible]'
     )
    end

    it 'a ansible user rsa key is created' do
      should contain_exec('home_ansible_ssh_keygen').with(
       'command' => 'ssh-keygen -t rsa -q -f /home/ansible/.ssh/id_rsa -N ""',
       'creates' => '/home/ansible/.ssh/id_rsa',
       'user'    => 'ansible'
      )
    end

  end

  context 'When you add an ansible user with sudo mode enable' do

    let(:facts) { {:osfamily => 'Debian' } }
    let(:params) { {:sudo => 'enable' } }

    it 'sudo software is present' do
      should contain_package('sudo').with(
          'ensure' => 'present'
      )
    end

    it 'a /etc/sudoers.d/ansible file is created' do
      should contain_file('/etc/sudoers.d/ansible').with(
        'ensure'  => 'file',
        'path'    => '/etc/sudoers.d/ansible',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0440',
        'content' => 'ansible ALL = NOPASSWD : ALL'
     )
    end

  end

  context 'When you add an ansible::user class with a password parameter' do
    let(:facts) { {:osfamily => 'Debian' } }
    let(:params) { {:password  => 'passwordhash' } }

    it 'an ansible user is created' do
      should contain_user('ansible').with(
        'ensure'     => 'present',
        'name'       => 'ansible',
        'shell'      => '/bin/bash',
        'managehome' => 'true',
        'password'   => 'passwordhash'
      )
    end

  end

end
