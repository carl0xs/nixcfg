# nixcfg

NixOS configuration files for my personal machines.

## What is NixOS?

NixOS is a declarative Linux distribution where all system configurations are defined in files using the Nix language. The core principle is to have a completely reproducible environment: **if a package works on one machine, it will also work on another.**

## Motivation

I used Linux (Manjaro and Ubuntu, switching between them) for 4 years. While it worked well, setting up a new machine always required some effort to configure toolchains and development environments. Dependencies would sometimes cause issues, and I never took the time to create proper installation scripts to automate my setup.

You can see my old configuration at [github.com/carl0xs/dotfiles](https://github.com/carl0xs/dotfiles).

With NixOS, I'm consolidating all my configurations in one place:
- My personal notebook
- My home server
- Future machines (including potential macOS setup using Nix)

This approach ensures all my toolchains are portable and reproducible across any system.

## Usage

### Notebook
```bash
sudo nixos-rebuild switch --impure --flake .#notebook
```

### Home Server
```bash
sudo nixos-rebuild switch --impure --flake .#homeserver
```

## TODO

- [ ] Add macOS configuration using nix-darwin
- [ ] Document common modules
- [ ] Add more host configurations
