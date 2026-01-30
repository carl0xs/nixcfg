{ config, pkgs, ... }:

{
  services.nginx.enable = true;
  services.nginx.recommendedGzipSettings = true;
  services.nginx.recommendedProxySettings = true;

  services.nginx.virtualHosts."carl0xs.dev" = {
    listen = [
      { addr = "127.0.0.1"; port = 8080; }
    ];

    locations."/" = {
      proxyPass = "http://127.0.0.1:4000";
      proxyWebsockets = true;
    };
  };

  services.nginx.virtualHosts."www.carl0xs.dev" = {
    listen = [
      { addr = "127.0.0.1"; port = 8080; }
    ];
    extraConfig = "return 301 https://carl0xs.dev$request_uri;";
  };
}
