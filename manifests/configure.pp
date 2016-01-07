class nfsserver::configure(
  $config = undef,
)
{
  if $config {
    $_config = $config
  }
  else {
    $_config = hiera_hash('nfsserver', undef)
  }
  
  $defaults = {
  }

  create_resources('nfsserver_export', $_config, $defaults)
  
}

define nfsserver_export(
  $exports = [],
)
{
  case $::osfamily {
    'RedHat', 'CentOS': {
      case $::operatingsystemmajrelease {
        '6': {
          file { "/etc/exports":
                owner   => root,
                group   => root,
                mode    => 644,
                content => template('nfsserver/etc/exports.erb'),
                notify => Exec['update_nfs_exports'],
          }
          exec { 'update_nfs_exports':
                  command     => 'exportfs -ra',
                  path        => '/bin:/usr/bin:/sbin:/usr/sbin',
                  refreshonly => true,
          }
        }
      }
    }
  }
}