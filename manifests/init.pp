# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include cx_airserver
class cx_airserver {
  file{ '/opt/connexta/cx_airserver':
    ensure => directory,
    owner  => 'root',
    group  => 'wheel',
    mode   => '0700',
    before => File['/opt/connexta/cx_airserver/scripts'],
  }
  file{ '/opt/connexta/cx_airserver/scripts':
    ensure => directory,
    owner  => 'root',
    group  => 'wheel',
    mode   => '0700',
    before => File['/opt/connexta/cx_airserver/scripts/airserver.sh'],
  }
  file { '/opt/connexta/cx_airserver/scripts/airserver.sh':
    ensure => 'file',
    owner  => 'root',
    group  => 'wheel',
    mode   => '0755',
    source => 'puppet:///modules/cx_airserver/airserver.sh',
    before => File['/Library/LaunchAgents/com.connexta.airserver.plist'],
  }
  file { '/Library/LaunchAgents/com.connexta.airserver.plist':
    ensure => 'file',
    owner  => 'root',
    group  => 'wheel',
    mode   => '0644',
    source => 'puppet:///modules/cx_airserver/com.connexta.airserver.plist',
  }
}
