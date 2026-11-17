cp /etc/nixos/hardware-configuration.nix hosts/(echo $hostname)/
sudo nixos-rebuild switch --impure --flake .#(echo $hostname)
