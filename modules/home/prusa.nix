{ pkgs, ... }:
{
  home.packages = with pkgs; [
    prusa-slicer
    prusaslicer-rename
  ];
}
