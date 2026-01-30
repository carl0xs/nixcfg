{ config, pkgs, ... }:

{
  systemd.services.phoenix-blog = {
    description = "Phoenix Blog (carl0xs.dev)";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "carlos";
      WorkingDirectory = "/home/carlos/www/apps/blog";
      ExecStart = "/home/carlos/www/apps/blog/bin/blog start";
      Restart = "always";
      RestartSec = 2;
      Environment = [
        "PHX_SERVER=true"
        "PHX_HOST=carl0xs.dev"
        "PORT=4000"
      ];
      EnvironmentFile = "-/home/carlos/www/apps/blog/.env";
    };
  };
}
