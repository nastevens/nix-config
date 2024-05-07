{ inputs, outputs, config, pkgs, pkgs-unstable, ... }: {
  imports = [
    ./1password.nix
    ./configuration.nix
    ./network.nix
    ./nfs.nix
    ./virtualisation.nix
    ../common
  ];
  hardware.opengl.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs outputs pkgs-unstable;
      nixosConfig = config;
    };
    users.nick = import ../../users/nick;
  };

  nixpkgs = {
    overlays = with outputs.overlays; [ additions modifications ];
    config.allowUnfree = true;
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.nick.enableGnomeKeyring = true;

  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "nick" ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
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

  environment.etc."greetd/environments".text = ''
    hyprland
  '';

  environment.etc."moon_landing.jpg".source = ./moon_landing.jpg;


  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser ];
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    pkgs-unstable.hypridle
    pkgs-unstable.hyprpaper
    btrfs-progs
    diskonaut
    wireguard-tools
  ];

  programs.hyprland = {
    enable = true;
  };
}
