{ pkgs, inputs, ... }:

{
  programs.nixvim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    viAlias = true;
    vimAlias = true;

    extraConfigLua = builtins.readFile ./init.lua;
  };

  home.packages = with pkgs; [
    stdenv.cc
  ];
}
