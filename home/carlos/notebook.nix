{ pkgs, ... }:

{
  imports = [
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

    google-chrome
    kitty
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
