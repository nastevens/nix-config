{ flake, pkgs, ... }:

let
  me = flake.config.me;
in
{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Mononoki" ]; })
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    vistafonts
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd Hyprland
      '';
    };
  };

  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  security.pam.services.${me.username}.enableGnomeKeyring = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    bandwhich # Needs sudo, make available system-wide
    glxinfo
    pavucontrol
    xdg-utils
    hypridle
    hyprpaper
    v4l-utils
  ];

  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser ];
  };

  programs.hyprland = {
    enable = true;
  };

  programs.dconf.enable = true;

  environment.etc."greetd/environments".text = ''
    hyprland
  '';

  # Caching used for hyprland upstream
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
}
