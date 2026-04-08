cp /etc/nixos/hardware-configuration.nix hosts/laptop/
cp niri/config.kdl ~/.config/niri/ 

sudo nixos-rebuild switch --impure --flake .#laptop
