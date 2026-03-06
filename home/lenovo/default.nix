{ pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
    ./hyprland.nix
    ./kitty.nix
    ./nvim.nix
    ./rofi.nix
    ./tmux.nix
    ./walker.nix
    ./waybar.nix
  ];

  home.username = "carlos";
  home.homeDirectory = "/home/carlos";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Dev tools
    tree
    gnumake
    gcc
    jq
    ripgrep
    fzf
    curl
    rsync
    bat
    lazygit
    direnv

    # Containers
    docker
    docker-compose

    # DB tools
    beekeeper-studio
    mongodb-compass
    usql

    # Desktop apps
    google-chrome
    discord
    postman
    libreoffice

    # Wayland utilities
    grim
    slurp
    wl-clipboard
    swaybg
    pavucontrol
    brightnessctl

    # File manager
    pcmanfm
    shared-mime-info

    # System
    zoxide
    btop
    fastfetch
  ];
}
