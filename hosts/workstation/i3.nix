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
      config = {
        modifier = "Mod4";
        terminal = "kitty";
        fonts = {
          names = [ "monospace" ];
          size = 8.0;
        };

        startup = [
        { command = "feh --bg-fill ~/.dotfiles/wallpaper/forest-foggy-misty-cloudy.png"; always = true; notification = false; }
        { command = "i3-resurrect restore"; always = true; notification = false; }
        { command = "xss-lock --transfer-sleep-lock -- i3lock --nofork"; always = false; notification = false; }
        { command = "nm-applet"; always = false; notification = false; }
        ];

        keybindings = {
          "${modifier}+Return" = "exec kitty";
          "${modifier}+Shift+q" = "kill";

          "${modifier}+d" = ''exec "rofi -modi drun,run -show drun"'';
          "${modifier}+p" = "exec --no-startup-id bash ~/.config/rofi/scripts/repos-rofi.sh";
          "${modifier}+t" = "exec --no-startup-id bash ~/.config/rofi/scripts/tmux-rofi.sh";
          "${modifier}+g" = "exec --no-startup-id bash ~/.config/rofi/scripts/github-rofi.sh";

          "${modifier}+j" = "focus left";
          "${modifier}+k" = "focus down";
          "${modifier}+l" = "focus up";
          "${modifier}+semicolon" = "focus right";

          "${modifier}+Shift+j" = "move left";
          "${modifier}+Shift+k" = "move down";
          "${modifier}+Shift+l" = "move up";
          "${modifier}+Shift+semicolon" = "move right";

          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          "${modifier}+h" = "split h";
          "${modifier}+v" = "split v";

          "${modifier}+f" = "fullscreen toggle";

          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";

          package = pkgs.i3;

          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";

          "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioMute"        = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";

          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";

          "${modifier}+Shift+e" =
            ''exec "i3-nagbar -t warning -m 'Exit i3?' -B 'Yes' 'i3-msg exit'"'';
        };

        modes.resize = {
          j = "resize shrink width 10 px or 10 ppt";
          k = "resize grow height 10 px or 10 ppt";
          l = "resize shrink height 10 px or 10 ppt";
          semicolon = "resize grow width 10 px or 10 ppt";
          Return = "mode default";
          Escape = "mode default";
        };

        floating.modifier = "Mod4";

        assigns = {
          "2" = [ { class = "(?i)brave"; } ];
        };

        bars = [
        {
          statusCommand = "i3status";
          fonts.names = [ "monospace" ];
        }
        ];

      };
    };
  };

  programs.dconf.enable = true;

  users.users.carlos.extraGroups = [
    "video"
      "audio"
      "networkmanager"
  ];
}
