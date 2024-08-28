{ pkgs, ... }: {
  imports = [ ./eza.nix ./zoxide.nix ];
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    sessionVariables = {
      LC_ALL = "en_US.utf8";
      ZSH_AUTOSUGGEST_USE_ASYNC = "true";
    };
    history = {
      extended = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      save = 100000;
      size = 100000;
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
      autoload -U up-line-or-beginning-search
      autoload -U down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
      bindkey "$terminfo[kcud1]" down-line-or-beginning-search 

      # compinstall completion configuration
      zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
      zstyle ':completion:*' matcher-list "" 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=* l:|=*'
      zstyle ':completion:*' verbose true

      # ctrl-w will delete one path component per press
      backward-delete-word-custom() {
        local WORDCHARS=''$(echo ''$WORDCHARS | tr -d '/#')
        zle backward-delete-word
      }
      zle -N backward-delete-word-custom
      bindkey '^W' backward-delete-word-custom
    '';
    envExtra = ''
      # Causing problems with Nix man pages
      #export MANPAGER="sh -c 'bat --plain --language=man'"

      function help() {
          "$@" --help 2>&1 | bat --plain --language=help
      }

      function take() {
          mkdir -p "$1" && cd "$1"
      }
    '';
    shellAliases = import ./aliases.nix;
  };
}
