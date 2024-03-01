{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    shortcut = "a";
    terminal = "tmux-256color";

    # These options are set by tmux-sensible but then overridden by the nix
    # defaults, which are different.
    # TODO: submit patch to make these match tmux-sensible
    aggressiveResize = true;
    escapeTime = 0;
    historyLimit = 50000;

    plugins = with pkgs; [
      #tmuxPlugins.onedark-theme
      tmuxPlugins.mkTmuxPlugin
      {
        pluginName = "grayspace-theme";
        #version = "unstable-2024-03-25-1";
        src = pkgs.writeTextDir "grayspace_theme.tmux"
          (builtins.readFile ./tmux/theme.tmux);
      }
    ];

    extraConfig = ''
      set -g renumber-windows on
      set -g status-keys emacs
      set -ag terminal-overrides ",xterm-256color:RGB"

      # Don't detach when closing last window of a session
      set -g detach-on-destroy off

      # Set terminal title to reflect current window in tmux session
      set -g set-titles on
      set -g set-titles-string "#I:#W"
    '';
  };
}
