# Commands to run before all others in puppet.
class init {
    group { "puppet":
        ensure => "present",
    }
    case $operatingsystem {
        ubuntu: {
            exec { "apt-update":
                command => "sudo apt-get update",
            }
            Exec["apt-update"] -> Package <| |>
            package { "python-software-properties":
                ensure => present,
            }
            $misc_packages = ['git-core', 'tmux']
            package { $misc_packages:
                ensure => present,
            }
        }
    }
}
