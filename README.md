# puppet-nfsserver
Puppet module for NFS Server setup (Only Centos 6 for now)

Hiera example:
```
nfsserver:
  settings:
    exports:
      - share:     '/storage/folder1'
        options:   '192.168.10.0/255.255.254.0(rw,no_root_squash,no_subtree_check,crossmnt)'
      - share:     '/storage/folder2'
        options:   '192.168.10.0/255.255.254.0(rw,no_root_squash,no_subtree_check,crossmnt)'
```
