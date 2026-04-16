cp /etc/nixos/hardware-configuration.nix hosts/workstation/
cp niri/config.kdl ~/.config/niri/ 

sudo nixos-rebuild switch --impure --flake .#workstation
