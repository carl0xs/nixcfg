{ config, pkgs, ... }:

{
  systemd.services.blog = {
    description = "Blog Phoenix app";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      Type = "simple";
      User = "carlos";
      Group = "users";

      WorkingDirectory = "/opt/blog";
      ExecStart = "/opt/blog/bin/blog start";

      Restart = "on-failure";
      RestartSec = 10;
      EnvironmentFile = "/etc/secrets/blog.env";
    };
  };
}
