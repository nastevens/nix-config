{ inputs, outputs, config, pkgs, pkgs-unstable, ... }: {
  imports = [
    ./configuration.nix
    #./nvidia.nix
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

  networking.hostName = "bakugo";
  #system = "x86_64-linux";
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
  #networking.nameservers = [ "192.168.2.4#pi.hole" ];
  #services.resolved = {
  #  enable = true;
  #  dnssec = "true";
  #  domains = [ "~." ];
  #  fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  #};

  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser ];
  };

  # Trying to fix mDNS issues with printer, octopi, etc
  # https://github.com/NixOS/nixpkgs/issues/98050#issuecomment-1471678276
  services.avahi.enable = true;
  services.resolved.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.connectionConfig."connection.mdns" = 2;

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
    package = pkgs-unstable.hyprland;
  };

  # programs.hyprlock = {
  #   enable = true;
  #   grace = 10;
  # };
}
