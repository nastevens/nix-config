{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # multimedia
    atril
    loupe
    mpv
    pithos

    # chat
    (discord.override { nss = nss_latest; })
    element-desktop
    signal-desktop
    slack
    telegram-desktop

    # gaming
    prismlauncher

    # other
    amdgpu_top
    anki-bin
    calibre
    deluge
    freeplane
    gnucash
    hunspell
    hunspellDicts.en_US
    libreoffice-qt
    wally-cli
    xarchiver
    zoom-us

    # creative
    gimp
    inkscape
    pinta

    # global dev tools (per-language tools use local flakes)
    hotspot
  ];

  services.gnome-keyring.enable = true;

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        "AddKeysToAgent" = false;
        "Compression" = false;
        "ControlMaster" = false;
        "ControlPath" = "~/.ssh/master-%r@%n:%p";
        "ControlPersist" = false;
        "ForwardAgent" = false;
        "HashKnownHosts" = false;
        "IdentityAgent" = "~/.1password/agent.sock";
        "ServerAliveCountMax" = 3;
        "ServerAliveInterval" = 60;
        "UserKnownHostsFile" = "~/.ssh/known_hosts";
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
