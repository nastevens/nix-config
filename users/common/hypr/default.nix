{ pkgs, inputs, ... }:
{
  imports = [
    inputs.hypridle.homeManagerModules.default
    inputs.hyprpaper.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    dunst
    wl-clipboard
    shotman
    waybar
    bibata-cursors
    mate.caja
    pamixer
    playerctl
    xdg-desktop-portal-hyprland
    eww-wayland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;
    # Could use `settings` instead https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.settings
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  services.hypridle = {
    enable = true;
    listeners = [
      {
        timeout = 600;
        onTimeout = "hyprctl dispatch dpms off";
        onResume = "hyprctl dispatch dpms on";
      }
    ];
  };

  services.hyprpaper = {
    enable = true;
    preloads = [ "/etc/moon_landing.jpg" ];
    wallpapers = [ ",/etc/moon_landing.jpg" ];
    splash = true;
  };
}
