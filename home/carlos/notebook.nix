{ pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./i3.nix
    ./kitty.nix
    ./nvim.nix
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
