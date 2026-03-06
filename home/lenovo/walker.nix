{ pkgs, ... }:

let
  gruvbox = {
    accent = "#7daea3";
    foreground = "#d4be98";
    background = "#282828";
    border = "#d4be98";
  };
in
{
  home.packages = with pkgs; [
    walker
    libqalculate
  ];

  # Walker config
  home.file.".config/walker/config.toml".text = ''
    force_keyboard_focus = true
    selection_wrap = true
    theme = "gruvbox"

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

  # Walker theme - layout
  home.file.".config/walker/themes/gruvbox/layout.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <interface>
      <requires lib="gtk" version="4.0"></requires>
      <object class="GtkWindow" id="Window">
        <style>
          <class name="window"></class>
        </style>
        <property name="resizable">true</property>
        <property name="title">Walker</property>
        <child>
          <object class="GtkBox" id="BoxWrapper">
            <style>
              <class name="box-wrapper"></class>
            </style>
            <property name="width-request">644</property>
            <property name="overflow">hidden</property>
            <property name="orientation">horizontal</property>
            <property name="valign">center</property>
            <property name="halign">center</property>
            <child>
              <object class="GtkBox" id="Box">
                <style>
                  <class name="box"></class>
                </style>
                <property name="orientation">vertical</property>
                <property name="hexpand-set">true</property>
                <property name="hexpand">true</property>
                <property name="spacing">10</property>
                <child>
                  <object class="GtkBox" id="SearchContainer">
                    <style>
                      <class name="search-container"></class>
                    </style>
                    <property name="overflow">hidden</property>
                    <property name="orientation">horizontal</property>
                    <property name="halign">fill</property>
                    <property name="hexpand-set">true</property>
                    <property name="hexpand">true</property>
                    <child>
                      <object class="GtkEntry" id="Input">
                        <style>
                          <class name="input"></class>
                        </style>
                        <property name="halign">fill</property>
                        <property name="hexpand-set">true</property>
                        <property name="hexpand">true</property>
                      </object>
                    </child>
                  </object>
                </child>
                <child>
                  <object class="GtkBox" id="ContentContainer">
                    <style>
                      <class name="content-container"></class>
                    </style>
                    <property name="orientation">horizontal</property>
                    <property name="spacing">10</property>
                    <property name="vexpand">true</property>
                    <property name="vexpand-set">true</property>
                    <child>
                      <object class="GtkLabel" id="Placeholder">
                        <style>
                          <class name="placeholder"></class>
                        </style>
                        <property name="label">No Results</property>
                        <property name="yalign">0.0</property>
                        <property name="hexpand">true</property>
                      </object>
                    </child>
                    <child>
                      <object class="GtkScrolledWindow" id="Scroll">
                        <style>
                          <class name="scroll"></class>
                        </style>
                        <property name="hexpand">true</property>
                        <property name="can_focus">false</property>
                        <property name="overlay-scrolling">true</property>
                        <property name="max-content-width">600</property>
                        <property name="max-content-height">300</property>
                        <property name="min-content-height">0</property>
                        <property name="propagate-natural-height">true</property>
                        <property name="propagate-natural-width">true</property>
                        <property name="hscrollbar-policy">automatic</property>
                        <property name="vscrollbar-policy">automatic</property>
                        <child>
                          <object class="GtkGridView" id="List">
                            <style>
                              <class name="list"></class>
                            </style>
                            <property name="max_columns">1</property>
                            <property name="can_focus">false</property>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkBox" id="Preview">
                        <style>
                          <class name="preview"></class>
                        </style>
                      </object>
                    </child>
                  </object>
                </child>
                <child>
                  <object class="GtkLabel" id="Error">
                    <style>
                      <class name="error"></class>
                    </style>
                    <property name="xalign">0</property>
                    <property name="visible">false</property>
                  </object>
                </child>
              </object>
            </child>
          </object>
        </child>
      </object>
    </interface>
  '';

  # Walker theme - style
  home.file.".config/walker/themes/gruvbox/style.css".text = ''
    * {
      all: unset;
    }

    * {
      font-family: 'JetBrainsMono Nerd Font', monospace;
      font-size: 18px;
      color: ${gruvbox.foreground};
    }

    scrollbar {
      opacity: 0;
    }

    .normal-icons {
      -gtk-icon-size: 16px;
    }

    .large-icons {
      -gtk-icon-size: 32px;
    }

    .box-wrapper {
      background: alpha(${gruvbox.background}, 0.95);
      padding: 20px;
      border: 2px solid ${gruvbox.border};
    }

    .search-container {
      background: ${gruvbox.background};
      padding: 10px;
    }

    .input placeholder {
      opacity: 0.5;
    }

    .input:focus,
    .input:active {
      box-shadow: none;
      outline: none;
    }

    child:selected .item-box * {
      color: ${gruvbox.accent};
    }

    .item-box {
      padding-left: 14px;
    }

    .item-text-box {
      all: unset;
      padding: 14px 0;
    }

    .item-subtext {
      font-size: 0px;
      min-height: 0px;
      margin: 0px;
      padding: 0px;
    }

    .item-image {
      margin-right: 14px;
      -gtk-icon-transform: scale(0.9);
    }

    .current {
      font-style: italic;
    }

    .keybind-hints {
      background: ${gruvbox.background};
      padding: 10px;
      margin-top: 10px;
    }
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
