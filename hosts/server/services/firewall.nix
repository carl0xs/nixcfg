{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [
    53   # Pi-hole DNS
    80   # Pi-hole admin web interface
  ];

  networking.firewall.allowedUDPPorts = [
    53   # Pi-hole DNS
  ];
}
