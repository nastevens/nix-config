{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dunst
    wl-clipboard
    shotman
    waybar
    bibata-cursors
    openzone-cursors
    mate.caja
    pamixer
    playerctl
    xdg-desktop-portal-hyprland
    eww
  ];

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
    settings = {
      preload = [ "/etc/moon_landing.jpg" ];
      wallpaper = [ ",/etc/moon_landing.jpg" ];
      splash = false;
    };
  };
}
