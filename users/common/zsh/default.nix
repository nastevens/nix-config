{ pkgs, ... }: {
  imports = [ ./eza.nix ./zoxide.nix ];
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    sessionVariables = {
      LC_ALL = "en_US.utf8";
      ZSH_AUTOSUGGEST_USE_ASYNC = "true";
    };
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
    };
    plugins = [
      {
        name = "you-should-use";
        src = pkgs.zsh-you-should-use;
        file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
      }
      {
        name = "git-prompt.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "woefe";
          repo = "git-prompt.zsh";
          rev = "v2.4.0";
          hash = "sha256-Q7Dp6Xgt5gvkWZL+htDmGYk9RTglOWrrbl6Wf6q/qjY=";
        };
        file = "git-prompt.zsh";
      }
      {
        name = "nick-zsh-theme";
        src =
          pkgs.writeTextDir "nick.zsh-theme" (builtins.readFile ./theme.zsh);
        file = "nick.zsh-theme";
      }
    ];
    initExtra = ''
      # emacs key mode 
      bindkey -e

      # autocompletion using arrow keys, based on history
      bindkey '^[OA' history-search-backward
      bindkey '^[OB' history-search-forward

      # ctrl-w will delete one path component per press
      my-backward-delete-word() {
        local WORDCHARS=''${WORDCHARS/\//}
        zle backward-delete-word
      }
      zle -N my-backward-delete-word
      bindkey '^W' my-backward-delete-word
    '';
    envExtra = ''
      # Causing problems with Nix man pages
      #export MANPAGER="sh -c 'bat --plain --language=man'"

      function help() {
          "$@" --help 2>&1 | bathelp
      }
    '';
    shellAliases = import ./aliases.nix;
  };
}
