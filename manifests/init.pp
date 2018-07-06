# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include cx_airserver
class cx_airserver {
    file { '/Library/LaunchAgents/com.connexta.airserver.plist':
        owner  => 'root',
        group  => 'wheel',
        mode   => '0755',
        source => 'puppet:///modules/cx_airserver/files/com.airserver.plist',
    }
    file { '/opt/connexta/cx_airserver/scripts/airserver.sh':
        owner  => 'root',
        group  => 'wheel',
        mode   => '0755',
        source => 'puppet:///modules/cx_airserver/files/airserver.sh',
    }
}
