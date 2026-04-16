{ config, pkgs, ... }:

{
  users.users.carlos = {
    isNormalUser = true;
    description = "carlos";
    shell = pkgs.fish;
    home = "/home/carlos";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
}
