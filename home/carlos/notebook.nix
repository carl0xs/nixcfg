{ pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
    ./i3status-rs.nix
    ./i3.nix
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

    rustup
    gnumake
    docker
    docker-compose
    beekeeper-studio
    usql
    gcc
    jq
    ripgrep
    fzf
    curl
    rsync
    mongodb-compass
    bat
    luarocks
    zoxide
    tmux
    pcmanfm
    lazygit
    xorg.xrandr

    google-chrome
    discord
    postman
    libreoffice
    maim
    flameshot
    xclip
    feh
    picom
    pavucontrol
    shared-mime-info
    direnv
  ];
}
