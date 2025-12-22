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
    packages = with pkgs; [
      tree
    ];
  };
}
