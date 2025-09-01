# How the config works

`configuration.nix` looks at /etc/hostname, takes the hostname, and the corresponding config in hosts. this will write machine specific opts, like ip and hostname.

To use, set the hostname with hostnamectl, and write vm specific opts within the $HOSTNAME.nix file
