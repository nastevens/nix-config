{ outputs, pkgs, ... }: {
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
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  home.packages = with pkgs; [
    neovim

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep
    jq
    file
    which
    gnused
    gnutar
    gawk
    zstd
    gnupg
    neofetch
    maestral
    fd
    bat
    gping
    mdcat
    hexyl
    viu
    bc
    gping
    just
    tokei
    htop
    termdown
    mmv

    # multimedia
    pithos
    pianobar
    mate.atril

    # chat
    (discord.override { nss = nss_latest; })
    telegram-desktop
    element-desktop
    signal-desktop
    slack
    zulip

    # gaming
    prismlauncher

    # other
    anki-bin
    gnucash
    prusa-slicer
    inkscape
    mate.caja
    amdgpu_top
    deluge
    cargo-information
    freeplane
    zoom-us
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
