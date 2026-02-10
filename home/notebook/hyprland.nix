{ pkgs, ... }:

let
  gruvbox = {
    accent = "7daea3";
    background = "282828";
    foreground = "d4be98";
    inactive = "3c3836";
  };
in
{
  home.packages = with pkgs; [
    mako
    libnotify
    pamixer
    blueman
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      exec-once = [
        "waybar"
        "mako"
        "nm-applet"
        "swaybg -m fill -i ~/.config/hypr/wallpaper.jpg"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
        "col.active_border" = "rgb(${gruvbox.accent})";
        "col.inactive_border" = "rgba(${gruvbox.inactive}aa)";
        resize_on_border = false;
        allow_tearing = false;
      };

      input = {
        kb_layout = "br";
        kb_variant = "thinkpad";
      };

      decoration = {
        rounding = 0;
        shadow = {
          enabled = true;
          range = 2;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 2;
          passes = 2;
          special = true;
          brightness = 0.60;
          contrast = 0.75;
        };
      };

      group = {
        "col.border_active" = "rgb(${gruvbox.accent})";
        "col.border_inactive" = "rgba(${gruvbox.inactive}aa)";
        "col.border_locked_active" = -1;
        "col.border_locked_inactive" = -1;
        groupbar = {
          font_size = 12;
          font_family = "monospace";
          font_weight_active = "ultraheavy";
          font_weight_inactive = "normal";
          indicator_height = 0;
          indicator_gap = 5;
          height = 22;
          gaps_in = 5;
          gaps_out = 0;
          text_color = "rgb(${gruvbox.foreground})";
          text_color_inactive = "rgba(${gruvbox.foreground}90)";
          "col.active" = "rgba(00000040)";
          "col.inactive" = "rgba(00000020)";
          gradients = true;
          gradient_rounding = 0;
          gradient_round_only_edges = false;
        };
      };

      animations = {
        enabled = "yes, please :)";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 0, 0, ease"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };

      master = {
        new_status = "master";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        focus_on_activate = true;
        anr_missed_pings = 3;
        on_focus_under_fullscreen = 1;
      };

      cursor = {
        hide_on_key_press = true;
      };

      binds = {
        hide_special_on_workspace_change = true;
      };

      bind = [
        # Apps
        "$mod, RETURN, exec, kitty"
        "$mod, D, exec, ~/.local/bin/launch-walker"
        "$mod, Q, killactive"

        # Custom rofi scripts
        "$mod, P, exec, ~/.config/rofi/scripts/repos-rofi.sh"
        "$mod, T, exec, ~/.config/rofi/scripts/tmux-rofi.sh"
        "$mod, G, exec, ~/.config/rofi/scripts/github-rofi.sh"

        # Focus
        "$mod, J, movefocus, l"
        "$mod, K, movefocus, d"
        "$mod, L, movefocus, u"
        "$mod, Ccedilla, movefocus, r"

        # Move windows
        "$mod SHIFT, J, movewindow, l"
        "$mod SHIFT, K, movewindow, d"
        "$mod SHIFT, L, movewindow, u"
        "$mod SHIFT, Ccedilla, movewindow, r"

        # Layout
        "$mod, H, layoutmsg, togglesplit"
        "$mod, V, layoutmsg, togglesplit"

        # Window state
        "$mod, F, fullscreen, 0"
        "$mod SHIFT, SPACE, togglefloating"
        "$mod, SPACE, togglefloating"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Session
        "$mod SHIFT, C, exec, hyprctl reload"
        "$mod SHIFT, R, exec, hyprctl reload"
        "$mod SHIFT, E, exec, hyprctl dispatch exit"

        # Resize mode
        "$mod, R, submap, resize"

        # Screenshots
        "SHIFT, Print, exec, grim -g \"$(slurp)\" - | wl-copy -t image/png"
        "CTRL SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy -t image/png"
        ", Print, exec, grim - | wl-copy -t image/png"
      ];

      bindl = [
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioMicMute, exec, pamixer --default-source -t"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };

    extraConfig = ''
      submap = resize

      bind = , j, resizeactive, -10 0
      bind = , k, resizeactive, 0 10
      bind = , l, resizeactive, 0 -10
      bind = , ccedilla, resizeactive, 10 0

      bind = , left, resizeactive, -10 0
      bind = , down, resizeactive, 0 10
      bind = , up, resizeactive, 0 -10
      bind = , right, resizeactive, 10 0

      bind = , return, submap, reset
      bind = , escape, submap, reset
      bind = $mod, r, submap, reset

      submap = reset
    '';
  };

  # Wallpaper
  home.file.".config/hypr/wallpaper.jpg".source = ./assets/wallpaper.jpg;

  # Mako notification daemon config
  home.file.".config/mako/config".text = ''
    anchor=top-right
    default-timeout=5000
    width=420
    outer-margin=20
    padding=10,15
    border-size=2
    max-icon-size=32
    font=JetBrainsMono Nerd Font 12

    text-color=#${gruvbox.foreground}
    border-color=#${gruvbox.accent}
    background-color=#${gruvbox.background}

    [urgency=critical]
    default-timeout=0
  '';
}
