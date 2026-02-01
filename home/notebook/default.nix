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

    rustup
    nodePackages.pnpm
    nodePackages.typescript-language-server
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
    elixir
    zoxide
    tmux
    devbox
    pcmanfm
    lazygit
    lua-language-server
    xorg.xrandr
    i3status
    i3blocks
    i3status-rust
    rofi
    rofi-power-menu
    i3-resurrect
    xss-lock
    i3lock
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
    picom
    pavucontrol
    shared-mime-info
    direnv
  ];
}
