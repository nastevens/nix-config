{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dunst
    eww
    pamixer
    playerctl
    shotman
    waybar
    wl-clipboard
    xdg-desktop-portal-hyprland
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.openzone-cursors;
    name = "OpenZone_Black";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Dark";
    };

    iconTheme = {
      package = pkgs.flat-remix-icon-theme;
      name = "Flat-Remix-Blue-Dark";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    # Could use `settings` instead https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.settings
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  services.hypridle = {
    enable = true;
    settings.listener = [
      {
        timeout = 600;
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }
    ];
  };

  services.hyprpaper = {
    enable = true;
    settings =
      let
        wallpaper = ./milky_way.jpg;
      in
      {
        preload = [ "${wallpaper}" ];
        wallpaper = [ ",${wallpaper}" ];
        splash = false;
      };
  };
}
