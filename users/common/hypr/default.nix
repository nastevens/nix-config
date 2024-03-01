{ pkgs, pkgs-unstable, inputs, ... }:
{
  imports = [
    inputs.hypridle.homeManagerModules.default
    # inputs.hyprlock.homeManagerModules.default
  ];
  home.packages = with pkgs; [
    dunst
    wl-clipboard
    shotman
    waybar
    swww # Wallpaper
    bibata-cursors
    mate.caja
    pamixer
    playerctl
    xdg-desktop-portal-hyprland
    eww-wayland
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    systemd.enable = true;
    # Could use `settings` instead https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.settings
    extraConfig = builtins.readFile ./hyprland.conf;
  };
  services.hypridle = {
    enable = true;
    #lockCmd = "pidof hyprlock || hyprlock";
    #beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
    #afterSleepCmd = "hyprctl dispatch dpms on";
    listeners = [
      # {
      #   timeout = 600;
      #   onTimeout = "${pkgs.systemd}/bin/loginctl lock-session";
      # }
      {
        timeout = 600;
        onTimeout = "hyprctl dispatch dpms off";
        onResume = "hyprctl dispatch dpms on";
      }
    ];
  };
}
