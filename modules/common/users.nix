{ config, pkgs, ... }:

{
  users.users.carlos = {
    isNormalUser = true;
    description = "carlos";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
}
