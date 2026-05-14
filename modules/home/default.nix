{ config, pkgs, inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; pkgs = pkgs; };
    backupFileExtension = "hm-bak";
    sharedModules = [
      inputs.niri.homeModules.niri
      inputs.nixvim.homeModules.nixvim
      ../fish/default.nix
      ../git/default.nix
      ../kitty/default.nix
      ../nvim/default.nix
      ../rofi/default.nix
      ../tmux/default.nix
      ../walker/default.nix
      ../waybar/default.nix
    ];
    users.carlos = import ../home-user/default.nix;
  };
}
