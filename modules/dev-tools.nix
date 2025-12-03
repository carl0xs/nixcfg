{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rustup
      rust-analyzer
      nodejs_22
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
      ruby
      ruby-lsp
      elixir
      ];
}
