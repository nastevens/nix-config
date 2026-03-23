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

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      side-by-side = false;
      line-numbers = true;
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

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

    signing = {
      format = "ssh";
      signByDefault = true;
      signer = "${pkgs._1password-gui}/bin/op-ssh-sign";
    };

    settings = {
      alias =
        let
          color = color: value: "%C(${color})${value}%Creset";
          green = color "green bold";
          yellow = color "yellow bold";
          blue = color "blue bold";
          red = color "red bold";
          mergeArgs = builtins.concatStringsSep " ";
        in
        {
          authors = mergeArgs [
            "shortlog"
            "--no-merges"
            "--numbered"
            "--summary"
            "--format='%an <%ae>'"
          ];
          ci = "commit";
          co = "checkout";
          cl = mergeArgs [
            "clean"
            "--dry-run"
            "-d" # recurse into untracked directories
            "-x" # allow removing ignored files
          ];
          clcl = mergeArgs [
            "clean"
            "--force"
            "-d" # recurse into untracked directories
            "-x" # allow removing ignored files
          ];
          d = "diff";
          dc = mergeArgs [
            "diff"
            "--cached"
          ];
          fap = mergeArgs [
            "fetch"
            "--all"
            "--prune"
          ];
          fapp = mergeArgs [
            "pull"
            "--all"
            "--ff-only"
            "--prune"
          ];
          graph = mergeArgs [
            "log"
            "--all"
            "--decorate"
            "--graph"
            "--format='${green "%h"} ${yellow "[%ar]"} ${red "%d"} %s ${blue "<%an>"}'"
          ];
          ls = "lsbranch";
          mf = mergeArgs [
            "merge"
            "--ff-only"
          ];
          s = "status";
          wip = "!git add -A && git commit -m WIP";
          unpushed = mergeArgs [
            "log"
            "--decorate"
            "--no-walk"
            "--oneline"
            "--branches"
            "--not"
            "--remotes=origin"
            "--remotes=upstream"
          ];
          unwip = "reset HEAD^";
        };
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
      user = {
        name = "Nick Stevens";
        email = "nick@bitcurry.com";
        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+lTG1ancKWBWdk/qgv0h+wGMfMWVcm9BNLw5RtpDXt";
      };
    };
  };
}
