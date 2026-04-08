{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
      autoLogin.enable = false;
      defaultSession = "none+i3";
    };
    desktopManager = {
      xterm.enable = false;
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3;
    };
  };

  programs.dconf.enable = true;

  users.users.carlos.extraGroups = [
    "video"
    "audio"
    "networkmanager"
  ];
}
