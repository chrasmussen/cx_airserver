require 'spec_helper'
  
describe 'cx_airserver' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_file('/opt/connexta/cx_airserver').with(
          'ensure' => 'directory',
          'owner'  => 'root',
          'group'  => 'wheel',
          'mode'   => '0700',
          'before' => 'File[/opt/connexta/cx_airserver/scripts]',
            ) }
      it { is_expected.to contain_file('/opt/connexta/cx_airserver/scripts').with(
          'ensure' => 'directory',
          'owner'  => 'root',
          'group'  => 'wheel',
          'mode'   => '0700',
          'before' => 'File[/opt/connexta/cx_airserver/scripts/airserver.sh]',
            ) }
      it { is_expected.to contain_file('/Library/LaunchAgents/com.connexta.airserver.plist').with(
          'owner'  => 'root',
          'group'  => 'wheel',
          'mode'   => '0644',
          'source' => 'puppet:///modules/cx_airserver/com.connexta.airserver.plist',
            ) }
      it { is_expected.to contain_file('/opt/connexta/cx_airserver/scripts/airserver.sh').with(
          'owner'  => 'root',
          'group'  => 'wheel',
          'mode'   => '0755',
          'source' => 'puppet:///modules/cx_airserver/airserver.sh',
          'before' => 'File[/Library/LaunchAgents/com.connexta.airserver.plist]',
            ) }
    end
  end
end
