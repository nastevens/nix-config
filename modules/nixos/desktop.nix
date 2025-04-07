{ flake, pkgs, ... }:

let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
    ./1password.nix
    ./sound.nix
    ./steam.nix
    ./virt.nix
    ({ ... }: {
      home-manager.users.${config.me.username} = {
        imports = [
          self.homeModules.desktop
        ];
      };
    })
  ];

  fonts.packages = with pkgs; [
    dejavu_fonts
    nerd-fonts.mononoki
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    vistafonts
  ];

  security.polkit.enable = true;
  security.pam.services.${config.me.username}.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [
    bandwhich # Needs sudo, make available system-wide
    glxinfo
    hypridle
    hyprpaper
    polkit_gnome
    v4l-utils
    xdg-utils
  ];

  # Hyprland has `exec-once`, but then we need to pipe in the path to the
  # authentication agent. It's easier to move up to OS level and let systemd
  # take care of it.
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  services = {
    devmon.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };
    udisks2.enable = true;
  };

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

  programs.hyprland = {
    enable = true;
  };

  programs.dconf.enable = true;

  programs.thunar.enable = true;

  # Thumbnail generation
  services.tumbler.enable = true;

  environment.etc."greetd/environments".text = ''
    hyprland
  '';

  # Caching used for hyprland upstream
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
}
