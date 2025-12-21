{ config, pkgs, ... }:

{
  users.users.carlos = {
    isNormalUser = true;
    description = "carlos";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [
      tree
    ];
  };
}
