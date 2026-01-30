{ config, pkgs, ... }:

let
  tunnelId = "CHANGE-ME";
  credentialsFile = "/var/lib/cloudflared/${tunnelId}.json";
in
{
  services.cloudflared = {
    enable = true;
    tunnels."${tunnelId}" = {
      credentialsFile = credentialsFile;
      ingress = {
        "carl0xs.dev" = "http://127.0.0.1:8080";
        "www.carl0xs.dev" = "http://127.0.0.1:8080";
      };
      default = "http_status:404";
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/cloudflared 0750 cloudflared cloudflared -"
  ];
}
