{ config, pkgs, ... }:
let
  plugins = pkgs.tmuxPlugins
    // (pkgs.callPackage ./grayspace-plugin.nix { })
    // (pkgs.callPackage ./menus-plugin.nix { inherit (config.xdg) cacheHome; })
    // (pkgs.callPackage ./suspend-plugin.nix { })
    // { inherit (pkgs.tmuxPlugins) session-wizard; };
in
{
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    shortcut = "a";
    terminal = "tmux-256color";
    extraConfig = builtins.readFile ./tmux.conf;

    # These options are set by tmux-sensible but then overridden by the nix
    # defaults, which are different.
    aggressiveResize = true;
    escapeTime = 0;
    historyLimit = 50000;

    plugins = with plugins; [
      grayspace
      menus
      mode-indicator
      suspend
      yank
      session-wizard
    ];
  };
}
