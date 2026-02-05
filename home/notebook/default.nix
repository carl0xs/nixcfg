{ pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
    ./i3.nix
    ./i3status-rs.nix
    ./kitty.nix
    ./nvim.nix
    ./rofi.nix
    ./tmux.nix
  ];

  home.username = "carlos";
  home.homeDirectory = "/home/carlos";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    tree
    gnumake
    gcc

    docker
    docker-compose

    beekeeper-studio
    mongodb-compass
    usql


    jq
    ripgrep
    fzf
    curl
    rsync
    bat
    lazygit

    zoxide
    pcmanfm
    xorg.xrandr
    xss-lock
    networkmanagerapplet
    alsa-utils

    google-chrome
    discord
    postman
    libreoffice
    maim
    flameshot
    xclip
    feh
    pavucontrol
    shared-mime-info
    direnv

		btop
		fastfetch
  ];
}
