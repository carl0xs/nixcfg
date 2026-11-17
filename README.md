# NixOS Configuration

## What is NixOS?

NixOS is a declarative Linux distribution where all system configurations are defined in files using the Nix language. The core principle is to have a completely reproducible environment: **if a package works on one machine, it will also work on another.**

## Hosts: 

#### cavetroll (workstation)
```bash
sudo nixos-rebuild switch --impure --flake .#cavetroll
```

#### onering (homeserver)
```bash
sudo nixos-rebuild switch --impure --flake .#onering
```
