require 'spec_helper'

describe 'cx_airserver' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_file('/Library/LaunchAgents/com.connexta.airserver.plist').with(
          'owner'  => 'root',
          'group'  => 'wheel',
          'mode'   => '0644',
          'source' => 'puppet:///modules/cx_airserver/files/com.airserver.plist',
            ) }
    end
  end
end
