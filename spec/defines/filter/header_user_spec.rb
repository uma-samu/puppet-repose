require 'spec_helper'
describe 'repose::filter::header_user', :type => :define do
  let :pre_condition do
    'include repose'
  end
  context 'on RedHat' do
    let :facts do
      {
          :osfamily               => 'RedHat',
          :operationsystemrelease => '6',
      }
    end


    context 'default parameters' do
      let(:title) { 'default' }
      it {
        should contain_file('/etc/repose/header-user.cfg.xml').with(
                   'ensure' => 'file',
                   'owner'  => 'repose',
                   'group'  => 'repose',
                   'mode'   => '0660')
      }
    end

    context 'with ensure absent' do
      let(:title) { 'default' }
      let(:params) { {
          :ensure => 'absent'
      } }
      it {
        should contain_file('/etc/repose/header-user.cfg.xml').with_ensure(
                   'absent')
      }
    end

        context 'providing header user definitions' do
          let(:title) { 'header_user' }
          let(:params) { {
                :ensure     => 'present',
                :filename   => 'header-user.cfg.xml',
                :source_headers => [
                        { 'name' => 'header_name1', 'value'  => '.95' },
                        { 'name' => 'header_name2', 'value'  => '.05' }
                     ],
          } }
          it {
              should contain_file('/etc/repose/header-user.cfg.xml').with_content(
                    /<header id="header_name1" quality=".95" \/>/
              )
            }
        end
  end
end
