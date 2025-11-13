{ lib, pkgs, ... }:
let
  inherit (lib.meta) getExe;
  maestral = pkgs.maestral;
in
{
  home.packages = [
    maestral
  ];
  programs.zsh.initContent = ''
    eval "$(${getExe maestral} completion zsh)"
  '';
}
