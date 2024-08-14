{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./dunst.nix
    ./tealdeer.nix
    ./firefox.nix
    ./git
    ./hypr
    ./rofi
    ./tmux
    ./waybar
    ./zsh
  ];

  home.packages = with pkgs; [
    # CLI utils
    bat
    bc
    fd
    file
    gawk
    gnupg
    gnused
    gnutar
    gping
    hexyl
    htop
    jq
    just
    maestral
    mdcat
    mmv
    neofetch
    p7zip
    ripgrep
    termdown
    unzip
    viu
    which
    xz
    zip
    zstd

    # multimedia
    loupe
    mate.atril
    mpv
    pithos

    # chat
    (discord.override { nss = nss_latest; })
    element-desktop
    signal-desktop
    slack
    telegram-desktop
    zulip

    # gaming
    prismlauncher

    # other
    amdgpu_top
    anki-bin
    cargo-information
    deluge
    freeplane
    gnucash
    hunspell
    hunspellDicts.en_US
    libreoffice-qt
    mate.caja
    wally-cli
    zoom-us

    # creative
    gimp
    inkscape
    pinta
    prusa-slicer

    # global dev tools (per-language tools use local flakes)
    gibo
    hotspot
    tokei
  ];

  services.gnome-keyring.enable = true;

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    serverAliveInterval = 60;
    matchBlocks = {
      "*" = {
        extraOptions.IdentityAgent = "~/.1password/agent.sock";
      };
    };
  };

  home.sessionVariables = {
    DROPBOX = "/home/nick/Dropbox";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
