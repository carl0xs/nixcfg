cp /etc/nixos/hardware-configuration.nix hosts/cavetroll/
sudo nixos-rebuild switch --impure --flake .#cavetroll
