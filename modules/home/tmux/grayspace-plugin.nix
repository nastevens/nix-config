{
  lib,
  pkgs,
  tmuxPlugins,
  ...
}:
{
  grayspace = tmuxPlugins.mkTmuxPlugin rec {
    pluginName = "grayspace";
    version = "unstable";
    src = lib.fileset.toSource {
      root = ./.;
      fileset = ./grayspace.tmux;
    };
  };
}
