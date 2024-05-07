{ config, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader = {
    #efi = {
    #  efiSysMountPoint = "/boot/efi";
    #  canTouchEfiVariables = true;
    #};
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    timeout = 10;
  };

  #fileSystems = {
  #  "/boot/efi" = {
  #    device = "/dev/disk/by-uuid/0255-F0D5";
  #    fsType = "vfat";
  #  };
  #};
  networking.hostName = "bakugo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  #  services.xserver = {
  #    enable = true;
  #    layout = "us";
  #    xkbVariant = "";
  #    displayManager = {
  #      sddm.enable = true;
  #      defaultSession = "none+awesome";
  #    };
  #
  #    windowManager.awesome = {
  #      enable = true;
  #    };
  #  };

  #  programs.sway.enable = true;
  security.polkit.enable = true;

  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nick = {
    isNormalUser = true;
    description = "Nick Stevens";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAKxVfeh+zYTcMfUbzTHaFyqorD0ODcdKehTJpUH5eQr bakugo-20210502"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP7U1kF0BA+5OOe8Xw2E9aEK+UVfxloLjRLQhh69uKsf lain-20210502"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAQhKRLdPbO7wXpUKkskEoeZMxjcv3STbTU5RARaSBsA notnotlinux-20240206"
    ];
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    git
    vim
    wget
    pciutils
    pavucontrol
    glxinfo
    xdg-utils
    # Needs sudo, make available system-wide
    bandwhich
    killall
  ];
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Mononoki" ]; })
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
