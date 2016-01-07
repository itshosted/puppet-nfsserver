class nfsserver::install
{
  case $::osfamily {
    'RedHat': {
      case $::operatingsystemmajrelease {
        '6': {
          
          package { "nfs-utils": 
            ensure => 'present'
          }
          package { "nfs-utils-lib": 
            ensure => 'present'
          }

          service { 'rpcbind':
            ensure    => 'running',
            enable    => true,
            require => [  Package['nfs-utils'],
                          Package['nfs-utils-lib'], 
                       ],
          }
                    
          service { 'nfs':
            ensure    => 'running',
            enable    => true,
            require => [  Package['nfs-utils'],
                          Package['nfs-utils-lib'],
                          Service['rpcbind'],
                       ],
          }
        }
        
        default: {
          fail("nfs module only supports EL6 and operatingsystemmajrelease was detected as <${::operatingsystemmajrelease}>.")
        }
      }
    }
  }
}
