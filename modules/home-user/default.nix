{ pkgs, lib, ... }:

{
  home.username = "carlos";
  home.homeDirectory = "/home/carlos";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
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
    docker
    docker-compose
    beekeeper-studio
    usql
    google-chrome
    discord
    libreoffice
    grim
    slurp
    wl-clipboard
    swaybg
    pavucontrol
    brightnessctl
    pcmanfm
    shared-mime-info
    zoxide
    htop
    fastfetch
    bash-language-server
    fuzzel
  ];
}
