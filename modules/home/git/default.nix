{
  flake,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    git-lfs
    git-utils
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;

    aliases = {
      authors = "shortlog --numbered --summary --format='%an <%ae>' --no-merges";
      ci = "commit";
      co = "checkout";
      cl = "clean -ndx";
      clcl = "clean -fdx";
      d = "diff";
      dc = "diff --cached";
      fap = "fetch --all --prune";
      fapp = "pull --all --prune --ff-only";
      graph = "log --graph --decorate --all --oneline --format='%C(green bold)%h%Creset %C(yellow bold)[%ar]%Creset %C(red bold)%d%Creset %s %C(blue bold)<%an>%Creset'";
      ls = "lsbranch";
      mf = "merge --ff-only";
      mfu = "merge --ff-only upstream/master";
      s = "status";
      wip = "!git add -A && git commit -m WIP";
      unpushed = "log --branches --not --remotes=origin --remotes=upstream --no-walk --decorate --oneline";
      unwip = "reset HEAD^";
    };

    ignores =
      let
        gitignore =
          path: name: builtins.readFile "${flake.inputs.github-gitignore}/${path}/${name}.gitignore";
        gitignoreGlobal = gitignore "Global";
        generate = list: lib.splitString "\n" (builtins.concatStringsSep "\n" list);
      in
      generate [
        (gitignoreGlobal "Linux")
        (gitignoreGlobal "macOS")
        (gitignoreGlobal "Vim")
        (gitignoreGlobal "Windows")
        ''
          # Local direnv cache
          .direnv
        ''
      ];

    settings = {
      color.ui = "auto";
      core = {
        autocrlf = "input";
        eol = "lf";
        editor = "nix run ~/neovim-nix/.# --";
        compression = -1;
      };
      delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          side-by-side = false;
          line-numbers = true;
          decorations = true;
          plus-style = "syntax #004000";
          plus-emph-style = "syntax #00A000";
        };
      };
      init.defaultBranch = "main";
      merge.defaultToUpstream = true;
      pull.ff = "only";
      rebase.autosquash = true;
      url."https://github.com".insteadOf = "git://github.com";
      user = {
        name = "Nick Stevens";
        email = "nick@bitcurry.com";
      };

      # Sign Git commits using key from 1Password
      commit.gpgsign = true;
      gpg = {
        format = "ssh";
        ssh = {
          program = "${pkgs._1password-gui}/bin/op-ssh-sign";
          allowedSignersFile = builtins.toPath ./git/allowed-signers;
        };
      };
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+lTG1ancKWBWdk/qgv0h+wGMfMWVcm9BNLw5RtpDXt";

    };
  };
}
