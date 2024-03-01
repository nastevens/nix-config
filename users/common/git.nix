{ pkgs, lib, inputs, ... }: {
  home.packages = with pkgs; [ git-lfs git-utils ];
  # TODO: add GPG signing to commits
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        side-by-side = false;
        line-numbers = true;
        decorations = true;
        plus-style = "syntax #004000";
        plus-emph-style = "syntax #00A000";
      };
    };
    lfs.enable = true;
    userName = "Nick Stevens";
    userEmail = "nick@bitcurry.com";
    extraConfig = {
      color.ui = "auto";
      core = {
        autocrlf = "input";
        eol = "lf";
        editor = "nvim";
        compression = -1;
      };
      init.defaultBranch = "main";
      merge.defaultToUpstream = true;
      pull.ff = "only";
      rebase.autosquash = true;
      url."https://github.com".insteadOf = "git://github.com";
    };
    aliases = {
      authors =
        "shortlog --numbered --summary --format='%an <%ae>' --no-merges";
      ci = "commit";
      co = "checkout";
      cl = "clean -ndx";
      clcl = "clean -fdx";
      d = "diff";
      dc = "diff --cached";
      fap = "fetch --all --prune";
      fapp = "pull --all --prune --ff-only";
      graph =
        "log --graph --decorate --all --oneline --format='%C(green bold)%h%Creset %C(yellow bold)[%ar]%Creset %C(red bold)%d%Creset %s %C(blue bold)<%an>%Creset'";
      ls = "lsbranch";
      mf = "merge --ff-only";
      mfu = "merge --ff-only upstream/master";
      s = "status";
      wip = "!git add -A && git commit -m WIP";
      unpushed =
        "log --branches --not --remotes=origin --remotes=upstream --no-walk --decorate --oneline";
      unwip = "reset HEAD^";
    };
    ignores = let
      gitignore = path: name:
        builtins.readFile
        "${inputs.github-gitignore}/${path}/${name}.gitignore";
      gitignoreGlobal = gitignore "Global";
      generate = list:
        lib.splitString "\n" (builtins.concatStringsSep "\n" list);
    in generate [
      (gitignoreGlobal "Linux")
      (gitignoreGlobal "macOS")
      (gitignoreGlobal "Vim")
      (gitignoreGlobal "Windows")
    ];
  };
}
