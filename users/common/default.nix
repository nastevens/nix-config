{ outputs, pkgs, pkgs-unstable, ... }: {
  imports = [
    ./alacritty.nix
    ./dunst.nix
    ./tealdeer.nix
    ./firefox.nix
    ./git.nix
    ./hypr
    ./rofi
    ./tmux
    ./waybar
    ./zsh
    ./sway.nix
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

    # multimedia
    pithos
    pianobar

    # chat
    (discord.override { nss = nss_latest; })
    telegram-desktop
    element-desktop
    signal-desktop
    slack

    # gaming
    prismlauncher

    # other
    pkgs-unstable.anki-bin
    gnucash
    prusa-slicer
    inkscape
    mate.caja
    mindustry-wayland
    amdgpu_top
    deluge
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
}
