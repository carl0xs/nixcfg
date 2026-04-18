{ pkgs, ... }:

{
  home.packages = with pkgs; [
    walker
    libqalculate
  ];

  systemd.user.services.walker = {
    Unit = {
      Description = "Walker application launcher (GApplication service)";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.walker}/bin/walker --gapplication-service";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services.elephant = {
    Unit = {
      Description = "Elephant clipboard manager";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.elephant}/bin/elephant";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Walker config
  home.file.".config/walker/config.toml".text = ''
    force_keyboard_focus = true
    selection_wrap = true

    [placeholders]
    "default" = { input = " Search...", list = "No Results" }

    [keybinds]
    quick_activate = []

    [columns]
    symbols = 1

    [providers]
    max_results = 256
    default = [
      "desktopapplications",
      "websearch",
    ]

    [[providers.prefixes]]
    prefix = "/"
    provider = "providerlist"

    [[providers.prefixes]]
    prefix = "."
    provider = "files"

    [[providers.prefixes]]
    prefix = ":"
    provider = "symbols"

    [[providers.prefixes]]
    prefix = "="
    provider = "calc"

    [[providers.prefixes]]
    prefix = "@"
    provider = "websearch"

    [[providers.prefixes]]
    prefix = "$"
    provider = "clipboard"
  '';

  # Script simplificado para lançar o walker
  home.file.".local/bin/launch-walker" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Start walker service if not running
      if ! pgrep -f "walker --gapplication-service" >/dev/null; then
        setsid walker --gapplication-service &
        sleep 0.3
      fi

      exec walker "$@"
    '';
  };
}
