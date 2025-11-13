{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "prusaslicer-rename";
  runtimeInputs = [ ];
  text = builtins.readFile ./prusaslicer-rename.sh;
}
