{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    terminal = "tmux-256color";
    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
    ];
    extraConfig = ''
            			set-option -g set-clipboard on

            			# Move between panes with vi keys
            			bind h select-pane -L
            			bind j select-pane -D
            			bind k select-pane -U
            			bind l select-pane -R

      						# Resize panes
      						bind -r H resize-pane -L 5
      						bind -r J resize-pane -D 5
      						bind -r K resize-pane -U 5
      						bind -r L resize-pane -R 5

            			# Enter copy-mode with vi-style key
            			bind-key [ copy-mode

            			# In copy-mode, use v to begin selection, y to copy
            			bind-key -T copy-mode-vi v send -X begin-selection
            			bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -selection clipboard -in"

            			### Status bar ###
            			# Fix titlebar
            			set -g set-titles on
            			set -g set-titles-string "#T"

            			# default statusbar colors
            			# but a shade darker to show remote
            			set-option -g status-style "fg=#e4e4ef,bg=#282828"

            			# default window title colors
            			set-window-option -g window-status-style "fg=#5f627f,bg=default"

            			# active window title colors
            			set-window-option -g window-status-current-style "fg=#ffdd33,bg=default,bold"

            			# pane border
            			set-option -g pane-border-style "fg=#52494e"
            			set-option -g pane-active-border-style "fg=#96a6c8"

            			# message text
            			set-option -g message-style "fg=#e4e4ef,bg=#453d41"

            			# pane number display
            			set-option -g display-panes-active-colour "#73c936"
            			set-option -g display-panes-colour "#ffdd33"

            			# clock
            			set-window-option -g clock-mode-colour "#73c936"

            			# copy mode highligh
            			set-window-option -g mode-style "fg=#e4e4ef,bg=#52494e"

            			# bell
            			set-window-option -g window-status-bell-style "fg=#181818,bg=#f43841"

                  set -g automatic-rename on
                  set -g automatic-rename-format '#{b:pane_current_path}'
    '';
  };
}
