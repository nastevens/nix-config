{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # multimedia
    loupe
    mate.atril
    maestral
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
    calibre
    deluge
    freeplane
    gnucash
    hunspell
    hunspellDicts.en_US
    libreoffice-qt
    mate.caja
    wally-cli
    xarchiver
    zoom-us

    # creative
    gimp
    inkscape
    pinta
    prusa-slicer

    # global dev tools (per-language tools use local flakes)
    hotspot
  ];

  services.gnome-keyring.enable = true;

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      addKeysToAgent = "no";
      compression = false;
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
      forwardAgent = false;
      hashKnownHosts = false;
      identityAgent = "~/.1password/agent.sock";
      serverAliveCountMax = 3;
      serverAliveInterval = 60;
      userKnownHostsFile = "~/.ssh/known_hosts";
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
