{ ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = ''
			set -g @plugin 'tmux-plugins/tmux-cpu'
			set-option -g set-clipboard on
			# VIM mode
			setw -g mode-keys vi

			# Move between panes with vi keys
			bind h select-pane -L
			bind j select-pane -D
			bind k select-pane -U
			bind l select-pane -R

			# Enter copy-mode with vi-style key
			bind-key [ copy-mode

			# In copy-mode, use v to begin selection, y to copy
			bind-key -T copy-mode-vi v send -X begin-selection
			bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -selection clipboard -in"

			unbind C-b
			set -g  prefix C-a
			set -g mouse on

			### Status bar ###
			set -g default-terminal "tmux-256color"

			# Fix titlebar
			set -g set-titles on
			set -g set-titles-string "#T"

			# default statusbar colors
			# but a shade darker to show remote
			set-option -g status-style "fg=#bdae93,bg=#1c1816"

			# default window title colors
			set-window-option -g window-status-style "fg=#bdae93,bg=default"

			# active window title colors
			set-window-option -g window-status-current-style "fg=#fabd2f,bg=default"

			# pane border
			set-option -g pane-border-style "fg=#3c3836"
			set-option -g pane-active-border-style "fg=#504945"

			# message text
			set-option -g message-style "fg=#d5c4a1,bg=#3c3836"

			# pane number display
			set-option -g display-panes-active-colour "#b8bb26"
			set-option -g display-panes-colour "#fabd2f"

			# clock
			set-window-option -g clock-mode-colour "#b8bb26"

			# copy mode highligh
			set-window-option -g mode-style "fg=#bdae93,bg=#504945"

			# bell
			set-window-option -g window-status-bell-style "fg=#3c3836,bg=#fb4934"
    '';
  };
}
