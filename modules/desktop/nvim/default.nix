{ pkgs, inputs, ... }:

{
  # PureVim (github:carl0xs/purevim) as the nvim config, pinned in flake.lock.
  # Update with: nix flake update purevim
  xdg.configFile."nvim" = {
    source = inputs.purevim;
    recursive = true;
  };
  xdg.configFile."nvim/early_init.lua".source = ./early_init.lua;

  home.sessionVariables.EDITOR = "nvim";

  home.packages = with pkgs; [
    inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default
    stdenv.cc

    # LSPs and formatters used by purevim
    lua-language-server
    rust-analyzer
    typescript-language-server
    stylua
  ];
}
