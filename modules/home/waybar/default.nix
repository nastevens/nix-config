{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "graphical-session.target" ];
    };
    style = ./style.css;
    settings.default = {
      # --- Config ---
      layer = "top";
      position = "right";
      exclusive = false;
      spacing = 10;

      # --- Layout ---
      modules-left = [ ];
      modules-center = [ ];
      modules-right = [
        "mpris"
        "tray"
        "network"
        "pulseaudio"
        "clock"
      ];

      # --- Modules ---
      clock = {
        format = "{:%H:%M}";
        interval = 1;
        tooltip = true;
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          format = {
            months = "<span color='#98c379'><b>{}</b></span>";
            days = "<span color='#abb2bf'><b>{}</b></span>";
            weeks = "<span color='#61afef'><b>W{}</b></span>";
            weekdays = "<span color='#e5c07b'><b>{}</b></span>";
            today = "<span color='#e06c75'><b>{}</b></span>";
          };
        };
        actions = {
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };

      };

      mpris = {
        format = "{status_icon}";
        format-paused = "{status_icon}";
        format-tooltip = "{dynamic}";
        status-icons = {
          default = "▶";
          paused = "⏸";
        };
      };

      network = {
        format-disconnected = "󰌙";
        format-ethernet = "󰌘";
        format-linked = "󰖪";
        format-wifi = "󰖩";
        interval = 1;
        tooltip = false;
      };

      pulseaudio = {
        format = " {volume}%";
        format-icons = {
          default = [
            ""
            ""
            ""
          ];
        };
        format-muted = "󰖁";
        on-click = "pamixer -t";
        scroll-step = 2;
        tooltip = true;
        tooltip-format = "{volume}%";
      };

      tray = {
        icon-size = 15;
        spacing = 5;
      };
    };
  };
}
