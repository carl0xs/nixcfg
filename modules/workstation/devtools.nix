{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      neovim
      rustup
      rust-analyzer
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
    ];
}
