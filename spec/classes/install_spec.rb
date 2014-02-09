require 'spec_helper'

describe 'ansible::install' do

  context "When you add an ansible::install class" do

    it { should contain_package('python-yaml')}
    it { should contain_package('python-jinja2')}
    it { should contain_package('python-paramiko')}
    it { should contain_package('python-markupsafe')}
    it { should contain_package('python-pip')}

    it 'ansible is present' do
      should contain_package('ansible').with(
          'ensure'   => 'present',
          'provider' => 'pip'
      )
    end

  end

end
